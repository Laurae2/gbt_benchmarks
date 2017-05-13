DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
echo "Running in directory: ${DIR}"

Rscript ../creator/higgs_lgb_gen.R ${DIR} "v2"
Rscript higgs_lgb.R ${DIR} 40 v2 leaves
Rscript higgs_lgb.R ${DIR} 40 v2 depth
Rscript higgs_lgb.R ${DIR} 40 v2 hessian
Rscript higgs_lgb.R ${DIR} 40 v2 sampling
Rscript higgs_lgb.R ${DIR} 20 v2 leaves
Rscript higgs_lgb.R ${DIR} 20 v2 depth
Rscript higgs_lgb.R ${DIR} 20 v2 hessian
Rscript higgs_lgb.R ${DIR} 20 v2 sampling
