import { GetStaticProps } from 'next';
import { getI18nProps } from '@/lib/getStatic';
import { RefTypePortal } from '@/components/content-management/reference-types/ref-types/RefTypePortal';

export default function RefType() {
  return <RefTypePortal />;
}

export const getStaticProps: GetStaticProps = async ({ locale }) => ({
  props: await getI18nProps(locale),
});
