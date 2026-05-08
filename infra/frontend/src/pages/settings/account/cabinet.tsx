import { GetStaticProps } from 'next';
import { getI18nProps } from '@/lib/getStatic';
import React from 'react';
import { InformationalSettings } from '@/components/settings/InformationalSettings';
import CabinetMain from '@/components/settings/Cabinet/CabinetMain';

export default function Page() {
  return (
    <InformationalSettings>
      <CabinetMain />
    </InformationalSettings>
  );
}

export const getStaticProps: GetStaticProps = async ({ locale }) => ({
  props: await getI18nProps(locale),
});
