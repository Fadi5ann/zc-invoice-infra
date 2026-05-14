import React from 'react';

export interface TaxActionsContextProps {
  openCreateTaxSheet: () => void;
  openUpdateTaxSheet: () => void;
  openDeleteTaxDialog: () => void;
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

export const TaxActionsContext = React.createContext<TaxActionsContextProps>({
  openCreateTaxSheet: () => {},
  openUpdateTaxSheet: () => {},
  openDeleteTaxDialog: () => {},
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

export const useTaxActions = () => React.useContext(TaxActionsContext);