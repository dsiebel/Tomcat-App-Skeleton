## lib/
Libraries and classes. Add your application specific libraries (if not already compiled inside your war-file) such as database drivers here.

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
