me=`basename "$0"`
#echo $#

if [ "$#" != "1" ]; then
    echo "Error provide username argument!"
    echo "Example: ./$me <username>"
    exit 1
fi

export USER=$1

USER_CSR_NAME=$USER-csr
USER_CSR_FILE=$USER.csr
USER_CSR_YAML=$USER-csr.yaml

export CLIENT_CERTIFICATE_DATA=$(kubectl get csr $USER_CSR_NAME -o jsonpath='{.status.certificate}')

export CLUSTER_NAME=$(kubectl config view --minify -o jsonpath={.current-context})
# export CLUSTER_NAME="minikube"


export CLUSTER_CA=$(kubectl config view --raw -o json | jq -r '.clusters[] | select(.name == "'$(kubectl config current-context)'") | .cluster."certificate-authority-data"')

export CLUSTER_ENDPOINT=$(kubectl config view --raw -o json | jq -r '.clusters[] | select(.name == "'$(kubectl config current-context)'") | .cluster."server"')

cat kubeconfig.tpl | envsubst > $USER.kubeconfig