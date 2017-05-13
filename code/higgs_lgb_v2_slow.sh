DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
echo "Running in directory: ${DIR}"

Rscript higgs_lgb.R ${DIR} 5 v2 leaves
Rscript higgs_lgb.R ${DIR} 5 v2 depth
Rscript higgs_lgb.R ${DIR} 5 v2 hessian
Rscript higgs_lgb.R ${DIR} 5 v2 sampling
Rscript higgs_lgb.R ${DIR} 4 v2 leaves
Rscript higgs_lgb.R ${DIR} 4 v2 depth
Rscript higgs_lgb.R ${DIR} 4 v2 hessian
Rscript higgs_lgb.R ${DIR} 4 v2 sampling
Rscript higgs_lgb.R ${DIR} 3 v2 leaves
Rscript higgs_lgb.R ${DIR} 3 v2 depth
Rscript higgs_lgb.R ${DIR} 3 v2 hessian
Rscript higgs_lgb.R ${DIR} 3 v2 sampling
Rscript higgs_lgb.R ${DIR} 2 v2 leaves
Rscript higgs_lgb.R ${DIR} 2 v2 depth
Rscript higgs_lgb.R ${DIR} 2 v2 hessian
Rscript higgs_lgb.R ${DIR} 2 v2 sampling
