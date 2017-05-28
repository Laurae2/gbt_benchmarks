DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
echo "Running in directory: ${DIR}"

./bosch_xgb_exact.sh
./higgs_xgb_exact.sh
