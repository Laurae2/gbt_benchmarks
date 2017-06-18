DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
echo "Running in directory: ${DIR}"

./bosch_lgb_v1-O2.sh
./bosch_lgb_v1-O2_slow.sh
