DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
echo "Running in directory: ${DIR}"

Rscript ../creator/bosch_lgb_gen.R ${DIR} "v1-Os"
Rscript bosch_lgb.R ${DIR} 12 "v1-Os" leaves
Rscript bosch_lgb.R ${DIR} 12 "v1-Os" depth
Rscript bosch_lgb.R ${DIR} 12 "v1-Os" hessian
Rscript bosch_lgb.R ${DIR} 12 "v1-Os" sampling
Rscript bosch_lgb.R ${DIR} 6 "v1-Os" leaves
Rscript bosch_lgb.R ${DIR} 6 "v1-Os" depth
Rscript bosch_lgb.R ${DIR} 6 "v1-Os" hessian
Rscript bosch_lgb.R ${DIR} 6 "v1-Os" sampling
Rscript bosch_lgb.R ${DIR} 1 "v1-Os" leaves
Rscript bosch_lgb.R ${DIR} 1 "v1-Os" depth
Rscript bosch_lgb.R ${DIR} 1 "v1-Os" hessian
Rscript bosch_lgb.R ${DIR} 1 "v1-Os" sampling
