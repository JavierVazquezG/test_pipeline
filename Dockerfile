FROM docker.artifactory.internal.amount.com/linuxbrew/brew
ARG VAULT_VERSION=0.10.1
WORKDIR /usr/src/app

COPY files/custom_ca.crt /usr/local/share/ca-certificates/custom_ca.crt
COPY files/AmountRootCA.crt /usr/local/share/ca-certificates/AmountRootCA.crt
COPY files/intermediate.crt /usr/local/share/ca-certificates/intermediate.crt

RUN /usr/sbin/update-ca-certificates

RUN brew install tfsec && brew install python3 && brew install git && brew install wget && brew install jq
RUN pip3 install requests && pip3 install gitpython && pip3 install boto3
# Install the vault CLI securely
RUN mkdir /usr/local/src/vault && \
    wget https://releases.hashicorp.com/vault/${VAULT_VERSION}/vault_${VAULT_VERSION}_linux_amd64.zip -P /usr/local/src/vault && \
    wget https://releases.hashicorp.com/vault/${VAULT_VERSION}/vault_${VAULT_VERSION}_SHA256SUMS -P /usr/local/src/vault && \
    cat /usr/local/src/vault/vault_${VAULT_VERSION}_SHA256SUMS | grep vault_${VAULT_VERSION}_linux_amd64.zip > /usr/local/src/vault/vault_${VAULT_VERSION}_linux_amd64.zip.sha256
RUN cd /usr/local/src/vault && sha256sum --quiet -c vault_${VAULT_VERSION}_linux_amd64.zip.sha256 && \
    if [ $? -eq 0 ]; then unzip /usr/local/src/vault/vault*.zip -d /usr/local/bin/ && rm -f /usr/local/src/vault/vault*.zip ; else exit 1 ; fi

COPY ./ssh-config /docker-entrypoint.d/
COPY ./secreports.sh .

RUN chmod +x /docker-entrypoint.d/ssh-config && mkdir ~/.ssh && ssh-keyscan -t rsa github.com >> ~/.ssh/known_hosts && chmod +x /tmp/secreports.sh
COPY . .
ENTRYPOINT ["/tmp/secreports.sh"]