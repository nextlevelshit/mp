Start all microservices

```shell
docker compose up --build --remove-orphans --force-recreate


# or

./dev.sh
```

In Production:
```shell
docker compose --env-file .env.prod up --build --remove-orphans --force-recreate

# or

./prod.sh
```

Test Configuration

```shell
docker compose config # dev environment
```

```shell
docker compose --env-file .env.prod config # production environment
```
