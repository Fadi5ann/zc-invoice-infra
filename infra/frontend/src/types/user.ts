import { DatabaseEntity } from './response/database-entity';
import { Role } from './role';
import { Upload } from './upload';

//abstract user dtos *****************************************************************************

export interface ResponseAbstractUserDto extends DatabaseEntity {
  id: string;
  firstName?: string;
  lastName?: string;
  dateOfBirth?: Date;
  isActive?: boolean;
  isApproved?: boolean;
  username: string;
  email: string;
  emailVerified?: Date;
  // role: ResponseRoleDto;
  // roleId: string;
}

export interface CreateAbstractUserDto {
  firstName?: string;
  lastName?: string;
  dateOfBirth?: string | Date;
  isActive?: boolean;
  isApproved?: boolean;
  password?: string;
  username: string;
  email: string;
  roleId?: string | number;
}

// eslint-disable-next-line @typescript-eslint/no-empty-object-type
export interface UpdateAbstractUserDto extends Partial<CreateAbstractUserDto> {}

//***********************************************************************************************

export interface UserPreferences {
  font?: string;
  theme?: string;
}

export interface ResponseUserDto {
  id: string;
  username?: string;
  firstName?: string;
  lastName?: string;
  email?: string;
  dateOfBirth?: string;
  role?: Role;
  roleId?: number;
  picture?: Upload;
  pictureId?: number;
  isActive?: boolean;
  isApproved?: boolean;
}

export interface CreateUserDto extends CreateAbstractUserDto {
  phone?: string;
  bio?: string;
  gender?: string; // Assuming Gender enum is string-based
  pictureId?: number;
}

export interface UpdateUserDto extends Partial<CreateUserDto> {}

// Type aliases for convenience
export type User = ResponseUserDto;
