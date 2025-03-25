# Use official Tomcat image
FROM tomcat:9.0-jdk11

# Set working directory
WORKDIR /usr/local/tomcat/webapps

# Copy JSP files to Tomcat's root
COPY . ./ROOT/

# Use Railway's dynamically injected PORT (default to 8080 if not set)
ENV PORT=8080
RUN sed -i "s/port=\"8080\"/port=\"${PORT}\"/" /usr/local/tomcat/conf/server.xml

# Start Tomcat
CMD ["catalina.sh", "run"]



