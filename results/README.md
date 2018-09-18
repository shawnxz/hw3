# Homework 3
By Xu Zhang.


## Part I: Using RSFgen

Usage:

```bash
./scripts/rsf_gen_timing_01.sh 500 2>&1 >/dev/null
```

**A1**: From the generated plots, it can be seen that in `designBad.png` (a bad design case), stimuli of the same type tend to gather together or occur in bursts; whereas in the best design case -- `design.png`, different stimuli are dispersed and mixed more evenly. This may be because continuous stimili of the same type may lead to dampened responses that may impede class separation during subsequent data analyses.


## Part II: `make_random_timing.py`

### Reproduce RSFgen
Usage:

```bash
./scripts/mrt_timing_01.sh 500 >/dev/null 2>&1
```

### Control ITI & Limit the number of repetitions
Usage:

```bash
./scripts/mrt_timing_02.sh 5000 >/dev/null 2>&1
```

**A2**: The timing structure this time tend to be even more dispersed, because there are constraints on the ITI.

**A3**: Different stimuli types are even more dispersed. The incidence of consecutively the same stimuli type is eliminated owing to the constraint on `-max_consec`.

**A4**: The optimal stimuli design requires that different stimuli types should be as dispersed or mixed as possible.


## Part 3: Block Designs

Usage:

```bash
./scripts/blkDesigns.sh
```

The comparison result is saved in `./results/Part III/effCompare.txt`.

**A5**: The general design efficiency is worse in the 100-second scenario than in the other two. There is an efficiency difference for A-B vs A-C, and more obviously in both 50-second and 100-second cases (A-C tends to be worse) because the runtime is short such that there is fewer contrast incidences for consecutive comparison between A and C. For example, in the 50-second case, there is only one C-A subsequence in the entire block series, while in the 100-second case, there is none. 

**A6**: `-polort 12` gives the highest efficiency. By definition this parameter corresponds to the "degree of polynomial corresponding to the null hypothesis". The higher this value, the higher the degree of the polynomial regressor will be, which would capture drifts in shorter timescales. Therefore, under the same run time, a higher `polort` value permits more tracking of the changes in the responses (which however, might contain noise), thus the efficiency is calculated to be higher.

**A7 & A8**: For 2 condition types, it is more desirable to use longer block lengths such that efficiency could be preserved while reducing task switching. For 7 condition types, it is more desirable to use shorter block lengths because the impact of noise with the time duration might be more severe for higher-degree regressors.