#!/bin/bash
###
# @Description:
# @Version:
# @Author: BaiYiZhuo
# @Date: 2023-09-14 15:40:23
# @LastEditTime: 2023-09-14 16:08:27
###
for dir in */; do
    cd $dir || exit
    dir=${dir%*/}
    echo "Building Docker image: $dir"
    tag=ghcr.io/baiyz0825/common-utils/$dir:latest
    docker build -t $tag -f $dir/Dockerfile .
    if [ $? -eq 0 ]; then
        echo "Docker image $dir built successfully"
        echo "Pushing Docker image: $dir"
        docker push $tag
        if [ $? -eq 0 ]; then
            echo "Docker image $tag pushed successfully"
        else
            echo "Failed to push Docker image $tag"
        fi
    else
        echo "Failed to build Docker image $tag"
    fi
    cd ../
done
