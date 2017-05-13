DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
echo "Running in directory: ${DIR}"

Rscript ../creator/bosch_lgb_gen.R ${DIR} "v2-O2"
Rscript bosch_lgb.R ${DIR} 12 "v2-O2" leaves
Rscript bosch_lgb.R ${DIR} 12 "v2-O2" depth
Rscript bosch_lgb.R ${DIR} 12 "v2-O2" hessian
Rscript bosch_lgb.R ${DIR} 12 "v2-O2" sampling
Rscript bosch_lgb.R ${DIR} 6 "v2-O2" leaves
Rscript bosch_lgb.R ${DIR} 6 "v2-O2" depth
Rscript bosch_lgb.R ${DIR} 6 "v2-O2" hessian
Rscript bosch_lgb.R ${DIR} 6 "v2-O2" sampling
Rscript bosch_lgb.R ${DIR} 1 "v2-O2" leaves
Rscript bosch_lgb.R ${DIR} 1 "v2-O2" depth
Rscript bosch_lgb.R ${DIR} 1 "v2-O2" hessian
Rscript bosch_lgb.R ${DIR} 1 "v2-O2" sampling
