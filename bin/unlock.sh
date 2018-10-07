#!/bin/bash

rm -R sirono-app

mkdir -p sirono-app/main/default
mkdir -p sirono-app/test/default

cp -R src/ sirono-app/main/default
cp -R test-src/ sirono-app/test/default
rm sirono-app/main/default/package.xml

# You must have a default targetdevhubusername set for this to work. If not add "--targetdevhubusername orgName" to the command below
# must have a unique name within a namespace. Pick something specific to your org and add it as an prefix or suffix (ie sirono-mycompany)
#sfdx force:package:create --name sirono --description "Sirono Common Utilities https://github.com/blueprinthealth/sirono-common" --packagetype Unlocked --path sirono-app --nonamespace -v dx

# Update the versionName and versionNumber in sfdx-project.json and then run the remaining commands
#sfdx force:package:version:create -p sirono -d sirono-app -x --wait 10
#sfdx force:package:version:promote -p sirono@1.0.0-1

# You must have a default targetusername set for this to work. If not add "--targetusername userName" to the command below
#sfdx force:package:install -w 5 -r --package sirono@1.0.0-1