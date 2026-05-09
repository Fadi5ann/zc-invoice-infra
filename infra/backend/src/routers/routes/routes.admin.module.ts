import { Module } from '@nestjs/common';
import { ConfigurationsModule } from 'src/shared/configurations/configurations.module';
import { ConfigurationController } from 'src/shared/configurations/controllers/configuration.controller';
import { LoggerController } from 'src/shared/logger/controller/logger.controller';
import { LoggerModule } from 'src/shared/logger/logger.module';
import { StoreController } from 'src/shared/store/controllers/store.controller';
import { StoreModule } from 'src/shared/store/store.module';

@Module({
  controllers: [ConfigurationController, LoggerController, StoreController],
  providers: [],
  exports: [],
  imports: [ConfigurationsModule, LoggerModule, StoreModule],
})
export class RoutesAdminModule {}
