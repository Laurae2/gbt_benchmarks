DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
echo "Running in directory: ${DIR}"

Rscript ../creator/higgs_lgb_gen.R ${DIR} "v1"
Rscript higgs_lgb.R ${DIR} 12 v1 leaves
Rscript higgs_lgb.R ${DIR} 12 v1 depth
Rscript higgs_lgb.R ${DIR} 12 v1 hessian
Rscript higgs_lgb.R ${DIR} 12 v1 sampling
Rscript higgs_lgb.R ${DIR} 6 v1 leaves
Rscript higgs_lgb.R ${DIR} 6 v1 depth
Rscript higgs_lgb.R ${DIR} 6 v1 hessian
Rscript higgs_lgb.R ${DIR} 6 v1 sampling
Rscript higgs_lgb.R ${DIR} 1 v1 leaves
Rscript higgs_lgb.R ${DIR} 1 v1 depth
Rscript higgs_lgb.R ${DIR} 1 v1 hessian
Rscript higgs_lgb.R ${DIR} 1 v1 sampling
