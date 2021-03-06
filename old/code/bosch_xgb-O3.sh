DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
echo "Running in directory: ${DIR}"

Rscript ../creator/bosch_xgb-ex_gen.R ${DIR} O3
Rscript bosch_xgb-ex.R ${DIR} 12 lossguide leaves O3
Rscript bosch_xgb-ex.R ${DIR} 12 lossguide depth O3
Rscript bosch_xgb-ex.R ${DIR} 12 lossguide hessian O3
Rscript bosch_xgb-ex.R ${DIR} 12 lossguide sampling O3
Rscript bosch_xgb-ex.R ${DIR} 12 depthwise depth O3
Rscript bosch_xgb-ex.R ${DIR} 12 depthwise hessian O3
Rscript bosch_xgb-ex.R ${DIR} 12 depthwise sampling O3
Rscript bosch_xgb-ex.R ${DIR} 6 lossguide leaves O3
Rscript bosch_xgb-ex.R ${DIR} 6 lossguide depth O3
Rscript bosch_xgb-ex.R ${DIR} 6 lossguide hessian O3
Rscript bosch_xgb-ex.R ${DIR} 6 lossguide sampling O3
Rscript bosch_xgb-ex.R ${DIR} 6 depthwise depth O3
Rscript bosch_xgb-ex.R ${DIR} 6 depthwise hessian O3
Rscript bosch_xgb-ex.R ${DIR} 6 depthwise sampling O3
Rscript bosch_xgb-ex.R ${DIR} 1 lossguide leaves O3
Rscript bosch_xgb-ex.R ${DIR} 1 lossguide depth O3
Rscript bosch_xgb-ex.R ${DIR} 1 lossguide hessian O3
Rscript bosch_xgb-ex.R ${DIR} 1 lossguide sampling O3
Rscript bosch_xgb-ex.R ${DIR} 1 depthwise depth O3
Rscript bosch_xgb-ex.R ${DIR} 1 depthwise hessian O3
Rscript bosch_xgb-ex.R ${DIR} 1 depthwise sampling O3
