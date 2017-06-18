# Gradient Boosted Trees Massive Benchmarking

This benchmarks xgboost (`@ccccf8a`) and LightGBM (`@a8673bd`) using R on the following constraints:

- Server 1: Intel i7-7700K 4c/8t (4s/2c/1t KVM topology) 4.5/4.4GHz + 64GB RAM 1600MHz (1, 2, 3, 4, 5, 6, 7, 8 threads) constrained to 54GB RAM + 128GB swap on RAID 0 2Gbps NVMe drives
- Server 2: Dual Quanta Freedom Ivy Bridge 20c/40t (2s/10c/2t KVM topology) 3.3/2.7GHz + 96GB RAM 1600MHz (1, 2, 3, 4, 5, 10, 20, 40 threads) constrained to 80GB RAM + 128GB swap on RAID 0 2Gbps NVMe drives
- Windows Server 2012 R2 virtualized with KVM
- R 3.4 compiled with MinGW 7.1 under Haswell architecture
- MinGW 7.1
- xgboost compiled with `-O2 -mtune=core2` like a default R user would do (multiply timings by 0.90 to get approximately `-O3` results)
- LightGBM compiled with Visual Studio for generic CPUs (no tuning applied for CPUs)
- Bosch (customized) dataset is used for testing pure speed on high dimensional small (1,000,000 x 970) 90% sparse data and hard-to-detect relationships
- Higgs (customized) dataset is used for testing pure speed on low dimensional (10,000,000 x 30) dense data and synthetic data (easy-to-detect relationships)
- Reput (customized) dataset is used for testing pure speed on "big data" (2,250,000 x 23,636) 95% sparse data with approximately 97% to 99.7% noise for feature signals (100-1000 signals per feature for 31,948 noise)

Versions to install:

* xgboost: manual installation of commit `dmlc/xgboost@ccccf8a` (Pull Request 2244, May 02 2017) or `devtools::install_github("Laurae2/ez_xgb/R-package@2017-05-02-v2", force = TRUE)`

* LightGBM: check "LightGBM setup" part.

In addition, the installation of xgboost/LightGBM must be performed manually. We are not providing "auto-building" setups of the packages for the following reasons:

* GitHub sometimes do not work for a small time, where you get a timeout error in R for `install_github`
* R does not rebuild from local folders if it has already created the binaries (you need to cleanup the mess yourself before)

Therefore, if you intend to use network compilation, make sure to clear all the binaries before reinstalling xgboost in R: you may re-use previous binaries instead of new binaries. In addition, Rscript wants to use the global package folder (like `C:\Program Files` in Windows), not the local package folder (like `C:\Users\Laurae\Documents\R` in Windows).

Dataset downloads:

