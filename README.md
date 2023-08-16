# stac-fastapi-pgstac

Fork of https://github.com/stac-utils/stac-fastapi-pgstac

## Environment variables

| Var name                           | Used for                                                      |
| ---------------------------------- | ------------------------------------------------------------- |
| APP_HOST                           | Host address for the application.                             |
| APP_PORT                           | Port number for the application.                              |
| RELOAD                             | Flag indicating whether the application should reload.        |
| POSTGRES_USER                      | PostgreSQL username.                                         |
| POSTGRES_PASS                      | PostgreSQL password.                                         |
| POSTGRES_DBNAME                    | PostgreSQL database name.                                    |
| POSTGRES_HOST_READER               | Hostname for reading from the PostgreSQL server.              |
| POSTGRES_HOST_WRITER               | Hostname for writing to the PostgreSQL server.                |
| POSTGRES_PORT                      | PostgreSQL port number.                                      |
| DB_MIN_CONN_SIZE                   | Minimum number of database connections in the pool.           |
| DB_MAX_CONN_SIZE                   | Maximum number of database connections in the pool.           |
| WEB_CONCURRENCY                    | Number of worker processes for the application.               |
| VSI_CACHE                          | Flag indicating whether VSI cache should be enabled.          |
| GDAL_HTTP_MERGE_CONSECUTIVE_RANGES | Flag indicating whether GDAL should merge consecutive ranges. |
| GDAL_DISABLE_READDIR_ON_OPEN       | Flag indicating whether GDAL should disable `readdir` on open. |


## What changed in the fork
- Self-initializing PgSTAC schema added
- Custom Dockerfile
- Custom new entrypoint script
- Build actions for Docker image on ACR
- Removed publishing to PyPI from GitHub Actions

<hr>

[![GitHub Workflow Status](https://img.shields.io/github/actions/workflow/status/stac-utils/stac-fastapi-pgstac/cicd.yaml?style=for-the-badge)](https://github.com/stac-utils/stac-fastapi-pgstac/actions/workflows/cicd.yaml)
[![PyPI](https://img.shields.io/pypi/v/stac-fastapi.pgstac?style=for-the-badge)](https://pypi.org/project/stac-fastapi.pgstac)
[![Documentation](https://img.shields.io/github/actions/workflow/status/stac-utils/stac-fastapi-pgstac/pages.yml?label=Docs&style=for-the-badge)](https://stac-utils.github.io/stac-fastapi-pgstac/)
[![License](https://img.shields.io/github/license/stac-utils/stac-fastapi-pgstac?style=for-the-badge)](https://github.com/stac-utils/stac-fastapi-pgstac/blob/main/LICENSE)

<p align="center">
  <img src="https://user-images.githubusercontent.com/10407788/174893876-7a3b5b7a-95a5-48c4-9ff2-cc408f1b6af9.png" style="vertical-align: middle; max-width: 400px; max-height: 100px;" height=100 />
  <img src="https://fastapi.tiangolo.com/img/logo-margin/logo-teal.png" alt="FastAPI" style="vertical-align: middle; max-width: 400px; max-height: 100px;" width=200 />
</p>

[PgSTAC](https://github.com/stac-utils/pgstac) backend for [stac-fastapi](https://github.com/stac-utils/stac-fastapi), the [FastAPI](https://fastapi.tiangolo.com/) implementation of the [STAC API spec](https://github.com/radiantearth/stac-api-spec)

## Overview

**stac-fastapi-pgstac** is an HTTP interface built in FastAPI.
It validates requests and data sent to a [PgSTAC](https://github.com/stac-utils/pgstac) backend, and adds [links](https://github.com/radiantearth/stac-spec/blob/master/item-spec/item-spec.md#link-object) to the returned data.
All other processing and search is provided directly using PgSTAC procedural sql / plpgsql functions on the database.
PgSTAC stores all collection and item records as jsonb fields exactly as they come in allowing for any custom fields to be stored and retrieved transparently.

## Usage

PgSTAC is an external project and may be used by multiple front ends.
For Stac FastAPI development, a Docker image (which is pulled as part of the docker-compose) is available via the [Github container registry](https://github.com/stac-utils/pgstac/pkgs/container/pgstac/81689794?tag=latest).
The PgSTAC version required by **stac-fastapi-pgstac** is found in the [setup](http://github.com/stac-utils/stac-fastapi-pgstac/blob/main/setup.py) file.

### Sorting

While the STAC [Sort Extension](https://github.com/stac-api-extensions/sort) is fully supported, [PgSTAC](https://github.com/stac-utils/pgstac) is particularly enhanced to be able to sort by datetime (either ascending or descending).
Sorting by anything other than datetime (the default if no sort is specified) on very large STAC repositories without very specific query limits (ie selecting a single day date range) will not have the same performance.
For more than millions of records it is recommended to either set a low connection timeout on PostgreSQL or to disable use of the Sort Extension.

### Hydration

To configure **stac-fastapi-pgstac** to [hydrate search result items in the API](https://stac-utils.github.io/pgstac/pgstac/#runtime-configurations), set the `USE_API_HYDRATE` environment variable to `true` or explicitly set the option in the PGStac Settings object.

### Migrations

There is a Python utility as part of PgSTAC ([pypgstac](https://stac-utils.github.io/pgstac/pypgstac/)) that includes a migration utility.
To use:

```shell
pypgstac migrate
```

## Contributing

See [CONTRIBUTING](https://github.com/stac-utils/stac-fastapi-pgstac/blob/main/CONTRIBUTING.md) for detailed contribution instructions.

To install:

```shell
git clone https://github.com/stac-utils/stac-fastapi-pgstac
cd stac-fastapi-pgstac
pip install -e ".[dev,server,docs]"
```

To test:

```shell
make test
```

Use Github [Pull Requests](https://github.com/stac-utils/stac-fastapi-pgstac/pulls) to provide new features or to request review of draft code, and use [Issues](https://github.com/stac-utils/stac-fastapi-pgstac/issues) to report bugs or request new features.

### Documentation

To build the docs:

```shell
make docs
```

Then, serve the docs via a local HTTP server:

```shell
mkdocs serve
```

## History

**stac-fastapi-pgstac** was initially added to **stac-fastapi** by [developmentseed](https://github.com/developmentseed).
In April of 2023, it was removed from the core **stac-fastapi** repository and moved to its current location (<http://github.com/stac-utils/stac-fastapi-pgstac>).

## License

[MIT](https://github.com/stac-utils/stac-fastapi-pgstac/blob/main/LICENSE)

<!-- markdownlint-disable-file MD033 -->
