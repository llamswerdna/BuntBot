import datetime
from requests_oauthlib import OAuth1
import os
from time import strptime

import requests
import mysql.connector
import json

# Step 0: Set up database connection
mydb = mysql.connector.connect(
    host=os.environ["MYSQL_HOST"],
    user=os.environ["MYSQL_USER"],
    password=os.environ["MYSQL_PASS"],
    database=os.environ["MYSQL_DB"]
)

myCursor = mydb.cursor()

# set up twitter env
consumer_key = os.environ["TWITTER_CONSUMER_KEY"]
consumer_secret = os.environ["TWITTER_CONSUMER_SECRET"]
access_token = os.environ["TWITTER_ACCESS_TOKEN"]
access_token_secret = os.environ["TWITTER_ACCESS_TOKEN_SECRET"]


# ///// FUNCTIONS \\\\\ #
ordinal = lambda n: "%d%s" % (n,"tsnrhtdd"[(n//10%10!=1)*(n%10<4)*n%10::4])


# call MLB API and return response
def mlbAPI(endpoint):
    host = "https://statsapi.mlb.com/api"
    callURL = host + endpoint
    response = requests.get(callURL)
    return response.json()


# insert games into the game list
def insertGame(game_pk, status_code):
    insertstatement = """
        INSERT INTO current_games (game_pk,status_code,last_play_processed,start_processing,stop_processing)
        VALUES(@@gamePk,'@@abstractGameCode',0,@@startProcess,0)
        """

    if status_code == "O" or status_code == "P":
        start_process = "0"
    else:
        start_process = "1"

    insertstatement = insertstatement.replace("@@gamePk", str(game_pk))
    insertstatement = insertstatement.replace("@@abstractGameCode", status_code)
    insertstatement = insertstatement.replace("@@startProcess", start_process)

    myCursor.execute(insertstatement)
    mydb.commit()


# get game feed
def retrieveGameFeed(gmPk, lastPlay):
    url = "/v1.1/game/"
    url += str(gmPk)
    url += "/feed/live?fields=metaData,gameEvents,logicalEvents,gameData,status,abstractGameState,"
    url += "detailedState,teams,away,home,id,liveData,plays,allPlays,result,homeScore,awayScore,event"
    url += ",currentPlay,eventType,description,about,atBatIndex,halfInning,inning,abstractGameCode,hasOut"

    # retrieve game feed and put in dictionary
    gmFeed = mlbAPI(url)
    statusCode = gmFeed["gameData"]["status"]["abstractGameCode"]
    currPlay = gmFeed["liveData"]["plays"]["currentPlay"]["atBatIndex"]
    gameData = gmFeed["gameData"]

    if statusCode == "F":
        currPlay += 1

    # loop through play-by-play
    for play in gmFeed["liveData"]["plays"]["allPlays"]:
        if lastPlay <= play["atBatIndex"] < currPlay:
            buntType = findBunt(play)

            if buntType != "N/A":
                tweetText = composeTweet(play, gameData, buntType)
                sendTweet(tweetText)

    # set currPlay to reflect the last play handled
    currPlay -= 1

    # update last play processed (and mark stop if needed)
    updateText = "Update current_games"
    updateText += " SET last_play_processed = " + str(currPlay)
    if statusCode == "F":
        updateText += ", stop_processing = 1"
    updateText += " WHERE game_pk = " + str(gmPk) + ";"
    myCursor.execute(updateText)
    mydb.commit()



def composeTweet(play, gameData, buntType):
    print("tweeeeet!", buntType)

    homeId = gameData["teams"]["home"]["id"]
    awayId = gameData["teams"]["away"]["id"]
    
    homeDeets = getTeamDeets(homeId)
    awayDeets = getTeamDeets(awayId)

    homeHandle = homeDeets[0][1]
    homeHashtag = "#" + homeDeets[0][2]
    # homeAbbrev = homeDeets[0][0]
    awayHandle = awayDeets[0][1]
    awayHashtag = "#" + awayDeets[0][2]
    # awayAbbrev = awayDeets[0][0]

    playDesc = play["result"]["description"]
    homeScore = play["result"]["homeScore"]
    awayScore = play["result"]["awayScore"]
    inningNo = play["about"]["inning"]
    inningDesc = play["about"]["halfInning"] + " of the " + ordinal(inningNo)
    inningDesc = inningDesc.capitalize()

    if homeScore == awayScore:
        scoreSummary = "@" + homeHandle + " and " + "@" + awayHandle + " tied " + str(homeScore) + "-" + str(awayScore)
    elif homeScore > awayScore:
        scoreSummary = "@" + homeHandle + " lead " + "@" + awayHandle + " " + str(homeScore) + "-" + str(awayScore)
    else:
        scoreSummary = "@" + awayHandle + " lead " + "@" + homeHandle + " " + str(awayScore) + "-" + str(homeScore)

    playDesc = playDesc.replace("  ", " ").replace("  ", " ").replace("  ", " ").replace("  ", " ").replace("  ", " ")

    # emojis!!!
    if buntType == "Sac Bunt":
        playDesc = playDesc + " 🎉"
    elif buntType == "Bunt Hit":
        playDesc = "❗❗ " + playDesc + " 😲🏃‍♂️💨"
    elif buntType == "Bunt Error":
        if playDesc.find("scores.") != -1:
            playDesc = playDesc.replace("scores.", "scores. 😂🤣")
        else:
            playDesc = playDesc + " 🤦‍♀️"
    elif buntType == "Sac Bunt DP":
        playDesc = playDesc.replace("double play.", "double play.  😳❌❌")

    tweetTemplate = "\n⚾ ${awayHashtag} at ${homeHashtag}\n\n${playDesc}\n\n${scoreSummary} ➡ ${inningDesc}"
    tweetTemplate = tweetTemplate.replace("${homeHashtag}", homeHashtag)
    tweetTemplate = tweetTemplate.replace("${awayHashtag}", awayHashtag)
    tweetTemplate = tweetTemplate.replace("${playDesc}", playDesc)
    tweetTemplate = tweetTemplate.replace("${scoreSummary}", scoreSummary)
    tweetTemplate = tweetTemplate.replace("${inningDesc}", inningDesc)

    return tweetTemplate


def sendTweet(tweetText):
    payload = {"text": "{}".format(tweetText)}
    url, auth = connect_to_oauth(
        consumer_key, consumer_secret, access_token, access_token_secret
    )
    request = requests.post(
        auth=auth, url=url, json=payload, headers={"Content-Type": "application/json"}
    )
    print(request.json())


def connect_to_oauth(consumer_key, consumer_secret, acccess_token, access_token_secret):
   url = "https://api.twitter.com/2/tweets"
   auth = OAuth1(consumer_key, consumer_secret, acccess_token, access_token_secret)
   return url, auth


def getTeamDeets(teamId):
    sqlStatement = """
            SELECT  `team_abbreviation`,`twitter`, `hashtag`
            FROM teams
            WHERE team_id = """

    sqlStatement += str(teamId)
    myCursor.execute(sqlStatement)
    
    return myCursor.fetchall()


def findBunt(play):
    eventType = play["result"]["eventType"]
    playDesc = play["result"]["description"]

    if eventType == "single" or eventType == "double" or eventType == "triple" or eventType == "home_run":
        if playDesc.find("bunt") != -1:
            return "Bunt Hit"
        else:
            return "N/A"
    elif eventType == "sac_bunt":
        if playDesc.find("error") != -1 and not play["about"]["hasOut"]:
            return "Bunt Error"
        else:
            return "Sac Bunt"
    elif eventType == "sac_bunt_double_play":
        return "Sac Bunt DP"
    else:
        return "N/A"
   
def hello_pubsub(event, context):
    # ///// BEGIN CORE PROCESSING \\\\\ #
    # Step 1: Get game date and determine refresh
    myCursor.execute("SELECT official_game_date FROM bunt_app_control;")

    oldGameDate = myCursor.fetchone()
    oldGameDate = oldGameDate[0]

    gameListDict = mlbAPI("/v1/schedule?sportId=1&fields=dates,date,games,gamePk,status,abstractGameCode")

    newGameDate = gameListDict["dates"][0]["date"]
    newGameDate = datetime.datetime.strptime(newGameDate, '%Y-%m-%d').date()

    if oldGameDate == newGameDate:
        # refresh game statuses
        for gm in gameListDict["dates"][0]["games"]:
            updateStmt = "UPDATE current_games SET status_code = '"
            updateStmt += gm["status"]["abstractGameCode"] + "' "
            updateStmt += "WHERE game_pk = "
            updateStmt += str(gm["gamePk"]) + " AND stop_processing != 1;"
            myCursor.execute(updateStmt)
            mydb.commit()

        # mark games that are ready to process
        myCursor.execute(
            "UPDATE current_games SET start_processing = 1 WHERE start_processing = 0 AND stop_processing = 0 and status_code in ('L','F');")
        mydb.commit()

    else:  # refresh game list
        print("get the new games!")

        # clear the decks
        myCursor.execute("TRUNCATE `current_games`;")
        mydb.commit()

        # loop new games and insert to db
        for gm in gameListDict["dates"][0]["games"]:
            game_pk = gm["gamePk"]
            status_code = gm["status"]["abstractGameCode"]
            insertGame(game_pk, status_code)

        # update the official date in app_control
        newGmDtStr = datetime.datetime.strftime(newGameDate, '%Y-%m-%d')
        myCursor.execute("UPDATE bunt_app_control SET official_game_date = '" + newGmDtStr + "';")
        mydb.commit()

    # retrieve list of games to process
    myCursor.execute(
        """SELECT game_pk, status_code, last_play_processed 
            FROM current_games WHERE start_processing = 1 
            AND stop_processing = 0;""")
    currGameList = myCursor.fetchall()

    for gl in currGameList:
        gmPk = gl[0]
        lastPlay = gl[2]
        retrieveGameFeed(gmPk, lastPlay)
    """
    # for testing only
    gmPk = 448890
    lastPlay = 0
    retrieveGameFeed(gmPk, lastPlay)
    """
    """
    bunt error: 662137
    sac bunt: ???
    bunt hit: 662137
    sac_bunt dp: 448890
    """

    # last thing we do: update last run time
    myCursor.execute("UPDATE bunt_app_control SET last_run_datetime = NOW();")
    mydb.commit()


