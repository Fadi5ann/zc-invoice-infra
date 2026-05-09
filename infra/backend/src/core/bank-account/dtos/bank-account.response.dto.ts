import { faker } from '@faker-js/faker';
import { ApiProperty } from '@nestjs/swagger';
import { Expose, Type } from 'class-transformer';
import { ResponseDtoHelper } from 'src/shared/database/dtos/database.response.dto';
import { ResponseRefParamDto } from 'src/shared/reference-types/dtos/ref-param/response-ref-param.dto';

export class ResponseBankAccountDto extends ResponseDtoHelper {
  @ApiProperty({ example: faker.number.int() })
  @Expose()
  id: number;

  @ApiProperty({ example: faker.person.firstName() })
  @Expose()
  name: string;

  @ApiProperty({ example: faker.finance.bic() })
  @Expose()
  bic: string;

  @ApiProperty({ example: faker.finance.accountNumber(20) })
  @Expose()
  rib: string;

  @ApiProperty({ example: faker.finance.iban() })
  @Expose()
  iban: string;

  @ApiProperty({ type: String })
  @Expose()
  currencyId: number;

  @ApiProperty({ type: ResponseRefParamDto })
  @Expose()
  @Type(() => ResponseRefParamDto)
  currency: ResponseRefParamDto;

  @ApiProperty({ example: faker.datatype.boolean() })
  @Expose()
  isMain: boolean;
}
