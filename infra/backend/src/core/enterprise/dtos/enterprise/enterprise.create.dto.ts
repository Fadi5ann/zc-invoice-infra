import { faker } from '@faker-js/faker';
import { ApiProperty } from '@nestjs/swagger';
import {
  IsArray,
  IsBoolean,
  IsObject,
  IsOptional,
  IsString,
  IsUrl,
  ValidateNested,
} from 'class-validator';
import { Type } from 'class-transformer';
import { CreateAddressDto } from '../address/address.create.dto';
import { CreateEnterpriseInterlocutorDto } from '../enterprise-interlocutor/create-enterprise-interlocutor.dto';
import { Optional } from '@nestjs/common';

export class CreateEnterpriseDto {
  @ApiProperty({ example: faker.company.name() })
  @IsString()
  name: string;

  @ApiProperty({ type: String })
  @IsString()
  phone: string;

  @ApiProperty({
    type: String,
  })
  @IsUrl()
  @IsOptional()
  website?: string;

  @ApiProperty({ type: Boolean })
  @IsBoolean()
  @IsOptional()
  particular?: boolean;

  @ApiProperty({ type: String })
  @IsString()
  taxId: string;

  @ApiProperty({ type: String })
  @IsOptional()
  @IsString()
  notes?: string;

  @ApiProperty({ type: Boolean })
  @IsBoolean()
  @IsOptional()
  system?: boolean;

  @ApiProperty({ type: Number })
  @IsOptional()
  activityId?: number;

  @ApiProperty({ type: Number })
  @IsOptional()
  currencyId?: number;

  @ApiProperty({ type: Number })
  @IsOptional()
  paymentConditionId?: number;

  @ApiProperty({ type: CreateAddressDto })
  @IsObject()
  @ValidateNested()
  @Type(() => CreateAddressDto)
  invoicingAddress: CreateAddressDto;

  @ApiProperty({ type: CreateAddressDto })
  @IsObject()
  @ValidateNested()
  @Type(() => CreateAddressDto)
  deliveryAddress: CreateAddressDto;

  @ApiProperty({ type: CreateEnterpriseInterlocutorDto })
  @IsArray()
  @Optional()
  @ValidateNested({ each: true })
  @Type(() => CreateEnterpriseInterlocutorDto)
  interlocutors?: CreateEnterpriseInterlocutorDto[];
}
