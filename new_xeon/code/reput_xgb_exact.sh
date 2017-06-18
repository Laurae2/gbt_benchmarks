DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
echo "Running in directory: ${DIR}"

Rscript reput_xgb2.R ${DIR} 40 exact depth release
Rscript reput_xgb2.R ${DIR} 40 exact hessian release
Rscript reput_xgb2.R ${DIR} 40 exact sampling release
Rscript reput_xgb2.R ${DIR} 20 exact depth release
Rscript reput_xgb2.R ${DIR} 20 exact hessian release
Rscript reput_xgb2.R ${DIR} 20 exact sampling release
