DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
echo "Running in directory: ${DIR}"

./bosch_lgb_v1-O3-fmath.sh
./bosch_lgb_v1-O3-fmath_slow.sh
