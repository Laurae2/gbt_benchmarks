DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
echo "Running in directory: ${DIR}"

./bosch_lgb_v2-Os.sh
./bosch_lgb_v2-Os_slow.sh
