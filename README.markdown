
# Wiki goes here


## Folder structure

__tomcat-app-skeleton/__

 * bin/
  * start.sh
  * stop.sh
 * conf/
  * context.xml
  * server.xml
  * tomcat-users.xml
 * logs/
 * server/
 * storage/
 * temp/
 * webapps/
 * work/

### bin/
Contains all scripts used for i.e. running and stopping you application.
__Note__ that those scripts need execution permission!

#### start.sh
This is the start-script of your application. It is also used to configure the application's environment.
````bash
export JAVA_HOME=/path/to/java/runtime/
export CATALINA_HOME=/path/to/tomcat/
export CATALINA_BASE=/path/to/new/app
export CATALINA_PID=${CATALINA_BASE}/temp/app.pid
export CATALINA_OPTS="-Dfile.root=${CATALINA_BASE}/storage -Dlog.root=${CATALINA_BASE}/logs"
 
${CATALINA_HOME}/bin/catalina.sh start
````