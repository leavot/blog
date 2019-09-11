#!/bin/bash 

repo_path=`pwd`
echo $repo_path
cd $repo_path && ls && git pull && git pull && git add . && git commit -m "auto push office" && git push origin master
