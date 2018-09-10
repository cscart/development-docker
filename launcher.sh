#!/bin/bash

checkExist () {
    if [ ! -f $1 ]; then
        echo "File $1 not found!"
        exit 1
    fi
}

getFolder () {
    env=$1
    case ${env} in

        local)
            folders="${cscartMysqlLogs} ${cscartMysqlConf} ${cscartVolumes}/cscart"
            for folder in ${folders}; do
                if [[ ! -d "${folder}" ]]; then
                    if [ "${folder}" = "${cscartMysqlConf}" ] || [ "${folder}" = "${cscartMysqlLogs}" ];then
                        mkdir -p -m777 ${folder}
                    else
                        mkdir -p -m770 ${folder} && chown daemon: ${folder}
                    fi
                fi
            done
        ;;

        external)
            folders="${cscartMysqlLogs} ${cscartMysqlConf} ${cscartVolumes}/cscart ${cscartVolumes}/acme ${cscartVolumes}/ssl"
            for folder in ${folders}; do
                if [[ ! -d "${folder}" ]]; then
                    if [ "${folder}" = "${cscartMysqlConf}" ] || [ "${folder}" = "${cscartMysqlLogs}" ];then
                        mkdir -p -m777 ${folder}
                    elif [ "${folder}" = "${cscartVolumes}/acme" ] || [ "${folder}" = "${cscartVolumes}/ssl" ];then
                        mkdir -p -m750 ${folder}
                    else 
                        mkdir -p -m770 ${folder} && chown daemon: ${folder}
                    fi
                fi
            done

        ;;
    esac

}

getParams () {
    var=$1
    case ${var} in

        local)
            dockerCommand="docker-compose -f ./compose/global.yml --project-name sandbox"
            cscartVolumes=$(cat .env | grep CSCART_VOLUMES | cut -f 2 -d =)
            cscartMysqlLogs=$(cat .env | grep MYSQL_LOGS | cut -f 2 -d =)
            cscartMysqlConf=$(cat .env | grep MYSQL_CONF | cut -f 2 -d =)
            cscartMysqlData=$(cat .env | grep MYSQL_DATA | cut -f 2 -d =)
        ;;

        external)
            dockerCommand="docker-compose -f ./compose/global.yml -f ./compose/external.yml --project-name sandbox"
            cscartVolumes=$(cat .env | grep CSCART_VOLUMES | cut -f 2 -d =)
            cscartMysqlLogs=$(cat .env | grep MYSQL_LOGS | cut -f 2 -d =)
            cscartMysqlConf=$(cat .env | grep MYSQL_CONF | cut -f 2 -d =)
            cscartMysqlData=$(cat .env | grep MYSQL_DATA | cut -f 2 -d =)
        ;;

        wildcard)
            wildcard=$(cat .env | grep WILDCARD | cut -f 2 -d =)
            domain=$(cat .env | grep DOMAIN | cut -f 2 -d =)
            cscartVolumes=$(cat .env | grep CSCART_VOLUMES | cut -f 2 -d =)
            cert=${cscartVolumes}/ssl/${domain}.crt
        ;;

        *)
            echo ""
            echo "Error!!! Not found ${var}."
            exit 1
        ;;


    esac
}

doWork () {
    do=$1
    case ${do} in

        external)
            checkExist .env
            getParams ${do}
            getFolder ${do}
            doWork wildcard
            ${dockerCommand} up -d php56-fpm php70-fpm php71-fpm php72-fpm mysql 
            sleep 3
            ${dockerCommand} up -d 
        ;;

        local)
            checkExist .env
            getParams ${do}
            getFolder ${do}
            ${dockerCommand} up -d php56-fpm php70-fpm php71-fpm php72-fpm mysql postfix
            sleep 3
            ${dockerCommand} up -d
        ;;

        wildcard)
            checkExist .env
            getParams ${do}
            if [[ "${wildcard}" = "yes" ]]; then
                ${dockerCommand} up -d proxy
                while [ ! -f ${cert} ]; do
                    echo " Please waiting for a certificate "
                    sleep 10
                done
            fi
        ;;

        *)
            echo ""
            echo "Error!!! ${do} is not specified."
            exit 1
        ;;

    esac

}

doWork $1