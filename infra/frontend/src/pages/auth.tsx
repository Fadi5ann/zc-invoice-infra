import { AuthenticationLayout } from '@/components/auth/AuthenticationLayout';

export default function Page() {
  return <AuthenticationLayout />;
}
import { GetStaticProps } from 'next';
import { getI18nProps } from '@/lib/getStatic';

export const getStaticProps: GetStaticProps = async ({ locale }) => ({
  props: await getI18nProps(locale),
});