* Bosch dataset: `train_numeric.csv` (to rename as `bosch_data.csv`) from Kaggle: https://www.kaggle.com/c/bosch-production-line-performance/data
* Higgs dataset: `HIGGS.csv` (to rename as `higgs_data.csv` from UCI Machine Learning Repository: https://archive.ics.uci.edu/ml/datasets/HIGGS
* Reput dataset: `url_svmlight` (to extract in folder `data/reput`) from UC San Diego / ICML-09: http://www.sysnet.ucsd.edu/projects/url/
* Alternative download for Reput dataset: url_svmlight UCI Machine Learning Repository: http://archive.ics.uci.edu/ml/datasets/URL+Reputation

Folder structure (with datasets) to have:

```
- code/
- creator/
- data/
------ reput/
---------- Day0.svm
---------- Day1.svm
---------- ...
---------- Day120.svm
---------- FeatureTypes
------ bosch_data.csv
------ higgs_data.csv
- lgb_na/
- summary/
- xgb_gbt_dw/
- xgb_gbt_ex/
- xgb_gbt_lg/
```

# Dataset Parameters

## Bosch

Estimated RAM needed: 40GB

Recommended RAM needed: 64GB

Reference times are provided for a stock i7-7700K when using 8 threads, and are very approximate (you may have wide differences).

Threads:
* i7-7700K: 1, 2, 3, 4, 5, 6, 7, 8 (exact: all)
* Dual Xeon: 1, 2, 3, 5, 10, 20, 40 (exact: 20, 40)

### Leaves test

Applies to:

* xgboost depthwise
* LightGBM

xgboost does not perform any run here.

| Run | Leaves | Depth | Hessian | Sampling | Iterations | Learning rate | Ref Time |
| --- | ---: | ---: | ---: | ---: | ---: | ---: | ---: |
| 1 | 7 | -1/0 | 1 | 1 | 2000 | 0.02 | 400s |
| 2 | 15 | -1/0 | 1 | 1 | 1500 | 0.02 | 375s |
| 3 | 31 | -1/0 | 1 | 1 | 1000 | 0.02 | 250s |
| 4 | 63 | -1/0 | 1 | 1 | 800 | 0.02 | 250s |
| 5 | 127 | -1/0 | 1 | 1 | 500 | 0.02 | 300s |
| 6 | 255 | -1/0 | 1 | 1 | 400 | 0.02 | 425s |
| 7 | 511 | -1/0 | 1 | 1 | 400 | 0.02 | 700s |
| 8 | 1023 | -1/0 | 1 | 1 | 400 | 0.02 | 1100s |
| 9 | 2047 | -1/0 | 1 | 1 | 400 | 0.02 | 1150s |
| 10 | 4095 | -1/0 | 1 | 1 | 400 | 0.02 | 1525s |

### Depth test

Applies to:

* xgboost depthwise
* xgboost lossguide
* LightGBM

xgboost exact performs only Run 1, 4, and 8.

| Run | Leaves | Depth | Hessian | Sampling | Iterations | Learning rate | Ref Time |
| --- | ---: | ---: | ---: | ---: | ---: | ---: | ---: |
| 1 | 7 | 3 | 1 | 1 | 2000 | 0.02 | 400s |
| 2 | 15 | 4 | 1 | 1 | 1500 | 0.02 | 350s |
| 3 | 31 | 5 | 1 | 1 | 1000 | 0.02 | 300s |
| 4 | 63 | 6 | 1 | 1 | 800 | 0.02 | 275s |
| 5 | 127 | 7 | 1 | 1 | 500 | 0.02 | 225s |
| 6 | 255 | 8 | 1 | 1 | 400 | 0.02 | 250s |
| 7 | 511 | 9 | 1 | 1 | 400 | 0.02 | 300s |
| 8 | 1023 | 10 | 1 | 1 | 400 | 0.02 | 375s |
| 9 | 2047 | 11 | 1 | 1 | 400 | 0.02 | 450s |
| 10 | 4095 | 12 | 1 | 1 | 400 | 0.02 | 550s |

### Pruning test

Applies to:

* xgboost depthwise
* xgboost lossguide
* LightGBM

xgboost exact performs only Run 1 and 3.

| Run | Leaves | Depth | Hessian | Sampling | Iterations | Learning rate | Ref Time |
| --- | ---: | ---: | ---: | ---: | ---: | ---: | ---: |
| 1 | 1023 | 10 | 1 | 1 | 400 | 0.02 | 375s |
| 2 | 1023 | 10 | 5 | 1 | 400 | 0.02 | 300s |
| 3 | 1023 | 10 | 25 | 1 | 400 | 0.02 | 225s |
| 4 | 1023 | 10 | 125 | 1 | 400 | 0.02 | 200s |

### Sampling test

Applies to:

* xgboost depthwise
* xgboost lossguide
* LightGBM

xgboost exact performs only Run 1 and 3.

| Run | Leaves | Depth | Hessian | Sampling | Iterations | Learning rate | Ref Time |
| --- | ---: | ---: | ---: | ---: | ---: | ---: | ---: |
| 1 | 63 | 6 | 1 | 1 | 400 | 0.04 | 375s |
| 2 | 63 | 6 | 1 | 0.8 | 400 | 0.04 | 300s |
| 3 | 63 | 6 | 1 | 0.6 | 400 | 0.04 | 225s |
| 4 | 63 | 6 | 1 | 0.4 | 400 | 0.04 | 200s |

## Higgs

Estimated RAM needed: 32GB

Recommended RAM needed: 64GB

Reference times are provided for a stock i7-7700K when using 8 threads, and are very approximate (you may have wide differences).

Threads:
* i7-7700K: 1, 2, 3, 4, 5, 6, 7, 8 (exact: 4, 8)
* Dual Xeon: 1, 2, 3, 5, 10, 20, 40 (exact: 20, 40)

### Leaves test

Applies to:

* xgboost depthwise
* LightGBM

xgboost does not perform any run here.

| Run | Leaves | Depth | Hessian | Sampling | Iterations | Learning rate | Ref Time |
| --- | ---: | ---: | ---: | ---: | ---: | ---: | ---: |
| 1 | 7 | -1/0 | 1 | 1 | 2000 | 0.25 | 725s |
| 2 | 15 | -1/0 | 1 | 1 | 1500 | 0.25 | 600s |
| 3 | 31 | -1/0 | 1 | 1 | 1000 | 0.25 | 500s |
| 4 | 63 | -1/0 | 1 | 1 | 500 | 0.25 | 300s |
| 5 | 127 | -1/0 | 1 | 1 | 400 | 0.25 | 300s |
| 6 | 255 | -1/0 | 1 | 1 | 350 | 0.25 | 300s |
| 7 | 511 | -1/0 | 1 | 1 | 300 | 0.25 | 325s |
| 8 | 1023 | -1/0 | 1 | 1 | 250 | 0.25 | 350s |
| 9 | 2047 | -1/0 | 1 | 1 | 200 | 0.25 | 400s |
| 10 | 4095 | -1/0 | 1 | 1 | 150 | 0.25 | 450s |

### Depth test

Applies to:

* xgboost depthwise
* xgboost lossguide
* LightGBM

xgboost exact performs only Run 1, 4, and 8.

| Run | Leaves | Depth | Hessian | Sampling | Iterations | Learning rate | Ref Time |
| --- | ---: | ---: | ---: | ---: | ---: | ---: | ---: |
| 1 | 7 | 3 | 1 | 1 | 2000 | 0.25 | 825s |
| 2 | 15 | 4 | 1 | 1 | 1500 | 0.25 | 775s |
| 3 | 31 | 5 | 1 | 1 | 1000 | 0.25 | 650s |
| 4 | 63 | 6 | 1 | 1 | 500 | 0.25 | 400s |
| 5 | 127 | 7 | 1 | 1 | 400 | 0.25 | 400s |
| 6 | 255 | 8 | 1 | 1 | 350 | 0.25 | 400s |
| 7 | 511 | 9 | 1 | 1 | 300 | 0.25 | 425s |
| 8 | 1023 | 10 | 1 | 1 | 250 | 0.25 | 425s |
| 9 | 2047 | 11 | 1 | 1 | 200 | 0.25 | 425s |
| 10 | 4095 | 12 | 1 | 1 | 150 | 0.25 | 425s |

### Pruning test

Applies to:

* xgboost depthwise
* xgboost lossguide
* LightGBM

xgboost exact performs only Run 1 and 3.

| Run | Leaves | Depth | Hessian | Sampling | Iterations | Learning rate | Ref Time |
| --- | ---: | ---: | ---: | ---: | ---: | ---: | ---: |
| 1 | 1023 | 10 | 1 | 1 | 400 | 0.25 | 350s |
| 2 | 1023 | 10 | 5 | 1 | 400 | 0.25 | 350s |
| 3 | 1023 | 10 | 25 | 1 | 400 | 0.25 | 325s |
| 4 | 1023 | 10 | 125 | 1 | 400 | 0.25 | 325s |

### Sampling test

Applies to:

* xgboost depthwise
* xgboost lossguide
* LightGBM

xgboost exact performs only Run 1 and 3.

| Run | Leaves | Depth | Hessian | Sampling | Iterations | Learning rate | Ref Time |
| --- | ---: | ---: | ---: | ---: | ---: | ---: | ---: |
| 1 | 63 | 6 | 1 | 1 | 400 | 0.25 | 325s |
| 2 | 63 | 6 | 1 | 0.8 | 400 | 0.25 | 450s |
| 3 | 63 | 6 | 1 | 0.6 | 400 | 0.25 | 400s |
| 4 | 63 | 6 | 1 | 0.4 | 400 | 0.25 | 350s |

## Reput

Estimated RAM needed: 64GB

Recommended RAM needed: 96GB

Reference times are provided for a stock i7-7700K when using 8 threads, and are very approximate (you may have wide differences).

Threads:
* i7-7700K: 4, 8 (exact: 4, 8)
* Dual Xeon: 20, 40 (exact: 20, 40)

### Leaves test

Applies to:

* xgboost depthwise
* LightGBM

xgboost does not perform any run here.

| Run | Leaves | Depth | Hessian | Sampling | Iterations | Learning rate | Ref Time |
| --- | ---: | ---: | ---: | ---: | ---: | ---: | ---: |
| 1 | 7 | -1/0 | 1 | 1 | 2000 | 0.25 | 13000s |
| 2 | 15 | -1/0 | 1 | 1 | 1250 | 0.25 | 9000s |
| 3 | 31 | -1/0 | 1 | 1 | 1100 | 0.25 | 9000s |
| 4 | 63 | -1/0 | 1 | 1 | 1000 | 0.25 | 5000s |
| 5 | 127 | -1/0 | 1 | 1 | 900 | 0.25 | 4000s |

### Depth test

Applies to:

* xgboost depthwise
* xgboost lossguide
* LightGBM

xgboost exact performs only Run 1 and 4.

| Run | Leaves | Depth | Hessian | Sampling | Iterations | Learning rate | Ref Time |
| --- | ---: | ---: | ---: | ---: | ---: | ---: | ---: |
| 1 | 7 | 3 | 1 | 1 | 2000 | 0.25 | 13000s |
| 2 | 15 | 4 | 1 | 1 | 1250 | 0.25 | 9000s |
| 3 | 31 | 5 | 1 | 1 | 1100 | 0.25 | 9000s |
| 4 | 63 | 6 | 1 | 1 | 1000 | 0.25 | 9500s |
| 5 | 127 | 7 | 1 | 1 | 900 | 0.25 | 10500s |

### Pruning test

Applies to:

* xgboost depthwise
* xgboost lossguide
* LightGBM

xgboost exact performs only Run 1 and 3.

| Run | Leaves | Depth | Hessian | Sampling | Iterations | Learning rate | Ref Time |
| --- | ---: | ---: | ---: | ---: | ---: | ---: | ---: |
| 1 | 63 | 6 | 1 | 1 | 700 | 0.25 | 10000s |
| 2 | 63 | 6 | 5 | 1 | 700 | 0.25 | 9500s |
| 3 | 63 | 6 | 25 | 1 | 700 | 0.25 | 8500s |
| 4 | 63 | 6 | 125 | 1 | 700 | 0.25 | 9000s |

### Sampling test

Applies to:

* xgboost depthwise
* xgboost lossguide
* LightGBM

xgboost exact performs only Run 1 and 3.

| Run | Leaves | Depth | Hessian | Sampling | Iterations | Learning rate | Ref Time |
| --- | ---: | ---: | ---: | ---: | ---: | ---: | ---: |
| 1 | 63 | 6 | 1 | 1 | 1000 | 0.25 | 10000s |
| 2 | 63 | 6 | 1 | 0.8 | 1000 | 0.25 | 9000s |
| 3 | 63 | 6 | 1 | 0.6 | 1000 | 0.25 | 7500s |
| 4 | 63 | 6 | 1 | 0.4 | 1000 | 0.25 | 6500s |

# Instruction Usage

Everything must be run from `./code/` folder unless said otherwise.

---

## Dataset Creation

**Dataset parsing:**

This will setup core datasets for Bosch, Higgs, and Reput, assuming they were downloaded in `../data`.

```bash
./all_setup.sh
```

When `reput` dataset is being parsed/engineered, you have a small popup showing an estimated ETA. There are two of them to go through before the dataset is considered created.

It takes approximately 40 minutes to do this step. If a dataset is not available, the script for that dataset will error-out but will let other datasets be built.

---

**Check if everything can work:**

Expect the test to take about 1 hour.

**Warning 1: BEFORE RUNNING THIS: INSTALL xgboost AND LightGBM. SEE THEIR RESPECTIVE PARTS FOR INSTALLATION STEPS.**

**Warning 2: The xgb/lgb binary dataset creators are disabled for the reput dataset. `reput_xgb_gen` will FREEZE. Training will FREEZE with binary dataset. If you are crazy enough, yuo can try creating the file `reput_train_xgb.data` of size 1.35GB (1,455,738,880 bytes). By default, it will create only RDS files for train/test (you will have to modify the creator files if you want the binary datasets).**

You can check if you can make it work using this:

```bash
./all_debug.sh
```

Make sure you have the following folders where you have `code`, `creator`, `data`, and `summary`:

* lgb_na
* xgb_gbt_dw
* xgb_gbt_ex
* xgb_gbt_lg

After debug worked successfully, get rid of the content inside:

* lgb_na
* summary
* xgb_gbt_dw
* xgb_gbt_ex
* xgb_gbt_lg

Get also rid of anything which is not `.csv` and `.rds` inside `data`.

---

## xgboost setup

**xgboost Compilation:**

Verify if in `R_HOME/etc/x64/Makeconf` that you have:

```bash
DLLFLAGS+= -static-libgcc
CFLAGS = -O2 -Wall $(DEBUGFLAG) -std=gnu99 -mtune=core2
CXX11FLAGS = -O2 -Wall $(DEBUGFLAG) -mtune=core2
```

R installation:

```r
devtools::install_github("Laurae2/ez_xgb/R-package@2017-05-02-v2", force = TRUE)
```

---

**xgboost Benchmarking:**

Run the setup to create datasets:

```bash
./all_xgb_setup.sh
```

Choose between Bosch, Higgs, and Reput, or all three:

```bash
./all_xgb.sh
./bosch_xgb.sh
./higgs_xgb.sh
./reput_xgb.sh
```

---

## LightGBM setup

**LightGBM Compilation:**

You must compile the DLL beforehand with the appropriate LightGBM commit. Feel free to use whatever method you use to build the DLL. If you cannot compile the DLL, a precompiled DLL is provided for research purposes, which is the DLL used for this research.

Get LightGBM repository from GitHub:

```sh
git clone --recursive https://github.com/Microsoft/LightGBM
cd LightGBM
git checkout a8673bd
```

You should have the following message: `HEAD is now at a8673bd... LightGBM Slack team is available. (#606)`

You will in any case need `git` in PATH environment variable. It might look like this:

```
c:\Rtools\mingw_64\bin;c:\Rtools\bin;C:\Program Files\R\R-3.4.0\bin\x64;C:\ProgramData\Oracle\Java\javapath;C:\Program Files\Git\bin;%SystemRoot%\system32;%SystemRoot%;%SystemRoot%\System32\Wbem;%SYSTEMROOT%\System32\WindowsPowerShell\v1.0\
```

Then in R:

```r
devtools::install_github("Laurae2/lgbdl")
lgbdl::lgb.dl(commit = "a8673bd",
              libdll = "E:\\benchmark_lot\\lib_lightgbm.dll", # YOUR PRECOMPILED DLL PATH
              repo = "https://github.com/Microsoft/LightGBM")
```

If you are getting "The program can't start because MSVCP140.dll is missing from your computer.", then install [Microsoft Visual C++ Redistributable for Visual Studio 2017](https://www.visualstudio.com/downloads/#build-tools-for-visual-studio-2017), and recompile the LightGBM package.

Also, make sure you are installing LightGBM in the right folder. You can check by running this in an interactive R console:

```r
> .libPaths()
[1] "C:/Program Files/R/R-3.4.0/library"
```

If it is not the case, modify `C:\Program Files\R\R-3.4.0\library\etc\Rprofile.site` by adding `.libPaths(.libPaths()[2])` (this will get rid of the local directory - select the appropriate one if needed).

---

**LightGBM Benchmarking:**

Run the setup to create datasets:

```bash
./all_lgb_setup.sh
```

Choose between Bosch, Higgs, and Reput, or all three:

```bash
./all_lgb.sh
./bosch_lgb.sh
./higgs_lgb.sh
./reput_lgb.sh
```

---