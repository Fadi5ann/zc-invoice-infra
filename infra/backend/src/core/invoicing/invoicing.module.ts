import { Module } from '@nestjs/common';
import { TypeOrmModule } from '@nestjs/typeorm';
import { QuotationEntity } from './entities/quotation.entity';
import { QuotationRepository } from './repositories/quotation.repository';
import { QuotationService } from './services/quotation.service';
import { QuotationArticleRepository } from './repositories/quotation-article.repository';
import { QuotationArticleService } from './services/quotation-article.service';
import { QuotationWorkflowService } from './services/quotation-workflow.service';
import { QuotationArticleEntity } from './entities/quotation-article.entity';
import { InventoryModule } from '../inventory/inventory.module';
import { TaxModule } from '../tax/tax.module';

@Module({
  exports: [
    QuotationRepository,
    QuotationArticleRepository,
    QuotationService,
    QuotationArticleService,
    QuotationWorkflowService,
  ],
  providers: [
    QuotationRepository,
    QuotationArticleRepository,
    QuotationService,
    QuotationArticleService,
    QuotationWorkflowService,
  ],
  imports: [
    TypeOrmModule.forFeature([QuotationEntity, QuotationArticleEntity]),
    InventoryModule,
    TaxModule,
  ],
})
export class InvoicingModule {}
