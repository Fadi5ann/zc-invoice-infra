import React, { useEffect } from 'react';
import { signOut } from 'next-auth/react';
import { useAuthPersistStore } from '@/hooks/stores/useAuthPersistStore';
import { Spinner } from '@/components/shared/Spinner';
import { useTranslation } from 'next-i18next';

export default function DisconnectComponent() {
  const authPersistStore = useAuthPersistStore();
  const { t } = useTranslation('common');

  useEffect(() => {
    const performDisconnect = async () => {
      authPersistStore.logout();
      await signOut({ callbackUrl: '/login' });
    };
    
    performDisconnect();
  }, [authPersistStore]);

  return (
    <div className="flex h-screen w-full items-center justify-center">
      <Spinner size="large" />
    </div>
  );
}
