DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
echo "Running in directory: ${DIR}"

Rscript ../creator/bosch_setup.R ${DIR}
Rscript ../creator/higgs_setup.R ${DIR}
Rscript ../creator/reput_setup1.R ${DIR}
Rscript ../creator/reput_setup2.R ${DIR}
Rscript ../creator/reput_setup3.R ${DIR}
