
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
		<td valign="top">'''Default:''' "-Dfile.root=${CATALINA_BASE}/storage -Dlog.root=${CATALINA_BASE}/logs"</td>
	</tr>
</table>

#### stop.sh
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

### conf/
The conf/- folder contains the tomcat's catalina engine configuration. Therefor every knwon configuration file can be overwritten in here. In the default setup the following configurations will be included.
Refer to the tomcat configuration guid for further information on configuring a tomcat installation: http://tomcat.apache.org/tomcat-7.0-doc/

#### context.xml
Contains the container context configuration specifying application resources. 
Initially this configuration file is empty.

#### tomcat-users.xml
The tomcat roles- user store. This file initially contains some default users:

```xml
<?xml version='1.0' encoding='utf-8'?>
<tomcat-users>
        <role rolename="admin"/>
        <role rolename="manager"/>
        <role rolename="tomcat"/>
        <user username="tomcat" password="tomcat" roles="admin,manager,tomcat"/>
</tomcat-users>
```

#### server.xml
Tomcat server configuration. The configuration contains some minor changes to the Connectors' ports in constrast to a freshly downloaded tomcat installation.


### logs/
The application's log directory. This directory will be used for the instance's __catalina.out__.
Also this directory will be available to the application as system property __log.root__ by default. This property may be used directly in your log4j.properties file for example:

```
log4j.appender.R=org.apache.log4j.RollingFileAppender
log4j.appender.R.File=${log.root}/myApp.log
```

### server/
Server directory of the catalina engine.

### storage/
This is the applications default file-base. All files like a lucene index or a derby database directory should be placed in here. To simplify access to this folder, it will be available to the application as system property __file.root__.
Therefor this can be used directly inside your spring configuration for example:

```xml
<bean id="mySampleBean" class="com.acme.Importer"
		p:importFilesPath="${file.root}/import"/>
```

### temp/
This directory will be used for the application's/tomcat's PID-file by default.
Also it will be set as system property __java.io.tmpdir__.

### webapps/
The tomcat's webapps directory for this application. Place your war-files in here.

### work/
Catalina work directory.

