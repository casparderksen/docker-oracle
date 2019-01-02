# About

This project configures and deploys an Oracle database in a Docker container for personal development environments.

# Prerequisites

First build an Oracle container image as described in [https://github.com/oracle/docker-images/tree/master/OracleDatabase/SingleInstance](https://github.com/oracle/docker-images/tree/master/OracleDatabase/SingleInstance). For Oracle Database 12.2.0.1 Enterprise Edition
this involves the following steps:

1. Place `linuxx64_12201_database.zip` in `dockerfiles/12.2.0.1`.
2. Go to `dockerfiles` and run `buildDockerImage.sh -v 12.2.0.1 -e`

Afterwards you can run `make save` and `make load` to export and import the image to file.

# Configuration

## Set-up scripts

The scripts in [docker/setup](docker/setup) are executed for initial setup of the database.
Edit [docker/setup/01\_create\_user.sql](docker/setup/01_create_user.sql) to setup a schema.

## Start-up scripts

The scripts in [docker/startup](docker/startup) are ran before starting the database.

## Dockerfile

Edit [docker/Dockerfile](docker/Dockerfile) to modify SID and PDB.

## Persistent volume

The database is located in `/opt/oracle/oradata`. The `run` target in (Makefile)[Makefile]
mounts this directory on a volume `oradata`, in order to persist the database between runs.

# Building an running the database

Use

    ORACLE_PWD=_\<password\>_ make run
    
to build and run the database, and set the database password.  The first run
will will create a database in a volume `oradata`. Consequent runs will mount
the previously built database.

# Caution: Oracle licensing

Check your Oracle license! A developer license only allows deployment on a physical development PC.
In general, Oracle does not allow soft partitioning and requires a license for the entire cluster
on which an instance is deployed.
