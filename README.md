# Trigger.dev Self-Hosting Docker

If you want to run the Trigger.dev platform yourself, instead of using [our cloud product](https://trigger.dev), you can use this repository to get started.

## Local development

If you want to self-host the Trigger.dev platform, when you're developing your web app locally you'll need to run the Trigger.dev platform locally as well.

### Initial setup

1. Copy the `local-development` directory into your project. If rename the folder you'll need to update the following commands accordingly.

2. Create your .env file:

```
cp local-development/.env.example local-development/.env
```

3. Populate any missing .env file values. You will need to create a [Resend](https://resend.com/) account and insert your API key.

4. The ports in the `docker-compose.yml` file are set so they are less likely to clash with your local webapp – platform is on 3010 and the database is on 5433. If you need to change these ports, you'll need to update the `LOGIN_ORIGIN` `APP_ORIGIN` and `DATABASE_HOST` environment variables.

### Starting the Docker containers

1. Run docker-compose to start the Trigger.dev platform:

```
docker-compose -f local-development/docker-compose.yml up -d
```

### Stopping the Docker containers

1. Run docker-compose to stop the Trigger.dev platform:

```
docker-compose -f local-development/docker-compose.yml stop
```

### Getting started with using Trigger.dev

Our main docs are at [docs.trigger.dev](https://docs.trigger.dev/).

Note, you'll need to ensure that you set the `apiUrl` to point at your local Trigger.dev platform. If you don't change the docker-compose.yml default then `apiUrl` should be `http://localhost:3010`.
