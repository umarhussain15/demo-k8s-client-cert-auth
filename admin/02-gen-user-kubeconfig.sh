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

CURRENT_CONTEXT=$(kubectl config current-context)

export CLUSTER_NAME=$(kubectl config view --raw -o json | jq -r ".contexts[] | select(.name == \"$CURRENT_CONTEXT\") | .context.\"cluster\"")

export CLUSTER_CA=$(kubectl config view --raw -o json | jq -r ".clusters[] | select(.name == \"$CLUSTER_NAME\") | .cluster.\"certificate-authority-data\"")


export CLUSTER_ENDPOINT=$(kubectl config view --raw -o json | jq -r ".clusters[] | select(.name == \"$CLUSTER_NAME\") | .cluster.\"server\"")

cat kubeconfig.tpl | envsubst > $USER.kubeconfig