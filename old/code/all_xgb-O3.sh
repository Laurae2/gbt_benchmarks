DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
echo "Running in directory: ${DIR}"

./bosch_xgb-O3.sh
./bosch_xgb-O3_slow.sh
