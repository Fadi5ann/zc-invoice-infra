import React from 'react';

export type BreadcrumbRoute = { title: string; href?: string };

interface BreadcrumbContextProps {
  routes: BreadcrumbRoute[];
  setRoutes: (routes: BreadcrumbRoute[]) => void;
  clearRoutes: () => void;
}

const defaultBreadcrumbContext: BreadcrumbContextProps = {
  routes: [],
  setRoutes: () => {},
  clearRoutes: () => {}
};

export const BreadcrumbContext = React.createContext<BreadcrumbContextProps>(
  defaultBreadcrumbContext
);

export const useBreadcrumb = () => React.useContext(BreadcrumbContext);
