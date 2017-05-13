DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
echo "Running in directory: ${DIR}"

Rscript ../creator/bosch_xgb_gen.R ${DIR}
Rscript bosch_xgb.R ${DIR} 40 lossguide leaves
Rscript bosch_xgb.R ${DIR} 40 lossguide depth
Rscript bosch_xgb.R ${DIR} 40 lossguide hessian
Rscript bosch_xgb.R ${DIR} 40 lossguide sampling
Rscript bosch_xgb.R ${DIR} 40 depthwise depth
Rscript bosch_xgb.R ${DIR} 40 depthwise hessian
Rscript bosch_xgb.R ${DIR} 40 depthwise sampling
Rscript bosch_xgb.R ${DIR} 20 lossguide leaves
Rscript bosch_xgb.R ${DIR} 20 lossguide depth
Rscript bosch_xgb.R ${DIR} 20 lossguide hessian
Rscript bosch_xgb.R ${DIR} 20 lossguide sampling
Rscript bosch_xgb.R ${DIR} 20 depthwise depth
Rscript bosch_xgb.R ${DIR} 20 depthwise hessian
Rscript bosch_xgb.R ${DIR} 20 depthwise sampling
