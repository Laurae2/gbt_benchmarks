# Gradient Boosted Trees Massive Benchmarking

Notebook with graphics and benchmark data load: https://htmlpreview.github.io/?https://github.com/Laurae2/gbt_benchmarks/blob/master/data_analysis.nb.html

---

This benchmarks xgboost (`v0.60@b4d97d3`, `v0.60@3b9b573`) and LightGBM (`v1@ea6bc0a`, `v2@1bf7bbd`, with different compilation flags) using R on the following constraints:

- 1, 2, 3, 4, 5, 6, 12 threads: Intel i7-3930K (6c/12t, 3.9/3.5GHz turbo) + 64GB RAM 1600MHz
- 20, 40 threads: Dual Quanta Freedom Ivy Bridge 2.3GHz (10c/20t, 3.1/2.7GHz turbo) + 80GB RAM 1600MHz
- Windows Server 2012 R2 virtualized using 12 (i7-3930K) or 40 (Dual Quanta Freedom) virtual sockets (will not work in Linux environments, you will need to do some script hacking to remove RAM monitoring)
- Microsoft R Client 3.3.2
- Rtools 3.4
- xgboost compiled with default flags after manual compilation
- LightGBM installed from GitHub using different flags
- Regular benchmark performs 12, 6, 1 threads performance check
- Slow benchmark performs 5, 4, 3, 2 threads performance check
- There is an overhead (approx 20%?) from the custom objective designed to check for performance and RAM during training
- Bosch (customized) dataset is used for testing pure speed on high dimensional small (1,000,000 x 970) sparse data and hard-to-detect relationships
- Higgs (customized) dataset is used for testing pure speed on low dimensional (10,000,000 x 30) dense data and synthetic data (easy-to-detect relationships)

xgboost was tested under the following flags:

