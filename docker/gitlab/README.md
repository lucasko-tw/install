cat /etc/gitlab/initial_root_password

https://docs.gitlab.com/ee/api/projects.html

https://cloudaffaire.com/how-to-create-a-gitlab-project-using-api/

curl --header "Authorization: Bearer KJFzZSaDZ_o5J4JqgVVB"
 -XPOST http://localhost/api/v4/projects?name=PROJECT1&visibility=private&description=TEST_123
 
 
 curl --header "Authorization: Bearer KJFzZSaDZ_o5J4JqgVVB" -XPOST http://localhost/api/v4//users?email=lucas@abc.com&username=lucas&name=lucas&password=lucas123&skip_confirmation=true