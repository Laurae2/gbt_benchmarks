DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
echo "Running in directory: ${DIR}"

Rscript reput_lgb.R ${DIR} 40 na leaves release
Rscript reput_lgb.R ${DIR} 40 na depth release
Rscript reput_lgb.R ${DIR} 40 na hessian release
Rscript reput_lgb.R ${DIR} 40 na sampling release
Rscript reput_lgb.R ${DIR} 20 na leaves release
Rscript reput_lgb.R ${DIR} 20 na depth release
Rscript reput_lgb.R ${DIR} 20 na hessian release
Rscript reput_lgb.R ${DIR} 20 na sampling release
