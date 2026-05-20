import { faker } from '@faker-js/faker';
import { ApiProperty } from '@nestjs/swagger';
import { IsInt, IsOptional, IsString } from 'class-validator';

export class CreateAddressDto {
  @ApiProperty({ example: faker.location.streetAddress(), type: String })
  @IsString()
  address: string;

  @ApiProperty({ example: faker.location.secondaryAddress(), type: String })
  @IsString()
  @IsOptional()
  address2?: string;

  @ApiProperty({ example: faker.location.city(), type: String })
  @IsString()
  region: string;

  @ApiProperty({ example: faker.location.zipCode(), type: String })
  @IsString()
  zipcode: string;

  @ApiProperty({ example: 1, type: Number })
  @IsInt()
  countryId: number;
}
