#!/bin/bash

##State the username of the admin upon running the script.##
username=$1

##Step One: Login into Azure.##

az login -u $username

##Step Two: Must have admin credentials to continue.##

echo "Verifying for Administrator Credentials. Please wait..."

check=$(az role assignment list  --include-classic-administrators \
--query "[?id=='NA(classic admins)'].principalName" | grep -E $username)
if [ -z $check ]; then
echo "You must have administrator credentials to use access this functionality" 1>&2
exit 1
fi

echo "User Validated, please state one of the following functions:"
echo "Input createuser username *no domain needed* to create a new user."
echo "Input assingrole create or delete username *no domain needed*."
echo "Input reader or contributor to assing or remove a role to an existing user."
echo "Input deleteuser username *no domain needed* to delete a non-admin existing user."

##Function One: Create User##
##Function will also check to see if the user we are intending to create already exits##

createuser()
{

##Variables.##

displayname=$1
userprincipalname=$displayname@doradoe1outlook.onmicrosoft.com
result=$(az ad user list --query [].userprincipalname | grep -E /$userprincipalname/)

if [ -n 'result' ]; then
echo "User being created. Please wait..."
az ad user create \
--display-name $displayname \
--password Revature2019 \
--user-principal-name $userprincipalname \
--subscription 3bd3e6a7-a098-4e65-99d2-933b271e522a \
--force-change-password-next-login true
fi

echo 'User created succesfully.'
exit 0

}

##Function Two: Assing a Role.##

assingrole()
{

##Variables.##
##Action value must be either create or delete.##
##Role value must be either reader or contributor.##

action=$1
displayname=$2
userprincipalname=$displayname@doradoe1outlook.onmicrosoft.com
role=$3

##Checks if the user exists and if the role is already assigned or not.##

if [ -z $userprincipalname ]; then
echo "Invalid username. Please provide an existing username." 1>&2
exit 1
elif [ -z $role ]; then
echo "Invalid role. Please enter reader or contributor." 1>&2
exit 1
fi
echo "Assigning/updating role. Please wait..."
az role assignment $action --assignee $userprincipalname --role $role
echo "Role assigned/updated"
}

##Function Three: Delete non-admin users.##

deleteuser()
{

##Variables.##

displayname=$1
userprincipalname=$displayname@doradoe1outlook.onmicrosoft.com

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
echo "User exists. Deleting User. Please wait..."
az ad user delete --upn-or-object-id $userprincipalname
echo "User deleted."
fi

}

$command $2 $3 $4
