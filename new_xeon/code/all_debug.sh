DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
echo "Running in directory: ${DIR}"

Rscript ../creator/bosch_xgb_gen.R ${DIR}
Rscript ../creator/higgs_xgb_gen.R ${DIR}
Rscript ../creator/reput_lgb_gen.R ${DIR}
./bosch_xgb_debug.sh
./higgs_xgb_debug.sh
./reput_xgb_debug.sh
Rscript ../creator/bosch_lgb_gen.R ${DIR} "na"
Rscript ../creator/higgs_lgb_gen.R ${DIR} "na"
Rscript ../creator/reput_lgb_gen.R ${DIR} "na"
./bosch_lgb_debug.sh
./higgs_lgb_debug.sh
./reput_lgb_debug.sh
