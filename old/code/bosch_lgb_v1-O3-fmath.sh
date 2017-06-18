DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
echo "Running in directory: ${DIR}"

Rscript ../creator/bosch_lgb_gen.R ${DIR} "v1-O3-fmath"
Rscript bosch_lgb.R ${DIR} 12 "v1-O3-fmath" leaves
Rscript bosch_lgb.R ${DIR} 12 "v1-O3-fmath" depth
Rscript bosch_lgb.R ${DIR} 12 "v1-O3-fmath" hessian
Rscript bosch_lgb.R ${DIR} 12 "v1-O3-fmath" sampling
Rscript bosch_lgb.R ${DIR} 6 "v1-O3-fmath" leaves
Rscript bosch_lgb.R ${DIR} 6 "v1-O3-fmath" depth
Rscript bosch_lgb.R ${DIR} 6 "v1-O3-fmath" hessian
Rscript bosch_lgb.R ${DIR} 6 "v1-O3-fmath" sampling
Rscript bosch_lgb.R ${DIR} 1 "v1-O3-fmath" leaves
Rscript bosch_lgb.R ${DIR} 1 "v1-O3-fmath" depth
Rscript bosch_lgb.R ${DIR} 1 "v1-O3-fmath" hessian
Rscript bosch_lgb.R ${DIR} 1 "v1-O3-fmath" sampling
