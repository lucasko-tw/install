#!/usr/bin/expect 

set timeout 30

spawn /opt/Oracle/Middleware/wlserver_10.3/common/bin/config.sh

expect "Create a new WebLogic domain"
send "Next\r"

expect "Choose Weblogic Platform components"
send "Next\r"

expect "Basic WebLogic Server Domain - 10.3.6.0"
send "Next\r"

expect "Edit Domain Information"
send "Next\r"

expect "Select the target domain directory for this domain"
send "Next\r"

expect "Name:          |                weblogic                 |"
send "1\r"

expect "Enter value for \"Name\""
send "lucas\r"

expect "1|         *Name:          |                   lucas                   |"
send "2\r"

expect "Enter new *User password"
send "1qaz@WSX\r"

expect "2|     *User password:     |              ************               |"
send "3\r"

expect "Enter new *Confirm user password"
send "1qaz@WSX\r"

expect "3| *Confirm user password: |              ************               |"
send "Next\r"

expect "1|Development Mode"
send "1\r"

expect "Java SDK Selection"
send "Next\r"

expect "Select Optional Configuration"
send "Next\r"

expect eof









