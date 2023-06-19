# College Allotment System

The front-end for the project is displayed on a mobile application built using flutter and dart,
state management for the same has been done using riverpod.

The connections to the database have been set up using a flutter package called mysql1, this is
a library that allows connecting to our mysql database and querying it. To know more about this
package, please check the link: https://pub.dev/packages/mysql1

All database connections have been set up in a separate folder named "database" in the "lib"
folder of the application. The sql queries have been written in separate folders for authentication
and data manipulation, called sql_auth.dart and sql_data.dart respectively.

The app allows both the students and college admins to login and access user-specific pages.
The flow of the app is as shown:

## Student login:
<!-- <img src="https://github.com/favicon.ico](https://github.com/ai-r-ia/College_Allotment_System/assets/87983584/ac64be85-06e9-4d62-bb86-17151b161652" width="48"/> -->
![image](https://github.com/ai-r-ia/College_Allotment_System/assets/87983584/ac64be85-06e9-4d62-bb86-17151b161652)
![image](https://github.com/ai-r-ia/College_Allotment_System/assets/87983584/0ef499bc-c563-486e-93a7-8f1f7a048c21)
![image](https://github.com/ai-r-ia/College_Allotment_System/assets/87983584/a657c7a7-1a04-418e-8db1-8047add96ff3)

A student can access the app by logging in with their credentials or creating a new account if
they haven’t previously registered. This adds a new entry into the user and student table in the
database.

![image](https://github.com/ai-r-ia/College_Allotment_System/assets/87983584/258e4156-4890-494e-a47c-0c1659eb5205)
![image](https://github.com/ai-r-ia/College_Allotment_System/assets/87983584/43c028e7-abb9-44a6-ac5a-0cc364361897)

Upon successful login or registration,the student dashboard is visible, wherein they can either
set their college allotment preference or view their profile and see their current preference list or
update their details.

## College Admin Login:
![image](https://github.com/ai-r-ia/College_Allotment_System/assets/87983584/63c4b63b-242a-4185-b1fb-f15ed3d26890)
![image](https://github.com/ai-r-ia/College_Allotment_System/assets/87983584/8fdeb8e9-2f90-44ae-b166-8c8d09edbf15)
![image](https://github.com/ai-r-ia/College_Allotment_System/assets/87983584/8bb31b74-33d2-4bd3-bd48-e9be7e400072)

A college administrator can access the app by logging in with their credentials or creating a new
account if they haven’t previously registered. This adds a new entry into the user and
collegeadmin table in the database.

![image](https://github.com/ai-r-ia/College_Allotment_System/assets/87983584/0d9b69cb-77d3-4b4e-aa67-f1d2fe7159dc)
![image](https://github.com/ai-r-ia/College_Allotment_System/assets/87983584/336869c4-f413-4ca3-96b9-f0888b24fb82)
![image](https://github.com/ai-r-ia/College_Allotment_System/assets/87983584/f88ba5c6-e142-468d-b98f-c41c1f7f4cd9)

Upon successful login or registration, the admin dashboard is visible, wherein they can either
add a course to the list of courses the college offers or allocate students that have applied to
their college (based on cut-off scores and preferences). In the next screen, the admin can view
the list of students allocated to their college and the total allocations done in all colleges so far.



## Instructions to run the application
In order to run the application, you must first ensure that your MySQL connection settings have
been reset according to the port connected to the app. In order to do this, please right click on
the connection on your workbench and click on ‘Edit Connection..’

![image](https://github.com/ai-r-ia/College_Allotment_System/assets/87983584/e984d9c9-d275-40a8-be4f-1db2a05dd6dd)

This will open a dialog box with your current connection configuration. Please ensure all entries
are filled out as shown in the image below (and also given as text).

Connection Name: localhost
Connection Method: Standard (TCP/IP)
Hostname: localhost
Port: 3306
Username: root

![image](https://github.com/ai-r-ia/College_Allotment_System/assets/87983584/feef4d0a-0c1e-49ca-83c2-0b36a045e1bb)

After having changed your username to ‘root’ in the previous step, please use the following
commands to change your password to ‘password’.
USE mysql;
SET PASSWORD FOR 'root'@'localhost' = ‘password’;
FLUSH privileges;
If the commands given above are not compatible with your MySQL version then please check
the following links to find commands specific toyour version.

https://dev.mysql.com/doc/refman/8.0/en/alter-user.html

https://www.javatpoint.com/change-mysql-user-password

**Note:** Please ensure your MySQL server is running when using the app and that you have run the script named ‘masterScript.sql’ beforehand to create the database and fill relevant entries.
