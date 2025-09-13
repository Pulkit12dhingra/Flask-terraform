FROM python:3.12-slim

# Install Terraform
RUN apt-get update && apt-get install -y wget unzip && \
    wget -q https://releases.hashicorp.com/terraform/1.9.5/terraform_1.9.5_linux_amd64.zip && \
    unzip terraform_1.9.5_linux_amd64.zip -d /usr/local/bin && \
    rm terraform_1.9.5_linux_amd64.zip

# Install Python deps
WORKDIR /app
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt pylint coverage

# Copy code
COPY . .

CMD ["make", "ci"]
