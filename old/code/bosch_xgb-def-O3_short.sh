DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
echo "Running in directory: ${DIR}"

Rscript ../creator/bosch_xgb-ex_gen.R ${DIR} O3
Rscript bosch_xgb-def.R ${DIR} 12 exact depth-short O3
Rscript bosch_xgb-def.R ${DIR} 12 exact hessian-short O3
Rscript bosch_xgb-def.R ${DIR} 12 exact sampling-short O3
Rscript bosch_xgb-def.R ${DIR} 6 exact depth-short O3
Rscript bosch_xgb-def.R ${DIR} 6 exact hessian-short O3
Rscript bosch_xgb-def.R ${DIR} 6 exact sampling-short O3
Rscript bosch_xgb-def.R ${DIR} 5 exact depth-short O3
Rscript bosch_xgb-def.R ${DIR} 5 exact hessian-short O3
Rscript bosch_xgb-def.R ${DIR} 5 exact sampling-short O3
Rscript bosch_xgb-def.R ${DIR} 4 exact depth-short O3
Rscript bosch_xgb-def.R ${DIR} 4 exact hessian-short O3
Rscript bosch_xgb-def.R ${DIR} 4 exact sampling-short O3
Rscript bosch_xgb-def.R ${DIR} 3 exact depth-short O3
Rscript bosch_xgb-def.R ${DIR} 3 exact hessian-short O3
Rscript bosch_xgb-def.R ${DIR} 3 exact sampling-short O3
Rscript bosch_xgb-def.R ${DIR} 2 exact depth-short O3
Rscript bosch_xgb-def.R ${DIR} 2 exact hessian-short O3
Rscript bosch_xgb-def.R ${DIR} 2 exact sampling-short O3
Rscript bosch_xgb-def.R ${DIR} 1 exact depth-short O3
Rscript bosch_xgb-def.R ${DIR} 1 exact hessian-short O3
Rscript bosch_xgb-def.R ${DIR} 1 exact sampling-short O3
