DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
echo "Running in directory: ${DIR}"

Rscript ../creator/bosch_xgb-ex_gen.R ${DIR} O3
Rscript bosch_xgb-ex.R ${DIR} 12 lossguide depth O3
Rscript bosch_xgb-ex.R ${DIR} 12 depthwise depth O3
Rscript bosch_xgb-ex.R ${DIR} 6 lossguide depth O3
Rscript bosch_xgb-ex.R ${DIR} 6 depthwise depth O3
Rscript bosch_xgb-ex.R ${DIR} 5 lossguide depth O3
Rscript bosch_xgb-ex.R ${DIR} 5 depthwise depth O3
Rscript bosch_xgb-ex.R ${DIR} 4 lossguide depth O3
Rscript bosch_xgb-ex.R ${DIR} 4 depthwise depth O3
Rscript bosch_xgb-ex.R ${DIR} 3 lossguide depth O3
Rscript bosch_xgb-ex.R ${DIR} 3 depthwise depth O3
Rscript bosch_xgb-ex.R ${DIR} 2 lossguide depth O3
Rscript bosch_xgb-ex.R ${DIR} 2 depthwise depth O3
Rscript bosch_xgb-ex.R ${DIR} 1 lossguide depth O3
Rscript bosch_xgb-ex.R ${DIR} 1 depthwise depth O3
