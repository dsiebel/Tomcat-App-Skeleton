# Introduction
This project is about simplifying the hosting of a multi-application-environment using seperate tomcat installations. 
The tomcat-app-skeleton setup allows to combine different java- and tomcat versions to run a web application in it's own, specific environment.

From the Tomcat docs (RUNNING.txt):

> __Advanced Configuration - Multiple Tomcat Instances__
> 
> In many circumstances, it is desirable to have a single copy of a Tomcat 
> binary distribution shared among multiple users on the same server.  To make
> this possible, you can set the $CATALINA_BASE environment variable to e
> directory that contains the files for your 'personal' Tomcat instance.
> 
> When you use $CATALINA_BASE, Tomcat will calculate all relative references for
> files in the following directories based on the value of $CATALINA_BASE instead
> of $CATALINA_HOME:
> 
> * bin  - Only setenv.sh (*nix), setenv.bat (windows) and tomcat-juli.jar
> * conf - Server configuration files (including server.xml)
> * logs - Log and output files
> * webapps - Automatically loaded web applications
> * work - Temporary working directories for web applications 
> * temp - Directory used by the JVM for temporary files (java.io.tmpdir)
> 
> Note that by default Tomcat will first try to load classes and JARs from
> $CATALINA_BASE/lib and then $CATALINA_HOME/lib. You can place instance specific
> JARs and classes (e.g. JDBC drivers) in $CATALINA_BASE/lib whilst keeping the
> standard Tomcat JARs in $CATALINA_HOME/lib.
> 
> If you do not set $CATALINA_BASE, $CATALINA_BASE will default to the same value
> as $CATALINA_HOME, which means that the same directory is used for all relative
> path resolutions.


## Prerequisites
For this setup to work you need at least one Java (JRE or JDK) and one Tomcat installation on your machine which can be applied to a specific application. To make even more sense I usually happen to have the three main tomcat versions available to the app-skeleton to be able to test a web application in different tomcat contexts in my DEV environment. This usually looks like this:

```
/opt/apache-tomcat5 -> /opt/apache-tomcat-5.5/
/opt/apache-tomcat-5.5/
/opt/apache-tomcat6 -> /opt/apache-tomcat-6.0.26/
/opt/apache-tomcat-6.0.26/
/opt/apache-tomcat-6.0.35/
/opt/apache-tomcat7 -> /opt/apache-tomcat-7.0.26/
/opt/apache-tomcat-7.0.26/
/opt/jre1.6.0_20/
/opt/jre1.7.0_03/
```

where __apache-tomcat5__, __apache-tomcat6__ and __apache-tomcat7__ are symlinks to the newest corresponding major version of the tomcat installation.


# Folder structure

## bin/
Contains the scripts used for i.e. running and stopping you application.
__Note__ that those scripts need execution permission!
You can add additional executables to this directory if needed.

### start.sh
This is the start-script of your web application. 
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
		<td valign="top"><tt>JAVA_HOME</tt></td>
		<td valign="top">Home path of the Java Runtime Environment (or JDK). Must point at a JDK installation to run tomcat with the "debug" argument.</td>
		<td valign="top"><file>/opt/java-1.6/jdk1.6.0_20</file></td>
	</tr>
	<tr>
		<td valign="top"><tt>CATALINA_HOME</tt></td>
		<td valign="top">Home path of the tomcat installation to use</td>
		<td valign="top"><file>/opt/apache-tomcat7</file></td>
	</tr>
	<tr>
		<td valign="top"><tt>CATALINA_BASE</tt></td>
		<td valign="top">Base path of your application (Base directory for resolving dynamic portions of a Catalina installation.  If not present, resolves to the same directory that CATALINA_HOME points to)</td>
		<td valign="top"><file>/path/to/my/app</file></td>
	</tr>
	<tr>
		<td valign="top"><tt>CATALINA_PID</tt></td>
		<td valign="top">(Optional) Path of the file which contains the pid of the catalina startup java process, when start (fork) is used. This is essential for _start.sh_ and _stop.sh_ to work properly</td>
		<td valign="top">${CATALINA_BASE}/temp/myapp.pid</td>
	</tr>
	<tr>
		<td valign="top"><tt>CATALINA_OPTS</tt></td>
		<td valign="top">(Optional) Java runtime options used when the "start", "run" or "debug" command is executed. Include here and not in JAVA_OPTS all options, that should only be used by Tomcat itself, not by the stop process, the version command etc. Examples are heap size, GC logging, JMX ports etc.
		I Usually add two system properties (<em>file.root</em> & <em>log.root</em>) to a web application's environment to simplify logging and access to the underlying filesystem in a multiple environment scenario (test, dev, staging, production) where those paths may vary.</td>
		<td valign="top"><strong>default:</strong> "-Dfile.root=${CATALINA_BASE}/storage -Dlog.root=${CATALINA_BASE}/logs"</td>
	</tr>
