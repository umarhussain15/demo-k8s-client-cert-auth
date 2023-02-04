me=`basename "$0"`
#echo $#

if [ "$#" != "2" ]; then
    echo "Error provide username and group name argument!"
    echo "Example: ./$me <username> <group name>"
    exit 1
fi

USER=$1
GROUP=$2

USER_KEY_FILE=$USER.key
USER_CSR_CNF=$USER.csr.cnf
USER_CSR_FILE=$USER.csr

if [ -f "$USER_KEY_FILE" ]; then
    echo "$USER_KEY_FILE exists. Using it"
else
openssl genrsa -out $USER_KEY_FILE 4096
fi

cat <<EOF > $USER_CSR_CNF
[ req ]
default_bits = 2048
prompt = no
default_md = sha256
distinguished_name = dn
[ dn ]
CN = $USER
O = $GROUP
[ v3_ext ]
authorityKeyIdentifier=keyid,issuer:always
basicConstraints=CA:FALSE
keyUsage=keyEncipherment,dataEncipherment
extendedKeyUsage=serverAuth,clientAuth
EOF

openssl req -config $USER_CSR_CNF -new -key $USER_KEY_FILE -nodes -out $USER_CSR_FILE