#!/bin/bash
cd ./results/Part_III

# 50-sec
3dDeconvolve -nodata 300 1 -polort 2 \
	-num_stimts 3 \
	-stim_times 1 blockt.50.A.txt 'BLOCK(50)' -stim_label 1 'A' \
	-stim_times 2 blockt.50.B.txt 'BLOCK(50)' -stim_label 2 'B' \
	-stim_times 3 blockt.50.C.txt 'BLOCK(50)' -stim_label 3 'C' \
	-gltsym "SYM: A -B" -gltsym "SYM: A -C" \
	> ./evalDesign_tmp_50_p2.log

chmod 666 ./evalDesign_tmp_50_p2.log

efficiency_50_p2=$(python '../../scripts/efficiency_parser.py' './evalDesign_tmp_50_p2.log')

# 50-sec
3dDeconvolve -nodata 300 1 -polort 6 \
	-num_stimts 3 \
	-stim_times 1 blockt.50.A.txt 'BLOCK(50)' -stim_label 1 'A' \
	-stim_times 2 blockt.50.B.txt 'BLOCK(50)' -stim_label 2 'B' \
	-stim_times 3 blockt.50.C.txt 'BLOCK(50)' -stim_label 3 'C' \
	-gltsym "SYM: A -B" -gltsym "SYM: A -C" \
	> ./evalDesign_tmp_50_p6.log

chmod 666 ./evalDesign_tmp_50_p6.log

efficiency_50_p6=$(python '../../scripts/efficiency_parser.py' './evalDesign_tmp_50_p6.log')

# 50-sec
3dDeconvolve -nodata 300 1 -polort 12 \
	-num_stimts 3 \
	-stim_times 1 blockt.50.A.txt 'BLOCK(50)' -stim_label 1 'A' \
	-stim_times 2 blockt.50.B.txt 'BLOCK(50)' -stim_label 2 'B' \
	-stim_times 3 blockt.50.C.txt 'BLOCK(50)' -stim_label 3 'C' \
	-gltsym "SYM: A -B" -gltsym "SYM: A -C" \
	> ./evalDesign_tmp_50_p12.log

chmod 666 ./evalDesign_tmp_50_p12.log

efficiency_50_p12=$(python '../../scripts/efficiency_parser.py' './evalDesign_tmp_50_p12.log')

touch eff_polort.txt
chmod 666 ./eff_polort.txt
echo $efficiency_50_p2 $efficiency_50_p6 $efficiency_50_p12 > eff_polort.txt