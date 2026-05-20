import { ApiProperty } from '@nestjs/swagger';
import { CreateInterlocutorDto } from '../interlocutor/interlocutor.create.dto';
import { IsObject, IsString, ValidateNested } from 'class-validator';
import { Type } from 'class-transformer';
import { Optional } from '@nestjs/common';

export class CreateEnterpriseInterlocutorDto {
  @ApiProperty({ type: CreateInterlocutorDto })
  @IsObject()
  @ValidateNested()
  @Type(() => CreateInterlocutorDto)
  interlocutor: CreateInterlocutorDto;

  @ApiProperty({ type: Boolean })
  @Optional()
  main: boolean;

  @ApiProperty({ type: String })
  @IsString()
  position: string;
}