</table>

Further available variables are - as explained in the tomcat docs in catalina.sh:

<table>
	<tr>
		<th width="20%">Variable</th>
		<th>Description</th>
	</tr>
	<tr>
		<td valign="top"><tt>CATALINA_OUT</tt></td>
		<td valign="top">(Optional) Full path to a file where stdout and stderr will be redirected. 
		Default is $CATALINA_BASE/logs/catalina.out</td>
	</tr>
	<tr>
		<td valign="top"><tt>CATALINA_TMPDIR</tt></td>
		<td valign="top">(Optional) Directory path location of temporary directory the JVM should use (java.io.tmpdir). Defaults to $CATALINA_BASE/temp.</td>
	</tr>
	<tr>
		<td valign="top"><tt>JRE_HOME</tt></td>
		<td valign="top">Must point at your Java Runtime installation. Defaults to JAVA_HOME if empty. If JRE_HOME and JAVA_HOME are both set, JRE_HOME is used.</td>
	</tr>
	<tr>
		<td valign="top"><tt>JAVA_ENDORSED_DIRS</tt></td>
		<td valign="top">(Optional) Lists of of colon separated directories containing some jars in order to allow replacement of APIs created outside of the JCP (i.e. DOM and SAX from W3C). It can also be used to update the XML parser implementation. Defaults to $CATALINA_HOME/endorsed.</td>
	</tr>
	<tr>
		<td valign="top"><tt>JPDA_TRANSPORT</tt></td>
		<td valign="top">(Optional) JPDA transport used when the "jpda start" command is executed. The default is "dt_socket".</td>
	</tr>
	<tr>
		<td valign="top"><tt>JPDA_ADDRESS</tt></td>
		<td valign="top">(Optional) Java runtime options used when the "jpda start" command is executed. The default is 8000.</td>
	</tr>
	<tr>
		<td valign="top"><tt>JPDA_SUSPEND</tt></td>
		<td valign="top">(Optional) Java runtime options used when the "jpda start" command is executed. Specifies whether JVM should suspend execution immediately after startup. Default is "n".</td>
	</tr>
	<tr>
		<td valign="top"><tt>JPDA_OPTS</tt></td>
		<td valign="top">(Optional) Java runtime options used when the "jpda start" command is executed. If used, JPDA_TRANSPORT, JPDA_ADDRESS, and JPDA_SUSPEND are ignored. Thus, all required jpda options MUST be specified. The default is:
			<pre>
				-agentlib:jdwp=transport=$JPDA_TRANSPORT,
					address=$JPDA_ADDRESS,server=y,suspend=$JPDA_SUSPEND
			</pre>
		</td>
	</tr>
	<tr>
		<td valign="top"><tt>LOGGING_CONFIG</tt></td>
		<td valign="top">(Optional) Override Tomcat's logging config file Example (all one line)
			<pre>LOGGING_CONFIG="-Djava.util.logging.config.file=$CATALINA_BASE/conf/logging.properties"</pre></td>
	</tr>
	<tr>
		<td valign="top"><tt>LOGGING_MANAGER</tt></td>
		<td valign="top">(Optional) Override Tomcat's logging manager Example (all one line)
			<pre>LOGGING_MANAGER="-Djava.util.logging.manager=org.apache.juli.ClassLoaderLogManager"</pre></td>
	</tr>
</table>

