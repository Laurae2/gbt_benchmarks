DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
echo "Running in directory: ${DIR}"

Rscript bosch_xgb-ex.R ${DIR} 5 lossguide leaves O3
Rscript bosch_xgb-ex.R ${DIR} 5 lossguide depth O3
Rscript bosch_xgb-ex.R ${DIR} 5 lossguide hessian O3
Rscript bosch_xgb-ex.R ${DIR} 5 lossguide sampling O3
Rscript bosch_xgb-ex.R ${DIR} 5 depthwise depth O3
Rscript bosch_xgb-ex.R ${DIR} 5 depthwise hessian O3
Rscript bosch_xgb-ex.R ${DIR} 5 depthwise sampling O3
Rscript bosch_xgb-ex.R ${DIR} 4 lossguide leaves O3
Rscript bosch_xgb-ex.R ${DIR} 4 lossguide depth O3
Rscript bosch_xgb-ex.R ${DIR} 4 lossguide hessian O3
Rscript bosch_xgb-ex.R ${DIR} 4 lossguide sampling O3
Rscript bosch_xgb-ex.R ${DIR} 4 depthwise depth O3
Rscript bosch_xgb-ex.R ${DIR} 4 depthwise hessian O3
Rscript bosch_xgb-ex.R ${DIR} 4 depthwise sampling O3
Rscript bosch_xgb-ex.R ${DIR} 3 lossguide leaves O3
Rscript bosch_xgb-ex.R ${DIR} 3 lossguide depth O3
Rscript bosch_xgb-ex.R ${DIR} 3 lossguide hessian O3
Rscript bosch_xgb-ex.R ${DIR} 3 lossguide sampling O3
Rscript bosch_xgb-ex.R ${DIR} 3 depthwise depth O3
Rscript bosch_xgb-ex.R ${DIR} 3 depthwise hessian O3
Rscript bosch_xgb-ex.R ${DIR} 3 depthwise sampling O3
Rscript bosch_xgb-ex.R ${DIR} 2 lossguide leaves O3
Rscript bosch_xgb-ex.R ${DIR} 2 lossguide depth O3
Rscript bosch_xgb-ex.R ${DIR} 2 lossguide hessian O3
Rscript bosch_xgb-ex.R ${DIR} 2 lossguide sampling O3
Rscript bosch_xgb-ex.R ${DIR} 2 depthwise depth O3
Rscript bosch_xgb-ex.R ${DIR} 2 depthwise hessian O3
Rscript bosch_xgb-ex.R ${DIR} 2 depthwise sampling O3
