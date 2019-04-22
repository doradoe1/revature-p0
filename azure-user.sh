#!/bin/bash

##Declare the variables needed. We will use these variables##
##across the three functions.##

username=$1
password=(-s $2)
role=$4
contributor=$(b24988ac-6180-42a0-ab88-20f7382dd24c)
reader=$(acdd72a7-3385-48ef-bd42-f606fba81ae7)

##Step One: Login into Azure.##

az login -u $username -p $password

##Step Two: Must have admin credentials to continue.##

echo "Verifying for Administrator Credentials"
check=$(az role assignment list  --include-classic-administrators \
--query "[?id=='NA(classic admins)'].principalName" | grep -E $username)
if [ -z $check ]; then
  echo "You must have administrator credentials to use access this functionality" 1>&2
  exit 1
fi
echo "User Validated, please state one of the following functions:" \
"Create user (createuser()), assing a role to an existing user (assignrole())," \
" or delete a non-admin existing user (deleteuser())"

##Function One: Create User##
##Function will also check to see if the user we are intending to create already exits##

createuser()
{
displayname=$1
userprincipalname=$displayname@doradoe1outlook.onmicrosoft.com
result=$(az ad user list --query [].userprincipalname | grep -E /$userprincipalname/)
if [ -n 'result' ]; then
az ad user create \
--display-name $displayname \
--password Revature2019 \
--user-principal-name $userprincipalname \
--subscription 3bd3e6a7-a098-4e65-99d2-933b271e522a \
--force-change-password-next-login true
fi

echo 'Это сделано'
exit 0
}

##Function Two: Assing a Role.##

az role assignment create --assignee $userprincipalname --role $role

az role assignment delete --assignee $userprincipalname --role $role

##Function Three: Delete non-admin users.

az ad user delete --upn-or-object-id $userprincipalname
