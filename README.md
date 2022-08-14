# Multi VM provisioning

You can provision multiple VM in a single terraform apply:

```
terraform init
terraform plan
terraform apply
```

At the end you will have two clusters vm with different environment:

1. Development - with 2 VM `Standard_B1ms` instance type.
2. Production - with 2 VM `Standard_DS1_v2` instance type.