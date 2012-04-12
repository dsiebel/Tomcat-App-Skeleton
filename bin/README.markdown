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
