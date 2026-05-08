import { Address, AddressType } from '@/types';

export const AbstractCopyAddressHandler = (
  prefix: AddressType,
  invoicingAddress: Address | undefined,
  setInvoicingAddress: (a?: Address) => void,
  deliveryAddress: Address | undefined,
  setDeliveryAddress: (a?: Address) => void
) => {
  if (prefix === 'invoicingAddress') {
    setDeliveryAddress(invoicingAddress ? { ...invoicingAddress } : undefined);
  } else if (prefix === 'deliveryAddress') {
    setInvoicingAddress(deliveryAddress ? { ...deliveryAddress } : undefined);
  }
};