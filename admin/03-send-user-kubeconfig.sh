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

cp $USER.kubeconfig ../users