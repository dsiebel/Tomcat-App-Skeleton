export JAVA_HOME=/path/to/java/runtime/
export CATALINA_HOME=/path/to/tomcat/
export CATALINA_BASE=/path/to/new/app
export CATALINA_PID=${CATALINA_BASE}/temp/app.pid

${CATALINA_HOME}/bin/catalina.sh stop
