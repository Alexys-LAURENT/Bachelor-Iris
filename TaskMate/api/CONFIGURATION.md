# Local configuration

Copy `.env.example` to `.env` in this directory, fill every field and keep values quoted (PHP INI syntax), or supply actual environment variables. Environment variables take precedence. Missing/empty values produce a configuration error without printing the value. Never commit `.env`.

Initialize a disposable local database from the structure-only SQL. No shared initial account password is supplied. This cleanup preserves the legacy application password format; it is not a full authentication redesign.
