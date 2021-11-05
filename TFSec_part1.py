#!/usr/bin/env python3.7

from genericpath import exists
import requests
import datetime
import os
import shutil
import git
import datetime

headers = {
    'accept': 'application/vnd.github.vixen-preview+json',
    'content-type': 'application/json',
}


def createFolder():
    date = datetime.datetime.now()
    folder_name = date.strftime('%Y-%m-%d')
    bucket_name = "amount-shared-cicd-security-reports.use2"
    os.system("aws s3 cp ~/Reports/* s3://{bucket_name}/{folder_name}/ --region us-east-2")

    
if __name__ == '__main__':
    for page in range(1,28):
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
                os.chdir(path)
                shutil.rmtree('cloneReposDirectory')
    createFolder()