DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
echo "Running in directory: ${DIR}"

Rscript bosch_xgb.R ${DIR} 40 exact depth release
Rscript bosch_xgb.R ${DIR} 40 exact hessian release
Rscript bosch_xgb.R ${DIR} 40 exact sampling release
Rscript bosch_xgb.R ${DIR} 20 exact depth release
Rscript bosch_xgb.R ${DIR} 20 exact hessian release
Rscript bosch_xgb.R ${DIR} 20 exact sampling release
Rscript bosch_xgb.R ${DIR} 10 exact depth release
Rscript bosch_xgb.R ${DIR} 10 exact hessian release
Rscript bosch_xgb.R ${DIR} 10 exact sampling release
Rscript bosch_xgb.R ${DIR} 5 exact depth release
Rscript bosch_xgb.R ${DIR} 5 exact hessian release
Rscript bosch_xgb.R ${DIR} 5 exact sampling release
Rscript bosch_xgb.R ${DIR} 4 exact depth release
Rscript bosch_xgb.R ${DIR} 4 exact hessian release
Rscript bosch_xgb.R ${DIR} 4 exact sampling release
Rscript bosch_xgb.R ${DIR} 3 exact depth release
Rscript bosch_xgb.R ${DIR} 3 exact hessian release
Rscript bosch_xgb.R ${DIR} 3 exact sampling release
Rscript bosch_xgb.R ${DIR} 2 exact depth release
Rscript bosch_xgb.R ${DIR} 2 exact hessian release
Rscript bosch_xgb.R ${DIR} 2 exact sampling release
Rscript bosch_xgb.R ${DIR} 1 exact depth release
Rscript bosch_xgb.R ${DIR} 1 exact hessian release
Rscript bosch_xgb.R ${DIR} 1 exact sampling release
