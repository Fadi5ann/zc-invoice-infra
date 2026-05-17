import { UserEntity } from 'src/modules/user-management/entities/user.entity';
import { DeepPartial } from 'typeorm';

export const adminSeed: DeepPartial<UserEntity> = {
  username: 'superadmin',
  email: 'superadmin@example.com',
  // Replaced plain text with the bcrypt hash for 'password123'
  password: '$2a$12$R9h/LIPzIf5v11uUs90.DuGZbGY12IFnyE6u2E8S.O1.y8p/Lp9u.',
  isActive: true,
  // isApproved: true,
  firstName: 'Super$',
  lastName: 'Admin$',
};
