DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
echo "Running in directory: ${DIR}"

Rscript ../creator/bosch_lgb_gen.R ${DIR} "v2"
Rscript bosch_lgb.R ${DIR} 40 v2 leaves
Rscript bosch_lgb.R ${DIR} 40 v2 depth
Rscript bosch_lgb.R ${DIR} 40 v2 hessian
Rscript bosch_lgb.R ${DIR} 40 v2 sampling
Rscript bosch_lgb.R ${DIR} 20 v2 leaves
Rscript bosch_lgb.R ${DIR} 20 v2 depth
Rscript bosch_lgb.R ${DIR} 20 v2 hessian
Rscript bosch_lgb.R ${DIR} 20 v2 sampling
