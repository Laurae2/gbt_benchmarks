DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
echo "Running in directory: ${DIR}"

Rscript higgs_lgb.R ${DIR} 4 na leaves debug
Rscript higgs_lgb.R ${DIR} 4 na depth debug
Rscript higgs_lgb.R ${DIR} 4 na hessian debug
Rscript higgs_lgb.R ${DIR} 4 na sampling debug
