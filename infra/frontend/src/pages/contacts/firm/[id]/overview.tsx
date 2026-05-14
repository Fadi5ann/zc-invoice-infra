import { GetServerSideProps } from 'next';
import { getI18nProps } from '@/lib/getStatic';
import React from 'react';
import { useRouter } from 'next/router';
import { FirmDetails } from '@/components/contacts/enterprise/FirmDetails';
import { ComingSoon } from '@/components/shared';

export default function Page() {
  const router = useRouter();
  const id = router.query.id as string;

  return (
    <FirmDetails firmId={id}>
      <ComingSoon />
    </FirmDetails>
  );
}

export const getServerSideProps: GetServerSideProps = async ({ locale }) => ({
  props: await getI18nProps(locale),
});
