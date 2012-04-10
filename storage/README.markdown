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
