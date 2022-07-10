module "dev_virtualmachine" {
    source       = "./vm"
    env_name     = "dev"
    subnet       = "10.0.2.0/24"
    vm_size      = "Standard_B1s"
    totalvm      = 2   
}


module "prod_virtualmachine" {
    source       = "./vm"
    env_name     = "prod"
    subnet       = "10.0.4.0/24"
    vm_size      = "Standard_B2s"
    totalvm      = 4
}