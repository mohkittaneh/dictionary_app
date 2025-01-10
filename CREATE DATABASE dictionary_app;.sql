-- Step 1: Create the database
CREATE DATABASE dictionary_app;

-- Step 2: Use the database
USE dictionary_app;

-- Step 3: Create the table for storing words and their definitions
CREATE TABLE words (
    id INT AUTO_INCREMENT PRIMARY KEY, -- Unique identifier for each word
    word VARCHAR(255) NOT NULL,        -- The word (e.g., "example")
    definition TEXT NOT NULL           -- The definition of the word
);

-- Step 4: Insert sample data into the table
INSERT INTO words (word, definition) VALUES
('example', 'A representative form or pattern.'),
('dictionary', 'A reference book or online resource containing words and their definitions.'),
('automation', 'The process of operating or controlling a process by automatic means.'),
('application', 'A program or piece of software designed to fulfill a particular purpose.'),
('server', 'A computer or system that provides resources, data, or services to other computers, called clients.');
