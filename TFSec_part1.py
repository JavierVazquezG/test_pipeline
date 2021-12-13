#!/usr/bin/env python3.7

import requests
import json
import os
token = os.getenv('GIT_API')
username = 'jfr10v'

repos_url = 'https://api.github.com/orgs/amount/repos'

# create a re-usable session object with the user creds in-built
gh_session = requests.Session()
gh_session.auth = (username, token)

# get the list of repos belonging to me
repos = json.loads(gh_session.get(repos_url).text)

# print the repo names
for repo in repos:
    print (repos)
    print (repo["name"])