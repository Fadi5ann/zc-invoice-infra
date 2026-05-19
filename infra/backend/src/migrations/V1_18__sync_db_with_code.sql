-- Disable foreign key checks temporarily to allow structural changes
SET FOREIGN_KEY_CHECKS = 0;
-- 1. Sync the permission table ID type with the string slugs used by code
ALTER TABLE permission MODIFY id VARCHAR(255) NOT NULL;
-- 2. Sync the user table ID type with TypeORM's UUID strings

-- 2. Safely convert user.id to VARCHAR by dropping and recreating dependent FKs
-- Drop FK from logger that references user.id
ALTER TABLE logger DROP FOREIGN KEY FK_user_logger;

-- Convert permission.id to VARCHAR
ALTER TABLE permission MODIFY id VARCHAR(255) NOT NULL;

-- Convert user.id to VARCHAR
ALTER TABLE user MODIFY id VARCHAR(255) NOT NULL;

-- Convert referencing columns to match new user id type
ALTER TABLE logger MODIFY COLUMN userId VARCHAR(255) NULL;

-- Recreate the logger foreign key
ALTER TABLE logger ADD CONSTRAINT FK_user_logger FOREIGN KEY (userId) REFERENCES user(id) ON DELETE SET NULL;

-- 3. Add the missing type column for TypeORM Inheritance tracking
ALTER TABLE user ADD COLUMN type VARCHAR(255) DEFAULT 'UserEntity';

-- 4. Add the missing isTemporary column to the upload metadata table
ALTER TABLE upload ADD COLUMN isTemporary TINYINT(1) DEFAULT 0;

-- Re-enable foreign key checks
SET FOREIGN_KEY_CHECKS = 1;
