import React from 'react';
import { toast } from 'sonner';
import { useMutation, useQuery } from '@tanstack/react-query';
import { api } from '@/api';
import { getErrorMessage } from '@/utils/errors';
import { useDebounce } from '@/hooks/other/useDebounce';
import { ActivityDeleteDialog } from './dialogs/ActivityDeleteDialog';
import { useTranslation } from 'next-i18next';
import { ActivityUpdateDialog } from './dialogs/ActivityUpdateDialog';
import { useActivityManager } from './hooks';
import { ActivityCreateDialog } from './dialogs/ActivityCreateDialog';
import { Activity } from '@/types';
import { DataTable } from './data-table/data-table';
import { ActivityActionsContext } from './data-table/ActionDialogContext';
import { getActivityColumns } from './data-table/columns';
import { useBreadcrumb } from '@/context/BreadcrumbContext';
import { useRouter } from 'next/router';
import ContentSection from '@/components/shared/ContentSection';
import { cn } from '@/lib/utils';

interface ActivityMainProps {
  className?: string;
}

const ActivityMain: React.FC<ActivityMainProps> = ({ className }) => {
  //next-router
  const router = useRouter();
  const { t: tSettings } = useTranslation('settings');
  const { t: tCommon } = useTranslation('common');

  //set page title in the breadcrumb
  const { setRoutes } = useBreadcrumb();
  React.useEffect(() => {
    setRoutes([
      { title: tCommon('menu.settings') },
      { title: tCommon('submenu.system') },
      { title: tCommon('settings.system.activity') }
    ]);
  }, [router.locale, setRoutes, tCommon]);

  const activityManager = useActivityManager();

  const [page, setPage] = React.useState(1);
  const { value: debouncedPage, loading: paging } = useDebounce<number>(page, 500);

  const [size, setSize] = React.useState(5);
  const { value: debouncedSize, loading: resizing } = useDebounce<number>(size, 500);

  const [sortDetails, setSortDetails] = React.useState({ order: true, sortKey: 'id' });
  const { value: debouncedSortDetails, loading: sorting } = useDebounce<typeof sortDetails>(
    sortDetails,
    500
  );

  const [searchTerm, setSearchTerm] = React.useState('');
  const { value: debouncedSearchTerm, loading: searching } = useDebounce<string>(searchTerm, 500);

  const [createDialog, setCreateDialog] = React.useState(false);
  const [updateDialog, setUpdateDialog] = React.useState(false);
  const [deleteDialog, setDeleteDialog] = React.useState(false);

  const {
    isPending: isFetchPending,
    error,
    data: activitiesResp,
    refetch: refetchActivities
  } = useQuery({
    queryKey: [
      'activities',
      debouncedPage,
      debouncedSize,
      debouncedSortDetails.order,
      debouncedSortDetails.sortKey,
      debouncedSearchTerm
    ],
    queryFn: () =>
      (api as any).activity.findPaginated(
        debouncedPage,
        debouncedSize,
        debouncedSortDetails.order ? 'ASC' : 'DESC',
        debouncedSortDetails.sortKey,
        'label',
        debouncedSearchTerm
      )
  });

  const activities = React.useMemo(() => {
    return activitiesResp?.data || [];
  }, [activitiesResp]);

  const context = {
    //dialogs
    openCreateDialog: () => setCreateDialog(true),
    openUpdateDialog: () => setUpdateDialog(true),
    openDeleteDialog: () => setDeleteDialog(true),
    //search, filtering, sorting & paging
    searchTerm,
    setSearchTerm,
    page,
    totalPageCount: activitiesResp?.meta.pageCount || 1,
    setPage,
    size,
    setSize,
    order: sortDetails.order,
    sortKey: sortDetails.sortKey,
    setSortDetails: (order: boolean, sortKey: string) => setSortDetails({ order, sortKey })
  };

  const { mutate: createMutation, isPending: isCreatePending } = useMutation({
    mutationFn: (data: Activity) => (api as any).activity.create(data),
    onSuccess: () => {
      toast.success('Activité ajoutée avec succès');
      refetchActivities();
      activityManager.reset();
    },
    onError: (error) => {
      toast.error(getErrorMessage('', error, "Erreur lors de la création de l'activité"));
    }
  });

  const { mutate: updateMutation, isPending: isUpdatePending } = useMutation({
    mutationFn: (data: Activity) => (api as any).activity.update(data),
    onSuccess: () => {
      toast.success('Activité modifiée avec succès');
      refetchActivities();
      activityManager.reset();
    },
    onError: (error) => {
      toast.error(getErrorMessage('', error, "Erreur lors de la modification de l'activité"));
    }
  });

  const { mutate: removeMutation, isPending: isDeletePending } = useMutation({
    mutationFn: (id: number) => (api as any).activity.remove(id),
    onSuccess: () => {
      if (activities.length === 1 && page > 1) setPage(page - 1);
      toast.success('Activité supprimée avec succès');
      refetchActivities();
      setDeleteDialog(false);
    },
    onError: (error) => {
      toast.error(getErrorMessage('', error, "Erreur lors de la suppression de l'activité"));
    }
  });

  const handleActivitySubmit = (
    activity: Activity,
    callback: (activity: Activity) => void
  ): boolean => {
    const validation = (api as any).activity.validate(activity);
    if (validation.message) {
      toast.error(validation.message);
      return false;
    } else {
      callback(activity);
      activityManager.reset();
      return true;
    }
  };

  const isPending =
    isFetchPending ||
    isCreatePending ||
    isUpdatePending ||
    isDeletePending ||
    paging ||
    resizing ||
    searching ||
    sorting;

  if (error) return 'An error has occurred: ' + error.message;
  return (
    <ActivityActionsContext.Provider value={context}>
      <ActivityCreateDialog
        open={createDialog}
        isCreatePending={isCreatePending}
        createActivity={() => {
          if (handleActivitySubmit(activityManager.getActivity(), createMutation)) {
            setCreateDialog(false);
          }
        }}
        onClose={() => {
          setCreateDialog(false);
        }}
      />
      <ActivityUpdateDialog
        open={updateDialog}
        updateActivity={() => {
          if (handleActivitySubmit(activityManager.getActivity(), updateMutation)) {
            setUpdateDialog(false);
          }
        }}
        isUpdatePending={isUpdatePending}
        onClose={() => {
          setUpdateDialog(false);
        }}
      />
      <ActivityDeleteDialog
        open={deleteDialog}
        deleteActivity={() => {
          if (activityManager?.id !== undefined) {
            removeMutation(activityManager.id);
          }
        }}
        isDeletionPending={isDeletePending}
        label={activityManager?.label}
        onClose={() => {
          setDeleteDialog(false);
        }}
      />
      <ContentSection
        title={tSettings('activity.singular')}
        desc={tSettings('activity.card_description')}
        className="w-full"
        childrenClassName={cn('overflow-hidden', className)}>
        <DataTable
          className="flex flex-col flex-1 overflow-hidden p-1"
          containerClassName="overflow-auto"
          data={activities}
          columns={getActivityColumns(tSettings)}
          isPending={isPending}
        />
      </ContentSection>
    </ActivityActionsContext.Provider>
  );
};

export default ActivityMain;
