# How to setup dbt DataOps with Kestra CI/CD for a Snowflake cloud data warehouse

If you are working as data analyst/engineer, you certainly work with SQL. Although SQL is simple to learn, you might already have asked yourself whether it wasn't possible to write object-oriented SQL. this is where dbt comes in.
The data build tool (dbt) is the T in ELT process, hence the "transform" in Extract Load Transform.
If you are new to cloud data warehouses ans Snowflake you might want to read the article 
If you are new to ELT and DBT you might want to read the article 

## Setting up Snowflake

## DBT Core local installation 

You can install dbt Core on the command line by using one of these methods:
 * Use pip to install dbt (recommended)
 * Use Homebrew to install dbt
 * Use a Docker image to install dbt
 * Install dbt from source
For more-specifc installation please refer to https://docs.getdbt.com/docs/core/installation

1. Python and Virtualenv setup, and dbt installation - Windows
  * Python:
This is the Python installer you want to use:
https://www.python.org/ftp/python/3.10.7/python-3.10.7-amd64.exe
Please make sure that you work with Python 3.11 as newer versions of python might not be compatible with some of the dbt packages.

 * Virtualenv setup:
Here are the commands we executed in this lesson:

```
cd Documents
mkdir course
cd course

virtualenv venv
venv\Scripts\activate
```

2. Virtualenv setup and dbt installation - Mac

    * Homebrew: https://brew.sh/

3. dbt installation: 
Here are the commands we execute in this tutorial:

```
mkdir dbt-projects 
cd dbt-projects 
virtualenv venv
. venv/bin/activate
pip install dbt-snowflake==1.5.0
dbt --version
```

4. dbt setup:

Initialize the dbt profiles folder on Mac/Linux:

```
mkdir ~/.dbt
```

Initialize the dbt profiles folder on Windows:

```
mkdir %userprofile%\.dbt
```

Create a dbt project (all platforms):

```
dbt init dbtlearn
```

It basically comes down to creating a ~/.dbt/profiles.yml with the following content:

```
snowflake-db:
  target: dev
  outputs:
    dev:
      type: snowflake
      account: [account id]

      # User/password auth
      user: [username]
      password: [password]

      role: [user role]
      database: [database name]
      warehouse: [warehouse name]
      schema: [dbt schema]
      threads: [1 or more]
      client_session_keep_alive: False
      query_tag: [anything]
```

This profile must be chosen in the dbt_project.yml:

```
# Name your project! Project names should contain only lowercase characters
# and underscores. A good package name should reflect your organization's
# name or the intended use of these models
name: 'dbtlearn'
version: '1.0.0'

# This setting configures which "profile" dbt uses for this project.
profile: 'snowflake-db'

# These configurations specify where dbt should look for different types of files.
# The `source-paths` config, for example, states that models in this project can be
# found in the "models/" directory. You probably won't need to change these!
source-paths: ["models"]
analysis-paths: ["analysis"]
test-paths: ["tests"]
data-paths: ["data"]
macro-paths: ["macros"]
snapshot-paths: ["snapshots"]

target-path: "target"  # directory which will store compiled SQL files
clean-targets:         # directories to be removed by `dbt clean`
    - "target"
    - "dbt_modules"


# Configuring models
# Full documentation: https://docs.getdbt.com/docs/configuring-models

# In this example config, we tell dbt to build all models in the example/ directory
# as tables. These settings can be overridden in the individual model files
# using the `{{ config(...) }}` macro.
models:
  snowflake_dbt_test:
      # Applies to all files under models/example/
      example:
          materialized: view
```


### Write your first dbt models

## Kestra installation

### Write your first Kestra flow

## PRATICAL SECTION

The practical section will go through a real-world Airbnb project