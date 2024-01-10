Start all microservices

```shell
docker compose up --build --remove-orphans --force-recreate


# or

./dev.sh
```

In Production:
```shell
docker compose --env-file .prod.env up --build --remove-orphans --force-recreate

# or

./prod.sh
```

Test Configuration

```shell
docker compose config # dev environment
```

```shell
docker compose --env-file .prod.env config # production environment
```

# mp-depot

## Generate strapi (mp-depot) keys


Add to `.env` or `.env.prod`
```dotenv
DEPOT_JWT_SECRET=XXX
DEPOT_API_TOKEN_SALT=XXX
DEPOT_ADMIN_JWT_SECRET=XXX
DEPOT_APP_KEYS=XXX,XXX,XXX,XXX
DEPOT_TRANSFER_TOKEN_SALT=XXX[dev.sh](dev.sh)
```
Replace `XXX` for instance with

```shell
openssl rand -base64 32
```

## Export data

1. Run `./dev.sh` or `./prod.sh`
2. Hook into `mp-depot` terminal
3. Run strapi export command

```shell
npm run strapi export -- --no-encrypt --file database/export_YYYYMMDDHHMMSS
```

Replace `YYYYMMDDHHMMSS` with current date time.

## Import data

1. Run `./dev.sh` or `./prod.sh`
2. Hook into `mp-depot` terminal
3. Run strapi export command

```shell
npm run strapi import -- -f export.tar.gz
```
