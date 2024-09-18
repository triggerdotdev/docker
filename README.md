# Trigger.dev Self-Hosting Docker

If you want to run the Trigger.dev platform yourself, instead of using [our cloud product](https://trigger.dev), you can use this repository to get started.

It's highly recommended you read our [self-hosting guide](https://trigger.dev/docs/open-source-self-hosting), which contains more detailed instructions and will be more up-to-date.

## Local development

If you want to self-host the Trigger.dev platform, when you're developing your web app locally you'll need to run the Trigger.dev platform locally as well.

### Initial setup

1. Clone this repository and navigate to it:

```sh
git clone https://github.com/triggerdotdev/docker.git
cd docker
```

2. Run the start script and follow the prompts

```bash
./start.sh # hint: you can append -d to run in detached mode
```

3. Populate any missing .env file values. (See the .env.example file for more instructions)

4. The ports in the `docker-compose.yml` file are set so they are less likely to clash with your local webapp – the platform runs on 3040 and the database is on 5433. If you need to change these ports, you'll need to update the `LOGIN_ORIGIN`, `APP_ORIGIN` and `DATABASE_HOST` environment variables.

### Stopping the Docker containers

1. Run the stop script

```bash
./stop.sh
```

### Getting started with using Trigger.dev

You should now be able to access the Trigger.dev dashboard at [http://localhost:3040](http://localhost:3040/).

To create an account, login using "Magic Link" and the email with the sign-in link will be printing to the console output in the running `triggerdotdev` container.

Our main docs are at [docs.trigger.dev](https://docs.trigger.dev/).

Note, you'll need to ensure that you configure the SDK to point at your self-hosted instance via the `TRIGGER_API_URL` environment variable. With the default settings and running everything locally you'd set it to `http://localhost:3040`.
