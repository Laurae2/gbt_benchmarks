DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
echo "Running in directory: ${DIR}"

Rscript reput_lgb.R ${DIR} 8 na leaves release
Rscript reput_lgb.R ${DIR} 8 na depth release
Rscript reput_lgb.R ${DIR} 8 na hessian release
Rscript reput_lgb.R ${DIR} 8 na sampling release
Rscript reput_lgb.R ${DIR} 4 na leaves release
Rscript reput_lgb.R ${DIR} 4 na depth release
Rscript reput_lgb.R ${DIR} 4 na hessian release
Rscript reput_lgb.R ${DIR} 4 na sampling release
