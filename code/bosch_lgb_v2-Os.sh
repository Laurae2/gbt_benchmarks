DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
echo "Running in directory: ${DIR}"

Rscript ../creator/bosch_lgb_gen.R ${DIR} "v2-Os"
Rscript bosch_lgb.R ${DIR} 12 "v2-Os" leaves
Rscript bosch_lgb.R ${DIR} 12 "v2-Os" depth
Rscript bosch_lgb.R ${DIR} 12 "v2-Os" hessian
Rscript bosch_lgb.R ${DIR} 12 "v2-Os" sampling
Rscript bosch_lgb.R ${DIR} 6 "v2-Os" leaves
Rscript bosch_lgb.R ${DIR} 6 "v2-Os" depth
Rscript bosch_lgb.R ${DIR} 6 "v2-Os" hessian
Rscript bosch_lgb.R ${DIR} 6 "v2-Os" sampling
Rscript bosch_lgb.R ${DIR} 1 "v2-Os" leaves
Rscript bosch_lgb.R ${DIR} 1 "v2-Os" depth
Rscript bosch_lgb.R ${DIR} 1 "v2-Os" hessian
Rscript bosch_lgb.R ${DIR} 1 "v2-Os" sampling
