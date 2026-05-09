import { Module } from '@nestjs/common';
import { TemplateService } from './services/template.service';
import { TemplateRepository } from './repositories/template.repository';
import { TypeOrmModule } from '@nestjs/typeorm';
import { TemplateEntity } from './entities/template.entity';
import { StorageModule } from '../storage/storage.module';

@Module({
  controllers: [],
  providers: [TemplateService, TemplateRepository],
  exports: [TemplateService],
  imports: [TypeOrmModule.forFeature([TemplateEntity]), StorageModule],
})
export class TemplateModule {}
