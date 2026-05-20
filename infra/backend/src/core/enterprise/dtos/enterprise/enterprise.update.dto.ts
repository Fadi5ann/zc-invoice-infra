import { ApiProperty } from '@nestjs/swagger';
import { CreateEnterpriseDto } from './enterprise.create.dto';
import { PartialType, OmitType } from '@nestjs/mapped-types';
import { UpdateEnterpriseInterlocutorDto } from '../enterprise-interlocutor/update-enterprise-interlocutor.dto';
import { IsArray, ValidateNested } from 'class-validator';
import { Type } from 'class-transformer';
import { Optional } from '@nestjs/common';

export class UpdateEnterpriseDto extends PartialType(
  OmitType(CreateEnterpriseDto, ['interlocutors']),
) {
  @ApiProperty({ type: UpdateEnterpriseInterlocutorDto })
  @IsArray()
  @Optional()
  @ValidateNested({ each: true })
  @Type(() => UpdateEnterpriseInterlocutorDto)
  interlocutors?: UpdateEnterpriseInterlocutorDto[];
}
