export default function Page() {
  return null;
}
import { GetStaticProps } from 'next';
import { getI18nProps } from '@/lib/getStatic';

export const getStaticProps: GetStaticProps = async ({ locale }) => ({
  props: await getI18nProps(locale),
});