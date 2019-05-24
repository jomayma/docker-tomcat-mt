echo 'BEGIN - CLEAN INSTALL mt-migration-tomcat'
echo 'DELETING PREVIOUS RESOURCES...'
oc delete all --selector build=mt-migration-tomcat
oc delete all --selector app=mt-migration-tomcat
echo 'NEW BUILD CREATION...'
oc new-build . --name=mt-migration-tomcat -e MWA_ENV=INT
echo 'START BUILD...'
oc start-build mt-migration-tomcat --from-dir=. --follow=true --wait=true
echo 'NEW APP...'
oc new-app mt-migration-tomcat
echo 'ROUTE CREATION...'
oc create route edge --service=mt-migration-tomcat
echo 'RESOURCES CREATED:'
oc get all --selector build=mt-migration-tomcat
oc get all --selector app=mt-migration-tomcat
echo 'END - CLEAN INSTALL mt-migration-tomcat'