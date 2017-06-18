DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
echo "Running in directory: ${DIR}"

Rscript bosch_lgb.R ${DIR} 40 na leaves release
Rscript bosch_lgb.R ${DIR} 40 na depth release
Rscript bosch_lgb.R ${DIR} 40 na hessian release
Rscript bosch_lgb.R ${DIR} 40 na sampling release
Rscript bosch_lgb.R ${DIR} 20 na leaves release
Rscript bosch_lgb.R ${DIR} 20 na depth release
Rscript bosch_lgb.R ${DIR} 20 na hessian release
Rscript bosch_lgb.R ${DIR} 20 na sampling release
Rscript bosch_lgb.R ${DIR} 10 na leaves release
Rscript bosch_lgb.R ${DIR} 10 na depth release
Rscript bosch_lgb.R ${DIR} 10 na hessian release
Rscript bosch_lgb.R ${DIR} 10 na sampling release
Rscript bosch_lgb.R ${DIR} 5 na leaves release
Rscript bosch_lgb.R ${DIR} 5 na depth release
Rscript bosch_lgb.R ${DIR} 5 na hessian release
Rscript bosch_lgb.R ${DIR} 5 na sampling release
Rscript bosch_lgb.R ${DIR} 4 na leaves release
Rscript bosch_lgb.R ${DIR} 4 na depth release
Rscript bosch_lgb.R ${DIR} 4 na hessian release
Rscript bosch_lgb.R ${DIR} 4 na sampling release
Rscript bosch_lgb.R ${DIR} 3 na leaves release
Rscript bosch_lgb.R ${DIR} 3 na depth release
Rscript bosch_lgb.R ${DIR} 3 na hessian release
Rscript bosch_lgb.R ${DIR} 3 na sampling release
Rscript bosch_lgb.R ${DIR} 2 na leaves release
Rscript bosch_lgb.R ${DIR} 2 na depth release
Rscript bosch_lgb.R ${DIR} 2 na hessian release
Rscript bosch_lgb.R ${DIR} 2 na sampling release
Rscript bosch_lgb.R ${DIR} 1 na leaves release
Rscript bosch_lgb.R ${DIR} 1 na depth release
Rscript bosch_lgb.R ${DIR} 1 na hessian release
Rscript bosch_lgb.R ${DIR} 1 na sampling release
