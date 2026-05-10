import { Country } from './country';
import { DatabaseEntity } from './response/database-entity';

export interface Address extends DatabaseEntity {
  id?: number;
  address?: string;
  address2?: string;
  region?: string;
  zipcode?: string;
  country?: Country;
  countryId?: number;
}

export type AddressType = 'invoicingAddress' | 'deliveryAddress' | '';
// export interface CreateAddressDto extends Omit<Address, 'createdAt' | 'updatedAt' | 'deletedAt' | 'country' | 'id'>{}
// Uncomment and add isDeletionRestricted to the Omit
export interface CreateAddressDto extends Omit<
  Address,
  'createdAt' | 'updatedAt' | 'deletedAt' | 'isDeletionRestricted' | 'country' | 'id'
> {}

export interface UpdateAddressDto extends Partial<CreateAddressDto> {
  id?: number;
}
