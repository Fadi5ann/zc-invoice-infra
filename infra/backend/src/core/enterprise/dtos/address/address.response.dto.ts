import { faker } from '@faker-js/faker';
import { ApiProperty } from '@nestjs/swagger';
import { ResponseDtoHelper } from 'src/shared/database/dtos/database.response.dto';
import { Expose, Type } from 'class-transformer';
import { ResponseRefParamDto } from 'src/shared/reference-types/dtos/ref-param/response-ref-param.dto';

export class ResponseAddressDto extends ResponseDtoHelper {
  @ApiProperty({ type: Number })
  @Expose()
  id: number;

  @ApiProperty({ example: faker.location.streetAddress(), type: String })
  @Expose()
  address: string;

  @ApiProperty({ example: faker.location.secondaryAddress(), type: String })
  @Expose()
  address2: string;

  @ApiProperty({ example: faker.location.city(), type: String })
  @Expose()
  region: string;

  @ApiProperty({ example: faker.location.zipCode(), type: Number })
  @Expose()
  zipcode: number;

  @ApiProperty({ type: () => ResponseRefParamDto })
  @Expose()
  @Type(() => ResponseRefParamDto)
  country: ResponseRefParamDto;

  @ApiProperty({ type: Number })
  @Expose()
  countryId: number;
}
