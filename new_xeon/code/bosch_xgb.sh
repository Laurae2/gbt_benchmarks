DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
echo "Running in directory: ${DIR}"

Rscript bosch_xgb.R ${DIR} 40 lossguide leaves release
Rscript bosch_xgb.R ${DIR} 40 lossguide depth release
Rscript bosch_xgb.R ${DIR} 40 lossguide hessian release
Rscript bosch_xgb.R ${DIR} 40 lossguide sampling release
Rscript bosch_xgb.R ${DIR} 40 depthwise depth release
Rscript bosch_xgb.R ${DIR} 40 depthwise hessian release
Rscript bosch_xgb.R ${DIR} 40 depthwise sampling release
Rscript bosch_xgb.R ${DIR} 20 lossguide leaves release
Rscript bosch_xgb.R ${DIR} 20 lossguide depth release
Rscript bosch_xgb.R ${DIR} 20 lossguide hessian release
Rscript bosch_xgb.R ${DIR} 20 lossguide sampling release
Rscript bosch_xgb.R ${DIR} 20 depthwise depth release
Rscript bosch_xgb.R ${DIR} 20 depthwise hessian release
Rscript bosch_xgb.R ${DIR} 20 depthwise sampling release
Rscript bosch_xgb.R ${DIR} 10 lossguide leaves release
Rscript bosch_xgb.R ${DIR} 10 lossguide depth release
Rscript bosch_xgb.R ${DIR} 10 lossguide hessian release
Rscript bosch_xgb.R ${DIR} 10 lossguide sampling release
Rscript bosch_xgb.R ${DIR} 10 depthwise depth release
Rscript bosch_xgb.R ${DIR} 10 depthwise hessian release
Rscript bosch_xgb.R ${DIR} 10 depthwise sampling release
Rscript bosch_xgb.R ${DIR} 5 lossguide leaves release
Rscript bosch_xgb.R ${DIR} 5 lossguide depth release
Rscript bosch_xgb.R ${DIR} 5 lossguide hessian release
Rscript bosch_xgb.R ${DIR} 5 lossguide sampling release
Rscript bosch_xgb.R ${DIR} 5 depthwise depth release
Rscript bosch_xgb.R ${DIR} 5 depthwise hessian release
Rscript bosch_xgb.R ${DIR} 5 depthwise sampling release
Rscript bosch_xgb.R ${DIR} 4 lossguide leaves release
Rscript bosch_xgb.R ${DIR} 4 lossguide depth release
Rscript bosch_xgb.R ${DIR} 4 lossguide hessian release
Rscript bosch_xgb.R ${DIR} 4 lossguide sampling release
Rscript bosch_xgb.R ${DIR} 4 depthwise depth release
Rscript bosch_xgb.R ${DIR} 4 depthwise hessian release
Rscript bosch_xgb.R ${DIR} 4 depthwise sampling release
Rscript bosch_xgb.R ${DIR} 3 lossguide leaves release
Rscript bosch_xgb.R ${DIR} 3 lossguide depth release
Rscript bosch_xgb.R ${DIR} 3 lossguide hessian release
Rscript bosch_xgb.R ${DIR} 3 lossguide sampling release
Rscript bosch_xgb.R ${DIR} 3 depthwise depth release
Rscript bosch_xgb.R ${DIR} 3 depthwise hessian release
Rscript bosch_xgb.R ${DIR} 3 depthwise sampling release
Rscript bosch_xgb.R ${DIR} 2 lossguide leaves release
Rscript bosch_xgb.R ${DIR} 2 lossguide depth release
Rscript bosch_xgb.R ${DIR} 2 lossguide hessian release
Rscript bosch_xgb.R ${DIR} 2 lossguide sampling release
Rscript bosch_xgb.R ${DIR} 2 depthwise depth release
Rscript bosch_xgb.R ${DIR} 2 depthwise hessian release
Rscript bosch_xgb.R ${DIR} 2 depthwise sampling release
Rscript bosch_xgb.R ${DIR} 1 lossguide leaves release
Rscript bosch_xgb.R ${DIR} 1 lossguide depth release
Rscript bosch_xgb.R ${DIR} 1 lossguide hessian release
Rscript bosch_xgb.R ${DIR} 1 lossguide sampling release
Rscript bosch_xgb.R ${DIR} 1 depthwise depth release
Rscript bosch_xgb.R ${DIR} 1 depthwise hessian release
Rscript bosch_xgb.R ${DIR} 1 depthwise sampling release