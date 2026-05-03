# Use an official Tomcat runtime as a parent image
#FROM tomcat:9.0-jdk11-openjdk
FROM tomcat:latest
# Remove default webapps to ensure a clean deployment (optional)
RUN rm -rf /usr/local/tomcat/webapps/*

# Copy your WAR file into the Tomcat webapps directory
# Tomcat will automatically extract it at startup
RUN ls -R
COPY webapp.war /usr/local/tomcat/webapps/ROOT.war

# Expose the default Tomcat port
EXPOSE 8080

# Start Tomcat
CMD ["catalina.sh", "run"]
