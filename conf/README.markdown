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
	<role rolename="manager-gui"/>
	<role rolename="manager-script"/>
	<role rolename="manager-jmx"/>
	<role rolename="manager-status"/>
	<role tolename="tomcat"/>
	<user username="tomcat" password="tomcat" roles="tomcat"/>
	<user username="admin" password="s3cret" roles="manager-gui"/>
</tomcat-users>
```

### server.xml
Tomcat server configuration. The configuration contains some minor changes to the Connectors' ports in constrast to a freshly downloaded tomcat installation. The port used go from 11000 up to 11999 splitted in blocks á 10 Ports per application (at least that's the plan). You can, of course, apply other port ranges if neccessary.
