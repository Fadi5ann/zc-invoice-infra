INSERT INTO `permission` (`id`, `label`, `description`) VALUES

(UUID(), 'create_role', 'Permission to create roles'),
(UUID(), 'read_role', 'Permission to view roles'),
(UUID(), 'update_role', 'Permission to update roles'),
(UUID(), 'delete_role', 'Permission to delete roles'),
(UUID(), 'assign_role', 'Permission to assign roles to users'),
(UUID(), 'unassign_role', 'Permission to remove roles from users'),

(UUID(), 'create_permission', 'Permission to create permissions'),
(UUID(), 'read_permission', 'Permission to view permissions'),
(UUID(), 'update_permission', 'Permission to update permissions'),
(UUID(), 'delete_permission', 'Permission to delete permissions'),
(UUID(), 'assign_permission', 'Permission to assign permissions to roles'),
(UUID(), 'unassign_permission', 'Permission to remove permissions from roles'),

(UUID(), 'create_user', 'Permission to create users'),
(UUID(), 'read_user', 'Permission to view user details'),
(UUID(), 'update_user', 'Permission to update users'),
(UUID(), 'delete_user', 'Permission to delete users'),

(UUID(), 'create_activity', 'Permission to create activity'),
(UUID(), 'read_activity', 'Permission to view activity details'),
(UUID(), 'update_activity', 'Permission to update activity'),
(UUID(), 'delete_activity', 'Permission to delete activity'),

(UUID(), 'create_bank_account', 'Permission to create bank account'),
(UUID(), 'read_bank_account', 'Permission to view bank account details'),
(UUID(), 'update_bank_account', 'Permission to update bank account'),
(UUID(), 'delete_bank_account', 'Permission to delete bank account'),

(UUID(), 'create_default_condition', 'Permission to create default_condition'),
(UUID(), 'read_default_condition', 'Permission to view default_condition details'),
(UUID(), 'update_default_condition', 'Permission to update default_condition'),
(UUID(), 'delete_default_condition', 'Permission to delete default_condition'),

(UUID(), 'create_payment_condition', 'Permission to create payment_condition'),
(UUID(), 'read_payment_condition', 'Permission to view payment_condition details'),
(UUID(), 'update_payment_condition', 'Permission to update payment_condition'),
(UUID(), 'delete_payment_condition', 'Permission to delete payment_condition'),

(UUID(), 'create_tax_withholding', 'Permission to create tax_withholding'),
(UUID(), 'read_tax_withholding', 'Permission to view tax_withholding details'),
(UUID(), 'update_tax_withholding', 'Permission to update tax_withholding'),
(UUID(), 'delete_tax_withholding', 'Permission to delete tax_withholding'),

(UUID(), 'create_tax', 'Permission to create tax'),
(UUID(), 'read_tax', 'Permission to view tax details'),
(UUID(), 'update_tax', 'Permission to update tax'),
(UUID(), 'delete_tax', 'Permission to delete tax'),

(UUID(), 'create_sequential', 'Permission to create sequential'),
(UUID(), 'read_sequential', 'Permission to view sequential details'),
(UUID(), 'update_sequential', 'Permission to update sequential'),
(UUID(), 'delete_sequential', 'Permission to delete sequential'),

(UUID(), 'create_firm', 'Permission to create firm'),
(UUID(), 'read_firm', 'Permission to view firm details'),
(UUID(), 'update_firm', 'Permission to update firm'),
(UUID(), 'delete_firm', 'Permission to delete firm'),

(UUID(), 'create_interlocutor', 'Permission to create interlocutor'),
(UUID(), 'read_interlocutor', 'Permission to view interlocutor details'),
(UUID(), 'update_interlocutor', 'Permission to update interlocutor'),
(UUID(), 'delete_interlocutor', 'Permission to delete interlocutor'),

(UUID(), 'create_selling_quotation', 'Permission to create selling_quotation'),
(UUID(), 'read_selling_quotation', 'Permission to view selling_quotation details'),
(UUID(), 'update_selling_quotation', 'Permission to update selling_quotation'),
(UUID(), 'delete_selling_quotation', 'Permission to delete selling_quotation'),

(UUID(), 'create_selling_invoice', 'Permission to create selling_invoice'),
(UUID(), 'read_selling_invoice', 'Permission to view selling_invoice details'),
(UUID(), 'update_selling_invoice', 'Permission to update selling_invoice'),
(UUID(), 'delete_selling_invoice', 'Permission to delete selling_invoice'),

(UUID(), 'create_selling_payment', 'Permission to create selling_payment'),
(UUID(), 'read_selling_payment', 'Permission to view selling_payment details'),
(UUID(), 'update_selling_payment', 'Permission to update selling_payment'),
(UUID(), 'delete_selling_payment', 'Permission to delete selling_payment');

-- 1. Insert the "Super Admin" Role
INSERT INTO `role` (`label`, `description`, `isDeletionRestricted`) 
VALUES ('Super Admin', 'Has all possible permissions', 1);

-- 2. Retrieve the ID of the "Super Admin" Role (use latest if duplicates exist)
SET @super_admin_role_id = (
	SELECT `id` FROM `role` WHERE `label` = 'Super Admin' ORDER BY `id` DESC LIMIT 1
);

-- 3. Assign All Permissions to the "Super Admin" Role
INSERT INTO `role_permission` (`roleId`, `permissionId`, `isDeletionRestricted`)
SELECT @super_admin_role_id AS `roleId`, `id` AS `permissionId`, 1 AS `isDeletionRestricted`
FROM `permission`;

-- 4. Verify the Assignments (Optional)
SELECT rp.`roleId`, rp.`permissionId`, r.`label` AS `role`, p.`label` AS `permission`
FROM `role_permission` rp
JOIN `role` r ON rp.`roleId` = r.`id`
JOIN `permission` p ON rp.`permissionId` = p.`id`
WHERE r.`label` = 'Super Admin';




