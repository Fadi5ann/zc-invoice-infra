import { Command } from 'nestjs-command';
import { Injectable } from '@nestjs/common';
import { permitedActions, permitedEntities } from './data/permissions.data';
import { PermissionService } from 'src/shared/abstract-user-management/services/permission.service';

@Injectable()
export class PermissionsSeederCommand {
  constructor(private readonly permissionService: PermissionService) {}

  @Command({
    command: 'seed:permissions',
    describe: 'seed system permissions',
  })
  async seed() {
    const start = new Date();
    console.log('Starting seeding of permissions');

    for (const entity of permitedEntities) {
      for (const action of permitedActions) {
        try {
          await this.permissionService.save({
            id: `${action}-${entity}`,
            label: `${action.toUpperCase()}_${entity.toUpperCase()}`,
            description: `This permission is for ${action} ${entity}`,
          });
        } catch (error: any) {
          // Check if the error is the 409 Conflict (PermissionAlreadyExistsException)
          if (error.status === 409) {
            // console.log(`Permission ${action}-${entity} already exists, skipping...`);
            continue; // Safely skip to the next iteration
          } else {
            // If it's a different error (e.g. database disconnect), throw it so you know what went wrong
            console.error(
              `Error saving permission ${action}-${entity}:`,
              error.message,
            );
            throw error;
          }
        }
      }
    }

    const end = new Date();
    console.log(`Seeding completed in ${end.getTime() - start.getTime()}ms`);
  }
}
