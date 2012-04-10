## conf/
The conf/- folder contains the tomcat's catalina engine configuration. Therefor every knwon configuration file can be overwritten in here. In the default setup the following configurations will be included.
Refer to the [tomcat configuration guide](http://tomcat.apache.org/tomcat-7.0-doc/) for further information on configuring a tomcat installation.

### context.xml
Contains the container context configuration specifying application resources. 
Initially this configuration file is empty.

### tomcat-users.xml
The tomcat roles and user file. This file initially contains some default users that can be use from within your application:

```xml
<?xml version='1.0' encoding='utf-8'?>
<tomcat-users>
        <role rolename="admin"/>
        <role rolename="manager"/>
        <role rolename="tomcat"/>
        <user username="tomcat" password="tomcat" roles="admin,manager,tomcat"/>
</tomcat-users>
```

### server.xml
Tomcat server configuration. The configuration contains some minor changes to the Connectors' ports in constrast to a freshly downloaded tomcat installation.