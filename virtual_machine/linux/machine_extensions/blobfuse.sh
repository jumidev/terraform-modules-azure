export BLOBFUSE_VERSION=1.1.1

# blobfuse
cd /tmp

wget https://github.com/Azure/azure-storage-fuse/releases/download/v${BLOBFUSE_VERSION}/blobfuse-${BLOBFUSE_VERSION}-stretch.deb && \
    dpkg -i blobfuse-${BLOBFUSE_VERSION}-stretch.deb && \
    rm -f blobfuse-${BLOBFUSE_VERSION}-stretch.deb

cd -