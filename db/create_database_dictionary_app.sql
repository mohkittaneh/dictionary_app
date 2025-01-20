

USE dictionary_app;

CREATE TABLE words (
    id INT AUTO_INCREMENT PRIMARY KEY,
    word VARCHAR(255) NOT NULL,    
    definition TEXT NOT NULL       
);

INSERT INTO words (word, definition) VALUES
('example', 'A representative form or pattern.'),
('dictionary', 'A reference book or online resource containing words and their definitions.'),
('automation', 'The process of operating or controlling a process by automatic means.'),
('application', 'A program or piece of software designed to fulfill a particular purpose.'),
('server', 'A computer or system that provides resources, data, or services to other computers, called clients.');
