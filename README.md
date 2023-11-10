# How to setup dbt DataOps with Kestra CI/CD for a Snowflake cloud data warehouse

If you are working as data analyst/engineer, you certainly work with SQL. Although SQL is simple to learn, you might already have asked yourself whether it wasn't possible to write object-oriented SQL. this is where dbt comes in.
The data build tool (dbt) is the T in ELT process, hence the "transform" in Extract Load Transform.
If you are new to cloud data warehouses ans Snowflake you might want to read the article 
If you are new to ELT and DBT you might want to read the article 

## Setting up Snowflake trial account

A Snowflake trial account lets you evaluate/test Snowflake’s with no cost or contractual obligations. 
You can sign up for a free trial using the self-service form https://signup.snowflake.com/

 * step 1: Fill the self-service form on Snowflake website

Enter the details (First Name, Last Name, Valid Email Address and Company) in the Sign Up form. If you are not working or do not wish to share the information of Company you are working, you can enter any random name or just mention ‘Student’.

 * step 2: Select Snowflake Edition, Platform and Region

After entering standard information on the first page of the form, you need to select the following which determines the features you can use during the trial and click GET STARTED.

Snowflake Edition : Standard
Cloud Platform : AWS
Geographic Deployment Region : eu-west-1

 * step 3:
 After completing the step 2, you will receive a message stating that an email has been sent to activate your account.
 Navigate to your email and click on CLICK TO ACTIVATE. You will also find the URL to access your Snowflake account in the email.

 * step 4: Create Username and Password
Once you activate your account, you will be prompted to choose a Username and Password to get started. These credentials are required to login every time you need to access Snowflake.
After successfully creating a Username and password, you will be asked to sign in. Sign in using the credentials created.

You can cancel a trial account at any time by contacting Snowflake Support and requesting the account to be canceled from https://community.snowflake.com/s/article/How-To-Submit-a-Support-Case-in-Snowflake-Lodge.
 
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

To test the connection to Snowflake data platform run:

```
dbt debug
```

### Write your first dbt models

The top level of a dbt workflow is the project. A project is a directory of a .yml file (the project configuration) and either .sql or .py files (the models). The project file tells dbt the project context, and the models let dbt know how to build a specific data set. For more details on projects, refer to https://docs.getdbt.com/docs/build/projects

This first dbt model requires the Snowflake provided snowflake_sample_data database.
If you don't have this database already in your account  please add it by following these instructions: https://docs.snowflake.net/manuals/user-guide/sample-data-using.html

Let's create simple dbt models that retrieve few columns of the table snowflake_sample_data.tpch_sf1.customer.

```
WITH customer_cte as (
	SELECT *

	FROM snowflake_sample_data.tpch_sf1.customer
)

SELECT
name as customer_name,
adress as customer_adresse,
phone as customer_phone
from 
customer_cte
```

Let's create customer_sample.sql sql file within models folder (models/customer_sample.sql). 
You can run the model in your dbt project by executing:

``` 
dbt run
```

### Write your first Kestra flow



## PRATICAL SECTION

The practical section will go through a real-world Airbnb project