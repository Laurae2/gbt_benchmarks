DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
echo "Running in directory: ${DIR}"

../creator/bosch_setup.R ${DIR}
../creator/higgs_setup.R ${DIR}
