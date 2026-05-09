import React from 'react';
import { EnterprisePortal } from '@/components/contacts/enterprise/EnterprisePortal';
import { GetStaticProps } from 'next';
import { getI18nProps } from '@/lib/getStatic';
export default function Page() {
  return <EnterprisePortal />;
}

export const getStaticProps: GetStaticProps = async ({ locale }) => ({
  props: await getI18nProps(locale),  // No need to pass namespaces — loads ALL by default
});