-- Disable foreign key checks temporarily to allow structural changes
SET FOREIGN_KEY_CHECKS = 0;

-- 1. Sync the permission table ID type with the string slugs used by code
ALTER TABLE permission MODIFY id VARCHAR(255) NOT NULL;

-- 2. Sync the user table ID type with TypeORM's UUID strings
ALTER TABLE user MODIFY id VARCHAR(255) NOT NULL;

-- 3. Add the missing type column for TypeORM Inheritance tracking
ALTER TABLE user ADD COLUMN type VARCHAR(255) DEFAULT 'UserEntity';

-- 4. Add the missing isTemporary column to the upload metadata table
ALTER TABLE upload ADD COLUMN isTemporary TINYINT(1) DEFAULT 0;

-- Re-enable foreign key checks
SET FOREIGN_KEY_CHECKS = 1;
