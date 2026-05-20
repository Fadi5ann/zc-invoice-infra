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

    const address = new AddressEntity();
    address.address = createAddressDto.address;
    address.address2 = createAddressDto.address2;
    address.region = createAddressDto.region;
    address.zipcode = createAddressDto.zipcode;
    address.country = country;

    return this.addressRepository.save(address);
  }

  async update(
    id: number,
    updateAddressDto: UpdateAddressDto,
  ): Promise<AddressEntity> {
    const addressToUpdate = await this.findOneById(id);

    const country = await this.countryService.findOneById(
      updateAddressDto.countryId,
    );

    addressToUpdate.address = updateAddressDto.address;
    addressToUpdate.address2 = updateAddressDto.address2;
    addressToUpdate.region = updateAddressDto.region;
    addressToUpdate.zipcode = updateAddressDto.zipcode;
    addressToUpdate.country = country;

    return this.addressRepository.save(addressToUpdate);
  }

  async softDelete(id: number): Promise<AddressEntity> {
    await this.findOneById(id);
    return this.addressRepository.softDelete(id);
  }
}
