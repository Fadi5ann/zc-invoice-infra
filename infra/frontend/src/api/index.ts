import { admin } from './admin';
export * from './admin';
import { auth } from './auth';
export * from './auth';

import { appConfig } from './app-config';
export * from './app-config';

import { cabinet } from './cabinet';
export * from './cabinet';
import { core } from './core';
export * from './core';
import { defaultCondition } from './default-condition';
export * from './default-condition';
import { interlocutor } from './interlocutor';
export * from './interlocutor';
import { firmInterlocutorEntry } from './firm-interlocutor-entry';
export * from './firm-interlocutor-entry';

import { invoice } from './invoice';
export * from './invoice';
import { payment } from './payment';
export * from './payment';
import { permission } from './permission';
export * from './permission';

import { role } from './role';
export * from './role';
import { sequence } from './sequence';
export * from './sequence';
import { tax } from './tax';
export * from './tax';
import { upload } from './upload';
export * from './upload';
import { user } from './user';
export * from './user';

import { invoicing } from './invoicing';
export * from './invoicing';

export * from '../types/response';
export * from '../types/enums';

export const api = {
  admin,
  auth,
  appConfig,
  cabinet,
  core,
  defaultCondition,
  firmInterlocutorEntry,
  interlocutor,
  invoice,
  invoicing,
  payment,
  permission,
  role,
  sequence,
  tax,
  upload,
  user,
  quotation: invoicing.quotation // Add quotation to root level for backward compatibility
};