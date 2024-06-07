#!/bin/sh

script_dir=$(dirname "$0")

. "$script_dir"/lib.sh

kind=$1

if [ -z "$kind" ]; then
    echo "Usage: $0 [full|webapp|worker] [docker-compose args]"
    exit 1
fi

if [ -n "$kind" ] && [ "$kind" != "full" ] && [ "$kind" != "webapp" ] && [ "$kind" != "worker" ]; then
    echo "Invalid kind: $kind"
    echo "Must be one of: full, webapp, worker"
    exit 1
fi

env_file=$script_dir/.env
env_example_file=$script_dir/.env.example

if [ ! -f "$env_file" ]; then
    read -p "No .env file found, would you like to create one? [Y/n] " yn
    case $yn in
        [nN]* )
            echo "Skipping .env file creation. The next steps will likely fail."
            ;;
        * )
            cp -v "$env_example_file" "$env_file"

            read -p "Would you also like to generate fresh secrets? [Y/n] " yn
            case $yn in
                [nN]* )
                    echo "Skipping secret generation. You should really not skip this step."
                    ;;
                * )
                    generate_secrets "$env_file"
                    sleep 2
                    ;;
            esac
            ;;
    esac
fi

if [ "$kind" = "full" ]; then
    compose_file=$script_dir/docker-compose.yml
    extra_args="-p=trigger"
else
    compose_file=$script_dir/docker-compose.$kind.yml
    extra_args="-p=trigger-$kind"
fi

shift
docker_compose -f "$compose_file" "$extra_args" up "$@"