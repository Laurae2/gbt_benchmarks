DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
echo "Running in directory: ${DIR}"

Rscript ../creator/bosch_lgb_gen.R ${DIR} "v2-Os"
Rscript bosch_lgb.R ${DIR} 12 "v2-Os" depth
Rscript bosch_lgb.R ${DIR} 6 "v2-Os" depth
Rscript bosch_lgb.R ${DIR} 5 "v2-Os" depth
Rscript bosch_lgb.R ${DIR} 4 "v2-Os" depth
Rscript bosch_lgb.R ${DIR} 3 "v2-Os" depth
Rscript bosch_lgb.R ${DIR} 2 "v2-Os" depth
Rscript bosch_lgb.R ${DIR} 1 "v2-Os" depth
