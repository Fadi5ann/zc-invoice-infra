import { GetStaticProps } from 'next';
import { getI18nProps } from '@/lib/getStatic';
import { RefParamPortal } from '@/components/content-management/reference-types/ref-params/RefParamPortal';

export default function RefType() {
  return <RefParamPortal />;
}

export const getStaticProps: GetStaticProps = async ({ locale }) => ({
  props: await getI18nProps(locale),
});
