#!/bin/sh

printf "["
sep=''

job_object() {
    printf "%s{\"job\":\"%s\",\"label\":\"%s\",\"context\":\"./%s\"}" "$1" "$2" "$3" "$4"
}

for job in */ ; do
    if [ ! -d "$job" ]; then
        continue;
    fi

    case "$job" in
        .*/ ) continue ;;
    esac

    label_found=0
    job="${job%/}"

    for label in "$job"/*/; do
        if [ ! -d "$label" ]; then
            continue;
        fi

        label="$(basename "$label")"
        case "$label" in
            .*/ ) continue ;;
        esac
        
        job_object "$sep" "$job" "$label" "$job/$label"
        sep=","
        label_found=1
    done

    if [ "$label_found" -eq 0 ]; then
        job_object "$sep" "$job" "latest" "$job"
    fi
done

printf "]\n"
