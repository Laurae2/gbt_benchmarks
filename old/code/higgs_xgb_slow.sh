DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
echo "Running in directory: ${DIR}"

Rscript higgs_xgb.R ${DIR} 5 lossguide leaves
Rscript higgs_xgb.R ${DIR} 5 lossguide depth
Rscript higgs_xgb.R ${DIR} 5 lossguide hessian
Rscript higgs_xgb.R ${DIR} 5 lossguide sampling
Rscript higgs_xgb.R ${DIR} 5 depthwise depth
Rscript higgs_xgb.R ${DIR} 5 depthwise hessian
Rscript higgs_xgb.R ${DIR} 5 depthwise sampling
Rscript higgs_xgb.R ${DIR} 4 lossguide leaves
Rscript higgs_xgb.R ${DIR} 4 lossguide depth
Rscript higgs_xgb.R ${DIR} 4 lossguide hessian
Rscript higgs_xgb.R ${DIR} 4 lossguide sampling
Rscript higgs_xgb.R ${DIR} 4 depthwise depth
Rscript higgs_xgb.R ${DIR} 4 depthwise hessian
Rscript higgs_xgb.R ${DIR} 4 depthwise sampling
Rscript higgs_xgb.R ${DIR} 3 lossguide leaves
Rscript higgs_xgb.R ${DIR} 3 lossguide depth
Rscript higgs_xgb.R ${DIR} 3 lossguide hessian
Rscript higgs_xgb.R ${DIR} 3 lossguide sampling
Rscript higgs_xgb.R ${DIR} 3 depthwise depth
Rscript higgs_xgb.R ${DIR} 3 depthwise hessian
Rscript higgs_xgb.R ${DIR} 3 depthwise sampling
Rscript higgs_xgb.R ${DIR} 2 lossguide leaves
Rscript higgs_xgb.R ${DIR} 2 lossguide depth
Rscript higgs_xgb.R ${DIR} 2 lossguide hessian
Rscript higgs_xgb.R ${DIR} 2 lossguide sampling
Rscript higgs_xgb.R ${DIR} 2 depthwise depth
Rscript higgs_xgb.R ${DIR} 2 depthwise hessian
Rscript higgs_xgb.R ${DIR} 2 depthwise sampling
