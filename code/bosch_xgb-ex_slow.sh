DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
echo "Running in directory: ${DIR}"

Rscript bosch_xgb-ex.R ${DIR} 5 lossguide leaves ex
Rscript bosch_xgb-ex.R ${DIR} 5 lossguide depth ex
Rscript bosch_xgb-ex.R ${DIR} 5 lossguide hessian ex
Rscript bosch_xgb-ex.R ${DIR} 5 lossguide sampling ex
Rscript bosch_xgb-ex.R ${DIR} 5 depthwise depth ex
Rscript bosch_xgb-ex.R ${DIR} 5 depthwise hessian ex
Rscript bosch_xgb-ex.R ${DIR} 5 depthwise sampling ex
Rscript bosch_xgb-ex.R ${DIR} 4 lossguide leaves ex
Rscript bosch_xgb-ex.R ${DIR} 4 lossguide depth ex
Rscript bosch_xgb-ex.R ${DIR} 4 lossguide hessian ex
Rscript bosch_xgb-ex.R ${DIR} 4 lossguide sampling ex
Rscript bosch_xgb-ex.R ${DIR} 4 depthwise depth ex
Rscript bosch_xgb-ex.R ${DIR} 4 depthwise hessian ex
Rscript bosch_xgb-ex.R ${DIR} 4 depthwise sampling ex
Rscript bosch_xgb-ex.R ${DIR} 3 lossguide leaves ex
Rscript bosch_xgb-ex.R ${DIR} 3 lossguide depth ex
Rscript bosch_xgb-ex.R ${DIR} 3 lossguide hessian ex
Rscript bosch_xgb-ex.R ${DIR} 3 lossguide sampling ex
Rscript bosch_xgb-ex.R ${DIR} 3 depthwise depth ex
Rscript bosch_xgb-ex.R ${DIR} 3 depthwise hessian ex
Rscript bosch_xgb-ex.R ${DIR} 3 depthwise sampling ex
Rscript bosch_xgb-ex.R ${DIR} 2 lossguide leaves ex
Rscript bosch_xgb-ex.R ${DIR} 2 lossguide depth ex
Rscript bosch_xgb-ex.R ${DIR} 2 lossguide hessian ex
Rscript bosch_xgb-ex.R ${DIR} 2 lossguide sampling ex
Rscript bosch_xgb-ex.R ${DIR} 2 depthwise depth ex
Rscript bosch_xgb-ex.R ${DIR} 2 depthwise hessian ex
Rscript bosch_xgb-ex.R ${DIR} 2 depthwise sampling ex
