DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
echo "Running in directory: ${DIR}"

Rscript bosch_lgb.R ${DIR} 5 "v1-O2" leaves
Rscript bosch_lgb.R ${DIR} 5 "v1-O2" depth
Rscript bosch_lgb.R ${DIR} 5 "v1-O2" hessian
Rscript bosch_lgb.R ${DIR} 5 "v1-O2" sampling
Rscript bosch_lgb.R ${DIR} 4 "v1-O2" leaves
Rscript bosch_lgb.R ${DIR} 4 "v1-O2" depth
Rscript bosch_lgb.R ${DIR} 4 "v1-O2" hessian
Rscript bosch_lgb.R ${DIR} 4 "v1-O2" sampling
Rscript bosch_lgb.R ${DIR} 3 "v1-O2" leaves
Rscript bosch_lgb.R ${DIR} 3 "v1-O2" depth
Rscript bosch_lgb.R ${DIR} 3 "v1-O2" hessian
Rscript bosch_lgb.R ${DIR} 3 "v1-O2" sampling
Rscript bosch_lgb.R ${DIR} 2 "v1-O2" leaves
Rscript bosch_lgb.R ${DIR} 2 "v1-O2" depth
Rscript bosch_lgb.R ${DIR} 2 "v1-O2" hessian
Rscript bosch_lgb.R ${DIR} 2 "v1-O2" sampling
