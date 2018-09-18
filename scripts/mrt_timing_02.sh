#!/bin/bash
mkdir -p times results times/Part_II results/Part_II results/Part_II/mrt_times
chmod -R 777 times results

runNum=$1

# Initialize the output file
touch ./results/Part_II/evalDesign_all.log
chmod 666 ./results/Part_II/evalDesign_all.log
truncate -s 0 ./results/Part_II/evalDesign_all.log

cd ./times/Part_II
rm -f ./*

for ((count=1;count<=runNum;count+=1)); do


	echo $count

	seedNum=$count

	# Saved for every run
	rsfFileName="stimt_seed"
	rsfFileName+=$seedNum

	make_random_timing.py -num_stim 3 -num_runs 1 \
		-run_time 300 \
		-stim_labels A B C \
		-num_reps 20 \
		-prefix $rsfFileName \
		-stim_dur 2 \
		-min_rest 1 \
		-max_rest 5 \
		-seed $seedNum \
		-max_consec 1

	# Stored only for the current run
	fileHeadstimt1=$rsfFileName
	fileHeadstimt2=$rsfFileName
	fileHeadstimt3=$rsfFileName
	fileHeadstimt1+="_01_A.1D"
	fileHeadstimt2+="_02_B.1D"
	fileHeadstimt3+="_03_C.1D"

	# Create a file to store the 3dDeconvolve outputs
	touch ./evalDesign_tmp.log

	3dDeconvolve -nodata 300 1 -polort 1 \
		-num_stimts 3 \
		-stim_times 1 $fileHeadstimt1 'GAM' -stim_label 1 'A' \
		-stim_times 2 $fileHeadstimt2 'GAM' -stim_label 2 'B' \
		-stim_times 3 $fileHeadstimt3 'GAM' -stim_label 3 'C' \
		-gltsym "SYM: A -B" -gltsym "SYM: A -C" \
		> ./evalDesign_tmp.log

	chmod 666 ./evalDesign_tmp.log

	efficiency=$(python '../../scripts/efficiency_parser.py' './evalDesign_tmp.log')

	echo $efficiency $seedNum >> ../../results/Part_II/evalDesign_all.log

done

cd ../../results/Part_II/

bestSeedNum=$(sort -n -k 1 evalDesign_all.log | tail -1 | cut -d " " -f2)
worstSeedNum=$(sort -n -k 1 evalDesign_all.log | head -1 | cut -d " " -f2)

cd ./mrt_times

make_random_timing.py -num_stim 3 -num_runs 1 \
	-run_time 300 \
	-stim_labels A B C \
	-num_reps 20 \
	-prefix stimt \
	-stim_dur 2 \
	-min_rest 1 \
	-max_rest 5 \
	-seed $bestSeedNum \
	-max_consec 1

cd ../
timing_tool.py -multi_timing mrt_times/stimt_*.1D \
	-multi_timing_to_events mrt_times.1d -tr 1 -multi_stim_dur 1 \
	-min_frac .5  -run_len 300

chmod 666 ./mrt_times.1d

1dplot -one -png design.png mrt_times.1d
