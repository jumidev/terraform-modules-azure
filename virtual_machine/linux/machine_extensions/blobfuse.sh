
blobfuse --version || (
    export BLOBFUSE_VERSION=1.1.1

    # blobfuse
    cd /tmp

    wget https://github.com/Azure/azure-storage-fuse/releases/download/v${BLOBFUSE_VERSION}/blobfuse-${BLOBFUSE_VERSION}-stretch.deb && \
        dpkg -i blobfuse-${BLOBFUSE_VERSION}-stretch.deb && \
        rm -f blobfuse-${BLOBFUSE_VERSION}-stretch.deb

    cd -

)

jq --version || (
    apt install -y jq
)

cd /usr/bin/ 

cat > blobfuse_azuremount <<- EOF
#!/bin/env bash

set -eu

TMP_DIR=\$1
CONTAINER=\$2
AZURE_ACCOUNT=\$3

AZURE_STORAGE_ACCESS_KEY=\$(curl 'http://169.254.169.254/metadata/identity/oauth2/token?api-version=2018-02-01&resource=https%3A%2F%2Fstorage.azure.com%2F' -H Metadata:true | jq '.access_token' -r)

mkdir -p \$TMP_DIR || true

blobfuse 


EOF

chmod +x blobfuse_azuremount

cd -
