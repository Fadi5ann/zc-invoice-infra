import { Module } from '@nestjs/common';
import { UserManagementModule } from 'src/modules/user-management/user-management.module';
import { PermissionsSeederCommand } from './permissions.seeder';
import { RolesSeederCommand } from './roles.seeder';
import { AdminSeederCommand } from './admin.seeder';
import { CurrencyModule } from 'src/modules/currency/currency.module';
import { ActivityModule } from 'src/modules/activity/activity.module';
import { PaymentConditionModule } from 'src/modules/payment-condition/payment-condition.module';
import { CountryModule } from 'src/modules/country/country.module';
import { CabinetModule } from 'src/modules/cabinet/cabinet.module';
import { AddressModule } from 'src/modules/address/address.module';
import { SequencesSeederCommand } from './sequences.seeder';
import { SequenceModule } from 'src/modules/sequence/sequence.module';
import { RefCurrenciesSeedCommand } from './currencies.seeder';
import { ReferenceTypesModule } from 'src/shared/reference-types/reference-types.module';
import { RefActivitiesSeedCommand } from './activities.seeder';
import { RefCountriesSeedCommand } from './countries.seeder';
import { RefTaxWithholdingSeedCommand } from './tax-withholding.seeder';
import { RefPaymentConditionsSeedCommand } from './payment-conditions.seeder';
import { ConfigurationSeedCommand } from './configuration.seeder';
import { ConfigurationsModule } from 'src/shared/configurations/configurations.module';

@Module({
  providers: [
    PermissionsSeederCommand,
    RolesSeederCommand,
    AdminSeederCommand,
    // CabinetSeederCommand,
    SequencesSeederCommand,
    RefCurrenciesSeedCommand,
    RefActivitiesSeedCommand,
    RefCountriesSeedCommand,
    RefPaymentConditionsSeedCommand,
    RefTaxWithholdingSeedCommand,
    ConfigurationSeedCommand,
  ],
  imports: [
    ReferenceTypesModule,
    UserManagementModule,
    CurrencyModule,
    ActivityModule,
    PaymentConditionModule,
    CountryModule,
    CabinetModule,
    AddressModule,
    SequenceModule,
    ConfigurationsModule,
  ],
})
export class SeedersModule {}
