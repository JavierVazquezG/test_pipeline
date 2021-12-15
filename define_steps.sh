#!/bin/bash -x

cat << EOF
  - name: "Docker Image - Python Script" 
    agents:
      queue: eks-buildkite-agent
    label: ":docker::python::aws:"
    plugins:
      - docker-compose#v3.7.0:
          run: app
          env:
            - VAULT_ADDR
            - VAULT_ROLE_ID
            - VAULT_SECRET_ID
EOF
#  - wait
#  - name: "Copying Files"
#    agents:
#    commands: 'copyFiles.sh'
#EOF