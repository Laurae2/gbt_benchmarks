DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
echo "Running in directory: ${DIR}"

Rscript higgs_xgb.R ${DIR} 40 exact depth release
Rscript higgs_xgb.R ${DIR} 40 exact hessian release
Rscript higgs_xgb.R ${DIR} 40 exact sampling release
Rscript higgs_xgb.R ${DIR} 20 exact depth release
Rscript higgs_xgb.R ${DIR} 20 exact hessian release
Rscript higgs_xgb.R ${DIR} 20 exact sampling release
