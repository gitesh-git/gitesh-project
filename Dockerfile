# Use the official Tomcat image from the Docker Hub
FROM tomcat:9.0

# Expose port 8081 (default Tomcat port)
EXPOSE 8081

# Copy your WAR file to the webapps directory
# Make sure to replace 'your-app.war' with the actual name of your WAR file
ADD */target/*.war /usr/local/tomcat/webapps/

# Start Tomcat in the foreground
CMD ["catalina.sh", "run"]

