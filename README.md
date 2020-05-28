# verdaccio-ldap
Verdaccio docker image with ldap plugin.

* [verdaccio](https://github.com/verdaccio/verdaccio)
* [verdaccio-ldap](https://github.com/Alexandre-io/verdaccio-ldap) plugin

## Build
```bash
# build docker image
$ make image

# push docker image
$ make push

# remove docker image
$ make clean
```

## Usage

### `conf/config.yaml`

```yaml
storage: /verdaccio/storage

auth:
  ldap:
    type: ldap
    client_options:
      url: "ldap://localhost:389"
      adminDn: "cn=admin,dc=lechuckroh,dc=dev"
      adminPassword: "mypassword"
      searchBase: "dc=lechuckroh,dc=dev"
      searchFilter: "(cn={{username}})"      
      cache: false
      reconnect: true
security:
  api:
    jwt:
      sign:
        expiresIn: 9999d
        notBefore: 1
  web:
    sign:
      expiresIn: 7d

uplinks:
  npmjs:
    url: https://registry.npmjs.org/
    maxage: 30m

packages:
  '@lechuckroh/*':
      access: $authenticated
      publish: $authenticated

  '@*/*':
    access: $all
    publish: $all
    proxy: npmjs

  '**':
    access: $all
    publish: $all
    proxy: npmjs

middlewares:
  audit:
    enabled: true

logs:
  - {type: stdout, format: pretty, level: trace}

web:
  enabled: true
  title: LechuckRoh NPM Registry
  gravatar: true
  sort_packages: asc
  primary_color: "#1890ff"
  scope: "@lechuckroh"
```

### `docker-compose.yaml`

```yaml
version: "3.1"
services:
  verdaccio:
    image: lechuckroh/verdaccio-ldap:4
    restart: unless-stopped
    ports:
      - "4873:4873"
    volumes:
      - "./conf:/verdaccio/conf"
      - "./storage:/verdaccio/storage"

volumes:
  verdaccio:
    driver: local
```

### Run
```bash
$ mkdir storage && chmod 777 storage
$ docker-compose up -d
```