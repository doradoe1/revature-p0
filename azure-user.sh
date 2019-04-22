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
echo "User being created. Please wait"
az ad user create \
--display-name $displayname \
--password Revature2019 \
--user-principal-name $userprincipalname \
--subscription 3bd3e6a7-a098-4e65-99d2-933b271e522a \
--force-change-password-next-login true
else
echo "User already exist. Please make sure that you have entered the display name" \
"correctly and try again" 1>&2
exit 1
fi

echo 'Это сделано'
exit 0
}

##Function Two: Assing a Role.##
assingrole()
{
##Variables.##
displayname=$1
userprincipalname=$displayname@doradoe1outlook.onmicrosoft.com
role=$2
contributor=$(b24988ac-6180-42a0-ab88-20f7382dd24c)
reader=$(acdd72a7-3385-48ef-bd42-f606fba81ae7)

##Checks if the user exists and if the role is already assigned or not.##
if [ -z $userprincipalname ]; then
echo "Invalid username. Please provide an existing displayname." 1>&2
exit 1
elif [ -z $role ]; then
echo "Invalid role. Please enter reader or contributor." 1>&2
exit 1
fi

az role assignment create --assignee $userprincipalname --role $role

az role assignment delete --assignee $userprincipalname --role $role

}

##Function Three: Delete non-admin users.##
deleteuser()
{
##Variables.##
displayname=$1
userprincipalname=$displayname@doradoe1outlook.onmicrosoft.com
role=$2

##Administration credentials checkpoint. Will not work procced if userprincipalname##
##belongs to an account administrator.##
admincheck=$(az role assignment list \
--include-classic-administrators \
--query "[?id=='NA(classic admins)'].principalName" | grep -E $userprincipalname)
if ! [ -z $admincheck ]; then
echo "The user you are attempting to delete is an administrator." \
"You do not have the permissions nessesary to delete administrators" 1>&2
exit 1
fi

##Verifying the existence of the user and deleting user from Azure Cloud##
user=$(az ad user list --query [].userPrincipalName | grep -E $userprincipalname)
if [ -z $user ]; then
echo "Invalid user. Please enter an existing user with non-administrator credentials." 1>&2
exit 1
else
echo "User exists. Deleting User. Please wait."
az ad user delete --upn-or-object-id $userprincipalname
fi
}
