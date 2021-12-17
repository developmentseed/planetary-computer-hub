# Digital Earth Pacific - Planetary Computer Hub
This is a specific deployment of Microsoft's Planetary Computer, and has been adapted from [Microsoft's Planetary Computer repo](https://github.com/microsoft/planetary-computer-hub)
For specifics not covered here, please refer to the upstream documentation.

## Deployment
### Prerequisites
#### Skills
A person managing this installation or performing a deployment should have knowledge of the following tools/technologies:
* Azure [Docs](https://docs.azure.com)
* Kubernetes [Docs](https://kubernetes.io/docs/home/)
* Helm [Docs](https://helm.sh/docs/)

#### Tools
* [Azure CLI](https://docs.microsoft.com/en-us/cli/azure/install-azure-cli)
* [kubectl](https://kubernetes.io/docs/tasks/tools/#kubectl)
* [Terraform](https://www.terraform.io/downloads.html)
* [Helm](https://helm.sh/docs/intro/install/)
### Deploy
_**NOTE:** All `make` commands should be run from the **root** of the repository_
To deploy this project, run `make deploy`

##Components
###Kubernetes
####comon-file-pvc.pvc.yaml
A PersistentVolumeClaim manifest to connect to the DEP common private storage

####dep-private-common.storageclass.yaml
A StorageClast manifest to provide access to the DEP common private storage

####letsencrypt-production.issuer.yaml
A CertManager Issuer manifest for production use against LetsEncrypt

####letsencrypt-staging.issuer.yaml
A CertManager Issuer manifest for experimental/staging use against LetsEncrypt

####titiler.ingress.yaml
An Ingress manifest to provide ingress of traffic and TLS for TiTiler

####titiler.service.yaml
A Service manifest to provide and endpoint for TiTiler traffic inside the cluster


###Terraform
####aks.tf
Handles deployment of the AKS backplane and node pools

####hub.tf
Handles the helm releases for JupyterHub and accessories

####keyvault.tf
Provides data elements to retrieve various keys from the keyvault.

####logs.tf
Handles deployment of log analytics for the system

####outputs.tf
Provides outputs of information for use in other parts of the deployment

####providers.tf
Sets up the Terraform providers for the deployment 

####rg.tf
Sets up the resource group for the infrastructure elements

####storage.tf
Sets up the storage accounts and containers for the common and user data

####vnet.tf
Sets up the VNets and Subnets for the AKS nodes and storage