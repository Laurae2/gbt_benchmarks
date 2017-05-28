DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
echo "Running in directory: ${DIR}"

Rscript reput_xgb.R ${DIR} 8 lossguide leaves release
Rscript reput_xgb.R ${DIR} 8 lossguide depth release
Rscript reput_xgb.R ${DIR} 8 lossguide hessian release
Rscript reput_xgb.R ${DIR} 8 lossguide sampling release
Rscript reput_xgb.R ${DIR} 8 depthwise depth release
Rscript reput_xgb.R ${DIR} 8 depthwise hessian release
Rscript reput_xgb.R ${DIR} 8 depthwise sampling release
Rscript reput_xgb.R ${DIR} 4 lossguide leaves release
Rscript reput_xgb.R ${DIR} 4 lossguide depth release
Rscript reput_xgb.R ${DIR} 4 lossguide hessian release
Rscript reput_xgb.R ${DIR} 4 lossguide sampling release
Rscript reput_xgb.R ${DIR} 4 depthwise depth release
Rscript reput_xgb.R ${DIR} 4 depthwise hessian release
Rscript reput_xgb.R ${DIR} 4 depthwise sampling release
