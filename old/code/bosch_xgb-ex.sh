DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
echo "Running in directory: ${DIR}"

Rscript ../creator/bosch_xgb-ex_gen.R ${DIR} ex
Rscript bosch_xgb-ex.R ${DIR} 12 lossguide leaves ex
Rscript bosch_xgb-ex.R ${DIR} 12 lossguide depth ex
Rscript bosch_xgb-ex.R ${DIR} 12 lossguide hessian ex
Rscript bosch_xgb-ex.R ${DIR} 12 lossguide sampling ex
Rscript bosch_xgb-ex.R ${DIR} 12 depthwise depth ex
Rscript bosch_xgb-ex.R ${DIR} 12 depthwise hessian ex
Rscript bosch_xgb-ex.R ${DIR} 12 depthwise sampling ex
Rscript bosch_xgb-ex.R ${DIR} 6 lossguide leaves ex
Rscript bosch_xgb-ex.R ${DIR} 6 lossguide depth ex
Rscript bosch_xgb-ex.R ${DIR} 6 lossguide hessian ex
Rscript bosch_xgb-ex.R ${DIR} 6 lossguide sampling ex
Rscript bosch_xgb-ex.R ${DIR} 6 depthwise depth ex
Rscript bosch_xgb-ex.R ${DIR} 6 depthwise hessian ex
Rscript bosch_xgb-ex.R ${DIR} 6 depthwise sampling ex
Rscript bosch_xgb-ex.R ${DIR} 1 lossguide leaves ex
Rscript bosch_xgb-ex.R ${DIR} 1 lossguide depth ex
Rscript bosch_xgb-ex.R ${DIR} 1 lossguide hessian ex
Rscript bosch_xgb-ex.R ${DIR} 1 lossguide sampling ex
Rscript bosch_xgb-ex.R ${DIR} 1 depthwise depth ex
Rscript bosch_xgb-ex.R ${DIR} 1 depthwise hessian ex
Rscript bosch_xgb-ex.R ${DIR} 1 depthwise sampling ex
