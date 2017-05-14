DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
echo "Running in directory: ${DIR}"

Rscript ../creator/bosch_xgb_gen.R ${DIR}
Rscript ../creator/higgs_xgb_gen.R ${DIR}
