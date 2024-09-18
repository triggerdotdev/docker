#!/bin/sh

script_dir=$(dirname "$0")

. "$script_dir"/lib.sh

kind=$1

# shift if we have to
if [ "$kind" = "full" ] || [ "$kind" = "webapp" ] || [ "$kind" = "worker" ]; then
    shift
fi

echo $kind

# default to full
if [ -z "$kind" ] || ( [ "$kind" != "webapp" ] && [ "$kind" != "worker" ] ); then
    kind="full"
fi

if [ "$kind" = "full" ]; then
    compose_file=$script_dir/docker-compose.yml
    extra_args="-p=trigger"
else
    compose_file=$script_dir/docker-compose.$kind.yml
    extra_args="-p=trigger-$kind"
fi

docker_compose -f "$compose_file" "$extra_args" pull "$@"