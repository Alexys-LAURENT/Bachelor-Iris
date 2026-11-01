# Local database

Set `HELPDESK_DB_HOST`, `HELPDESK_DB_NAME`, `HELPDESK_DB_USER` and `HELPDESK_DB_PASSWORD` in the ASP.NET process environment before starting HelpDesk. The application does not load a `.env` file automatically. No login is supplied in source. The SQL under `HelpDesk/Sql` defines structure only. Connection strings containing passwords are not logged.
