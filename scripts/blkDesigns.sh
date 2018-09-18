#!/bin/bash
cd ./results/Part_III

# 20-sec
3dDeconvolve -nodata 300 1 -polort 1 \
	-num_stimts 3 \
	-stim_times 1 blockt.20.A.txt 'BLOCK(20)' -stim_label 1 'A' \
	-stim_times 2 blockt.20.B.txt 'BLOCK(20)' -stim_label 2 'B' \
	-stim_times 3 blockt.20.C.txt 'BLOCK(20)' -stim_label 3 'C' \
	-gltsym "SYM: A -B" -gltsym "SYM: A -C" \
	> ./evalDesign_tmp_20.log

chmod 666 ./evalDesign_tmp_20.log

efficiency_20=$(python '../../scripts/efficiency_parser.py' './evalDesign_tmp_20.log')

# 50-sec
3dDeconvolve -nodata 300 1 -polort 1 \
	-num_stimts 3 \
	-stim_times 1 blockt.50.A.txt 'BLOCK(50)' -stim_label 1 'A' \
	-stim_times 2 blockt.50.B.txt 'BLOCK(50)' -stim_label 2 'B' \
	-stim_times 3 blockt.50.C.txt 'BLOCK(50)' -stim_label 3 'C' \
	-gltsym "SYM: A -B" -gltsym "SYM: A -C" \
	> ./evalDesign_tmp_50.log

chmod 666 ./evalDesign_tmp_50.log

efficiency_50=$(python '../../scripts/efficiency_parser.py' './evalDesign_tmp_50.log')

# 100-sec
3dDeconvolve -nodata 300 1 -polort 1 \
	-num_stimts 3 \
	-stim_times 1 blockt.100.A.txt 'BLOCK(100)' -stim_label 1 'A' \
	-stim_times 2 blockt.100.B.txt 'BLOCK(100)' -stim_label 2 'B' \
	-stim_times 3 blockt.100.C.txt 'BLOCK(100)' -stim_label 3 'C' \
	-gltsym "SYM: A -B" -gltsym "SYM: A -C" \
	> ./evalDesign_tmp_100.log

chmod 666 ./evalDesign_tmp_100.log

efficiency_100=$(python '../../scripts/efficiency_parser.py' './evalDesign_tmp_100.log')

touch effCompare.txt
chmod 666 ./effCompare.txt
echo $efficiency_20 $efficiency_50 $efficiency_100 > effCompare.txt