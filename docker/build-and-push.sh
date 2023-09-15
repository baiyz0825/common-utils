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
    tag1=byz0825/$dir:latest
    tag2=ghcr.io/baiyz0825/common-utils/$dir:latest
    echo "Building Docker image path : $dir"
    echo "Building Docker image Tag is: $tag1,$tag2"
    docker tag $dir $tag1
    docker tag $dir $tag2
    docker build  -f ./Dockerfile .
    if [ $? -eq 0 ]; then
        echo "Docker image $tag1,$tag2 built successfully"
        echo "Pushing Docker image: $tag1,$tag2"
        docker push $tag1 && docker push $tag2
        if [ $? -eq 0 ]; then
            echo "Docker image $tag1,$tag2 pushed successfully"
        else
            echo "Failed to push Docker image $tag1,$tag2"
        fi
    else
        echo "Failed to build Docker image $tag1,$tag2"
    fi
    cd ../
done
