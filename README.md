NetScanPro

Web-Based Cyber Security Network Scanner

NetScanPro is a web-based Cyber Security Network Scanner developed using Java, JSP, Servlets, HTML, CSS, JavaScript, and MySQL.

The project combines web development and cybersecurity concepts to provide an authenticated platform for performing authorized TCP port scanning on a local system, viewing scan results, and maintaining scan history.

---

Project Objectives

The main objectives of NetScanPro are:

- To understand TCP-based network communication
- To implement TCP port scanning using Java sockets
- To apply multithreading for scanning multiple ports
- To build a web-based cybersecurity application
- To implement user authentication and session management
- To securely store user passwords
- To store and manage scan history using MySQL
- To provide a simple security dashboard

---

Key Features

Web Development

- Responsive web interface
- User Registration
- User Login
- Session Management
- Logout
- Security Dashboard
- Network Scanner interface
- Scan History interface
- Scan Result page
- HTML and CSS based UI

Cyber Security

- TCP Port Scanning
- Custom Port Range Scanning
- Multithreaded Scanning
- Socket Timeout Handling
- Open Port Detection
- Input Validation
- Localhost-only Target Restriction
- Password Hashing
- Authentication and Authorization
- Secure Database Queries
- Scan Activity Tracking

---

Technology Stack

Category| Technology
Frontend| HTML5, CSS3, JavaScript
Web Technology| JSP
Backend| Java 23
Server-side| Jakarta Servlets
Database| MySQL
Database Connectivity| JDBC
Web Server| Apache Tomcat 10.1
Build Tool| Maven
Network Technology| TCP Socket
Development Tool| Visual Studio Code

---

Application Architecture

                User
                 |
                 v
        HTML / CSS / JavaScript
                 |
                 v
                JSP
                 |
                 v
        Jakarta Servlets
          /            \
         /              \
        v                v
 Authentication     TCP Port Scanner
                         |
                         v
                  Multithreaded
                   TCP Sockets
                         |
                         v
                       JDBC
                         |
                         v
                    MySQL Database

---

Main Modules

1. User Authentication

NetScanPro provides user registration and login functionality.

The application uses session-based authentication to ensure that protected pages can only be accessed by authenticated users.

Passwords are securely hashed using PBKDF2 with HMAC-SHA256 and a randomly generated salt instead of storing plain-text passwords.

---

2. Network Scanner

The Network Scanner allows an authenticated user to provide:

- Target Host
- Start Port
- End Port

The application uses Java TCP sockets to check whether ports are open.

The scanner uses multiple threads to perform port checks efficiently and applies a connection timeout.

For safe local testing, the current application allows scanning only:

127.0.0.1
localhost

---

3. Scan Results

After completing a scan, NetScanPro displays:

- Target host
- Start port
- End port
- Detected open TCP ports

---

4. Scan History

Scan activity is stored in the MySQL database.

The application maintains information such as:

- User ID
- Target
- Start Port
- End Port
- Scan Time

Detected open ports are stored separately and linked to their corresponding scan.

---

5. Security Dashboard

The dashboard provides an overview of the user's scanning activity.

It displays:

- Total Scans
- Open Ports
- Platform information

The dashboard retrieves these statistics from the MySQL database.

---

Database Design

The project uses a MySQL database named:

netscanpro

Main Tables

users
scan_history
scan_results

Database Relationship

users
  |
  | user_id
  v
scan_history
  |
  | scan_id
  v
scan_results

users

Stores registered user information and securely hashed passwords.

scan_history

Stores information about scans performed by authenticated users.

scan_results

Stores the open ports detected during a particular scan.

---

Security Implementation

NetScanPro implements several security practices.

Password Security

Passwords are hashed using:

PBKDF2WithHmacSHA256

A unique random salt is generated for each password.

---

Authentication

Protected pages check whether a valid user session exists before allowing access.

---

Authorization

The application associates scan activity with the authenticated user's ID.

Users can access their own scanning activity through the application.

---

SQL Injection Prevention

Database operations use Java "PreparedStatement" instead of directly concatenating user input into SQL queries.

Example:

PreparedStatement ps = con.prepareStatement(sql);

---

Input Validation

The scanner validates:

- Target host
- Port numbers
- Port range
- Maximum scan range

Ports must be within:

1 - 65535

---

Safe Target Restriction

The current application restricts scanning to local targets:

127.0.0.1
localhost

This provides a controlled environment for cybersecurity learning and testing.

---

Project Structure

NetScanPro/
│
├── pom.xml
├── README.md
│
└── src/
    └── main/
        ├── java/
        │   └── com/
        │       └── netscanpro/
        │           ├── controller/
        │           │   └── ScanServlet.java
        │           │
        │           ├── db/
        │           │   └── DBConnection.java
        │           │
        │           ├── scanner/
        │           │   └── TcpPortScanner.java
        │           │
        │           ├── servlet/
        │           │   ├── LoginServlet.java
        │           │   ├── RegisterServlet.java
        │           │   └── LogoutServlet.java
        │           │
        │           └── util/
        │               └── PasswordUtil.java
        │
        └── webapp/
            ├── dashboard.jsp
            ├── history.jsp
            ├── login.jsp
            ├── register.jsp
            ├── result.jsp
            └── scan.jsp

---

Requirements

To run NetScanPro, install:

- Java JDK 23
- Apache Maven
- MySQL Server 8
- Apache Tomcat 10.1
- Visual Studio Code or another Java-compatible IDE

---

Database Setup

Create the database:

CREATE DATABASE netscanpro;

Create the required tables:

users
scan_history
scan_results

Configure the local MySQL connection in:

DBConnection.java

Use your own local MySQL credentials.

Never upload real database passwords, API keys, or other secrets to GitHub.

---

Build the Project

Open PowerShell in the project root directory:

mvn clean package

A successful build generates:

target/NetScanPro.war

---

Deploy on Apache Tomcat

Copy the generated WAR file into the Tomcat "webapps" directory.

Start Apache Tomcat and open:

http://localhost:8080/NetScanPro/login.jsp

---

How to Use

Step 1 — Register

Create a new user account from the Registration page.

Step 2 — Login

Log in using the registered account.

Step 3 — Dashboard

After login, the Security Dashboard displays scanning statistics.

Step 4 — Start Scan

Open Start Network Scan.

Enter:

Target Host: 127.0.0.1

Enter the desired start and end ports.

Step 5 — View Results

Start the scan and view the detected open TCP ports.

Step 6 — Scan History

Open Scan History to review previous scan activity.

---

Security Notice

NetScanPro is designed for educational and authorized security testing.

The current application is restricted to local testing using:

127.0.0.1
localhost

Do not use the application to scan systems or networks without proper authorization.

---

Future Improvements

The following features can be added in future versions:

- Real-time scan progress indicator
- Improved scan status messages
- Scan report export
- Detailed service information
- Advanced result filtering
- Security report generation
- Improved dashboard visualizations
- Additional authentication security controls

---

Learning Outcomes

Through this project, the following concepts were practiced:

Web Development

- HTML
- CSS
- JavaScript
- JSP
- Jakarta Servlets
- MVC-style request handling
- Form processing
- Session management

Cyber Security

- TCP networking
- Port scanning
- Network security concepts
- Authentication
- Authorization
- Password hashing
- Input validation
- SQL injection prevention
- Secure database access
- Security testing in a controlled environment

Database

- MySQL
- JDBC
- SQL queries
- PreparedStatement
- Relational database design
- Table relationships

---

Author

Abhijeet Mishra

B.Tech CSE — Cyber Security

---

License

This project is created for educational and cybersecurity learning purposes.