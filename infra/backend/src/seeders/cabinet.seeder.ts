import { Command } from 'nestjs-command';
import { Injectable } from '@nestjs/common';
import { CabinetService } from 'src/modules/cabinet/services/cabinet.service';
import { ActivityService } from 'src/modules/activity/services/activity.service';
import { CurrencyService } from 'src/modules/currency/services/currency.service';
import { AddressService } from 'src/modules/address/services/address.service';
import { CountryService } from 'src/modules/country/services/country.service';

import {
  cabinetAddressSeederData,
  cabinetSeederData,
} from './data/cabinet.data';

@Injectable()
export class CabinetSeederCommand {
  constructor(
    private readonly cabinetService: CabinetService,
    private readonly activityService: ActivityService,
    private readonly currencyService: CurrencyService,
    private readonly addressService: AddressService,
    private readonly countryService: CountryService,
  ) {}

  @Command({
    command: 'seed:cabinet',
    describe: 'seed system cabinet',
  })
  async seed() {
    const start = new Date();
    console.log('Starting seeding of cabinet');

    // 1. Safely Resolve Country (Handles technical debt in AddressService)
    let countryId = null;
    try {
      let countries = await this.countryService.findAll();
      let countryList = Array.isArray(countries)
        ? countries
        : (countries as any)?.items || (countries as any)?.data || [];
      if (countryList.length === 0) {
        await this.countryService.save({
          alpha2Code: 'FR',
          alpha3Code: 'FRA',
        });
        countries = await this.countryService.findAll();
        countryList = Array.isArray(countries)
          ? countries
          : (countries as any)?.items || (countries as any)?.data || [];
      }
      countryId = countryList.length > 0 ? countryList[0].id : null;
    } catch (e: any) {
      console.warn('Could not fetch/create country:', e.message);
    }

    // 2. Safely Resolve Activity
    let activityId = null;
    try {
      let activities = await this.activityService.findAll();
      let actList = Array.isArray(activities)
        ? activities
        : (activities as any)?.items || (activities as any)?.data || [];
      if (actList.length === 0) {
        await this.activityService.save({
          label: 'Software Development',
        });
        activities = await this.activityService.findAll();
        actList = Array.isArray(activities)
          ? activities
          : (activities as any)?.items || (activities as any)?.data || [];
      }
      activityId = actList.length > 0 ? actList[0].id : null;
    } catch (e: any) {
      console.warn('Could not fetch/create activity:', e.message);
    }

    // 3. Safely Resolve Currency
    let currencyId = null;
    try {
      let currencies = await this.currencyService.findAll();
      let curList = Array.isArray(currencies)
        ? currencies
        : (currencies as any)?.items || (currencies as any)?.data || [];
      if (curList.length === 0) {
        await this.currencyService.save({
          label: 'Euro',
          code: 'EUR',
          symbol: '€',
          digitAfterComma: 2,
        });
        currencies = await this.currencyService.findAll();
        curList = Array.isArray(currencies)
          ? currencies
          : (currencies as any)?.items || (currencies as any)?.data || [];
      }
      currencyId = curList.length > 0 ? curList[0].id : null;
    } catch (e: any) {
      console.warn('Could not fetch/create currency:', e.message);
    }

    // 4. Create Address
    const addressData: any = { ...cabinetAddressSeederData };
    if (countryId) {
      addressData.countryId = countryId;
    } else {
      delete addressData.countryId;
    }
    const address = await this.addressService.save(addressData);

    // 5. Create Cabinet
    const cabinetData: any = {
      ...cabinetSeederData,
      addressId: address.id,
    };
    if (activityId) {
      cabinetData.activityId = activityId;
    } else {
      delete cabinetData.activityId;
    }
    if (currencyId) {
      cabinetData.currencyId = currencyId;
    } else {
      delete cabinetData.currencyId;
    }

    await this.cabinetService.save(cabinetData);

    const end = new Date();
    console.log(`Seeding completed in ${end.getTime() - start.getTime()}ms`);
  }
}
