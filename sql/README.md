# Database schema

`schema.sql` creates the database structure without exported accounts or business data. Import it into a dedicated local development database with the MySQL client. Review the database name in the script first; schema initialization is not a migration for an existing production database.

Historical database snapshots and their data have been removed from the current tree. Old commits may still contain the original example data. Create development accounts through the application or a local seed; no default account is supplied.
