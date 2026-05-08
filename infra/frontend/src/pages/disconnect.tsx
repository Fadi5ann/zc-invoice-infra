import React from 'react';
import DisconnectComponent from '@/components/auth/DisconnectComponent';

export default function page() {
  return <DisconnectComponent />;
}
import { GetStaticProps } from 'next';
import { getI18nProps } from '@/lib/getStatic';

export const getStaticProps: GetStaticProps = async ({ locale }) => ({
  props: await getI18nProps(locale),
});