import { Injectable } from '@nestjs/common';
import { AddressRepository } from '../repositories/address.repository';
import { CreateAddressDto } from '../dtos/address.create.dto';
import { UpdateAddressDto } from '../dtos/address.update.dto';
import { CountryService } from 'src/modules/country/services/country.service';
import { AddressNotFoundException } from '../errors/address.notfound.error';
import { AddressEntity } from '../entities/address.entity';

@Injectable()
export class AddressService {
  constructor(
    private readonly addressRepository: AddressRepository,
    private countryService: CountryService,
  ) {}

  async findOneById(id: number): Promise<AddressEntity> {
    const address = await this.addressRepository.findOneById(id);
    if (!address) {
      throw new AddressNotFoundException();
    }
    return address;
  }

  async save(createAddressDto: CreateAddressDto): Promise<AddressEntity> {
    const country = await this.countryService.findOneById(
      createAddressDto.countryId,
    );
    if (!country) {
      throw new Error(
        `Country with ID ${createAddressDto.countryId} does not exist.`,
      );
    }

    const { zipcode, countryId, ...rest } = createAddressDto;

    // 2. Create the entity instance
    const address = this.addressRepository.create({
      ...rest,
      zipcode,
      countryId,
      country: country, // TypeORM handles the rest via the Relation
    });

    // 3. Save the instance
    return this.addressRepository.save(address);
  }

  async update(
    id: number,
    updateAddressDto: UpdateAddressDto,
  ): Promise<AddressEntity> {
    await this.findOneById(id);

    const country = await this.countryService.findOneById(
      updateAddressDto.countryId,
    );
    if (!country) {
      throw new Error(
        `Country with ID ${updateAddressDto.countryId} does not exist.`,
      );
    }

    const { zipcode, countryId, ...rest } = updateAddressDto;

    const addressData = {
      ...rest,
      zipcode,
      countryId,
      country: country,
    };

    // Pass the payload directly
    await this.addressRepository.update(id, addressData);

    return this.findOneById(id);
  }

  async softDelete(id: number): Promise<AddressEntity> {
    await this.findOneById(id);
    return this.addressRepository.softDelete(id);
  }
}
