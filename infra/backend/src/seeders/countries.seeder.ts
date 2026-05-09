import { Command } from 'nestjs-command';
import { Injectable } from '@nestjs/common';
import { RefTypeRepository } from 'src/shared/reference-types/repositories/ref-type.repository';
import { RefParamRepository } from 'src/shared/reference-types/repositories/ref-param.repository';
import { countriesSeed } from './data/countries.data';

@Injectable()
export class RefCountriesSeedCommand {
  constructor(
    private readonly refTypeRepository: RefTypeRepository,
    private readonly refParamRepository: RefParamRepository,
  ) {}

  @Command({
    command: 'seed:countries',
    describe: 'Seed system countries',
  })
  async seed() {
    const start = new Date();
    console.log('🚀 Starting seeding of countries...');
    //=============================================================================================
    let countryRefType = await this.refTypeRepository.findOne({
      where: { label: 'Country' },
    });

    if (!countryRefType) {
      countryRefType = await this.refTypeRepository.save({
        id: 'country',
        label: 'Country',
        description: 'Parent reference type for all countries',
      });
      for (const country of countriesSeed) {
        await this.refParamRepository.save({
          label: country.alpha2Code,
          description: `Description for ${country.alpha2Code}`,
          refType: countryRefType,
          extras: {
            alpha3Code: country.alpha3Code,
          },
        });
      }
    }
    //=============================================================================================
    const end = new Date();
    console.log(
      `✅ Seeding completed in ${end.getTime() - start.getTime()}ms ⏱️`,
    );
  }
}
