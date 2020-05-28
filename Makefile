image:
	docker build --no-cache -t lechuckroh/verdaccio-ldap:4 .

push:
	docker push lechuckroh/verdaccio-ldap:4
	docker tag lechuckroh/verdaccio-ldap:4 lechuckroh/verdaccio-ldap:latest
	docker push lechuckroh/verdaccio-ldap:latest
	docker rmi lechuckroh/verdaccio-ldap:latest

clean:
	docker rmi lechuckroh/verdaccio-ldap:4
