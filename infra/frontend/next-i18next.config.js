
//  HttpBackend must use the /cjs path
const HttpBackend = require('i18next-http-backend/cjs');

// These two need .default
const ChainedBackend = require('i18next-chained-backend').default;
const LocalStorageBackend = require('i18next-localstorage-backend').default;

const isBrowser = typeof window !== 'undefined';
const development = process.env.NODE_ENV === 'development';

const nextI18NextConfig = {
  use: isBrowser ? [ChainedBackend] : [],

  backend: {
    backendOptions: [
      {
        // LocalStorageBackend options
        expirationTime: development ? 0 : 60 * 60 * 1000,
      },
      {
        // HttpBackend options
        loadPath: '/locales/{{lng}}/{{ns}}.json',
      },
    ],
    backends: isBrowser ? [LocalStorageBackend, HttpBackend] : [],
  },

  i18n: {
    defaultLocale: 'fr',
    locales: ['fr', 'en'],
  },

  serializeConfig: false,
  defaultNS: 'common',

  ns: [
    'common',
    'contacts',
    'country',
    'currency',
    'invoicing',
    'logger',
    'permissions',
  ],
};

module.exports = nextI18NextConfig;