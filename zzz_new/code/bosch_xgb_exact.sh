DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
echo "Running in directory: ${DIR}"

Rscript bosch_xgb.R ${DIR} 8 exact depth release
Rscript bosch_xgb.R ${DIR} 8 exact hessian release
Rscript bosch_xgb.R ${DIR} 8 exact sampling release
Rscript bosch_xgb.R ${DIR} 7 exact depth release
Rscript bosch_xgb.R ${DIR} 7 exact hessian release
Rscript bosch_xgb.R ${DIR} 7 exact sampling release
Rscript bosch_xgb.R ${DIR} 6 exact depth release
Rscript bosch_xgb.R ${DIR} 6 exact hessian release
Rscript bosch_xgb.R ${DIR} 6 exact sampling release
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
