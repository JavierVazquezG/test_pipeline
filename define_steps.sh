#!/bin/bash -x

cat << EOF
  - name: "Docker Image - Python Script" 
    agents:
      queue: eks-buildkite-agent
    label: ":docker::python::aws:"
    plugins:
      - docker-compose#v3.7.0:
          run: app
          volumes:
            - "/root/.ssh/id_rsa:/root/.ssh/id_rsa"
            - "/root/.ssh/known_hosts:/root/.ssh/known_hosts"
EOF
#  - wait
#  - name: "Copying Files"
#    agents:
#    commands: 'copyFiles.sh'
#EOF