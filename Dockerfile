# Use official Tomcat image
FROM tomcat:9.0-jdk11

# Set working directory inside the container
WORKDIR /usr/local/tomcat/webapps

# Copy all JSP files and static resources (CSS, JS)
COPY . /usr/local/tomcat/webapps/ROOT/

# Expose port 8080 for Tomcat
EXPOSE 8080

# Start Tomcat server
CMD ["catalina.sh", "run"]




