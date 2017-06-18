DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
echo "Running in directory: ${DIR}"

./bosch_lgb_v2.sh
./bosch_lgb_v2_slow.sh
./higgs_lgb_v2.sh
./higgs_lgb_v2_slow.sh
