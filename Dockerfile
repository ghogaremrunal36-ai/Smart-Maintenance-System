# ==============================================================================
# SMART BUILDING MAINTENANCE SYSTEM - DOCKERFILE FOR RENDER DEPLOYMENT
# Multi-stage build: compiles Java Servlets and serves via Apache Tomcat 9
# ==============================================================================

# ------------------------------------------------------------------------------
# STAGE 1: Build & Compile Java Sources
# ------------------------------------------------------------------------------
FROM eclipse-temurin:17-jdk-alpine AS builder

WORKDIR /build

# Copy web resources and Java sources
COPY web/ ./web/
COPY src/ ./src/

# Ensure output directories exist
RUN mkdir -p web/WEB-INF/classes

# Compile all Java sources using servlet-api from Tomcat and MySQL connector
# Download official servlet-api jar for standalone compilation in builder stage
RUN wget -q https://repo1.maven.org/maven2/javax/servlet/javax.servlet-api/4.0.1/javax.servlet-api-4.0.1.jar -O /build/servlet-api.jar

# Compile all Java source files
RUN find src/java -name "*.java" > /build/sources.txt && \
    javac -cp "/build/servlet-api.jar:web/WEB-INF/lib/*" \
          -d web/WEB-INF/classes \
          -sourcepath src/java \
          @/build/sources.txt

# ------------------------------------------------------------------------------
# STAGE 2: Production Apache Tomcat 9 Runtime
# ------------------------------------------------------------------------------
FROM tomcat:9.0-jdk17-temurin

# Remove default Tomcat webapps (ROOT, examples, docs) for security & clean root URL
RUN rm -rf /usr/local/tomcat/webapps/ROOT \
           /usr/local/tomcat/webapps/examples \
           /usr/local/tomcat/webapps/docs \
           /usr/local/tomcat/webapps/host-manager

# Copy compiled application as ROOT webapp so it serves directly at /
COPY --from=builder /build/web /usr/local/tomcat/webapps/ROOT

# Ensure MySQL connector is also available in Tomcat global lib
RUN cp /usr/local/tomcat/webapps/ROOT/WEB-INF/lib/mysql-connector-*.jar /usr/local/tomcat/lib/ 2>/dev/null || true

# Render assigns port dynamically via PORT environment variable (default 8080)
EXPOSE 8080

# Start Tomcat
CMD ["catalina.sh", "run"]
