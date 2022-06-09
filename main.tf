module "dev_clusterAKS" {
    source       = "./aks"
    env_name     = "dev"
    cluster_name = "learnk8scluster"
    instance_type= "standard_d2_v2"
    helm_name = "moodle"
    set_username = "moodleUsername"
    set_password = "moodlePassword"
}

# module "dev_virtualmachine" {
#     source       = "./vm"
#     env_name     = "dev"
# }

module "prod_clusterAKS" {
    source       = "./aks"
    env_name     = "prod"
    cluster_name = "learnk8scluster"
    instance_type= "standard_d2_v2"
    helm_name = "wordpress"
    set_username = "wordpressUsername"
    set_password = "wordpressPassword"
}

# module "prod_virtualmachine" {
#     source       = "./vm"
#     env_name     = "prod"
# }