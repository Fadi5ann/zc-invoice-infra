CREATE TABLE
    `logger` (
        `id` INT AUTO_INCREMENT PRIMARY KEY,
        `event` VARCHAR(255) NULL,
        `api` VARCHAR(255) NULL,
        `method` VARCHAR(50) NULL,
        `userId` VARCHAR(255) NULL,
        `logInfo` json DEFAULT NULL,
        `loggedAt` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
        KEY `FK_user_logger` (`userId`),
        CONSTRAINT `FK_user_logger` FOREIGN KEY (`userId`) REFERENCES `user` (`id`) ON DELETE SET NULL
    );
