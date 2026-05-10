import { GetStaticProps } from 'next';
import { getI18nProps } from '@/lib/getStatic';
import React from 'react';
import { InformationalSettings } from '@/components/settings/InformationalSettings';
import { BankAccountMain } from './BankAccountPortal';

export default function Page() {
  return (
    <InformationalSettings>
      <BankAccountMain />
    </InformationalSettings>
  );
}

export const getStaticProps: GetStaticProps = async ({ locale }) => ({
  props: await getI18nProps(locale),
});
