import { ApiProperty } from '@nestjs/swagger';
import { IsEnum, IsJSON, IsOptional, IsString, Length } from 'class-validator';
import { TemplateType } from 'src/app/enums/template-type.enum';

export class CreateTemplateDto {
  @ApiProperty({ type: String })
  @IsString()
  @Length(1, 255)
  name: string;

  @ApiProperty({ type: String, required: false })
  @IsString()
  @IsOptional()
  description?: string;

  @ApiProperty({ enum: TemplateType, required: false })
  @IsEnum(TemplateType)
  @IsOptional()
  templateType?: TemplateType;

  @ApiProperty({ type: Number, required: false })
  @IsOptional()
  documentId?: number;

  @ApiProperty({ type: Object, required: false })
  @IsOptional()
  @IsJSON()
  variables?: object;

  @ApiProperty({ type: Object, required: false })
  @IsOptional()
  @IsJSON()
  backupVariables?: object;
}
