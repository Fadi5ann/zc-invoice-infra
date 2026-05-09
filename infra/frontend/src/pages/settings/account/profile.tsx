import { GetStaticProps } from 'next';
import { getI18nProps } from '@/lib/getStatic';
import React from 'react';
import { ComingSoon } from '@/components/shared';
import { InformationalSettings } from '@/components/settings/InformationalSettings';

export default function Page() {
  return (
    <InformationalSettings>
      <ComingSoon />
    </InformationalSettings>
  );
}

export const getStaticProps: GetStaticProps = async ({ locale }) => ({
  props: await getI18nProps(locale),
});
