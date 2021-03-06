DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
echo "Running in directory: ${DIR}"

Rscript bosch_lgb.R ${DIR} 5 "v2-O3-fmath" leaves
Rscript bosch_lgb.R ${DIR} 5 "v2-O3-fmath" depth
Rscript bosch_lgb.R ${DIR} 5 "v2-O3-fmath" hessian
Rscript bosch_lgb.R ${DIR} 5 "v2-O3-fmath" sampling
Rscript bosch_lgb.R ${DIR} 4 "v2-O3-fmath" leaves
Rscript bosch_lgb.R ${DIR} 4 "v2-O3-fmath" depth
Rscript bosch_lgb.R ${DIR} 4 "v2-O3-fmath" hessian
Rscript bosch_lgb.R ${DIR} 4 "v2-O3-fmath" sampling
Rscript bosch_lgb.R ${DIR} 3 "v2-O3-fmath" leaves
Rscript bosch_lgb.R ${DIR} 3 "v2-O3-fmath" depth
Rscript bosch_lgb.R ${DIR} 3 "v2-O3-fmath" hessian
Rscript bosch_lgb.R ${DIR} 3 "v2-O3-fmath" sampling
Rscript bosch_lgb.R ${DIR} 2 "v2-O3-fmath" leaves
Rscript bosch_lgb.R ${DIR} 2 "v2-O3-fmath" depth
Rscript bosch_lgb.R ${DIR} 2 "v2-O3-fmath" hessian
Rscript bosch_lgb.R ${DIR} 2 "v2-O3-fmath" sampling
