import { GetStaticProps } from 'next';
import { getI18nProps } from '@/lib/getStatic';
import { LoggerMain } from '@/components/administrative-tools/Logger/LoggerMain';

export default function Page() {
  return <LoggerMain />;
}

export const getStaticProps: GetStaticProps = async ({ locale }) => ({
  props: await getI18nProps(locale),
});
