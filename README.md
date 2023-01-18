# BuntBot
Twitter bot that tweets every time an MLB player bunts.

The bot consists of two parts: a MySQL database to store state between runs and a Python function that runs every minute.

The Python function gets the date of current games in progress from the MySQL db, then it calls the MLB API for the list of "current" games to compare the date. If the date matches, it continues where's it left off, checking the play-by-play endpoint for additional plays and determining if any play is a bunt. If the dates do not match, it refreshes the game list for a new day.

If a bunt play is detected, the app calls the Twitter API and tweets about it. 

This script and data structure could easily be adapted for other usages of the MLB API (E.g. Tweet each at-bat for a particular player or tweet about every triple or stolen base attempt. 
