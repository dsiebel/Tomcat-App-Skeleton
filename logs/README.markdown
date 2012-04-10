## logs/
The application's log directory. This directory will be used for the instance's __catalina.out__ for example.
Also this directory will be available to the application as system property __log.root__ by default. This property may be used directly in your log4j.properties file for example:

```
log4j.appender.R=org.apache.log4j.RollingFileAppender
log4j.appender.R.File=${log.root}/myApp.log