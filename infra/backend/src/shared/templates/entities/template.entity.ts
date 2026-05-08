import { TemplateType } from 'src/app/enums/template-type.enum';
import { EntityHelper } from 'src/shared/database/interfaces/database.entity.interface';
import { StorageEntity } from 'src/shared/storage/entities/storage.entity';
import {
  Column,
  Entity,
  JoinColumn,
  ManyToOne,
  PrimaryGeneratedColumn,
} from 'typeorm';

@Entity('templates')
export class TemplateEntity extends EntityHelper {
  @PrimaryGeneratedColumn('uuid')
  id: string;

  @Column({})
  name: string;

  @Column({ nullable: true })
  description?: string;

  @Column({ type: 'enum', enum: TemplateType })
  templateType?: TemplateType;

  @ManyToOne(() => StorageEntity, null, {
    cascade: true,
    nullable: true,
  })
  @JoinColumn({ name: 'documentId' })
  document?: StorageEntity;

  @Column({ nullable: true })
  documentId?: number;

  @Column({ type: 'json', nullable: true })
  variables?: object;

  @Column({ type: 'json', nullable: true })
  backupVariables?: object;
}
