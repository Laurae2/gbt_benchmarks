DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
echo "Running in directory: ${DIR}"

./bosch_lgb.sh
./higgs_lgb.sh
Rscript ../creator/reput_lgb_gen.R ${DIR} "na"
./reput_lgb.sh
