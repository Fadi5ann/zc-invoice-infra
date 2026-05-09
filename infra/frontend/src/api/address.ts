import { CreateAddressDto } from '@/types';

interface ValidationResult {
  message?: string;
}

const validate = (address: CreateAddressDto | undefined): ValidationResult => {
  if (!address) {
    return { message: 'Address is required.' };
  }

  if (!address.address?.trim()) {
    return { message: 'Address line 1 is required.' };
  }

  if (!address.region?.trim()) {
    return { message: 'Region is required.' };
  }

  if (!address.zipcode && address.zipcode !== 0) {
    return { message: 'Zip code is required.' };
  }

  if (!address.countryId || address.countryId < 0) {
    return { message: 'Country is required.' };
  }

  return {};
};

export const address = {
  validate
};
