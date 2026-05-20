import { Injectable } from '@nestjs/common';
import { EnterpriseRepository } from '../repositories/enterprise.repository';
import { AbstractCrudService } from 'src/shared/database/services/abstract-crud.service';
import { EnterpriseEntity } from '../entities/enterprise.entity';
import { CreateEnterpriseDto } from '../dtos/enterprise/enterprise.create.dto';
import { Transactional } from '@nestjs-cls/transactional';
import { EnterpriseInterlocutorService } from './enterprise-interlocutor.service';
import { AddressService } from './address.service';
import { UpdateEnterpriseDto } from '../dtos/enterprise/enterprise.update.dto';

@Injectable()
export class EnterpriseService extends AbstractCrudService<EnterpriseEntity> {
  constructor(
    private readonly enterpriseRepository: EnterpriseRepository,
    private readonly addressService: AddressService,
    private readonly enterpriseInterlocutorService: EnterpriseInterlocutorService,
  ) {
    super(enterpriseRepository);
  }

  @Transactional()
  async extendedSave(
    createEnterpriseDto: CreateEnterpriseDto,
  ): Promise<EnterpriseEntity> {
    const {
      invoicingAddress: invoicingAddressDto,
      deliveryAddress: deliveryAddressDto,
      interlocutors,
      ...enterpriseData
    } = createEnterpriseDto;

    const deliveryAddress = await this.addressService.save(deliveryAddressDto);
    const invoicingAddress =
      await this.addressService.save(invoicingAddressDto);

    const enterprise = await this.enterpriseRepository.save({
      ...enterpriseData,
      deliveryAddress,
      invoicingAddress,
    });

    if (interlocutors && interlocutors.length > 0) {
      await this.enterpriseInterlocutorService.extendedSaveMany(
        interlocutors.map((interlocutor) => ({
          ...interlocutor,
          enterprise,
        })),
      );
    }

    return enterprise;
  }

  @Transactional()
  async extendedUpdate(
    id: number,
    updateEnterpriseDto: UpdateEnterpriseDto,
  ): Promise<EnterpriseEntity> {
    const {
      invoicingAddress: invoicingAddressDto,
      deliveryAddress: deliveryAddressDto,
      ...enterpriseData
    } = updateEnterpriseDto;

    const enterprise = await this.findOneById(id);

    // It's safer to use .save() for address updates to correctly handle relation mapping.
    const deliveryAddress = deliveryAddressDto
      ? await this.addressService.save({
          id: enterprise.deliveryAddressId,
          ...deliveryAddressDto,
        })
      : enterprise.deliveryAddress;
    const invoicingAddress = invoicingAddressDto
      ? await this.addressService.save({
          id: enterprise.invoicingAddressId,
          ...invoicingAddressDto,
        })
      : enterprise.invoicingAddress;

    return this.enterpriseRepository.save({
      ...enterprise,
      ...enterpriseData,
      deliveryAddress,
      invoicingAddress,
    });
  }
}
