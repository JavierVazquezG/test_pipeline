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

# Get environment variables
S3Bucket = os.getenv('S3_BUCKET')
TOKEN_API = os.getenv('GIT_API')


headers = {
    'accept': 'application/vnd.github.vixen-preview+json',
    'authorization': 'Bearer '+TOKEN_API,
    'content-type': 'application/json',
}

#Setting the session of the boto3
session = boto3.Session()

def updateS3Bucket(S3Bucket, filename, key):
    s3 = session.client('s3')
    s3.upload_file('/usr/src/app/'+filename, S3Bucket, key)

if __name__ == '__main__':
    
    
    # os.system("touch test.txt")
    # os.system("ls -lrt ~/" )
    # os.system("cd ~")
    # os.system("pwd")
    # updateS3Bucket(S3Bucket, "test.txt", "18")
    

    for page in range(1,32):
       response = requests.get('https://api.github.com/orgs/amount/repos?page='+str(page)+'&per_page=100', headers=headers)
       data = response.json()
       
       for repo in data:
           if(repo["language"] == 'HCL'):
               #date = datetime.datetime.now()
               #folder_name = date.strftime('%Y-%m-%d')
               reposName = repo["name"]
               ssh_clone_url = repo["ssh_url"]
               path = os.getcwd()
               print(path)
               if os.path.exists('cloneReposDirectory'):
                   shutil.rmtree('cloneReposDirectory')
               os.mkdir('cloneReposDirectory')
               os.chdir(path+'/cloneReposDirectory')
               os.mkdir(reposName)
               os.chdir(reposName)
               git.Repo.clone_from(ssh_clone_url, '.')
               os.system("tfsec . --format csv --out TFSec_Report_"+reposName+".csv")
               os.system("mv TFSec_Report_"+reposName+".csv ~/")
               file_Report = "TFSec_Report_"+reposName+".csv"
               listado = os.system("ls -lrt")
               print(listado)
               updateS3Bucket(S3Bucket, file_Report, "test1")
               os.chdir(path)
               shutil.rmtree('cloneReposDirectory')