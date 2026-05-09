import React from 'react';
import { cn } from '@/lib/utils';
import { Select, SelectContent, SelectItem, SelectTrigger, SelectValue } from '../ui/select';
import { useRouter } from 'next/router';
import { useTranslation } from 'next-i18next';

interface LanguageSwitcherProps {
  className?: string;
}
export const LanguageSwitcher = ({ className }: LanguageSwitcherProps) => {
  const router = useRouter();
  const { i18n, t } = useTranslation();

    // ✅ Initialize immediately — no more undefined → string switch
  const [currentLanguage, setCurrentLanguage] = React.useState<string>(
    () => (typeof window !== 'undefined' ? localStorage.getItem('locale') : null) ?? i18n.language ?? 'fr'
  );

  React.useEffect(() => {
    if (currentLanguage !== i18n.language) {
      i18n.changeLanguage(currentLanguage);
    }
  }, []);  // run once on mount

  const onToggleLanguageClick = (newLocale: string) => {
    const { pathname, asPath, query } = router;

    router.push({ pathname, query }, asPath, { locale: newLocale }).then(() => {
      localStorage.setItem('locale', newLocale);
      i18n.changeLanguage(newLocale);
      setCurrentLanguage(newLocale);
    });
  };

  return (
    <div className={cn(className)}>
      <Select
        value={currentLanguage}
        onValueChange={onToggleLanguageClick}>
        <SelectTrigger>
          <SelectValue placeholder={t('selectLanguage')} />
        </SelectTrigger>
        <SelectContent>
          <SelectItem value="fr">{t('Français 🇫🇷')}</SelectItem>
          <SelectItem value="en">{t('English 🇬🇧')}</SelectItem>
        </SelectContent>
      </Select>
    </div>
  );
};
