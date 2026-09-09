USE GreenStepsDB;
GO

-- Drop if exists (to reset if you run this twice)
IF OBJECT_ID('QuizAttempts', 'U') IS NOT NULL DROP TABLE QuizAttempts;

-- Create QuizAttempts table
CREATE TABLE QuizAttempts (
    AttemptId INT IDENTITY(1,1) PRIMARY KEY,
    UserId INT NOT NULL,
    QuizId INT NOT NULL,
    QuizTitle NVARCHAR(200) NOT NULL,
    Score INT NOT NULL,              -- correct answers
    TotalQuestions INT NOT NULL,
    AttemptedAt DATETIME NOT NULL DEFAULT GETDATE(),
    AdminFeedback NVARCHAR(500) NULL, -- admin comment (optional)
    FeedbackDate DATETIME NULL,        -- when admin gave feedback
    FOREIGN KEY (UserId) REFERENCES Users(UserId) ON DELETE CASCADE
);

PRINT 'QuizAttempts table created successfully!';