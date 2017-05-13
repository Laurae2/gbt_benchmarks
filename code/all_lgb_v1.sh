DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
echo "Running in directory: ${DIR}"

./bosch_lgb_v1.sh
./bosch_lgb_v1_slow.sh
./higgs_lgb_v1.sh
./higgs_lgb_v1_slow.sh
