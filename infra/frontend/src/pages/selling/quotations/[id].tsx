import { QuotationUpdateForm } from '@/components/invoicing/quotation/forms/QuotationUpdateForm';
import { useRouter } from 'next/router';

export default function Page() {
  const router = useRouter();
  const id = router.query.id as string;
  return <QuotationUpdateForm id={Number(id)} />;
}

export async function getServerSideProps() {
  return { props: {} };
}
