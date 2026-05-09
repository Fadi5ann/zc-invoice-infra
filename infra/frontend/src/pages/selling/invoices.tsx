import { GetStaticProps } from 'next';
import { getI18nProps } from '@/lib/getStatic';
import React from 'react';
import { InvoicePortal } from '@/components/selling/invoice/InvoicePortal';

export default function InvoicesPage() {
  return <InvoicePortal />;
}

export const getStaticProps: GetStaticProps = async ({ locale }) => ({
  props: await getI18nProps(locale),
});
