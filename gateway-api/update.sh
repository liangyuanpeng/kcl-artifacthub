#!/bin/bash

set -o errexit
set -o nounset
set -eoux pipefail

# git clone https://github.com/kubernetes-sigs/gateway-api.git -b release-1.1

# TODO 根据文件名区分API 版本号

for API in /home/runner/work/lanactions/lanactions/gateway-api/config/crd/standard/*
do
    if [ "$(basename "${API}")" = "kustomization.yaml" ];then 
        continue
    fi
    kcl-openapi generate model --crd -f $API --skip-validation -t /home/runner/work/lanactions/lanactions/kcl-artifacthub/gateway-api/standard
done

for API in /home/runner/work/lanactions/lanactions/gateway-api/config/crd/experimental/*
do
    if [ "$(basename "${API}")" = "kustomization.yaml" ];then 
        continue
    fi
    kcl-openapi generate model --crd -f $API --skip-validation -t /home/runner/work/lanactions/lanactions/kcl-artifacthub/gateway-api/experimental
        echo "generate"
done
