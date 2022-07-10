module "dev_virtualmachine" {
    source       = "./vm"
    env_name     = "dev"
    subnet       = "10.0.2.0/24"
    totalvm        = 2
}

module "prod_virtualmachine" {
    source       = "./vm"
    env_name     = "prod"
    subnet       = "10.0.4.0/24"
    totalvm        = 3
}