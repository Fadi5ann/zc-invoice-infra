import React from 'react';

export interface PaymentConditionActionsContextProps {
  openCreateDialog: () => void;
  openUpdateDialog: () => void;
  openDeleteDialog: () => void;
  searchTerm: string;
  setSearchTerm: (term: string) => void;
  page: number;
  totalPageCount: number;
  setPage: (page: number) => void;
  size: number;
  setSize: (size: number) => void;
  order: boolean;
  sortKey: string;
  setSortDetails: (order: boolean, sortKey: string) => void;
}

export const PaymentConditionActionsContext = React.createContext<PaymentConditionActionsContextProps>({
  openCreateDialog: () => {},
  openUpdateDialog: () => {},
  openDeleteDialog: () => {},
  searchTerm: '',
  setSearchTerm: () => {},
  page: 1,
  totalPageCount: 1,
  setPage: () => {},
  size: 10,
  setSize: () => {},
  order: true,
  sortKey: 'id',
  setSortDetails: () => {},
});

export const usePaymentConditionActions = () => React.useContext(PaymentConditionActionsContext);