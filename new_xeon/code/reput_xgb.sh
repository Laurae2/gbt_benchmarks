DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
echo "Running in directory: ${DIR}"

Rscript reput_xgb.R ${DIR} 10 lossguide leaves release
Rscript reput_xgb.R ${DIR} 10 lossguide depth release
Rscript reput_xgb.R ${DIR} 10 lossguide hessian release
Rscript reput_xgb.R ${DIR} 10 lossguide sampling release
Rscript reput_xgb.R ${DIR} 10 depthwise depth release
Rscript reput_xgb.R ${DIR} 10 depthwise hessian release
Rscript reput_xgb.R ${DIR} 10 depthwise sampling release
Rscript reput_xgb.R ${DIR} 5 lossguide leaves release
Rscript reput_xgb.R ${DIR} 5 lossguide depth release
Rscript reput_xgb.R ${DIR} 5 lossguide hessian release
Rscript reput_xgb.R ${DIR} 5 lossguide sampling release
Rscript reput_xgb.R ${DIR} 5 depthwise depth release
Rscript reput_xgb.R ${DIR} 5 depthwise hessian release
Rscript reput_xgb.R ${DIR} 5 depthwise sampling release
