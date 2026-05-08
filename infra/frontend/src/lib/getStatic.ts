
const nextI18nextConfig = require('../../next-i18next.config.js');
import { serverSideTranslations } from 'next-i18next/serverSideTranslations';

// All your namespaces listed here
const ALL_NAMESPACES = [
  'common',
  'contacts',
  'content-management',
  'country',
  'currency',
  'invoicing',
  'logger',
  'permissions',
  'settings',
  'social-title',
];

export const getI18nProps = async (
  locale: string | undefined,
  namespaces: string[] = ALL_NAMESPACES // loads all by default
) => {
  return {
    ...(await serverSideTranslations(locale ?? 'fr', namespaces, nextI18nextConfig)),
  };
};