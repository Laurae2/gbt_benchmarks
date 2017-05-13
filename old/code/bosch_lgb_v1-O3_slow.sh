DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
echo "Running in directory: ${DIR}"

Rscript bosch_lgb.R ${DIR} 5 "v1-O3" leaves
Rscript bosch_lgb.R ${DIR} 5 "v1-O3" depth
Rscript bosch_lgb.R ${DIR} 5 "v1-O3" hessian
Rscript bosch_lgb.R ${DIR} 5 "v1-O3" sampling
Rscript bosch_lgb.R ${DIR} 4 "v1-O3" leaves
Rscript bosch_lgb.R ${DIR} 4 "v1-O3" depth
Rscript bosch_lgb.R ${DIR} 4 "v1-O3" hessian
Rscript bosch_lgb.R ${DIR} 4 "v1-O3" sampling
Rscript bosch_lgb.R ${DIR} 3 "v1-O3" leaves
Rscript bosch_lgb.R ${DIR} 3 "v1-O3" depth
Rscript bosch_lgb.R ${DIR} 3 "v1-O3" hessian
Rscript bosch_lgb.R ${DIR} 3 "v1-O3" sampling
Rscript bosch_lgb.R ${DIR} 2 "v1-O3" leaves
Rscript bosch_lgb.R ${DIR} 2 "v1-O3" depth
Rscript bosch_lgb.R ${DIR} 2 "v1-O3" hessian
Rscript bosch_lgb.R ${DIR} 2 "v1-O3" sampling
