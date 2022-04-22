#!/usr/bin/expect 

set timeout 30 
spawn java -jar wls1036_generic.jar

expect "installation of WebLogic 10.3.6.0" 
send "Next\r" 

expect "Choose Middleware Home Directory"
send "/opt/Oracle/Middleware\r"

expect "Enter new Middleware Home"
send "Next\r"

expect "Receive Security Update"
send "3\r"

expect "Receive Security Update"
send "No\r"

expect "Do you wish to bypass"
send "Yes\r"

expect "Provide your email address for security updates "
send "Next\r"

expect "Select the type of installation you wish to perform"
send "1\r"

expect "JDK(s) chosen will be installed"
send "Next\r"

expect "Product Installation Directories"
send "1\r"

expect "/opt/Oracle/Middleware/wlserver_10.3"
send "Next\r"

expect "1|WebLogic Server:"
send "Next\r"

expect "The following Products and JDKs will be installed"
send "Next\r"

expect "Congratulations! Installation is complete"
send "Next\r"

expect eof









