## bin/
Contains all scripts used for i.e. running and stopping you application.
__Note__ that those scripts need execution permission!

### start.sh
This is the start-script of your application. 
It is also used to configure the application's environment:

```bash
export JAVA_HOME=/path/to/java/runtime/
export CATALINA_HOME=/path/to/tomcat/
export CATALINA_BASE=/path/to/my/app
export CATALINA_PID=${CATALINA_BASE}/temp/myapp.pid
export CATALINA_OPTS="-Dfile.root=${CATALINA_BASE}/storage -Dlog.root=${CATALINA_BASE}/logs"

${CATALINA_HOME}/bin/catalina.sh start
```

<table>
	<tr>
		<th width="20%">Variable</th>
		<th>Description</th>
		<th width="20%">Sample</th>
	</tr>
	<tr>
		<td valign="top"><tt>$JAVA_HOME</tt></td>
		<td valign="top">Home path of the Java Runtime Environment (or JDK)</td>
		<td valign="top"><file>/opt/java-1.6/jdk1.6.0_20</file></td>
	</tr>
	<tr>
		<td valign="top"><tt>$CATALINA_HOME</tt></td>
		<td valign="top">Home path of the tomcat installation to use</td>
		<td valign="top"><file>/opt/apache-tomcat7</file></td>
	</tr>
	<tr>
		<td valign="top"><tt>$CATALINA_BASE</tt></td>
		<td valign="top">Base path of your application</td>
		<td valign="top"><file>/path/to/my/app</file></td>
	</tr>
	<tr>
		<td valign="top"><tt>$CATALINA_PID</tt></td>
		<td valign="top">Realpath of the process pid file. This is essential for the start- and stop-scripts to work properly</td>
		<td valign="top">${CATALINA_BASE}/temp/myNewApp.pid</td>
	</tr>
	<tr>
		<td valign="top"><tt>$CATALINA_OPTS</tt></td>
		<td valign="top">Additional runtime parameters used by the catalina engine and therefor as Java System Properties. Usually I add two system properties (${file.root} & ${log.root}) to a web application's environment to simplify access to the underlying filesystem.</td>
		<td valign="top">Default: "-Dfile.root=${CATALINA_BASE}/storage -Dlog.root=${CATALINA_BASE}/logs"</td>
	</tr>
</table>

### stop.sh
This script can be used to gracefully stop the running tomcat instance containing your web application.
It basically contains the same catalina configuration as the corresponsing start.sh.

```bash
export JAVA_HOME=/path/to/java/runtime/
export CATALINA_HOME=/path/to/tomcat/
export CATALINA_BASE=/path/to/my/app
export CATALINA_PID=${CATALINA_BASE}/temp/myapp.pid
 
${CATALINA_HOME}/bin/catalina.sh stop
```

__Note__ that all paths in start.sh and stop.sh have to be identical for the scripts to work properly!