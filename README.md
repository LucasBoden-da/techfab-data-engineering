# Data Warehouse Deployment on AWS with Terraform

## Overview

This project automates the deployment of a **Data Warehouse (DW)** on **Amazon Redshift** using **Terraform**. It also provides SQL scripts to **load data from an S3 bucket into Redshift**. The workflow includes:

- **Infrastructure as Code (IaC)** with Terraform to provision AWS resources.
- **Amazon Redshift** as the cloud Data Warehouse.
- **Amazon S3** for storing raw CSV files.
- **SQL scripts** to load and transform data into Redshift.

---

## Project Structure
```plaintext
techfab-data-engineering/
├── terraform_setup/            # Terraform configuration for AWS infrastructure
│   ├── provider.tf             # AWS provider setup
│   ├── redshift.tf             # Redshift cluster creation
│   ├── redshift_role.tf        # IAM role for S3 access
│   ├── terraform.tfstate       # Terraform state file
├── data_ingestion/             # SQL scripts for data loading
│   ├── load_data.sql           # SQL commands to load data from S3 into Redshift
├── data/                       # Folder containing raw CSV files (uploaded manually to S3)
└── README.md                   # Project documentation
```

---

## Setup Instructions

### 1. AWS Configuration
1. Log in to your **AWS account**.
2. Go to **Amazon S3** and create a **new bucket** in the **Ohio region (us-east-2)**.
3. Inside the S3 bucket, create a **folder named `data/`**.
4. Upload the **CSV files** from the `data/` directory.

---

### 2. Deploy AWS Infrastructure
1. **Clone this repository** and navigate to `terraform_setup/`:
   ```bash
   git clone https://github.com/LucasBoden-da/techfab-data-engineering.git
   cd techfab-data-engineering/terraform_setup
   ```

2. **Initialize Terraform:**
   ```bash
   terraform init
   terraform validate
   terraform plan
   terraform apply
   ```
   - This will **provision the AWS infrastructure**, including:
     - **Redshift cluster**
     - **IAM role with S3 access**

3. **Verify AWS Resources:**
   - Go to **AWS Redshift** and check if the **Redshift cluster** has been created.
   - Go to **AWS IAM** and confirm that the **role `RedshiftS3AccessRole`** exists.

4. **Copy the IAM Role ARN:**
   - In **IAM**, find the `RedshiftS3AccessRole` ARN.
   - Replace **`YOUR_AWS_ACCOUNT_ID`** and **`YOUR_ROLE_NAME`** in `data_ingestion/load_data.sql`.

---

### 3. Load Data into Redshift
1. **Find your Redshift Cluster Endpoint:**
   - Go to **AWS Redshift > Clusters** and copy the **cluster endpoint**.

2. **Run the SQL Load Command:**
   - In `data_ingestion`, run the command below with your credentials:
   ```bash
   psql -h <YOUR-ENDPOINT> -U <YOUR-USER> -d <YOUR-DATABASE> -p 5439 -f load_data.sql
   ```
   - Enter your **Redshift password** when prompted.

---

## License
This project is licensed under the MIT License. See the [LICENSE](LICENSE) file for details.
