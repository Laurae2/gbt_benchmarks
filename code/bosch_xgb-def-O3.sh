DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
echo "Running in directory: ${DIR}"

Rscript ../creator/bosch_xgb-ex_gen.R ${DIR} O3
Rscript bosch_xgb-def.R ${DIR} 12 exact depth O3
Rscript bosch_xgb-def.R ${DIR} 12 exact hessian O3
Rscript bosch_xgb-def.R ${DIR} 12 exact sampling O3
Rscript bosch_xgb-def.R ${DIR} 6 exact depth O3
Rscript bosch_xgb-def.R ${DIR} 6 exact hessian O3
Rscript bosch_xgb-def.R ${DIR} 6 exact sampling O3
Rscript bosch_xgb-def.R ${DIR} 1 exact depth O3
Rscript bosch_xgb-def.R ${DIR} 1 exact hessian O3
Rscript bosch_xgb-def.R ${DIR} 1 exact sampling O3