* One run using default `exact` xgboost (`v0.60@b4d97d3`) using xgboost "default" compilation flags (`-O3 -funroll-loops -march=native`)
* For each other runs: lossguide and depthwise using `v0.60@b4d97d3`
* `-O2 -mtune=core2` (R's default flags ; benchmark)
* `-O3 -funroll-loops -march=native` (xgboost "default" compilation flags when compiled from source for .exe, xgboost uses `-msse2` instead of `-march=native`)
* `-O3 -funroll-loops -march=native -ffast-math` on compile and `-Wl,-O1 -O3 -Wl,-ffast-math` on linking

LightGBM was tested under the following flags:

* For each run: `v1@ea6bc0a` and `v2@1bf7bbd`
* `-O2 -mtune=core2` (R's default flags ; benchmark)
* `-O3 -march=native` on compile and `-Wl,-O1 -O3` on linking (native = sandybridge ; slower)
* `-O3 -march=native -ffast-math` on compile and `-Wl,-O1 -O3 -Wl,-ffast-math` on linking (native = sandybridge ; slightly)
* `-O2 -march=native` (native = sandybridge ; R's default flags with tuning for Sandy Bridge)
* `-Os` (optimized for size)
* `-O3 -march=native -ffast-math --param max-gcse-insertion-ratio=65535 --param max-inline-insns-single=16777215 --param max-inline-insns-auto=0 --param large-function-insns=65535 --param large-function-growth=65535 --param inline-unit-growth=65535 --param ipcp-unit-growth=65535` on compile and `-Wl,-O1 -O3 -march=native -Wl,-ffast-math --param max-gcse-insertion-ratio=65535 --param max-inline-insns-single=16777215 --param max-inline-insns-auto=0 --param large-function-insns=65535 --param large-function-growth=65535 --param inline-unit-growth=65535 --param ipcp-unit-growth=65535` on linking (native = sandybridge ; nuclear optimization settings but not performed yet)

Versions to install:

* xgboost: manual installation of commit `dmlc/xgboost@b4d97d3` (Pull Request 2045, Feb 20 2017) or `devtools::install_github("Laurae2/ez_xgb/R-package@2017-02-15-v1", force = TRUE)`

* xgboost-ex: manual installation of commit `dmlc/xgboost@3b9b573` (Pull Request 2161, Mar 31 2017) or `devtools::install_github("Laurae2/ez_xgb/R-package@2017-03-31-v2", force = TRUE)`

* LightGBM v1: `devtools::install_github("Microsoft/LightGBM@v1@ea6bc0a", subdir = "R-package", force = TRUE)`

* LightGBM v2: `devtools::install_github("Microsoft/LightGBM@1bf7bbd", subdir = "R-package", force = TRUE)`

* LightGBM v2 + Intel OpenCL: `devtools::install_github("Laurae2/LightGBM@7514fde", subdir = "R-package", force = TRUE)` (or make an installation using https://github.com/Microsoft/LightGBM/pull/448

LightGBM v1 and v2 are also tested on Bosch using `-O3 -Wl,-O1` and `-march=native` parameters, and with or without `-Wl,-ffast-math` parameter. To use them, you must modify R compilation flags for `CXX1XFLAGS` and `DLLFLAGS+=` (Windows) using `$R_HOME/etc/Makeconf` or `$R_HOME/etc/x64/Makeconf`. It will not work without this change because the most right compilation parameters have priority if they are declared in different forms. They are not tested against Higgs because it does not make sense to benchmark on a synthetic dataset (lossguide-style should always be better).

LightGBM requires also re-creating the datasets each time you are switching versions.

In addition, the installation of xgboost/LightGBM must be performed manually. We are not providing "auto-building" setups of the packages for the following reasons:

* GitHub sometimes do not work for a small time, where you get a timeout error in R for `install_github`
* R does not rebuild from local folders if it has already created the binaries (you need to cleanup the mess yourself before)

Therefore, if you intend to use local compilation (which is literally mandatory for xgboost), make sure to clear all the binaries before reinstalling xgboost in R: you risk re-using the same binaries which are not compiled using the same flags.

You may yourself add the auto-compilation for each script, and it is not hard: just a simple Rscript call along with `Makeconf` replacements.

The flag comparison tests should be run quickly using the fast test scripts, because you will notice quickly if there are any significant or sensible differences.

You may also give a shot to `--param max-gcse-insertion-ratio=65535 --param max-inline-insns-single=16777215 --param max-inline-insns-auto=0 --param large-function-insns=65535 --param large-function-growth=65535 --param inline-unit-growth=65535 --param ipcp-unit-growth=65535` parameters, but this is clearly not recommended for multithreading. We are denotating it as `extreme` in our benchmarks.

# Accuracy testing benchmark (LightGBM)

`-ffast-math` might cause numerical issues, as obviously it is optimization with relaxed constraint. This causes program-wide FPU control word issues when used on the linker compilation part without attaching to the linker. Check this topic for more: [gcc's bugzilla](https://gcc.gnu.org/bugzilla/show_bug.cgi?id=55522).

Each accuracy testing benchmark was done here by:

* Starting a fresh R session before compiling
* Starting a fresh R session before training a model

Model training script:

```r
library(lightgbm)
data(agaricus.train, package='lightgbm')
train <- agaricus.train
dtrain <- lgb.Dataset(train$data, label=train$label)
data(agaricus.test, package='lightgbm')
test <- agaricus.test
dtest <- lgb.Dataset.create.valid(dtrain, test$data, label=test$label)
params <- list(objective="regression", metric="l2")
valids <- list(test=dtest)
model <- lgb.train(params, dtrain, 10, valids, min_data=1, learning_rate=1, early_stopping_rounds=10)
```

All accuracy tests are passed successfully even with `-ffast-math` when compared to the default benchmark.

**Benchmark (default) behavior**:

* Linker: None
* Compile: None

```r
[1]:	test's l2:0.0271235
[2]:	test's l2:0.0147532
[3]:	test's l2:0.011826
[4]:	test's l2:0.00845716
[5]:	test's l2:0.00583288
[6]:	test's l2:0.00414783
[7]:	test's l2:0.00288979
[8]:	test's l2:0.00204831
[9]:	test's l2:0.00143532
[10]:	test's l2:0.0010155
```

**(Supposedly) Fastest behavior** (UNTESTED):

* Linker: -Wl,-ffast-math, -ffast-math
* Compile: -ffast-math

```r
[1]:	test's l2:0.0271235
[2]:	test's l2:0.0147532
[3]:	test's l2:0.011826
[4]:	test's l2:0.00845716
[5]:	test's l2:0.00583288
[6]:	test's l2:0.00414783
[7]:	test's l2:0.00288979
[8]:	test's l2:0.00204831
[9]:	test's l2:0.00143532
[10]:	test's l2:0.0010155
```

**(Supposedly) Extremely Fast behavior** (UNTESTED):

* Linker: -Wl,-ffast-math, -ffast-math
* Compile: -ffast-math

```r
Warning message:
In inDL(x, as.logical(local), as.logical(now), ...) :
  DLL attempted to change FPU control word from 8001f to 108001f
[1]:	test's l2:0.0271235
[2]:	test's l2:0.0147532
[3]:	test's l2:0.011826
[4]:	test's l2:0.00845716
[5]:	test's l2:0.00583288
[6]:	test's l2:0.00414783
[7]:	test's l2:0.00288979
[8]:	test's l2:0.00204831
[9]:	test's l2:0.00143532
[10]:	test's l2:0.0010155
```

**(Supposedly) Fast behavior**:

* Linker: -Wl,-ffast-math
* Compile: -fast-math

```r
[1]:	test's l2:0.0271235
[2]:	test's l2:0.0147532
[3]:	test's l2:0.011826
[4]:	test's l2:0.00845716
[5]:	test's l2:0.00583288
[6]:	test's l2:0.00414783
[7]:	test's l2:0.00288979
[8]:	test's l2:0.00204831
[9]:	test's l2:0.00143532
[10]:	test's l2:0.0010155
```

**(Supposedly) Fast behavior** (UNTESTED):

* Linker: -ffast-math
* Compile: -fast-math

```r
Warning message:
In inDL(x, as.logical(local), as.logical(now), ...) :
  DLL attempted to change FPU control word from 8001f to 108001f
[1]:	test's l2:0.0271235
[2]:	test's l2:0.0147532
[3]:	test's l2:0.011826
[4]:	test's l2:0.00845716
[5]:	test's l2:0.00583288
[6]:	test's l2:0.00414783
[7]:	test's l2:0.00288979
[8]:	test's l2:0.00204831
[9]:	test's l2:0.00143532
[10]:	test's l2:0.0010155
```

**(Supposedly) Fast behavior** (UNTESTED):

* Linker: None
* Compile: -fast-math

```r
[1]:	test's l2:0.0271235
[2]:	test's l2:0.0147532
[3]:	test's l2:0.011826
[4]:	test's l2:0.00845716
[5]:	test's l2:0.00583288
[6]:	test's l2:0.00414783
[7]:	test's l2:0.00288979
[8]:	test's l2:0.00204831
[9]:	test's l2:0.00143532
[10]:	test's l2:0.0010155
```

# Instruction Usage

Everything must be run from `./code/` folder unless said otherwise.

Each time, you have the choice between the files you want to run. Keep in mind the following:

* For complete testing (leaves, depth, hessian, sampling), use the non-`fast` files (`whatever.sh`, `whatever_slow.sh`)
* For quick testing (depth only), use the `fast` file (`whatever_fast.sh`)
* Sometimes (for xgboost exact), a `short` file is included (`whatever_short.sh`), so you can skip most runs for only keeping the very essentials (2 runs per depth, hessian, sampling)
* For testing a special CPU, use `extra` file (`whatever_extra.sh`)

---

**Dataset Creation:**

You will need to download the datasets first which will be put in `/data`:

* Bosch: https://www.kaggle.com/c/bosch-production-line-performance/data
* Higgs: https://archive.ics.uci.edu/ml/machine-learning-databases/00280/

This will setup core datasets for Bosch and Higgs, assuming they were downloaded in `../data`.

```bash
./all_setup.sh
```

---

**xgboost Exact-O3 Compilation:**

Verify if in `R_HOME/etc/x64/Makeconf` that you have:

```bash
DLLFLAGS+= -static-libgcc
CFLAGS = -O3 -Wall $(DEBUGFLAG) -std=gnu99 -funroll-loops -march=native
CXX1XFLAGS = -O3 -Wall $(DEBUGFLAG) -funroll-loops -march=native
```

R installation:

```r
devtools::install_github("Laurae2/ez_xgb/R-package@2017-02-15-v1", force = TRUE)
```

---

**xgboost Exact-O3 Bosch Benchmarking:**

Choose what to run:

* `bosch_xgb-def_fast.sh` (one single test): for Bosch, run xgboost with default flags on 12/6/5/4/3/2/1 threads on lossguide/depthwise: depth test
* `bosch_xgb-def.sh` (critical tests): for Bosch, run xgboost with default flags on 12/6/1 threads on lossguide/depthwise: leaves test (not available for depthwise), depth test, pruning test, sampling test
* `bosch_xgb-def_slow.sh` (thread tests to combine with the critical tests): for Bosch, run xgboost with default flags on 5/4/3/2 threads on lossguide/depthwise: leaves test (not available for depthwise), depth test, pruning test, sampling test

```bash
./bosch_xgb-def_fast.sh
./bosch_xgb-def.sh
./bosch_xgb-def_slow.sh
```

---

**xgboost Compilation:**

Verify if in `R_HOME/etc/x64/Makeconf` that you have:

```bash
DLLFLAGS+= -static-libgcc
CFLAGS = -O2 -Wall $(DEBUGFLAG) -std=gnu99 -mtune=core2
CXX1XFLAGS = -O2 -Wall $(DEBUGFLAG) -mtune=core2
```

R installation:

```r
devtools::install_github("Laurae2/ez_xgb/R-package@2017-02-15-v1", force = TRUE)
```

---

**xgboost Bosch Benchmarking:**

Choose what to run:

* `bosch_xgb_fast.sh` (one single test): for Bosch, run xgboost with default flags on 12/6/5/4/3/2/1 threads on lossguide/depthwise: depth test (not available for depthwise)
* `bosch_xgb.sh` (critical tests): for Bosch, run xgboost with default flags on 12/6/1 threads on lossguide/depthwise: leaves test (not available for depthwise), depth test, pruning test, sampling test
* `bosch_xgb_slow.sh` (thread tests to combine with the critical tests): for Bosch, run xgboost with default flags on 5/4/3/2 threads on lossguide/depthwise: leaves test (not available for depthwise), depth test, pruning test, sampling test
* `bosch_xgb_exact.sh` (specific for more threads): for Bosch, run xgboost with default flags on 40/20 threads on lossguide/depthwise: leaves test (not available for depthwise), depth test, pruning test, sampling test

```bash
./bosch_xgb_fast.sh
./bosch_xgb.sh
./bosch_xgb_slow.sh
./bosch_xgb_extra.sh
```

---

**xgboost Higgs Benchmarking:**

Choose what to run:

* `higgs_xgb_fast.sh` (one single test): for Higgs, run xgboost with default flags on 12/6/5/4/3/2/1 threads on lossguide/depthwise: depth test (not available for depthwise)
* `higgs_xgb.sh` (critical tests): for Higgs, run xgboost with default flags on 12/6/1 threads on lossguide/depthwise: leaves test (not available for depthwise), depth test, pruning test, sampling test
* `higgs_xgb_slow.sh` (thread tests to combine with the critical tests): for Higgs, run xgboost with default flags on 5/4/3/2 threads on lossguide/depthwise: leaves test (not available for depthwise), depth test, pruning test, sampling test
* `higgs_xgb_exact.sh` (specific for more threads): for Higgs, run xgboost with default flags on 40/20 threads on lossguide/depthwise: leaves test (not available for depthwise), depth test, pruning test, sampling test

```bash
./higgs_xgb_fast.sh
./higgs_xgb.sh
./higgs_xgb_slow.sh
./higgs_xgb_extra.sh
```

---

**xgboost O3 Compilation:**

Verify if in `R_HOME/etc/x64/Makeconf` that you have:

```bash
DLLFLAGS+= -static-libgcc
CFLAGS = -O3 -Wall $(DEBUGFLAG) -std=gnu99 -funroll-loops -march=native
CXX1XFLAGS = -O3 -Wall $(DEBUGFLAG) -funroll-loops -march=native
```

R installation:

```r
devtools::install_github("Laurae2/ez_xgb/R-package@2017-02-15-v1", force = TRUE)
```

---

**xgboost O3 Bosch Benchmarking:**

Choose what to run:

* `bosch_xgb-O3_fast.sh` (one single test): for Bosch, run xgboost with `-O3 -funroll-loops -march=native` flags on 12/6/5/4/3/2/1 threads on lossguide/depthwise: depth test (not available for depthwise)
* `bosch_xgb-O3.sh` (critical tests): for Bosch, run xgboost with `-O3 -funroll-loops -march=native` flags on 12/6/1 threads on lossguide/depthwise: leaves test (not available for depthwise), depth test, pruning test, sampling test
* `bosch_xgb-O3_slow.sh` (full thread tests to combine with the critical tests): for Bosch, run xgboost with `-O3 -funroll-loops -march=native` flags on 5/4/3/2 threads on lossguide/depthwise: leaves test (not available for depthwise), depth test, pruning test, sampling test
* `bosch_xgb-def-O3_short.sh` (full thread tests): for Bosch, run xgboost with `-O3 -funroll-loops -march=native` flags on 12/6/5/4/3/2/1 threads on exact: shortened depth test, shortened pruning test, shortened sampling test
* `bosch_xgb-def-O3_short_extra.sh` (full thread tests): for Bosch, run xgboost with `-O3 -funroll-loops -march=native` flags on 40/20 threads on exact: shortened depth test, shortened pruning test, shortened sampling test

```bash
./bosch_xgb-O3_fast.sh
./bosch_xgb-O3.sh
./bosch_xgb-O3_slow.sh
./bosch_xgb-def-O3_short.sh
./bosch_xgb-def-O3_short_extra.sh
```

---

**xgboost O3-fmath Compilation:**

Verify if in `R_HOME/etc/x64/Makeconf` that you have:

```bash
DLLFLAGS+= -static-libgcc -Wl,-O1 -O3 -Wl,-ffast-math
CFLAGS = -O3 -Wall $(DEBUGFLAG) -std=gnu99 -funroll-loops -march=native -ffast-math
CXX1XFLAGS = -O3 -Wall $(DEBUGFLAG) -funroll-loops -march=native -ffast-math
```

R installation:

```r
devtools::install_github("Laurae2/ez_xgb/R-package@2017-02-15-v1", force = TRUE)
```

---

**xgboost O3 Bosch Benchmarking:**

Choose what to run:

* `bosch_xgb-O3_fast.sh` (one single test): for Bosch, run xgboost with `-O3 -funroll-loops -march=native -ffast-math` flags on 12/6/5/4/3/2/1 threads on lossguide/depthwise: depth test (not available for depthwise)
* `bosch_xgb-O3.sh` (critical tests): for Bosch, run xgboost with `-O3 -funroll-loops -march=native -ffast-math` flags on 12/6/1 threads on lossguide/depthwise: leaves test (not available for depthwise), depth test, pruning test, sampling test
* `bosch_xgb-O3_slow.sh` (thread tests to combine with the critical tests): for Bosch, run xgboost with `-O3 -funroll-loops -march=native -ffast-math` flags on 5/4/3/2 threads on lossguide/depthwise: leaves test (not available for depthwise), depth test, pruning test, sampling test

```bash
./bosch_xgb-O3_fast.sh
./bosch_xgb-O3.sh
./bosch_xgb-O3_slow.sh
```

---

**LightGBM v1 Compilation:**

Verify if in `R_HOME/etc/x64/Makeconf` that you have:

```bash
DLLFLAGS+= -static-libgcc
CXX1XFLAGS = -O2 -Wall $(DEBUGFLAG) -mtune=core2
```

If not, adjust.

R:

```r
devtools::install_github("Microsoft/LightGBM@v1@ea6bc0a", subdir = "R-package", force = TRUE)
```

---

**LightGBM v1 Bosch Benchmarking:**

Choose what to run:

* `bosch_lgb_v1_fast.sh` (one single test): for Bosch, run LightGBM v1 with default flags on 12/6/5/4/3/2/1 threads: depth test
* `bosch_lgb_v1.sh` (critical tests): for Bosch, run LightGBM v1 with default flags on 12/6/1 threads: leaves test, depth test, pruning test, sampling test
* `bosch_lgb_v1_slow.sh` (thread tests to combine with the critical tests): for Bosch, run LightGBM v1 with default flags on 5/4/3/2 threads: leaves test, depth test, pruning test, sampling test
* `bosch_lgb_v1_exact.sh` (specific for more threads): for Bosch, run LightGBM v1 with default flags on 40/20 threads: leaves test, depth test, pruning test, sampling test

```
./bosch_lgb_v1_fast.sh
./bosch_lgb_v1.sh
./bosch_lgb_v1_slow.sh
./bosch_lgb_v1_extra.sh
```

---

**LightGBM v1 Higgs Benchmarking:**

* `higgs_lgb_v1_fast.sh` (one single test): for Higgs, run LightGBM v1 with default flags on 12/6/5/4/3/2/1 threads: depth test
* `higgs_lgb_v1.sh` (critical tests): for Higgs, run LightGBM v1 with default flags on 12/6/1 threads leaves test, depth test, pruning test, sampling test
* `higgs_lgb_v1_slow.sh` (thread tests to combine with the critical tests): for Higgs, run LightGBM v1 with default flags on 5/4/3/2 threads: leaves test, depth test, pruning test, sampling test
* `higgs_lgb_v1_exact.sh` (specific for more threads): for Higgs, run LightGBM v1 with default flags on 40/20 threads: leaves test, depth test, pruning test, sampling test

```bash
./higgs_lgb_v1_fast.sh
./higgs_lgb_v1.sh
./higgs_lgb_v1_slow.sh
./higgs_lgb_v1_extra.sh
```

---

**LightGBM v2 Compilation:**

Verify if in `R_HOME/etc/x64/Makeconf` that you have:

```bash
DLLFLAGS+= -static-libgcc
CXX1XFLAGS = -O2 -Wall $(DEBUGFLAG) -mtune=core2
```

If not, adjust.

R:

```r
devtools::install_github("Microsoft/LightGBM@1bf7bbd", subdir = "R-package", force = TRUE)
```

---

**LightGBM v2 Bosch Benchmarking:**

Choose what to run:

* `bosch_lgb_v2_fast.sh` (one single test): for Bosch, run LightGBM v2 with default flags on 12/6/5/4/3/2/1 threads: depth test
* `bosch_lgb_v2.sh` (critical tests): for Bosch, run LightGBM v2 with default flags on 12/6/1 threads: leaves test, depth test, pruning test, sampling test
* `bosch_lgb_v2_slow.sh` (thread tests to combine with the critical tests): for Bosch, run LightGBM v2 with default flags on 5/4/3/2 threads: leaves test, depth test, pruning test, sampling test
* `bosch_lgb_v2_exact.sh` (specific for more threads): for Bosch, run LightGBM v2 with default flags on 40/20 threads: leaves test, depth test, pruning test, sampling test

```bash
./bosch_lgb_v2_fast.sh
./bosch_lgb_v2.sh
./bosch_lgb_v2_slow.sh
./bosch_lgb_v2_extra.sh
```

---

**LightGBM v2 Higgs Benchmarking:**

Choose what to run:

* `higgs_lgb_v2_fast.sh` (one single test): for Higgs, run LightGBM v2 with default flags on 12/6/5/4/3/2/1 threads: depth test
* `higgs_lgb_v2.sh` (critical tests): for Higgs, run LightGBM v2 with default flags on 12/6/1 threads: leaves test, depth test, pruning test, sampling test
* `higgs_lgb_v2_slow.sh` (thread tests to combine with the critical tests): for Higgs, run LightGBM v2 with default flags on 5/4/3/2 threads: leaves test, depth test, pruning test, sampling test
* `higgs_lgb_v2_exact.sh` (specific for more threads): for Higgs, run LightGBM v2 with default flags on 40/20 threads: leaves test, depth test, pruning test, sampling test

```bash
./higgs_lgb_v2_fast.sh
./higgs_lgb_v2.sh
./higgs_lgb_v2_slow.sh
./higgs_lgb_v2_extra.sh
```

---

**LightGBM v1-O3 Compilation:**

Verify if in `R_HOME/etc/x64/Makeconf` that you have:

```bash
DLLFLAGS+= -static-libgcc -Wl,-O1 -O3
CXX1XFLAGS = -O3 -Wall $(DEBUGFLAG) -march=native
```

If not, adjust.

R:

```r
devtools::install_github("Microsoft/LightGBM@v1@ea6bc0a", subdir = "R-package", force = TRUE)
```

---

**LightGBM v1-O3 Bosch Benchmarking:**

Choose what to run:

* `bosch_lgb_v1-O3_fast.sh` (one single test): for Bosch, run LightGBM v1 with `-O3 -march=native` flags on 12/6/5/4/3/2/1 threads: depth test
* `bosch_lgb_v1-O3.sh` (critical tests): for Bosch, run LightGBM v1 with `-O3 -march=native` flags on 12/6/1 threads: leaves test, depth test, pruning test, sampling test
* `bosch_lgb_v1-O3_slow.sh` (thread tests to combine with the critical tests): for Bosch, run LightGBM v1 with `-O3 -march=native` flags on 5/4/3/2 threads: leaves test, depth test, pruning test, sampling test

```bash
./bosch_lgb_v1-O3_fast.sh
./bosch_lgb_v1-O3.sh
./bosch_lgb_v1-O3_slow.sh
```

---

**LightGBM v1-O3-fmath Compilation:**

Verify if in `R_HOME/etc/x64/Makeconf` that you have:

```bash
DLLFLAGS+= -static-libgcc -Wl,-O1 -O3 -Wl,-ffast-math
CXX1XFLAGS = -O3 -Wall $(DEBUGFLAG) -march=native -ffast-math
```

If not, adjust.

R:

```r
devtools::install_github("Microsoft/LightGBM@v1@ea6bc0a", subdir = "R-package", force = TRUE)
```

---

**LightGBM v1-O3-fmath Bosch Benchmarking:**

Choose what to run:

* `bosch_lgb_v1-O3-fmath_fast.sh` (one single test): for Bosch, run LightGBM v1 with `-O3 -march=native -ffast-math` flags on 12/6/5/4/3/2/1 threads: depth test
* `bosch_lgb_v1-O3-fmath.sh` (critical tests): for Bosch, run LightGBM v1 with `-O3 -march=native -ffast-math` flags on 12/6/1 threads: leaves test, depth test, pruning test, sampling test
* `bosch_lgb_v1-O3-fmath_slow.sh` (thread tests to combine with the critical tests): for Bosch, run LightGBM v1 with `-O3 -march=native -ffast-math` flags on 5/4/3/2 threads: leaves test, depth test, pruning test, sampling test

```bash
./bosch_lgb_v1-O3-fmath_fast.sh
./bosch_lgb_v1-O3-fmath.sh
./bosch_lgb_v1-O3-fmath_slow.sh
```

---

**LightGBM v1-O3-extreme Compilation:**

Verify if in `R_HOME/etc/x64/Makeconf` that you have:

```bash
DLLFLAGS+= -static-libgcc -Wl,-O1 -O3 -Wl,-ffast-math --param max-gcse-insertion-ratio=65535 --param max-inline-insns-single=16777215 --param max-inline-insns-auto=0 --param large-function-insns=65535 --param large-function-growth=65535 --param inline-unit-growth=65535 --param ipcp-unit-growth=65535
CXX1XFLAGS = -O3 -Wall $(DEBUGFLAG) -march=native -ffast-math --param max-gcse-insertion-ratio=65535 --param max-inline-insns-single=16777215 --param max-inline-insns-auto=0 --param large-function-insns=65535 --param large-function-growth=65535 --param inline-unit-growth=65535 --param ipcp-unit-growth=65535
```

If not, adjust.

R:

```r
devtools::install_github("Microsoft/LightGBM@v1@ea6bc0a", subdir = "R-package", force = TRUE)
```

---

**LightGBM v1-O3-extreme Bosch Benchmarking:**

Choose what to run:

* `bosch_lgb_v1-O3-extreme_fast.sh` (one single test): for Bosch, run LightGBM v1 with `-O3 -march=native -ffast-math --param max-gcse-insertion-ratio=65535 --param max-inline-insns-single=16777215 --param max-inline-insns-auto=0 --param large-function-insns=65535 --param large-function-growth=65535 --param inline-unit-growth=65535 --param ipcp-unit-growth=65535` flags on 12/6/5/4/3/2/1 threads: depth test
* `bosch_lgb_v1-O3-extreme.sh` (critical tests): for Bosch, run LightGBM v1 with `-O3 -march=native -ffast-math --param max-gcse-insertion-ratio=65535 --param max-inline-insns-single=16777215 --param max-inline-insns-auto=0 --param large-function-insns=65535 --param large-function-growth=65535 --param inline-unit-growth=65535 --param ipcp-unit-growth=65535` flags on 12/6/1 threads: leaves test, depth test, pruning test, sampling test
* `bosch_lgb_v1-O3-extreme_slow.sh` (thread tests to combine with the critical tests): for Bosch, run LightGBM v1 with `-O3 -march=native -ffast-math --param max-gcse-insertion-ratio=65535 --param max-inline-insns-single=16777215 --param max-inline-insns-auto=0 --param large-function-insns=65535 --param large-function-growth=65535 --param inline-unit-growth=65535 --param ipcp-unit-growth=65535` flags on 5/4/3/2 threads: leaves test, depth test, pruning test, sampling test

```bash
./bosch_lgb_v1-O3-extreme_fast.sh
./bosch_lgb_v1-O3-extreme.sh
./bosch_lgb_v1-O3-extreme_slow.sh
```

---

**LightGBM v2-O3 Compilation:**

Verify if in `R_HOME/etc/x64/Makeconf` that you have:

```bash
DLLFLAGS+= -static-libgcc -Wl,-O1 -O3 -march=native
CXX1XFLAGS = -O3 -Wall $(DEBUGFLAG) -march=native
```

If not, adjust.

R:

```r
devtools::install_github("Microsoft/LightGBM@1bf7bbd", subdir = "R-package", force = TRUE)
```

---

**LightGBM v2 Bosch Benchmarking:**

Choose what to run:

* `bosch_lgb_v2-O3_fast.sh` (one single test): for Bosch, run LightGBM v2 with `-O3 -march=native` flags on 12/6/5/4/3/2/1 threads: depth test
* `bosch_lgb_v2-O3.sh` (critical tests): for Bosch, run LightGBM v2 with `-O3 -march=native` flags on 12/6/1 threads: leaves test, depth test, pruning test, sampling test
* `bosch_lgb_v2-O3_slow.sh` (thread tests to combine with the critical tests): for Bosch, run LightGBM v2 with `-O3 -march=native` flags on 5/4/3/2 threads: leaves test, depth test, pruning test, sampling test

```bash
./bosch_lgb_v2-O3_fast.sh
./bosch_lgb_v2-O3.sh
./bosch_lgb_v2-O3_slow.sh
```

---

**LightGBM v2-O3-fmath Compilation:**

Verify if in `R_HOME/etc/x64/Makeconf` that you have:

```bash
DLLFLAGS+= -static-libgcc -Wl,-O1 -O3 -march=native -Wl,-ffast-math
CXX1XFLAGS = -O3 -Wall $(DEBUGFLAG) -march=native -ffast-math
```

If not, adjust.

R:

```r
devtools::install_github("Microsoft/LightGBM@1bf7bbd", subdir = "R-package", force = TRUE)
```

---

**LightGBM v2-O3-fmath Bosch Benchmarking:**

Choose what to run:

* `bosch_lgb_v2-O3-fmath_fast.sh` (one single test): for Bosch, run LightGBM v2 with `-O3 -march=native -ffast-math` flags on 12/6/5/4/3/2/1 threads: depth test
* `bosch_lgb_v2-O3-fmath.sh` (critical tests): for Bosch, run LightGBM v2 with `-O3 -march=native -ffast-math` flags on 12/6/1 threads: leaves test, depth test, pruning test, sampling test
* `bosch_lgb_v2-O3-fmath_slow.sh` (thread tests to combine with the critical tests): for Bosch, run LightGBM v2 with `-O3 -march=native -ffast-math` flags on 5/4/3/2 threads: leaves test, depth test, pruning test, sampling test

```bash
./bosch_lgb_v2-O3-fmath_fast.sh
./bosch_lgb_v2-O3-fmath.sh
./bosch_lgb_v2-O3-fmath_slow.sh
```

---

**LightGBM v2-O3-extreme Compilation:**

Verify if in `R_HOME/etc/x64/Makeconf` that you have:

```bash
DLLFLAGS+= -static-libgcc -Wl,-O1 -O3 -march=native -Wl,-ffast-math --param max-gcse-insertion-ratio=65535 --param max-inline-insns-single=16777215 --param max-inline-insns-auto=0 --param large-function-insns=65535 --param large-function-growth=65535 --param inline-unit-growth=65535 --param ipcp-unit-growth=65535
CXX1XFLAGS = -O3 -Wall $(DEBUGFLAG) -march=native -ffast-math --param max-gcse-insertion-ratio=65535 --param max-inline-insns-single=16777215 --param max-inline-insns-auto=0 --param large-function-insns=65535 --param large-function-growth=65535 --param inline-unit-growth=65535 --param ipcp-unit-growth=65535
```

If not, adjust.

R:

```r
devtools::install_github("Microsoft/LightGBM@1bf7bbd", subdir = "R-package", force = TRUE)
```

---

**LightGBM v2-O3-extreme Bosch Benchmarking:**

Choose what to run:

* `bosch_lgb_v2-O3-extreme_fast.sh` (one single test): for Bosch, run LightGBM v2 with `-O3 -march=native -ffast-math --param max-gcse-insertion-ratio=65535 --param max-inline-insns-single=16777215 --param max-inline-insns-auto=0 --param large-function-insns=65535 --param large-function-growth=65535 --param inline-unit-growth=65535 --param ipcp-unit-growth=65535` flags on 12/6/5/4/3/2/1 threads: depth test
* `bosch_lgb_v2-O3-extreme.sh` (critical tests): for Bosch, run LightGBM v2 with `-O3 -march=native -ffast-math --param max-gcse-insertion-ratio=65535 --param max-inline-insns-single=16777215 --param max-inline-insns-auto=0 --param large-function-insns=65535 --param large-function-growth=65535 --param inline-unit-growth=65535 --param ipcp-unit-growth=65535` flags on 12/6/1 threads: leaves test, depth test, pruning test, sampling test
* `bosch_lgb_v2-O3-extreme_slow.sh` (thread tests to combine with the critical tests): for Bosch, run LightGBM v2 with `-O3 -march=native -ffast-math --param max-gcse-insertion-ratio=65535 --param max-inline-insns-single=16777215 --param max-inline-insns-auto=0 --param large-function-insns=65535 --param large-function-growth=65535 --param inline-unit-growth=65535 --param ipcp-unit-growth=65535` flags on 5/4/3/2 threads: leaves test, depth test, pruning test, sampling test

```bash
./bosch_lgb_v2-O3-extreme_fast.sh
./bosch_lgb_v2-O3-extreme.sh
./bosch_lgb_v2-O3-extreme_slow.sh
```

---