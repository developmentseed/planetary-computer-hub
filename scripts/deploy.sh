#!/usr/bin/env bash
set -eu

cd helm/chart && \
    helm dependency update && \
    cd ../..

echo "[init terraform]"
terraform -chdir=terraform/prod init

echo "[applying terraform]"
terraform -chdir=terraform/prod plan -out plan.tfstate
terraform -chdir=terraform/prod apply plan.tfstate

echo "[getting kubeconfig]"
terraform -chdir=terraform/prod output -json resources | jq -r .kubeconfig > .kubeconfig
export KUBECONFIG=".kubeconfig"

az aks get-credentials --overwrite-existing --resource-group "dep-pc-main-rg" --name "dep-pc-cluster"

KEY_PRIVATE=$(az storage account keys list -g dep-pc-main-rg -n deppcprivatestorage | grep "key1" -A 4 | grep "value" | sed 's/value"\: "//g' | sed 's/"//g')
kubectl delete secret -n prod azure-secret --ignore-not-found
kubectl create secret generic -n prod azure-secret --from-literal azurestorageaccountname=deppcprivatestorage --from-literal azurestorageaccountkey="$KEY_PRIVATE" --type=Opaque
curl -skSL https://raw.githubusercontent.com/kubernetes-sigs/azurefile-csi-driver/master/deploy/install-driver.sh | bash -s master --
kubectl get storageclass azurefile-csi
if [ $? -eq 1 ]; then
 kubectl create -f https://raw.githubusercontent.com/kubernetes-sigs/azurefile-csi-driver/master/deploy/example/storageclass-azurefile-csi.yaml
fi
kubectl apply -f kubernetes/dep-private-common.storageclass.yaml
kubectl apply -f kubernetes/common-file-pvc.pvc.yaml

#git clone git@github.com:developmentseed/titiler.git
cd titiler/deployment/k8s || exit
helm install titiler titiler -f titiler/Chart.yaml --set fullnameOverride="titiler" --set service.type="LoadBalancer"