DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
echo "Running in directory: ${DIR}"

Rscript ../creator/bosch_xgb_gen.R ${DIR}
Rscript bosch_xgb.R ${DIR} 12 lossguide depth
Rscript bosch_xgb.R ${DIR} 12 depthwise depth
Rscript bosch_xgb.R ${DIR} 6 lossguide depth
Rscript bosch_xgb.R ${DIR} 6 depthwise depth
Rscript bosch_xgb.R ${DIR} 5 lossguide depth
Rscript bosch_xgb.R ${DIR} 5 depthwise depth
Rscript bosch_xgb.R ${DIR} 4 lossguide depth
Rscript bosch_xgb.R ${DIR} 4 depthwise depth
Rscript bosch_xgb.R ${DIR} 3 lossguide depth
Rscript bosch_xgb.R ${DIR} 3 depthwise depth
Rscript bosch_xgb.R ${DIR} 2 lossguide depth
Rscript bosch_xgb.R ${DIR} 2 depthwise depth
Rscript bosch_xgb.R ${DIR} 1 lossguide depth
Rscript bosch_xgb.R ${DIR} 1 depthwise depth
