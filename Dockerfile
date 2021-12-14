FROM linuxbrew/brew
WORKDIR /usr/src/app

RUN brew install tfsec && brew install python3 && brew install git
RUN pip3 install requests && pip3 install gitpython && pip3 install boto3
# Install the vault CLI securely
RUN mkdir /usr/local/src/vault && \
    wget https://releases.hashicorp.com/vault/${VAULT_VERSION}/vault_${VAULT_VERSION}_linux_amd64.zip -P /usr/local/src/vault && \
    wget https://releases.hashicorp.com/vault/${VAULT_VERSION}/vault_${VAULT_VERSION}_SHA256SUMS -P /usr/local/src/vault && \
    cat /usr/local/src/vault/vault_${VAULT_VERSION}_SHA256SUMS | grep vault_${VAULT_VERSION}_linux_amd64.zip > /usr/local/src/vault/vault_${VAULT_VERSION}_linux_amd64.zip.sha256
RUN cd /usr/local/src/vault && sha256sum --quiet -c vault_${VAULT_VERSION}_linux_amd64.zip.sha256 && \
    if [ $? -eq 0 ]; then unzip /usr/local/src/vault/vault*.zip -d /usr/local/bin/ && rm -f /usr/local/src/vault/vault*.zip ; else exit 1 ; fi

COPY ./ssh-config /docker-entrypoint.d/

COPY . .
CMD ["TFSec_part1.py"]
ENTRYPOINT ["python3"]