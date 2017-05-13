DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
echo "Running in directory: ${DIR}"

Rscript bosch_lgb.R ${DIR} 5 "v1-Os" leaves
Rscript bosch_lgb.R ${DIR} 5 "v1-Os" depth
Rscript bosch_lgb.R ${DIR} 5 "v1-Os" hessian
Rscript bosch_lgb.R ${DIR} 5 "v1-Os" sampling
Rscript bosch_lgb.R ${DIR} 4 "v1-Os" leaves
Rscript bosch_lgb.R ${DIR} 4 "v1-Os" depth
Rscript bosch_lgb.R ${DIR} 4 "v1-Os" hessian
Rscript bosch_lgb.R ${DIR} 4 "v1-Os" sampling
Rscript bosch_lgb.R ${DIR} 3 "v1-Os" leaves
Rscript bosch_lgb.R ${DIR} 3 "v1-Os" depth
Rscript bosch_lgb.R ${DIR} 3 "v1-Os" hessian
Rscript bosch_lgb.R ${DIR} 3 "v1-Os" sampling
Rscript bosch_lgb.R ${DIR} 2 "v1-Os" leaves
Rscript bosch_lgb.R ${DIR} 2 "v1-Os" depth
Rscript bosch_lgb.R ${DIR} 2 "v1-Os" hessian
Rscript bosch_lgb.R ${DIR} 2 "v1-Os" sampling
