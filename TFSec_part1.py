#!/usr/bin/env python3.7

from genericpath import exists
import requests
import os
import shutil
import git
import boto3
import botocore
import datetime
from datetime import date

headers = {
    'accept': 'application/vnd.github.vixen-preview+json',
    'content-type': 'application/json',
}

# Get environment variables
S3Bucket = os.getenv('S3_BUCKET')

#Setting the session of the boto3
session = boto3.Session()

def updateS3Bucket(S3Bucket, filename, key):
    s3 = session.client('s3')
    s3.upload_file('~/usr/src/app/Reports/'+filename, S3Bucket, key)

if __name__ == '__main__':
    print(boto3.client('sts').get_caller_identity()['Account'])
    
    os.system("mkdir Reports")
    os.system("touch test.txt")
    os.system("mv test.txt ~/usr/src/app/Reports")
    updateS3Bucket(S3Bucket, "18", "test.txt")
    

    #for page in range(1,32):
    #    response = requests.get('https://api.github.com/orgs/amount/repos?page='+str(page), headers=headers)
    #    data = response.json()

    #    for repo in data:
    #        if(repo["language"] == 'HCL'):
    #            date = datetime.datetime.now()
    #            folder_name = date.strftime('%Y-%m-%d')
    #            reposName = repo["name"]
    #            ssh_clone_url = repo["ssh_url"]
    #            path = os.getcwd()
    #            if os.path.exists('cloneReposDirectory'):
    #                shutil.rmtree('cloneReposDirectory')
    #            os.mkdir('cloneReposDirectory')
    #            os.chdir(path+'/cloneReposDirectory')
    #            os.mkdir(reposName)
    #            os.chdir(reposName)
    #            git.Repo.clone_from(ssh_clone_url, '.')
    #            if not (os.path.exists('~/Reports')):
    #                os.system("mkdir ~/Reports")
    #            os.system("tfsec . --format csv --out TFSec_Report_"+reposName+".csv")
    #            os.system("mv TFSec_Report_"+reposName+".csv ~/Reports/")
    #            file_Report = "TFSec_Report_"+reposName+".csv"
    #            updateS3Bucket(S3Bucket, folder_name, file_Report)
    #            os.chdir(path)
    #            shutil.rmtree('cloneReposDirectory')