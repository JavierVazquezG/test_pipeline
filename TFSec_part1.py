#!/usr/bin/env python3.7

import requests
import datetime
import os
import shutil
import git

headers = {
    'accept': 'application/vnd.github.vixen-preview+json',
    'content-type': 'application/json',
}

if __name__ == '__main__':
        for page in range(1,28):
            response = requests.get('https://api.github.com/orgs/amount/repos?page='+str(page), headers=headers)
            data = response.json()

            for repo in data:
                if(repo["language"] == 'HCL'):
                    date = datetime.datetime.now()
                    folder_name = date.strftime('%Y-%m-%d')
                    
                    reposName = repo["name"]
                    ssh_clone_url = repo["ssh_url"]
                    path = os.getcwd()
                    if os.path.exists('cloneReposDirectory'):
                        shutil.rmtree('cloneReposDirectory')
                    os.mkdir('cloneReposDirectory')
                    os.chdir(path+'/cloneReposDirectory')
                    os.mkdir(reposName)
                    os.chdir(reposName)
                    git.Repo.clone_from(ssh_clone_url, '.')
                    os.system("docker run -it -v \"$(pwd):/src\" tfsec/tfsec /src --format csv > $(pwd)/TFSec_Report_"+reposName+".csv")
                    os.system("mkdir ../../Reports")
                    os.system("mv TFSec_Report_"+reposName+".csv ../../Reports")
                    os.chdir(path)
                    shutil.rmtree('cloneReposDirectory')
                
