# About

This project configures and deploys an Oracle database in a Docker container for personal development environments.

# Prerequisites

First build an Oracle container as described in [https://github.com/oracle/docker-images/tree/master/OracleDatabase/SingleInstance](https://github.com/oracle/docker-images/tree/master/OracleDatabase/SingleInstance). For Oracle Database 12.2.0.1 Enterprise Edition
this involves the following steps:

1. Place `linuxx64_12201_database.zip` in `dockerfiles/12.2.0.1`.
2. Go to `dockerfiles` and run `buildDockerImage.sh -v 12.2.0.1 -e`

Afterwards you can run `make save` and `make load` to export and import the image to file.
Use `ORACLE_PWD=<password> make run` to build and run the database, and set the database password.
The first run will will create a database in a volume `oradata`. Consequent runs will mount the
previously built database.

# Caution: Oracle licensing

Check your Oracle license! A developer license only allows deployment on physical development PCs.
In general, Oracle does not allow soft partitioning and requires a license for the entire cluster
on which an instance is deployed.