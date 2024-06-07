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

if [ "$kind" = "full" ]; then
    compose_file=$script_dir/docker-compose.yml
    extra_args="-p=trigger"
else
    compose_file=$script_dir/docker-compose.$kind.yml
    extra_args="-p=trigger-$kind"
fi

shift
docker_compose -f "$compose_file" "$extra_args" down "$@"