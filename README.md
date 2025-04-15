# Terraform Project Template

## Overview

This is a base template for creating new Terraform ter_temp projects. It provides a standardized structure and basic configuration for AWS infrastructure deployment.

## Prerequisites

- AWS CLI configured
- Terraform installed (version 1.0.0 or higher)
- PowerShell 5.1 or higher

## Template Structure

```
template_terraform_project/
├── ps_scripts/                    # PowerShell scripts
├── terraform__main_files/         # Terraform template files
│   ├── modules/
│   │   └── s3_bucket/             # S3 bucket module
│   │       ├── main.tf            # Module resource definitions
│   │       ├── variables.tf       # Module variables
│   │       └── outputs.tf         # Module outputs
│   ├── backend.tf                 # Backend template configuration
│   ├── main.tf                    # Main template (module invocation)
│   ├── outputs.tf                 # Output template
│   ├── provider.tf                # Provider configuration
│   ├── terraform.tfvars           # Terraform variables values
│   ├── variables.tf               # Variables template
│   └── versions.tf                # Terraform and provider versions
└── New-ProjectFromTemplate.ps1    # Main deployment script
```

## Usage

1. Clone this template
2. Run the PowerShell script with your project name:

```powershell
.\New-ProjectFromTemplate.ps1 -ProjectName "your_project_name"
```

## Template Features

- **Automated Setup**: PowerShell scripts for project initialization
- **State Management**: Configured for remote state with S3 backend
- **Provider Configuration**: Pre-configured AWS provider settings
- **Variable Management**: Structured variable definitions
- **Documentation**: Standardized README template

## Configuration

### Required Variables

Update the following variables in `terraform.tfvars` or through environment variables:

```hcl
project_name = "your_project_name"
aws_region   = "your_aws_region"
```

### State Management

The template is configured to use S3 for state management. Update the backend configuration in `provider.tf`:

```hcl
backend "s3" {
  bucket = "your-terraform-state-bucket"
  key    = "your-project-name/terraform.tfstate"
  region = "your-aws-region"
}
```

## Deployment

After configuration, deploy using:

```bash
terraform init
terraform plan
terraform apply
```

## Best Practices

- Always review the generated plan before applying
- Use consistent naming conventions
- Keep sensitive data in separate variable files
- Document all major changes

## Contributing

To contribute to this template:

1. Fork the repository
2. Create a feature branch
3. Submit a pull request

## License