### stop.sh
This script can be used to gracefuly stop the running tomcat containing your web application.
It basically contains the same catalina configuration as the corresponding _start.sh_.

```bash
export JAVA_HOME=/path/to/java/runtime/
export CATALINA_HOME=/path/to/tomcat/
export CATALINA_BASE=/path/to/my/app
export CATALINA_PID=${CATALINA_BASE}/temp/myapp.pid
 
${CATALINA_HOME}/bin/catalina.sh stop
```

__Note__ that all paths in _start.sh_ and _stop.sh_ have to be identical for the scripts to work properly!

## conf/
The _conf/_ folder contains the tomcat's configuration. Therefor every knwon configuration file can be overwritten in here. In the default setup the following configurations will be included. Refer to the [tomcat configuration guide](http://tomcat.apache.org/tomcat-7.0-doc/) for further information on configuring a tomcat installation.

### Catalina/localhost/manager.xml
This file holds the context configuration for the tomcat's default manager application. The manager will be referenced from CATALINA_HOME as configured in your _start.sh_:

```xml
<?xml version="1.0" encoding="UTF-8"?>
<Context docBase="${catalina.home}/webapps/manager"
    antiResourceLocking="false" privileged="true" >
</Context>
```

__From the tomcat docs (RUNNING.txt):__

> It might be useful to note that the values of __CATALINA_HOME__ and
> __CATALINA_BASE__ can be referenced in the XML configuration files processed
> by Tomcat as __${catalina.home}__ and __${catalina.base}__ respectively.

### context.xml
Contains the container context configuration specifying application resources. 
Initially this configuration file is empty.

### tomcat-users.xml
The tomcat roles and user file. This file initially contains some default users that can be used from within your application (i.e. security constraints in your application's _web.xml_):

```xml
<?xml version='1.0' encoding='utf-8'?>
<tomcat-users>
        <role rolename="admin"/>
        <role rolename="manager"/>
        <role rolename="manager-gui"/>
        <role rolename="tomcat"/>
        <user username="tomcat" password="tomcat" roles="admin,manager,tomcat,manager-gui"/>
</tomcat-users>
```

### server.xml
Tomcat server configuration. The configuration contains some minor changes to the Connectors' ports in constrast to a freshly downloaded tomcat installation. The port used go from 11000 up to 11999 splitted in blocks á 10 Ports per application (at least that's the plan). You can, of course, apply other port ranges if neccessary.

## lib/
Libraries and classes. Add you application-specific libraries (if not already compiled inside your war-file) such as database drivers into this directory.

__From the tomcat docs:__

> In the default configuration the JAR libraries and classes both in
> CATALINA_BASE/lib and in CATALINA_HOME/lib will be added to the common
> classpath, but the ones in CATALINA_BASE will be added first and thus will
> be searched first.
>
> The idea is that you may leave the standard Tomcat libraries in
> CATALINA_HOME/lib and add other ones such as database drivers into
> CATALINA_BASE/lib.
>
> In general it is advised to never share libraries between web applications,
> but put them into WEB-INF/lib directories inside the applications. See
> Classloading documentation in the User Guide for details.


## logs/
The application's log directory. This directory will be used for the instance's _catalina.out_ for example.
Also this directory will be available to the application as system property __log.root__ by default. This property may be used directly in your log4j.properties file for example:

```
log4j.appender.R=org.apache.log4j.RollingFileAppender
log4j.appender.R.File=${log.root}/myApp.log
```

## server/
Server directory of the catalina engine.

## storage/
This is the applications default file-base. All files like a Lucene index or a Derby database directory should be placed in here. To simplify access to this folder, it will be available to the application as system property __file.root__.
Therefor this can be used directly inside your spring configuration for example:

```xml
<bean id="mySampleBean" class="com.acme.Importer" p:importFilesPath="${file.root}/import"/>
```

Or you can use it by calling

```java 
System.getProperty("file.root");
```

## temp/
Directory used by the JVM for temporary files. Will be set as system property __java.io.tmpdir__.
This directory will also be used for the application's/tomcat's PID-file by default.

## webapps/
Automatically loaded web applications. Place your war-files in here.

## work/
Temporary working directories for web applications.
