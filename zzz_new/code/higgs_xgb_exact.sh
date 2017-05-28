DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
echo "Running in directory: ${DIR}"

Rscript higgs_xgb.R ${DIR} 8 exact depth release
Rscript higgs_xgb.R ${DIR} 8 exact hessian release
Rscript higgs_xgb.R ${DIR} 8 exact sampling release
Rscript higgs_xgb.R ${DIR} 4 exact depth release
Rscript higgs_xgb.R ${DIR} 4 exact hessian release
Rscript higgs_xgb.R ${DIR} 4 exact sampling release
