import { Injectable } from '@nestjs/common';
import { AbstractCrudService } from 'src/shared/database/services/abstract-crud.service';
import { AddressEntity } from '../entities/address.entity';
import { AddressRepository } from '../repositories/address.repository';
import { DeepPartial } from 'typeorm';
import { QueryDeepPartialEntity } from 'typeorm/query-builder/QueryPartialEntity.js';

@Injectable()
export class AddressService extends AbstractCrudService<AddressEntity> {
  constructor(private readonly addressRepository: AddressRepository) {
    super(addressRepository);
  }

  async save(dto: DeepPartial<AddressEntity>) {
    const address = this.addressRepository.create({
      ...dto,
      country: dto.countryId ? { id: dto.countryId } : undefined,
    });
    return this.addressRepository.save(address);
  }

  async update(id: string | number, dto: QueryDeepPartialEntity<AddressEntity>) {
    const entity = await this.findOneById(id);
    if (!entity) throw new Error('Entity not found');
    
    return this.addressRepository.update(id, dto);
  }
}
