DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
echo "Running in directory: ${DIR}"

Rscript ../creator/higgs_xgb_gen.R ${DIR}
Rscript higgs_xgb.R ${DIR} 40 lossguide leaves
Rscript higgs_xgb.R ${DIR} 40 lossguide depth
Rscript higgs_xgb.R ${DIR} 40 lossguide hessian
Rscript higgs_xgb.R ${DIR} 40 lossguide sampling
Rscript higgs_xgb.R ${DIR} 40 depthwise depth
Rscript higgs_xgb.R ${DIR} 40 depthwise hessian
Rscript higgs_xgb.R ${DIR} 40 depthwise sampling
Rscript higgs_xgb.R ${DIR} 20 lossguide leaves
Rscript higgs_xgb.R ${DIR} 20 lossguide depth
Rscript higgs_xgb.R ${DIR} 20 lossguide hessian
Rscript higgs_xgb.R ${DIR} 20 lossguide sampling
Rscript higgs_xgb.R ${DIR} 20 depthwise depth
Rscript higgs_xgb.R ${DIR} 20 depthwise hessian
Rscript higgs_xgb.R ${DIR} 20 depthwise sampling
