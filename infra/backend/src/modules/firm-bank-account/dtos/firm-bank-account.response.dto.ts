import { faker } from '@faker-js/faker';
import { ApiProperty } from '@nestjs/swagger';
export class ResponseFirmBankAccountDto {
  @ApiProperty({
    required: false,
    example: faker.number.int(),
  })
  id?: number;
  @ApiProperty({
    required: false,
    example: faker.person.firstName(),
  })
  name?: string;

  @ApiProperty({
    required: false,
    example: faker.finance.bic(),
  })
  bic?: string;

  @ApiProperty({
    required: false,
    example: faker.finance.accountNumber(20),
  })
  rib?: string;

  @ApiProperty({
    required: false,
    example: faker.finance.iban(),
  })
  iban?: string;

  @ApiProperty({
    required: false,
    example: faker.number.int({ min: 1, max: 1000 }),
  })
  currencyId?: number;

  @ApiProperty({
    required: false,
    example: faker.datatype.boolean(),
  })
  isMain?: boolean;

  @ApiProperty({
    required: false,
    example: faker.number.int({ min: 1, max: 1000 }),
  })
  firmId?: number;
}
