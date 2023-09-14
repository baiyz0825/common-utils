#!/bin/bash
###
# @Description:
# @Version:
# @Author: BaiYiZhuo
# @Date: 2023-09-14 15:40:23
# @LastEditTime: 2023-09-14 16:24:01
###
for dir in */; do
    cd "$dir"
    echo "将要处理  $(pwd)"
    dir=${dir%*/}
    echo "Building Docker image path : $dir"
    tag=ghcr.io/baiyz0825/common-utils/$dir:latest
    echo "Building Docker image Tag is: $tag"
    docker build -t $tag -f ./Dockerfile .
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
