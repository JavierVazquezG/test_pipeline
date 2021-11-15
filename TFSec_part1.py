#!/usr/bin/env python3.7

from genericpath import exists
import requests
import os
import shutil
import git
from datetime import date

headers = {
    'accept': 'application/vnd.github.vixen-preview+json',
    'content-type': 'application/json',
}
def install_aws():
    os.system('curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"')
    os.system("unzip awscliv2.zip")
    os.system("sudo ./aws/install")

if __name__ == '__main__':
    install_aws()
    
    for page in range(1,32):
        response = requests.get('https://api.github.com/orgs/amount/repos?page='+str(page), headers=headers)
        data = response.json()

        for repo in data:
            if(repo["language"] == 'HCL'):
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
                if not (os.path.exists('~/Reports')):
                    os.system("mkdir ~/Reports")
                os.system("tfsec . --format csv --out TFSec_Report_"+reposName+".csv")
                os.system("mv TFSec_Report_"+reposName+".csv ~/Reports/")
                list = os.listdir("~/Reports")
                print(list)
                print("Next list")
                list2 = os.listdir("~/")
                print(list2)
                os.chdir(path)
                shutil.rmtree('cloneReposDirectory')