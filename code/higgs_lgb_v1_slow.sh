DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
echo "Running in directory: ${DIR}"

Rscript higgs_lgb.R ${DIR} 5 v1 leaves
Rscript higgs_lgb.R ${DIR} 5 v1 depth
Rscript higgs_lgb.R ${DIR} 5 v1 hessian
Rscript higgs_lgb.R ${DIR} 5 v1 sampling
Rscript higgs_lgb.R ${DIR} 4 v1 leaves
Rscript higgs_lgb.R ${DIR} 4 v1 depth
Rscript higgs_lgb.R ${DIR} 4 v1 hessian
Rscript higgs_lgb.R ${DIR} 4 v1 sampling
Rscript higgs_lgb.R ${DIR} 3 v1 leaves
Rscript higgs_lgb.R ${DIR} 3 v1 depth
Rscript higgs_lgb.R ${DIR} 3 v1 hessian
Rscript higgs_lgb.R ${DIR} 3 v1 sampling
Rscript higgs_lgb.R ${DIR} 2 v1 leaves
Rscript higgs_lgb.R ${DIR} 2 v1 depth
Rscript higgs_lgb.R ${DIR} 2 v1 hessian
Rscript higgs_lgb.R ${DIR} 2 v1 sampling
