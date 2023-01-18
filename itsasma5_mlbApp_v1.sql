-- phpMyAdmin SQL Dump
-- version 4.9.7
-- https://www.phpmyadmin.net/
--
-- Host: localhost:3306
-- Generation Time: Jan 18, 2023 at 03:51 PM
-- Server version: 5.7.23-23
-- PHP Version: 7.4.33

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `itsasma5_mlbApp_v1`
--

DELIMITER $$
--
-- Procedures
--
$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `bunt_app_control`
--

CREATE TABLE `bunt_app_control` (
  `official_game_date` date NOT NULL,
  `last_run_datetime` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `bunt_app_control`
--

INSERT INTO `bunt_app_control` (`official_game_date`, `last_run_datetime`) VALUES
('2022-11-05', '2022-11-06 07:59:00');

-- --------------------------------------------------------

--
-- Table structure for table `current_games`
--

CREATE TABLE `current_games` (
  `game_pk` int(11) NOT NULL,
  `status_code` varchar(10) COLLATE utf8_unicode_ci NOT NULL,
  `last_play_processed` int(11) NOT NULL,
  `start_processing` tinyint(1) NOT NULL,
  `stop_processing` tinyint(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `current_games`
--

INSERT INTO `current_games` (`game_pk`, `status_code`, `last_play_processed`, `start_processing`, `stop_processing`) VALUES
(715719, 'F', 63, 1, 1);

-- --------------------------------------------------------

--
-- Table structure for table `social_media_type`
--

CREATE TABLE `social_media_type` (
  `social_type_id` int(11) NOT NULL,
  `social_type_desc` varchar(20) COLLATE utf8_unicode_ci NOT NULL,
  `social_url_template` varchar(200) COLLATE utf8_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `social_media_type`
--

INSERT INTO `social_media_type` (`social_type_id`, `social_type_desc`, `social_url_template`) VALUES
(1, 'twitter', 'https://twitter.com/[[handle]]'),
(2, 'facebook', 'https://www.facebook.com/[[handle]]/'),
(3, 'instagram', 'https://www.instagram.com/[[handle]]/'),
(4, 'tumblr', 'https://[[handle]].tumblr.com/'),
(5, 'pinterest', 'https://www.pinterest.com/[[handle]]/'),
(6, 'snapchat', 'http://www.snapchat.com/add/[[handle]]'),
(7, 'hashtag', '#[[handle]]');

-- --------------------------------------------------------

--
-- Table structure for table `teams`
--

CREATE TABLE `teams` (
  `team_id` int(11) NOT NULL,
  `team_name` varchar(50) COLLATE utf8_unicode_ci NOT NULL,
  `team_abbreviation` varchar(3) COLLATE utf8_unicode_ci NOT NULL,
  `team_location` varchar(50) COLLATE utf8_unicode_ci NOT NULL,
  `club_name` varchar(50) COLLATE utf8_unicode_ci NOT NULL,
  `division` varchar(30) COLLATE utf8_unicode_ci NOT NULL,
  `league` varchar(25) COLLATE utf8_unicode_ci NOT NULL,
  `twitter` varchar(40) COLLATE utf8_unicode_ci NOT NULL,
  `hashtag` varchar(40) COLLATE utf8_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `teams`
--

INSERT INTO `teams` (`team_id`, `team_name`, `team_abbreviation`, `team_location`, `club_name`, `division`, `league`, `twitter`, `hashtag`) VALUES
(108, 'Los Angeles Angels', 'LAA', 'Anaheim', 'Angels', 'American League West', 'American League', 'Angels', 'GoHalos'),
(109, 'Arizona Diamondbacks', 'ARI', 'Phoenix', 'Diamondbacks', 'National League West', 'National League', 'Dbacks', 'Dbacks'),
(110, 'Baltimore Orioles', 'BAL', 'Baltimore', 'Orioles', 'American League East', 'American League', 'Orioles', 'Birdland'),
(111, 'Boston Red Sox', 'BOS', 'Boston', 'Red Sox', 'American League East', 'American League', 'redsox', 'DirtyWater'),
(112, 'Chicago Cubs', 'CHC', 'Chicago', 'Cubs', 'National League Central', 'National League', 'Cubs', 'ItsDifferentHere'),
(113, 'Cincinnati Reds', 'CIN', 'Cincinnati', 'Reds', 'National League Central', 'National League', 'Reds', 'ATOBTTR'),
(114, 'Cleveland Guardians', 'CLE', 'Cleveland', 'Guardians', 'American League Central', 'American League', 'CleGuardians', 'ForTheLand'),
(115, 'Colorado Rockies', 'COL', 'Denver', 'Rockies', 'National League West', 'National League', 'Rockies', 'Rockies'),
(116, 'Detroit Tigers', 'DET', 'Detroit', 'Tigers', 'American League Central', 'American League', 'tigers', 'DetroitRoots'),
(117, 'Houston Astros', 'HOU', 'Houston', 'Astros', 'American League West', 'American League', 'astros', 'LevelUp'),
(118, 'Kansas City Royals', 'KC', 'Kansas City', 'Royals', 'American League Central', 'American League', 'Royals', 'TogetherRoyal'),
(119, 'Los Angeles Dodgers', 'LAD', 'Los Angeles', 'Dodgers', 'National League West', 'National League', 'Dodgers', 'AlwaysLA'),
(120, 'Washington Nationals', 'WSH', 'Washington', 'Nationals', 'National League East', 'National League', 'Nationals', 'NATITUDE'),
(121, 'New York Mets', 'NYM', 'Flushing', 'Mets', 'National League East', 'National League', 'Mets', 'LGM'),
(133, 'Oakland Athletics', 'OAK', 'Oakland', 'Athletics', 'American League West', 'American League', 'Athletics', 'DrumTogether'),
(134, 'Pittsburgh Pirates', 'PIT', 'Pittsburgh', 'Pirates', 'National League Central', 'National League', 'Pirates', 'LetsGoBucs'),
(135, 'San Diego Padres', 'SD', 'San Diego', 'Padres', 'National League West', 'National League', 'padres', 'TimeToShine'),
(136, 'Seattle Mariners', 'SEA', 'Seattle', 'Mariners', 'American League West', 'American League', 'Mariners', 'SeaUsRise'),
(137, 'San Francisco Giants', 'SF', 'San Francisco', 'Giants', 'National League West', 'National League', 'SFGiants', 'SFGameUp'),
(138, 'St. Louis Cardinals', 'STL', 'St. Louis', 'Cardinals', 'National League Central', 'National League', 'Cardinals', 'STLCards'),
(139, 'Tampa Bay Rays', 'TB', 'St. Petersburg', 'Rays', 'American League East', 'American League', 'Raysbaseball', 'RaysUp'),
(140, 'Texas Rangers', 'TEX', 'Arlington', 'Rangers', 'American League West', 'American League', 'Rangers', 'StraightUpTX'),
(141, 'Toronto Blue Jays', 'TOR', 'Toronto', 'Blue Jays', 'American League East', 'American League', 'Bluejays', 'NextLevel'),
(142, 'Minnesota Twins', 'MIN', 'Minneapolis', 'Twins', 'American League Central', 'American League', 'Twins', 'MNTwins'),
(143, 'Philadelphia Phillies', 'PHI', 'Philadelphia', 'Phillies', 'National League East', 'National League', 'Phillies', 'RingTheBell'),
(144, 'Atlanta Braves', 'ATL', 'Atlanta', 'Braves', 'National League East', 'National League', 'Braves', 'ForTheA'),
(145, 'Chicago White Sox', 'CWS', 'Chicago', 'White Sox', 'American League Central', 'American League', 'whitesox', 'ChangeTheGame'),
(146, 'Miami Marlins', 'MIA', 'Miami', 'Marlins', 'National League East', 'National League', 'Marlins', 'MakeItMiami'),
(147, 'New York Yankees', 'NYY', 'Bronx', 'Yankees', 'American League East', 'American League', 'Yankees', 'RepBX'),
(158, 'Milwaukee Brewers', 'MIL', 'Milwaukee', 'Brewers', 'National League Central', 'National League', 'Brewers', 'ThisIsMyCrew');

-- --------------------------------------------------------

--
-- Table structure for table `team_social`
--

CREATE TABLE `team_social` (
  `team_id` int(11) NOT NULL,
  `social_type_id` int(11) NOT NULL,
  `social_handle` varchar(50) COLLATE utf8_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `team_social`
--

INSERT INTO `team_social` (`team_id`, `social_type_id`, `social_handle`) VALUES
(133, 1, 'Athletics'),
(133, 2, 'Athletics'),
(133, 3, 'athletics'),
(133, 4, 'oaklandathletics'),
(133, 5, 'athletics'),
(133, 6, 'athletics'),
(134, 1, 'Pirates'),
(134, 2, 'Pirates'),
(134, 3, 'pittsburghpirates'),
(134, 4, 'pirates'),
(134, 5, 'piratesbaseball'),
(134, 6, 'pirates'),
(135, 1, 'padres'),
(135, 2, 'Padres'),
(135, 3, 'padres'),
(135, 4, 'padres'),
(135, 5, 'sandiegopadres'),
(135, 6, 'padres'),
(136, 1, 'Mariners'),
(136, 2, 'Mariners'),
(136, 3, 'mariners'),
(136, 4, 'mariners'),
(136, 5, 'marinersmlb'),
(136, 6, 'mariners'),
(137, 1, 'SFGiants'),
(137, 2, 'Giants'),
(137, 3, 'SFGiants'),
(137, 4, 'sfgiants'),
(137, 5, 'thesfgiants'),
(137, 6, 'sfgiants'),
(138, 1, 'Cardinals'),
(138, 2, 'Cardinals'),
(138, 3, 'cardinals'),
(138, 4, 'stlcardinals'),
(138, 5, 'cardinalsmlb'),
(138, 6, 'cardinals'),
(139, 1, 'Raysbaseball'),
(139, 2, 'Rays'),
(139, 3, 'raysbaseball'),
(139, 4, 'raysbaseball'),
(139, 5, 'raysbaseball'),
(139, 6, 'rays'),
(140, 1, 'Rangers'),
(140, 2, 'Rangers'),
(140, 3, 'rangers'),
(140, 4, 'texasrangers'),
(140, 5, 'rangersbaseball'),
(140, 6, 'rangers'),
(141, 1, 'Bluejays'),
(141, 2, 'BlueJays'),
(141, 3, 'bluejays'),
(141, 4, 'torontobluejays'),
(141, 5, 'torontobluejays'),
(141, 6, 'bluejays'),
(142, 1, 'Twins'),
(142, 2, 'Twins'),
(142, 3, 'twins'),
(142, 4, 'twinsbaseball'),
(142, 5, 'minnesotatwins'),
(142, 6, 'twins'),
(143, 1, 'Phillies'),
(143, 2, 'Phillies'),
(143, 3, 'phillies'),
(143, 4, 'phillies'),
(143, 5, 'philaphillies'),
(143, 6, 'phillies'),
(144, 1, 'Braves'),
(144, 2, 'Braves'),
(144, 3, 'braves'),
(144, 4, 'atlantabraves'),
(144, 5, 'atlantabraves'),
(144, 6, 'braves'),
(145, 1, 'whitesox'),
(145, 2, 'WhiteSox'),
(145, 3, 'whitesox'),
(145, 4, 'whitesox'),
(145, 5, 'chicagowhitesox'),
(145, 6, 'whitesox'),
(146, 1, 'Marlins'),
(146, 2, 'Marlins'),
(146, 3, 'marlins'),
(146, 4, 'marlins'),
(146, 5, 'miamimarlins'),
(146, 6, 'marlins'),
(147, 1, 'Yankees'),
(147, 2, 'Yankees'),
(147, 3, 'yankees'),
(147, 4, 'yankees'),
(147, 5, 'yankeesbaseball'),
(147, 6, 'Yankees'),
(158, 1, 'Brewers'),
(158, 2, 'Brewers'),
(158, 3, 'brewers'),
(158, 4, 'brewers'),
(158, 5, 'brewersbaseball'),
(158, 6, 'brewers'),
(108, 1, 'Angels'),
(108, 2, 'Angels'),
(108, 3, 'angels'),
(108, 4, 'angels'),
(108, 5, 'angelsbaseball'),
(108, 6, 'angelsmlb'),
(109, 1, 'Dbacks'),
(109, 2, 'D-backs'),
(109, 3, 'dbacks'),
(109, 4, 'dbacks'),
(109, 5, 'dbacks'),
(109, 6, 'dbacks'),
(110, 1, 'Orioles'),
(110, 2, 'Orioles'),
(110, 3, 'orioles'),
(110, 4, 'orioles'),
(110, 5, 'oriolesbaseball'),
(110, 6, 'orioles'),
(111, 1, 'redsox'),
(111, 2, 'RedSox'),
(111, 3, 'redsox'),
(111, 4, 'redsox'),
(111, 5, 'bostonredsox'),
(111, 6, 'redsox'),
(112, 1, 'Cubs'),
(112, 2, 'Cubs'),
(112, 3, 'cubs'),
(112, 4, 'chicagocubs'),
(112, 5, 'cubsbaseball'),
(112, 6, 'cubs'),
(113, 1, 'Reds'),
(113, 2, 'Reds'),
(113, 3, 'reds'),
(113, 4, 'cincinnatireds'),
(113, 5, 'redsbaseball'),
(113, 6, 'reds'),
(114, 1, 'Indians'),
(114, 2, 'Indians'),
(114, 3, 'indians'),
(114, 4, 'clevelandindians'),
(114, 5, 'indiansbaseball'),
(114, 6, 'indians'),
(115, 1, 'Rockies'),
(115, 2, 'Rockies'),
(115, 3, 'rockies'),
(115, 4, 'coloradorockies'),
(115, 5, 'coloradorockies'),
(115, 6, 'rockies'),
(116, 1, 'tigers'),
(116, 2, 'Tigers'),
(116, 3, 'tigers'),
(116, 4, 'detroittigers'),
(116, 5, 'tigersbaseball'),
(116, 6, 'tigers'),
(117, 1, 'astros'),
(117, 2, 'Astros'),
(117, 3, 'astrosbaseball'),
(117, 4, 'houstonastros'),
(117, 5, 'houstonastros'),
(117, 6, 'astrosmlb'),
(118, 1, 'Royals'),
(118, 2, 'Royals'),
(118, 3, 'kcroyals'),
(118, 4, 'royals'),
(118, 5, 'royalsbaseball'),
(118, 6, 'royals'),
(119, 1, 'Dodgers'),
(119, 2, 'Dodgers'),
(119, 3, 'dodgers'),
(119, 4, 'ladodgers'),
(119, 5, 'dodgersbaseball'),
(119, 6, 'dodgersmlb'),
(120, 1, 'Nationals'),
(120, 2, 'Nationals'),
(120, 3, 'nationals'),
(120, 4, 'washingtonnationals'),
(120, 5, 'nationals'),
(120, 6, 'nationals'),
(121, 1, 'Mets'),
(121, 2, 'Mets'),
(121, 3, 'mets'),
(121, 4, 'mets'),
(121, 5, 'metsbaseball'),
(121, 6, 'mets'),
(145, 7, 'ChangeTheGame'),
(114, 7, 'ForTheLand'),
(116, 7, 'DetroitRoots'),
(118, 7, 'TogetherRoyal'),
(142, 7, 'MNTwins'),
(110, 7, 'Birdland'),
(111, 7, 'DirtyWater'),
(147, 7, 'RepBX'),
(139, 7, 'RaysUp'),
(141, 7, 'NextLevel'),
(117, 7, 'LevelUp'),
(108, 7, 'GoHalos'),
(133, 7, 'DrumTogether'),
(136, 7, 'SeaUsRise'),
(140, 7, 'StraightUpTX'),
(112, 7, 'ItsDifferentHere'),
(113, 7, 'ATOBTTR'),
(158, 7, 'ThisIsMyCrew'),
(134, 7, 'LetsGoBucs'),
(138, 7, 'STLCards'),
(144, 7, 'ForTheA'),
(146, 7, 'MakeItMiami'),
(121, 7, 'LGM'),
(143, 7, 'RingTheBell'),
(120, 7, 'NATITUDE'),
(109, 7, 'Dbacks'),
(115, 7, 'Rockies'),
(119, 7, 'AlwaysLA'),
(135, 7, 'TimeToShine'),
(137, 7, 'SFGameUp');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `teams`
--
ALTER TABLE `teams`
  ADD PRIMARY KEY (`team_id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
