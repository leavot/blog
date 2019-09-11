#!/bin/bash 

# add following to crontab to enable auto git push for this repo
# */10 * * * * /media/sf_github/leavot/blog/git_auto_push.sh >/dev/null 2>&1

#get current repo's path
repo_path=$(cd $(dirname $0); pwd)
echo $repo_path
cd $repo_path && ls && git pull && git pull && git add . && git commit -m "auto push office" && git push origin master
