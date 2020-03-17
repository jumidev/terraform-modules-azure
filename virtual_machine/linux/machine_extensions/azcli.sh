az --version || (
    # based on https://docs.microsoft.com/en-us/cli/azure/install-azure-cli-apt?view=azure-cli-latest
    if which apt ; then
        apt update -y 
        apt install -y ca-certificates curl apt-transport-https lsb-release gnupg wget libcurl3-gnutls fuse 
        curl -sL https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > /etc/apt/trusted.gpg.d/microsoft.asc.gpg 
        AZ_REPO=$(lsb_release -cs)
        echo "deb [arch=amd64] https://packages.microsoft.com/repos/azure-cli/ $AZ_REPO main" > /etc/apt/sources.list.d/azure-cli.list 
        apt update -y && apt install -y azure-cli 
    fi 

    # based on https://docs.microsoft.com/en-us/cli/azure/install-azure-cli-yum?view=azure-cli-latest
    if which yum ; then
        rpm --import https://packages.microsoft.com/keys/microsoft.asc
        sh -c 'echo -e "[azure-cli]
name=Azure CLI
baseurl=https://packages.microsoft.com/yumrepos/azure-cli
enabled=1
gpgcheck=1
gpgkey=https://packages.microsoft.com/keys/microsoft.asc" > /etc/yum.repos.d/azure-cli.repo'
        yum install -y azure-cli
    fi

)