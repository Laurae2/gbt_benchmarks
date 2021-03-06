DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
echo "Running in directory: ${DIR}"

Rscript ../creator/bosch_lgb_gen.R ${DIR} "v1"
Rscript bosch_lgb.R ${DIR} 40 v1 leaves
Rscript bosch_lgb.R ${DIR} 40 v1 depth
Rscript bosch_lgb.R ${DIR} 40 v1 hessian
Rscript bosch_lgb.R ${DIR} 40 v1 sampling
Rscript bosch_lgb.R ${DIR} 20 v1 leaves
Rscript bosch_lgb.R ${DIR} 20 v1 depth
Rscript bosch_lgb.R ${DIR} 20 v1 hessian
Rscript bosch_lgb.R ${DIR} 20 v1 sampling
