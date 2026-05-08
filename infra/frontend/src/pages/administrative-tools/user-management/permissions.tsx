import { GetStaticProps } from 'next';
import { getI18nProps } from '@/lib/getStatic';
import PermissionMain from '@/components/administrative-tools/user-management/permission/PermissionMain';
import UserManagementSettings from '@/components/administrative-tools/UserManagementSettings';
import React from 'react';

export default function Page() {
  return (
    <UserManagementSettings>
      <PermissionMain />
    </UserManagementSettings>
  );
}

export const getStaticProps: GetStaticProps = async ({ locale }) => ({
  props: await getI18nProps(locale),
});
