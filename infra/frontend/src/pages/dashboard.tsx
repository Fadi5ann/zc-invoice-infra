import React from 'react';
import { ComingSoon } from '@/components/shared';

export default function page() {
  return <ComingSoon />;
}
import { GetStaticProps } from 'next';
import { getI18nProps } from '@/lib/getStatic';

export const getStaticProps: GetStaticProps = async ({ locale }) => ({
  props: await getI18nProps(locale),
});