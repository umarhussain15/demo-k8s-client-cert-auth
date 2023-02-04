me=`basename "$0"`
#echo $#

if [ "$#" != "1" ]; then
    echo "Error provide username argument!"
    echo "Example: ./$me <username>"
    exit 1
fi


USER=$1

USER_KEY_FILE=$USER.key
USER_CSR_CNF=$USER.csr.cnf
USER_CSR_FILE=$USER.csr

cp $USER_CSR_FILE ../admin