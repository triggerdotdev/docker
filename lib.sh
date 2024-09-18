#!/bin/sh

docker_compose() {
    if docker compose >/dev/null 2>&1; then
        set -x
        docker compose "$@"
    elif command -v docker-compose >/dev/null 2>&1; then
        set -x
        docker-compose "$@"
    else
        echo Please install docker compose: https://docs.docker.com/compose/install/
    fi

    set +x
}

generate_secrets() {
    env_file=$1

    echo "Generated secrets:"
    
    MAGIC_LINK_SECRET=$(openssl rand -hex 16)
    echo MAGIC_LINK_SECRET="$MAGIC_LINK_SECRET"

    SESSION_SECRET=$(openssl rand -hex 16)
    echo SESSION_SECRET="$SESSION_SECRET"

    ENCRYPTION_KEY=$(openssl rand -hex 16)
    echo ENCRYPTION_KEY="$ENCRYPTION_KEY"

    PROVIDER_SECRET=$(openssl rand -hex 32)
    echo PROVIDER_SECRET="$PROVIDER_SECRET"

    COORDINATOR_SECRET=$(openssl rand -hex 32)
    echo COORDINATOR_SECRET="$COORDINATOR_SECRET"

    write_secrets() {
        sed -i "s/MAGIC_LINK_SECRET=.*/MAGIC_LINK_SECRET=$MAGIC_LINK_SECRET/" "$env_file"
        sed -i "s/SESSION_SECRET=.*/SESSION_SECRET=$SESSION_SECRET/" "$env_file"
        sed -i "s/ENCRYPTION_KEY=.*/ENCRYPTION_KEY=$ENCRYPTION_KEY/" "$env_file"
        sed -i "s/PROVIDER_SECRET=.*/PROVIDER_SECRET=$PROVIDER_SECRET/" "$env_file"
        sed -i "s/COORDINATOR_SECRET=.*/COORDINATOR_SECRET=$COORDINATOR_SECRET/" "$env_file"
    }

    if [ -z "$env_file" ]; then
        return
    fi

    if [ ! -f "$env_file" ]; then
        read -p "No $(basename "$env_file") file found, would you like to create one? [Y/n] " yn
        case $yn in
            [nN]* )
                echo "Skipping .env file creation."
                return
                ;;
            * )
                env_example_file=$(dirname "$env_file")/.env.example
                cp -v "$env_example_file" "$env_file"
                
                echo "Writing secrets to $(basename "$env_file")"
                write_secrets
                ;;
        esac
    fi

    read -p "Would you like to replace your current secrets in $(basename "$env_file")? [Y/n] " yn

    case $yn in
        [nN]* )
            echo "Skipped writing secrets. You may want to add them manually to $(basename "$env_file")"
            ;;
        * )
            echo "Overwriting secrets in $(basename "$env_file")"
            cp -v "$env_file" "$env_file.backup"
            write_secrets
            echo "Done. Backup written to: $(basename "$env_file").backup"
            ;;
    esac


}