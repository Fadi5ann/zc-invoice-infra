import React from 'react';
import { useTranslation } from 'next-i18next';
import { cn } from '@/lib/utils';
import { useActivityManager } from './hooks';
import { Input } from '@/components/ui/input';
import { Label } from '@/components/ui/label';

interface ActivityFormProps {
  className?: string;
}

export const ActivityForm: React.FC<ActivityFormProps> = ({ className }) => {
  const { t: tSettings } = useTranslation('settings');
  const activityManager = useActivityManager();
  const activity = activityManager.getActivity();

  return (
    <div className={cn('flex flex-col gap-4', className)}>
      <div className="flex flex-col gap-2">
        <Label htmlFor="activity-label">{tSettings('activity.label') || 'Activity Label'}</Label>
        <Input
          id="activity-label"
          placeholder="Enter activity label"
          value={activity.label || ''}
          onChange={(e) => {
            const updated = { ...activity, label: e.target.value };
            activityManager.setActivity(updated);
          }}
        />
      </div>
    </div>
  );
};
