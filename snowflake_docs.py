# This script reads dbt model schema files and pushes the table and column descriptions to Snowflake.
# It connects to Snowflake using the snowflake-connector-python library and uses the PyYAML library to parse YAML files.
# It traverses all *_schema.yml files in the specified directory, extracts the model names and descriptions,
#  and executes SQL commands to add comments to the corresponding tables and columns in Snowflake.

import os
import yaml
import snowflake.connector

# Connecting to Snowflake
conn = snowflake.connector.connect(
    user='AIRBYTE_USER',
    password='password',
    account='gtkyhtt-yh42174',
    warehouse='EPSION_DW',
    database='EPSION_DB',
    schema='EPSION_RAW_MARTS'
)


cursor = conn.cursor()

# dbt models directory
models_dir = 'D:\epsion_project\epsion_analytics\models\marts'

# Traversing all *_schema.yml files
for root, dirs, files in os.walk(models_dir):
    for file in files:
        if file.endswith('_schema.yml'):
            file_path = os.path.join(root, file)
            print(f"Processing: {file_path}")

            with open(file_path, encoding='utf-8') as f:
                try:
                    schema = yaml.safe_load(f)
                except yaml.YAMLError as e:
                    print(f"YAML error in {file_path}: {e}")
                    continue

            if 'models' not in schema:
                continue

            for model in schema['models']:
                model_name = model.get('name')
                table_desc = model.get('description', '')
                table_desc_clean = table_desc.replace("'", "''")

                # Adding description to the table 
                if table_desc:
                    sql = f"COMMENT ON TABLE {conn.schema}.{model_name} IS '{table_desc_clean}'"
                    cursor.execute(sql)

                # Adding description to the column 
                for col in model.get('columns', []):
                    col_name = col.get('name')
                    col_desc = col.get('description', '')
                    col_desc_clean = col_desc.replace("'", "''")

                    if col_desc:
                        sql = f"COMMENT ON COLUMN {conn.schema}.{model_name}.{col_name} IS '{col_desc_clean}'"
                        cursor.execute(sql)

# Done
cursor.close()
conn.close()
print("✅ All descriptions successfully pushed to Snowflake.")