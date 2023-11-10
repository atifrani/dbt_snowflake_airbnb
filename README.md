# How to setup dbt DataOps with Kestra CI/CD for a Snowflake cloud data warehouse

If you are working as data analyst/engineer, you certainly work with SQL. Although SQL is simple to learn, you might already have asked yourself whether it wasn't possible to write object-oriented SQL. this is where dbt comes in.
The data build tool (dbt) is the T in ELT process, hence the "transform" in Extract Load Transform.
If you are new to cloud data warehouses ans Snowflake you might want to read the article 
If you are new to ELT and DBT you might want to read the article 

## Setting up Snowflake

## DBT local installation 
1. Python and Virtualenv setup, and dbt installation - Windows
  * Python:
This is the Python installer you want to use:
https://www.python.org/ftp/python/3.10.7/python-3.10.7-amd64.exe
Please make sure that you work with Python 3.11 as newer versions of python might not be compatible with some of the dbt packages.

 * Virtualenv setup:
Here are the commands we executed in this lesson:
cd Documents
mkdir course
cd course

virtualenv venv
venv\Scripts\activate

2. Virtualenv setup and dbt installation - Mac

    * Homebrew: https://brew.sh/

3. dbt installation: 
Here are the commands we execute in this tutorial:

mkdir dbt-projects 
cd dbt-projects 
virtualenv venv
. venv/bin/activate
pip install dbt-snowflake==1.5.0
which dbt


4. dbt setup:

Initialize the dbt profiles folder on Mac/Linux:
mkdir ~/.dbt

Initialize the dbt profiles folder on Windows:
mkdir %userprofile%\.dbt

Create a dbt project (all platforms):

dbt init dbtlearn

### Write your first dbt models

## Kestra installation

### Write your first Kestra flow

## PRATICAL SECTION

The practical section will go through a real-world Airbnb project