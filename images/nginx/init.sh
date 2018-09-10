#!/bin/sh

checkVariables () {
    vars=$@
    for var in ${vars}
    do
        if [ -z "$(printenv ${var})" ]; then
            echo "Error ${var} not specified"
            exit 1
        fi
        printenv ${var}
    done
}

getDaysLeft () {
    pathToCert=$1
    daysLeft=$(echo "(" $(date -d "$(openssl x509 -in ${pathToCert} -text -noout | grep "Not After" | cut -c 25-)" +%s) - $(date -d "now" +%s) ")" / 86400 | bc)
    echo "${daysLeft}"
}

checkDNSparams () {
    dnsApi=$1
    case ${dnsApi} in
        dns_cf)
            checkVariables CF_Key CF_Email
        ;;

        dns_selectel)
            checkVariables SL_Key
        ;;

        *)
            echo ""
            echo "Error!!! Not found DNS provider."
            exit 1
        ;;


    esac
}

getCommand () {
    do=$1
    case ${do} in
        force_wildcard_cert)
            checkDNSparams $(printenv DNS_API)
            getCert=$(--issue --dns $(printenv DNS_API) --force -d $(printenv DOMAIN) -d "*.$(printenv DOMAIN)" --fullchain-file /etc/nginx/ssl/$(printenv DOMAIN).crt --key-file /etc/nginx/ssl/$(printenv DOMAIN).key)
            getConf=$(cd /etc/nginx/conf.d && for i in *.dist; do cp -f $i $i.conf; done && nginx -s reload)
            exit 0
        ;;

        force_cert)
            getCert=$(--issue --nginx --force -d $(printenv DOMAIN) --fullchain-file /etc/nginx/ssl/$(printenv DOMAIN).crt --key-file /etc/nginx/ssl/$(printenv DOMAIN).key)
            getConf=$(cd /etc/nginx/conf.d && for i in *.dist; do cp -f $i $i.conf; done && nginx -s reload)
            exit 0
        ;;

        wildcard_cert)
            checkDNSparams $(printenv DNS_API)
            if [[ -f /acme.sh/$(printenv DOMAIN)/$(printenv DOMAIN).cer ]] ; then
                getDaysLeft "/acme.sh/$(printenv DOMAIN)/$(printenv DOMAIN).cer"
                echo "The SSL certificate found, remaining days = ${daysLeft} "
                if [ ${daysLeft} -le 10 ] ; then
                    echo "The remaining days of SSL certificates are less than 10 days!"
                    echo "Getting forced the wildcard ssl certificate"
                    getCommand force_wildcard_cert
                elif [ ${daysLeft} -gt 10 ] ; then
                    echo "Certificate already received"
                fi 
            else
                echo "The SSL certificate not found"
                echo "Getting the wildcard ssl certificate"
                getCert=$(--issue --dns $(printenv DNS_API) -d $(printenv DOMAIN) -d "*.$(printenv DOMAIN)" --fullchain-file /etc/nginx/ssl/$(printenv DOMAIN).crt --key-file /etc/nginx/ssl/$(printenv DOMAIN).key)
                getConf=$(cd /etc/nginx/conf.d && for i in *.dist; do cp -f $i $i.conf; done && nginx -s reload)
                exit 0
            fi
            getCommand copy_cert
        ;;

        cert)
            if [[ -f /acme.sh/$(printenv DOMAIN)/$(printenv DOMAIN).cer ]] ; then
                getDaysLeft "/acme.sh/$(printenv DOMAIN)/$(printenv DOMAIN).cer"
                echo "The SSL certificate found, remaining days = ${daysLeft} "
                if [ ${daysLeft} -le 10 ] ; then
                    echo "The remaining days of SSL certificates are less than 10 days!"
                    echo "Getting forced the ssl certificate"
                    getCommand force_cert
                elif [ ${daysLeft} -gt 10 ] ; then
                    echo "Certificate already received"
                fi
            else
                echo "The SSL certificate not found"
                echo "Getting the ssl certificate"  
                getCert=$(--issue --nginx -d $(printenv DOMAIN) --fullchain-file /etc/nginx/ssl/$(printenv DOMAIN).crt --key-file /etc/nginx/ssl/$(printenv DOMAIN).key)
                getConf=$(cd /etc/nginx/conf.d && for i in *.dist; do cp -f $i $i.conf; done && supervisorctl restart nginx)
                exit 0
            fi
            getCommand copy_cert
        ;;

        copy_cert)
            if [[ -f /etc/nginx/ssl/$(printenv DOMAIN).crt ]] ; then
                if [[ $(getDaysLeft "/acme.sh/$(printenv DOMAIN)/$(printenv DOMAIN).cer") -eq $(getDaysLeft "/etc/nginx/ssl/$(printenv DOMAIN).crt") ]] ; then
                    echo "Remaining days for "/acme.sh/$(printenv DOMAIN)/$(printenv DOMAIN).cer" = $(getDaysLeft "/acme.sh/$(printenv DOMAIN)/$(printenv DOMAIN).cer")"
                    echo "Remaining days for "/etc/nginx/ssl/$(printenv DOMAIN).crt" = $(getDaysLeft "/etc/nginx/ssl/$(printenv DOMAIN).crt")"
                    getConf=$(cd /etc/nginx/conf.d && for i in *.dist; do cp -f $i $i.conf; done && nginx -s reload)
                    echo "Already updated"
                    exit 0
                else
                    getCert=$(--install-cert -d $(printenv DOMAIN) --fullchain-file /etc/nginx/ssl/$(printenv DOMAIN).crt --key-file /etc/nginx/ssl/$(printenv DOMAIN).key)
                    getConf=$(cd /etc/nginx/conf.d && for i in *.dist; do cp -f $i $i.conf; done && nginx -s reload)
                    exit 0
                fi
            else
                getCert=$(--install-cert -d $(printenv DOMAIN) --fullchain-file /etc/nginx/ssl/$(printenv DOMAIN).crt --key-file /etc/nginx/ssl/$(printenv DOMAIN).key)
                getConf=$(cd /etc/nginx/conf.d && for i in *.dist; do cp -f $i $i.conf; done && supervisorctl restart nginx)
                exit 0
            fi 
        ;;

    esac

}

checkVariables DOMAIN

if [ -z "$(printenv WILDCARD)" ] || [ "$(printenv WILDCARD)" != "yes" ] ; then
    echo "WILDCARD (empty/not yes) = \"$(printenv WILDCARD)\""
    if [[ "$(printenv FORCE)" = "yes" ]] ; then
        echo "FORCE (yes) = \"$(printenv FORCE)\" "
        getCommand force_cert
    else
        echo "FORCE (empty/not yes) = \"$(printenv FORCE)\" "
        getCommand cert
    fi

elif [[ "$(printenv WILDCARD)" = "yes" ]] ; then
    echo "WILDCARD (yes) = \"$(printenv WILDCARD)\" "
    if [[ "$(printenv FORCE)" = "yes" ]] ; then
        echo "FORCE (yes) = \"$(printenv FORCE)\" "
        getCommand force_wildcard_cert
    else
        echo "FORCE (empty/not yes) = \"$(printenv FORCE)\" "
        getCommand wildcard_cert
        echo "${getCert}"
    fi
fi