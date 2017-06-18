DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
echo "Running in directory: ${DIR}"

./bosch_xgb.sh
./higgs_xgb.sh
./reput_xgb.sh
