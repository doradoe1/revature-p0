#!/bin/bash

##Function One: Create User##

username=$1
password=$2
displayname=$3
userprincipalname=$displayname@doradoe1outlook.onmicrosoft.com
subscription=$4

az login -u $username -p $password


result=$(az ad user list --query [].userprincipalname | grep -E /$userprincipalname/)

if [ -n 'result' ]; then
az ad user create --display-name $displayname --password Revature2019 \
--user-principal-name $userprincipalname --subscription $subscription \
--force-change-password-next-login true
fi

echo 'Это сделано'


##Function Two: Assing a Role##

az role definition create --role-definition '{ \
            "Name": "$userprincipalname", \
            "Description": "Perform VM actions and read storage and network information." \
            "Actions": [ \
                "Microsoft.Compute/*/read", \
                "Microsoft.Compute/virtualMachines/start/action", \
                "Microsoft.Compute/virtualMachines/restart/action", \
                "Microsoft.Network/*/read", \
                "Microsoft.Storage/*/read", \
                "Microsoft.Authorization/*/read", \
                "Microsoft.Resources/subscriptions/resourceGroups/read", \
                "Microsoft.Resources/subscriptions/resourceGroups/resources/read", \
                "Microsoft.Insights/alertRules/*", \
                "Microsoft.Support/*" \
            ], \
            "DataActions": [ \
                "Microsoft.Storage/storageAccounts/blobServices/containers/blobs/*" \
            ], \
            "NotDataActions": [ \
                "Microsoft.Storage/storageAccounts/blobServices/containers/blobs/write" \
            ], \
            "AssignableScopes": ["/subscriptions/xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx"] \
        }'
