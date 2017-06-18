DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
echo "Running in directory: ${DIR}"

Rscript ../creator/bosch_xgb-ex_gen.R ${DIR} ex
Rscript bosch_xgb-ex.R ${DIR} 12 lossguide depth ex
Rscript bosch_xgb-ex.R ${DIR} 12 depthwise depth ex
Rscript bosch_xgb-ex.R ${DIR} 6 lossguide depth ex
Rscript bosch_xgb-ex.R ${DIR} 6 depthwise depth ex
Rscript bosch_xgb-ex.R ${DIR} 5 lossguide depth ex
Rscript bosch_xgb-ex.R ${DIR} 5 depthwise depth ex
Rscript bosch_xgb-ex.R ${DIR} 4 lossguide depth ex
Rscript bosch_xgb-ex.R ${DIR} 4 depthwise depth ex
Rscript bosch_xgb-ex.R ${DIR} 3 lossguide depth ex
Rscript bosch_xgb-ex.R ${DIR} 3 depthwise depth ex
Rscript bosch_xgb-ex.R ${DIR} 2 lossguide depth ex
Rscript bosch_xgb-ex.R ${DIR} 2 depthwise depth ex
Rscript bosch_xgb-ex.R ${DIR} 1 lossguide depth ex
Rscript bosch_xgb-ex.R ${DIR} 1 depthwise depth ex
