me=`basename "$0"`
#echo $#

if [ "$#" != "1" ]; then
    echo "Error provide username argument!"
    echo "Example: ./$me <username>"
    exit 1
fi

USER=$1
GROUP=$2

USER_KEY_FILE=$USER.key
USER_CSR_CNF=$USER.csr.cnf
USER_CSR_FILE=$USER.csr
USER_KUBE_CONFIG_FILE=$USER.kubeconfig

kubectl config  --kubeconfig $USER_KUBE_CONFIG_FILE set-credentials $USER --client-key $USER_KEY_FILE --embed-certs=true