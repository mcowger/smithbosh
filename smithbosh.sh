#!/bin/bash -e


function usage()
{
    echo "Toolsmiths Helper for PKS."
    echo ""
    echo "-h --help"
    echo "--json=<path to JSON file"
    echo ""
    echo 'example: eval "$(smithbosh.sh --json=mayflower.json)"'
}

if [ "$#" -ne 1 ]; then
        usage
        exit 1
fi
while [ "$1" != "" ]; do
    PARAM=`echo $1 | awk -F= '{print $1}'`
    VALUE=`echo $1 | awk -F= '{print $2}'`
    case $PARAM in
        -h | --help)
            usage
            exit
            ;;
        --json)
            json=$VALUE
            ;;
        *)
            echo "ERROR: unknown parameter \"$PARAM\""
            usage
            exit 1
            ;;
    esac
    shift
done

#grab the private key for the ubuntu opsman and put it in a temp file
private_key_file_name=`mktemp`
cat $json | jq -cr .ops_manager_private_key > $private_key_file_name

#now grab the opsman IP from the JSON:
opsman=`cat $json | jq -cr .ops_manager.url | awk -F/ '{print $3}'`

# get the username and password for OM
username=`cat $json  | jq -cr .ops_manager.username`
password=`cat $json | jq -cr .ops_manager.password`


#now run the required command to do bosh_env:

om -u $username -p $password -k -t $opsman bosh-env
echo -n "export "
echo -n 'BOSH_ALL_PROXY="'
echo -n "ssh+socks5://ubuntu@$opsman:22?private-key=$private_key_file_name"
echo  '"'
