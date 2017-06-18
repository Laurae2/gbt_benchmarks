DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
echo "Running in directory: ${DIR}"

Rscript ../creator/bosch_xgb-ex_gen.R ${DIR} O3
Rscript bosch_xgb-def.R ${DIR} 40 exact depth-short O3
Rscript bosch_xgb-def.R ${DIR} 40 exact hessian-short O3
Rscript bosch_xgb-def.R ${DIR} 40 exact sampling-short O3
Rscript bosch_xgb-def.R ${DIR} 20 exact depth-short O3
Rscript bosch_xgb-def.R ${DIR} 20 exact hessian-short O3
Rscript bosch_xgb-def.R ${DIR} 20 exact sampling-short O3
