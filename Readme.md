Start all microservices

```shell
./dev.sh
```

In Production:
```shell
./run.sh
```

In Production dettached mode (background):
```shell
./run-bg.sh
```

# mp-depot

## Generate strapi (mp-depot) keys


Add to `.env` or `.env.dev`

```dotenv
DEPOT_JWT_SECRET=XXX
DEPOT_API_TOKEN_SALT=XXX
DEPOT_ADMIN_JWT_SECRET=XXX
DEPOT_APP_KEYS=XXX,XXX,XXX,XXX
DEPOT_TRANSFER_TOKEN_SALT=XXX
```
Replace `XXX` for instance with

```shell
openssl rand -base64 32
```

## Export data

1. Run all microservices

2. Hook into `mp-depot` terminal 
   ```shell
   docker exec -it depot sh
   
   # or in dev mode
   
   docker exec -it depot-dev sh
   ```
   
3. Run strapi import command

   ```shell
   npm run strapi export -- --no-encrypt --file database/export_YYYYMMDDHHMMSS
   ```

Replace `YYYYMMDDHHMMSS` with current date time.

## Import data

1. Run all microservices

2. Hook into `mp-depot` terminal
   ```shell
   docker exec -it depot sh
   
   # or in dev mode
   
   docker exec -it depot-dev sh
   ```
   
3. Run strapi export command
   ```shell
   npm run strapi import -- -f export.tar.gz
   ```
