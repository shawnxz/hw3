#!/bin/bash
mkdir -p times results times/Part_I results/Part_I
chmod -R 777 times results

runNum=$1

# Initialize the output file
touch ./results/Part_I/evalDesign_all.log
chmod 666 ./results/Part_I/evalDesign_all.log
truncate -s 0 ./results/Part_I/evalDesign_all.log

cd ./times/Part_I
rm -f ./*

for ((count=1;count<=runNum;count+=1)); do


	echo $count

	seedNum=$count

	# Saved for every run
	rsfFileName="stim_seed"
	rsfFileName+=$seedNum
	rsfFileName+="_"

	RSFgen \
		-nt 300 \
		-num_stimts 3 \
		-nreps 1 20 \
		-nreps 2 20 \
		-nreps 3 20 \
		-seed $seedNum \
		-prefix $rsfFileName

	# Stored only for the current run
	fileHeadstimt=$rsfFileName
	fileHeadstimt+="*.1D"

	make_stim_times.py \
		-files $fileHeadstimt \
		-prefix stimt \
		-nt 300 \
		-tr 1 \
		-nruns 1

	# Create a file to store the 3dDeconvolve outputs
	touch ./evalDesign_tmp.log

	3dDeconvolve -nodata 300 1 -polort 1 \
		-num_stimts 3 \
		-stim_times 1 stimt.01.1D 'GAM' -stim_label 1 'A' \
		-stim_times 2 stimt.02.1D 'GAM' -stim_label 2 'B' \
		-stim_times 3 stimt.03.1D 'GAM' -stim_label 3 'C' \
		-gltsym "SYM: A -B" -gltsym "SYM: A -C" \
		> ./evalDesign_tmp.log

	chmod 666 ./evalDesign_tmp.log

	efficiency=$(python '../../scripts/efficiency_parser.py' './evalDesign_tmp.log')

	echo $efficiency $seedNum >> ../../results/Part_I/evalDesign_all.log

done

cd ../../results/Part_I

bestSeedNum=$(sort -n -k 1 evalDesign_all.log | tail -1 | cut -d " " -f2)
worstSeedNum=$(sort -n -k 1 evalDesign_all.log | head -1 | cut -d " " -f2)

RSFgen \
	-nt 300 \
	-num_stimts 3 \
	-nreps 1 20 \
	-nreps 2 20 \
	-nreps 3 20 \
	-seed $bestSeedNum \
	-prefix stim \
	-one_file

1dplot -one -png design.png stim.1D

RSFgen \
	-nt 300 \
	-num_stimts 3 \
	-nreps 1 20 \
	-nreps 2 20 \
	-nreps 3 20 \
	-seed $worstSeedNum \
	-prefix stimBad \
	-one_file

1dplot -one -png designBad.png stimBad.1D