DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
echo "Running in directory: ${DIR}"

Rscript higgs_lgb.R ${DIR} 8 na leaves release
Rscript higgs_lgb.R ${DIR} 8 na depth release
Rscript higgs_lgb.R ${DIR} 8 na hessian release
Rscript higgs_lgb.R ${DIR} 8 na sampling release
Rscript higgs_lgb.R ${DIR} 7 na leaves release
Rscript higgs_lgb.R ${DIR} 7 na depth release
Rscript higgs_lgb.R ${DIR} 7 na hessian release
Rscript higgs_lgb.R ${DIR} 7 na sampling release
Rscript higgs_lgb.R ${DIR} 6 na leaves release
Rscript higgs_lgb.R ${DIR} 6 na depth release
Rscript higgs_lgb.R ${DIR} 6 na hessian release
Rscript higgs_lgb.R ${DIR} 6 na sampling release
Rscript higgs_lgb.R ${DIR} 5 na leaves release
Rscript higgs_lgb.R ${DIR} 5 na depth release
Rscript higgs_lgb.R ${DIR} 5 na hessian release
Rscript higgs_lgb.R ${DIR} 5 na sampling release
Rscript higgs_lgb.R ${DIR} 4 na leaves release
Rscript higgs_lgb.R ${DIR} 4 na depth release
Rscript higgs_lgb.R ${DIR} 4 na hessian release
Rscript higgs_lgb.R ${DIR} 4 na sampling release
Rscript higgs_lgb.R ${DIR} 3 na leaves release
Rscript higgs_lgb.R ${DIR} 3 na depth release
Rscript higgs_lgb.R ${DIR} 3 na hessian release
Rscript higgs_lgb.R ${DIR} 3 na sampling release
Rscript higgs_lgb.R ${DIR} 2 na leaves release
Rscript higgs_lgb.R ${DIR} 2 na depth release
Rscript higgs_lgb.R ${DIR} 2 na hessian release
Rscript higgs_lgb.R ${DIR} 2 na sampling release
Rscript higgs_lgb.R ${DIR} 1 na leaves release
Rscript higgs_lgb.R ${DIR} 1 na depth release
Rscript higgs_lgb.R ${DIR} 1 na hessian release
Rscript higgs_lgb.R ${DIR} 1 na sampling release
