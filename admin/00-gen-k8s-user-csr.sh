me=`basename "$0"`
#echo $#

if [ "$#" != "1" ]; then
    echo "Error provide username argument!"
    echo "Example: ./$me <username>"
    exit 1
fi

export USER=$1

USER_CSR_FILE=$USER.csr
USER_CSR_YAML=$USER-csr.yaml

openssl req -text -noout -verify -in $USER_CSR_FILE

export BASE64_CSR=$(cat $USER_CSR_FILE | base64 | tr -d '\n')

export USER_CSR_NAME=$USER-csr
cat csr.yaml | envsubst > $USER_CSR_YAML

kubectl apply -f $USER_CSR_YAML
