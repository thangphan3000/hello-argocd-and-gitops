#!/bin/bash

set -ex

new_tag_version=$1
echo "New version: $new_tag_version"

new_image=lixun2002/lixun:$new_tag_version
docker tag nginx:1.27.4 $new_image
docker push $new_image

tmp_dir=$(mktemp -d)
echo $tmp_dir

git clone https://github.com/thangphan3000/hello-argocd-and-gitops.git $tmp_dir

sed -i '' -e "s/lixun2002\/lixun:.*/lixun2002\/lixun:$new_tag_version/g" $tmp_dir/my-app/1-deployment.yaml

cd $tmp_dir
git add .
git commit -m "Update image to $new_image"
git push

rm -rf $tmp_dir
