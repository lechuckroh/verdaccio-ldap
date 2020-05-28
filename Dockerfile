FROM verdaccio/verdaccio:4

USER root

RUN npm i && npm i verdaccio-ldap

USER verdaccio
