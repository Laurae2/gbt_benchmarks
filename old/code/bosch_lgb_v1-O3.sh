DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
echo "Running in directory: ${DIR}"

Rscript ../creator/bosch_lgb_gen.R ${DIR} "v1-O3"
Rscript bosch_lgb.R ${DIR} 12 "v1-O3" leaves
Rscript bosch_lgb.R ${DIR} 12 "v1-O3" depth
Rscript bosch_lgb.R ${DIR} 12 "v1-O3" hessian
Rscript bosch_lgb.R ${DIR} 12 "v1-O3" sampling
Rscript bosch_lgb.R ${DIR} 6 "v1-O3" leaves
Rscript bosch_lgb.R ${DIR} 6 "v1-O3" depth
Rscript bosch_lgb.R ${DIR} 6 "v1-O3" hessian
Rscript bosch_lgb.R ${DIR} 6 "v1-O3" sampling
Rscript bosch_lgb.R ${DIR} 1 "v1-O3" leaves
Rscript bosch_lgb.R ${DIR} 1 "v1-O3" depth
Rscript bosch_lgb.R ${DIR} 1 "v1-O3" hessian
Rscript bosch_lgb.R ${DIR} 1 "v1-O3" sampling
