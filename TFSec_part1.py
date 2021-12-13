#!/usr/bin/env python3.7

import requests
import json
import os
username = 'jfr10v'
token = os.getenv('GIT_API')


# create a re-usable session object with the user creds in-built
gh_session = requests.Session()
gh_session.auth = (username, token)

# get the list of repos belonging to me
for page in range(1,32):
    repos_url = 'https://api.github.com/orgs/amount/repos?'+str(page)+'&per_page=100'
    repos = json.loads(gh_session.get(repos_url).text)
    for repo in repos:
        print (repo["language"]=="HCL")
   