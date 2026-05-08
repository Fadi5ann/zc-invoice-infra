import { ApiProperty } from '@nestjs/swagger';
import { Expose, Type } from 'class-transformer';
import { TemplateType } from 'src/app/enums/template-type.enum';
import { ResponseDtoHelper } from 'src/shared/database/dtos/database.response.dto';
import { ResponseStorageDto } from 'src/shared/storage/dtos/response-storage.dto';

export class ResponseTemplateDto extends ResponseDtoHelper {
  @ApiProperty({ type: String })
  @Expose()
  id: string;

  @ApiProperty({ type: String })
  @Expose()
  name: string;

  @ApiProperty({ enum: TemplateType })
  @Expose()
  templateType?: TemplateType;

  @ApiProperty({ type: String })
  @Expose()
  description?: string;

  @ApiProperty({ type: ResponseStorageDto })
  @Expose()
  @Type(() => ResponseStorageDto)
  document?: ResponseStorageDto;

  @ApiProperty({ type: Number })
  @Expose()
  documentId?: number;

  @ApiProperty({ type: Object })
  @Expose()
  variables?: object;

  @ApiProperty({ type: Object })
  @Expose()
  backupVariables?: object;
}
