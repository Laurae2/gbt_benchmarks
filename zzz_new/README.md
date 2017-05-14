# Gradient Boosted Trees Massive Benchmarking

This benchmarks xgboost (`v0.60@b4d97d3`, `v0.60@3b9b573`) and LightGBM (`v1`, `v2@1bf7bbd`, with different compilation flags) using R on the following constraints:

- Server 1: Intel i7-7700K 4c/8t (4s/2c/1t KVM topology) 5.0/4.8GHz + 64GB RAM 1600MHz (1, 2, 3, 4, 5, 6, 7, 8 threads)
- Server 2: Dual Quanta Freedom Ivy Bridge 20c/40t (2s/10c/2t KVM topology) 3.3/2.7GHz + 96GB RAM 1600MHz (1, 2, 3, 4, 5, 10, 20, 40 threads)
- Windows Server 2012 R2 virtualized with KVM
- R 3.4 compiled with MinGW 7.1 under Haswell architecture
- MinGW 7.1
- xgboost compiled with `-O3 -mtune=native`
- LightGBM compiled with `-O3 -mtune=native`
- Bosch (customized) dataset is used for testing pure speed on high dimensional small (1,000,000 x 970) sparse data and hard-to-detect relationships
- Higgs (customized) dataset is used for testing pure speed on low dimensional (10,000,000 x 30) dense data and synthetic data (easy-to-detect relationships)

Versions to install:

* xgboost: manual installation of commit `dmlc/xgboost@ccccf8a` (Pull Request 2244, May 02 2017) or `devtools::install_github("Laurae2/ez_xgb/R-package@2017-05-02-v2", force = TRUE)`

* LightGBM: `devtools::install_github("Microsoft/LightGBM@ea6bc0a", subdir = "R-package", force = TRUE)`

In addition, the installation of xgboost/LightGBM must be performed manually. We are not providing "auto-building" setups of the packages for the following reasons:

* GitHub sometimes do not work for a small time, where you get a timeout error in R for `install_github`
* R does not rebuild from local folders if it has already created the binaries (you need to cleanup the mess yourself before)

Therefore, if you intend to use local compilation (which is literally mandatory for xgboost), make sure to clear all the binaries before reinstalling xgboost in R: you may re-use previous binaries instead of new binaries.

# Instruction Usage

Everything must be run from `./code/` folder unless said otherwise.

---

**Dataset Creation:**

This will setup core datasets for Bosch and Higgs, assuming they were downloaded in `../data`.

```bash
./all_setup.sh
```

---

**Check if everything can work:**

Expect the test to take about 30 minutes.

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

**xgboost Compilation:**

Verify if in `R_HOME/etc/x64/Makeconf` that you have:

```bash
DLLFLAGS+= -static-libgcc
CFLAGS = -O3 -Wall $(DEBUGFLAG) -std=gnu99 -funroll-loops -march=native
CXX11FLAGS = -O3 -Wall $(DEBUGFLAG) -funroll-loops -march=native
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

Choose between Bosch and Higgs, or both:

```bash
./all_xgb.sh
./bosch_xgb.sh
./higgs_xgb.sh
```

---

**LightGBM Compilation:**

Verify if in `R_HOME/etc/x64/Makeconf` that you have:

```bash
DLLFLAGS+= -static-libgcc
CFLAGS = -O3 -Wall $(DEBUGFLAG) -std=gnu99 -funroll-loops -march=native
CXX11FLAGS = -O3 -Wall $(DEBUGFLAG) -funroll-loops -march=native
```

If not, adjust.

R:

```r
devtools::install_github("Microsoft/LightGBM@ea6bc0a", subdir = "R-package", force = TRUE)
```

---

**LightGBM Benchmarking:**

Run the setup to create datasets:

```bash
./all_lgb_setup.sh
```

Choose between Bosch and Higgs, or both:

```bash
./all_lgb.sh
./bosch_lgb.sh
./higgs_lgb.sh
```

---