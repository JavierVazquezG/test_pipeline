#!/bin/bash -x

name=$(hostname)
echo $hostname

cat << EOF
  - name: "Docker Image - Python Script" 
    agents:
      name: "$name"
    label: ":docker::python::aws:"
    plugins:
      - docker-compose#v3.7.0:
          run: app
  - wait
  - name: "Copying Files"
    agents:
      name: "$name"
    commands: 'copyFiles.sh'
EOF