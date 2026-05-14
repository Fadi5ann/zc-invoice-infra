import React from 'react';

export interface ActivityActionsContextProps {
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

export const ActivityActionsContext = React.createContext<ActivityActionsContextProps>({
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

export const useActivityActions = () => React.useContext(ActivityActionsContext);