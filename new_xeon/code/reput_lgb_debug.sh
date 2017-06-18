DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
echo "Running in directory: ${DIR}"

Rscript reput_lgb.R ${DIR} 4 na leaves debug
Rscript reput_lgb.R ${DIR} 4 na depth debug
Rscript reput_lgb.R ${DIR} 4 na hessian debug
Rscript reput_lgb.R ${DIR} 4 na sampling debug
