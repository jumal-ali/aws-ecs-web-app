#!/bin/bash

AWS_REGION="eu-west-1"

if [ -z "$1" ] || [ -z "$2" ] || [ -z "$3" ]; then
    echo -e "Aborting, Not enough arguments provided"
    echo -e "
Help:

    Usage:     
                
    update-ecs-service.sh [Cluster] [Service] [Task_Revison]

    Example:

    update-ecs-service.sh \"dev-cluster\" \"web-service\" \"web-app:4\"
"
    exit 1
fi

CLUSTER="$1"
SERVICE="$2"
TASK_REVISION="$3"

echo -e "DEPLOYING - ${TASK_REVISION}"

if ! aws ecs update-service \
    --region "${AWS_REGION}" \
    --cluster="${CLUSTER}" \
    --service="${SERVICE}" \
    --task-definition="${TASK_REVISION}" \
    --force-new-deployment \
    --query service.taskDefinition 
then
    echo "FAILED"
    exit 1
fi

echo "SUCCESS"
