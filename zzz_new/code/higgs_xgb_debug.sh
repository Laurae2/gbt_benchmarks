DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
echo "Running in directory: ${DIR}"

Rscript higgs_xgb.R ${DIR} 4 lossguide leaves debug
Rscript higgs_xgb.R ${DIR} 4 lossguide depth debug
Rscript higgs_xgb.R ${DIR} 4 lossguide hessian debug
Rscript higgs_xgb.R ${DIR} 4 lossguide sampling debug
Rscript higgs_xgb.R ${DIR} 4 depthwise depth debug
Rscript higgs_xgb.R ${DIR} 4 depthwise hessian debug
Rscript higgs_xgb.R ${DIR} 4 depthwise sampling debug
Rscript higgs_xgb.R ${DIR} 4 exact depth debug
Rscript higgs_xgb.R ${DIR} 4 exact hessian debug
Rscript higgs_xgb.R ${DIR} 4 exact sampling debug
