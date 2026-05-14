import { Activity } from '@/types';
import { useState } from 'react';

export interface ActivityManager {
  id?: number;
  label?: string;
  setActivity: (activity: Activity) => void;
  getActivity: () => Activity;
  reset: () => void;
}

const initialState: Partial<Activity> = {
  id: undefined,
  label: ''
};

export const useActivityManager = (): ActivityManager => {
  const [activity, setActivityState] = useState<Activity>(initialState as Activity);

  const setActivity = (newActivity: Activity) => {
    setActivityState(newActivity);
  };

  const getActivity = (): Activity => {
    return activity;
  };

  const reset = () => {
    setActivityState(initialState as Activity);
  };

  return {
    id: activity.id,
    label: activity.label,
    setActivity,
    getActivity,
    reset
  };
};
