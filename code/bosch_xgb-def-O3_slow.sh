DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
echo "Running in directory: ${DIR}"

Rscript bosch_xgb-def.R ${DIR} 5 exact depth O3
Rscript bosch_xgb-def.R ${DIR} 5 exact hessian O3
Rscript bosch_xgb-def.R ${DIR} 5 exact sampling O3
Rscript bosch_xgb-def.R ${DIR} 4 exact depth O3
Rscript bosch_xgb-def.R ${DIR} 4 exact hessian O3
Rscript bosch_xgb-def.R ${DIR} 4 exact sampling O3
Rscript bosch_xgb-def.R ${DIR} 3 exact depth O3
Rscript bosch_xgb-def.R ${DIR} 3 exact hessian O3
Rscript bosch_xgb-def.R ${DIR} 3 exact sampling O3
Rscript bosch_xgb-def.R ${DIR} 2 exact depth O3
Rscript bosch_xgb-def.R ${DIR} 2 exact hessian O3
Rscript bosch_xgb-def.R ${DIR} 2 exact sampling O3
