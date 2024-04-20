deploy:
    terraform init
    terraform workspace select virginia || terraform workspace new virginia
    terraform apply -var-file=virginia.tfvars

    terraform workspace select ohio || terraform workspace new ohio
    terraform apply -var-file=ohio.tfvars

    terraform workspace select california || terraform workspace new california
    terraform apply -var-file=california.tfvars

    terraform workspace select oregon || terraform workspace new oregon
    terraform apply -var-file=oregon.tfvars

clean:
    terraform destroy -auto-approve
