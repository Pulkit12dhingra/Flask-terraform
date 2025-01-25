# Terraform AWS Flask App

This project sets up an AWS EC2 instance to host a simple Flask application using Terraform.

## Project Structure

```
.gitignore
app.py
Dockerfile
main.tf
outputs.tf
README.md
scripts/
    flask_app.sh
terraform.tfvars
variables.tf
```

## Files

### `main.tf`

This file contains the main Terraform configuration for setting up the AWS provider, key pair, security group, and EC2 instance.

### `variables.tf`

This file defines the variables used in the Terraform configuration.

### `terraform.tfvars`

This file contains the values for the variables defined in `variables.tf`.

### `outputs.tf`

This file defines the outputs of the Terraform configuration.

### `scripts/flask_app.sh`

This script sets up the Flask application on the EC2 instance.

### `.gitignore`

This file specifies which files and directories to ignore in version control.

### `app.py`

This file contains the Flask application code.

### `Dockerfile`

This file contains the Docker configuration for the Flask application.

## Usage

1. Initialize Terraform:
    ```sh
    terraform init
    ```

2. Apply the Terraform configuration:
    ```sh
    terraform apply
    ```

3. After the apply command completes, the public IP of the EC2 instance will be output. You can access the Flask application by navigating to `http://<instance_public_ip>:5000` in your web browser.