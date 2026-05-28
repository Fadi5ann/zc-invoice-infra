import { Injectable } from '@nestjs/common';
import { AbstractCrudService } from 'src/shared/database/services/abstract-crud.service';
import { QuotationEntity } from '../entities/quotation.entity';
import { QuotationRepository } from '../repositories/quotation.repository';
import { DeepPartial } from 'typeorm';
import { QuotationArticleEntity } from '../entities/quotation-article.entity';
import { QuotationArticleService } from './quotation-article.service';
import { Transactional } from '@nestjs-cls/transactional';

@Injectable()
export class QuotationService extends AbstractCrudService<QuotationEntity> {
  constructor(
    private readonly quotationArticleService: QuotationArticleService,
    quotationRepository: QuotationRepository,
  ) {
    super(quotationRepository);
  }

  @Transactional()
  async extendedSave(
    quotation: DeepPartial<QuotationEntity>,
  ): Promise<QuotationEntity> {
    const { quotationArticles, ...quotationData } = quotation;
    const created = await this.repository.save(quotationData);
    if (!created) {
      throw new Error('Failed to create quotation');
    }
    await this.quotationArticleService.extendedSaveMany(
      quotationArticles.map((article: DeepPartial<QuotationArticleEntity>) => ({
        ...article,
        quotationId: created.id,
      })),
    );
    return created;
  }

  @Transactional()
  async extendedUpdate(id: number, quotation: DeepPartial<QuotationEntity>) {
    // const existing = await this.repository.findOneById(id);
    // if (!this.quotationWorkflowService.isUpdatable(existing.status)) {
    //   throw new BadRequestException(
    //     `Quotation with status '${existing.status}' cannot be updated`,
    //   );
    // }

    const { quotationArticles, ...quotationData } = quotation;
    const updated = await this.repository.update(id, quotationData);
    if (!updated) {
      throw new Error('Failed to update quotation');
    }

    const existingArticles = quotationArticles.filter(
      (article: DeepPartial<QuotationArticleEntity>) => article.id,
    );

    const newArticles = quotationArticles.filter(
      (article: DeepPartial<QuotationArticleEntity>) => !article.id,
    );

    await Promise.all([
      this.quotationArticleService.extendedUpdateMany(
        existingArticles.map(
          (article: DeepPartial<QuotationArticleEntity>) => ({
            id: article.id,
            data: {
              ...article,
              quotationId: id,
            },
          }),
        ),
      ),
      this.quotationArticleService.extendedSaveMany(
        newArticles.map((article: DeepPartial<QuotationArticleEntity>) => ({
          ...article,
          quotationId: id,
        })),
      ),
    ]);

    return this.repository.findOneById(id);
  }
}
