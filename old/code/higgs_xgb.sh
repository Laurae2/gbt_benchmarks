DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
echo "Running in directory: ${DIR}"

Rscript ../creator/higgs_xgb_gen.R ${DIR}
Rscript higgs_xgb.R ${DIR} 12 lossguide leaves
Rscript higgs_xgb.R ${DIR} 12 lossguide depth
Rscript higgs_xgb.R ${DIR} 12 lossguide hessian
Rscript higgs_xgb.R ${DIR} 12 lossguide sampling
Rscript higgs_xgb.R ${DIR} 12 depthwise depth
Rscript higgs_xgb.R ${DIR} 12 depthwise hessian
Rscript higgs_xgb.R ${DIR} 12 depthwise sampling
Rscript higgs_xgb.R ${DIR} 6 lossguide leaves
Rscript higgs_xgb.R ${DIR} 6 lossguide depth
Rscript higgs_xgb.R ${DIR} 6 lossguide hessian
Rscript higgs_xgb.R ${DIR} 6 lossguide sampling
Rscript higgs_xgb.R ${DIR} 6 depthwise depth
Rscript higgs_xgb.R ${DIR} 6 depthwise hessian
Rscript higgs_xgb.R ${DIR} 6 depthwise sampling
Rscript higgs_xgb.R ${DIR} 1 lossguide leaves
Rscript higgs_xgb.R ${DIR} 1 lossguide depth
Rscript higgs_xgb.R ${DIR} 1 lossguide hessian
Rscript higgs_xgb.R ${DIR} 1 lossguide sampling
Rscript higgs_xgb.R ${DIR} 1 depthwise depth
Rscript higgs_xgb.R ${DIR} 1 depthwise hessian
Rscript higgs_xgb.R ${DIR} 1 depthwise sampling
