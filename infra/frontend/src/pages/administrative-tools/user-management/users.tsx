import { GetStaticProps } from 'next';
import { getI18nProps } from '@/lib/getStatic';
import React from 'react';
import UserManagementSettings from '@/components/administrative-tools/UserManagementSettings';
import UserMain from '@/components/administrative-tools/user-management/user/UserMain';

export default function Page() {
  return (
    <UserManagementSettings>
      <UserMain />
    </UserManagementSettings>
  );
}

export const getStaticProps: GetStaticProps = async ({ locale }) => ({
  props: await getI18nProps(locale),
});
