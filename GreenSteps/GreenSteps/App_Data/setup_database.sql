-- =====================================================
-- GreenSteps Database Setup Script
-- Run this once in SQL Server to create everything
-- =====================================================

-- Create database if not exists
IF NOT EXISTS (SELECT * FROM sys.databases WHERE name = 'GreenStepsDB')
BEGIN
    CREATE DATABASE GreenStepsDB;
END
GO

USE GreenStepsDB;
GO

-- ====== USERS TABLE ======
IF OBJECT_ID('Users', 'U') IS NOT NULL DROP TABLE Users;
CREATE TABLE Users (
    UserId INT IDENTITY(1,1) PRIMARY KEY,
    FullName NVARCHAR(100) NOT NULL,
    Email NVARCHAR(150) NOT NULL UNIQUE,
    Password NVARCHAR(100) NOT NULL,
    Role NVARCHAR(20) NOT NULL DEFAULT 'User',
    CreatedAt DATETIME NOT NULL DEFAULT GETDATE()
);

INSERT INTO Users (FullName, Email, Password, Role) VALUES
('Admin', 'admin@greensteps.com', 'admin123', 'Admin'),
('Demo User', 'user@greensteps.com', 'user123', 'User');

-- ====== ARTICLES TABLE ======
IF OBJECT_ID('Articles', 'U') IS NOT NULL DROP TABLE Articles;
CREATE TABLE Articles (
    ArticleId INT IDENTITY(1,1) PRIMARY KEY,
    Title NVARCHAR(200) NOT NULL,
    Content NVARCHAR(MAX) NOT NULL,
    Category NVARCHAR(50) NOT NULL DEFAULT 'General',
    Author NVARCHAR(100) NULL,
    PublishedDate DATETIME NOT NULL DEFAULT GETDATE()
);

INSERT INTO Articles (Title, Content, Category, Author, PublishedDate) VALUES
('5 Easy Ways to Reduce Plastic Waste',
 'Plastic waste is one of the biggest environmental challenges today. Here are five simple changes you can start with: 1) Use a reusable water bottle. 2) Bring your own shopping bags. 3) Avoid single-use straws. 4) Buy in bulk to reduce packaging. 5) Recycle properly by sorting your waste.',
 'Waste Reduction', 'GreenSteps Team', '2026-01-01'),
('The Power of Renewable Energy',
 'Renewable energy from solar, wind, and water sources is transforming how we power our homes and cities. Solar panels are becoming more affordable, wind farms are expanding worldwide, and hydroelectric power continues to provide reliable clean energy. By switching to renewables, we can drastically cut carbon emissions.',
 'Energy', 'GreenSteps Team', '2026-01-05'),
('Sustainable Eating Made Simple',
 'What you eat has a huge impact on the planet. Eating more plant-based meals, choosing local and seasonal produce, reducing food waste, and supporting sustainable farms are all ways to make your diet greener. You do not have to go fully vegetarian - even one meatless meal a week makes a difference!',
 'Lifestyle', 'GreenSteps Team', '2026-01-10');

-- ====== VIDEOS TABLE ======
IF OBJECT_ID('Videos', 'U') IS NOT NULL DROP TABLE Videos;
CREATE TABLE Videos (
    VideoId INT IDENTITY(1,1) PRIMARY KEY,
    Title NVARCHAR(200) NOT NULL,
    Description NVARCHAR(1000) NOT NULL,
    YouTubeId NVARCHAR(20) NOT NULL,
    Category NVARCHAR(50) NOT NULL DEFAULT 'General',
    DurationMinutes INT NOT NULL DEFAULT 0,
    UploadedDate DATETIME NOT NULL DEFAULT GETDATE()
);

INSERT INTO Videos (Title, Description, YouTubeId, Category, DurationMinutes, UploadedDate) VALUES
('How Solar Panels Work', 'A clear and simple explanation of how solar panels convert sunlight into electricity.', 'xKxrkht7CpY', 'Energy', 5, '2026-01-15'),
('Zero Waste Living for Beginners', 'Practical tips to start your zero waste journey.', 'pF72px2R3Hg', 'Lifestyle', 12, '2026-01-18'),
('Climate Change Explained', 'Understand the science behind climate change in this concise educational video.', 'ifrHogDujXw', 'Education', 8, '2026-01-20');

-- ====== QUIZZES TABLE ======
IF OBJECT_ID('Quizzes', 'U') IS NOT NULL DROP TABLE Quizzes;
CREATE TABLE Quizzes (
    QuizId INT IDENTITY(1,1) PRIMARY KEY,
    Title NVARCHAR(200) NOT NULL,
    Description NVARCHAR(500) NOT NULL,
    Category NVARCHAR(50) NOT NULL DEFAULT 'General',
    CreatedAt DATETIME NOT NULL DEFAULT GETDATE()
);

INSERT INTO Quizzes (Title, Description, Category, CreatedAt) VALUES
('Sustainable Living Basics', 'Test your knowledge of everyday eco-friendly habits.', 'Lifestyle', '2026-01-25'),
('Renewable Energy 101', 'How much do you know about renewable energy sources?', 'Energy', '2026-01-28');

-- ====== QUESTIONS TABLE ======
IF OBJECT_ID('Questions', 'U') IS NOT NULL DROP TABLE Questions;
CREATE TABLE Questions (
    QuestionId INT IDENTITY(1,1) PRIMARY KEY,
    QuizId INT NOT NULL,
    QuestionText NVARCHAR(500) NOT NULL,
    OptionA NVARCHAR(200) NOT NULL,
    OptionB NVARCHAR(200) NOT NULL,
    OptionC NVARCHAR(200) NOT NULL,
    OptionD NVARCHAR(200) NOT NULL,
    CorrectAnswer NVARCHAR(1) NOT NULL,
    FOREIGN KEY (QuizId) REFERENCES Quizzes(QuizId) ON DELETE CASCADE
);

INSERT INTO Questions (QuizId, QuestionText, OptionA, OptionB, OptionC, OptionD, CorrectAnswer) VALUES
(1, 'Which of these is the most eco-friendly way to commute short distances?', 'Drive a car alone', 'Take a bus', 'Ride a bicycle', 'Take a taxi', 'C'),
(1, 'Which material takes the longest to decompose?', 'Paper', 'Plastic bottle', 'Banana peel', 'Cotton t-shirt', 'B'),
(1, 'What is the R that comes first in Reduce Reuse Recycle?', 'Recycle', 'Reuse', 'Refuse', 'Reduce', 'D'),
(2, 'Which is NOT a renewable energy source?', 'Solar power', 'Wind power', 'Coal', 'Hydropower', 'C'),
(2, 'What do solar panels convert sunlight into?', 'Water', 'Electricity', 'Heat only', 'Gasoline', 'B'),
(2, 'Wind turbines generate electricity by harnessing what?', 'Solar rays', 'Water flow', 'Wind motion', 'Earths heat', 'C');

PRINT 'Database setup complete! Users, Articles, Videos, Quizzes, and Questions tables ready.';
