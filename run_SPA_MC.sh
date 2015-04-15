#!/bin/bash

# shell script reads from file new parameter set, which then replaces old values in SPA model input file
# ... then, SPA is executed
 
# read from file containing new parameter set
exec < 'values_VC'
read iter
read iota
read gplant
read capacitance
read root_leaf_ratio
 
# print new values to screen
echo $iter
echo $iota
echo $gplant
echo $capacitance
echo $root_leaf_ratio
echo "This is iteration $iter."
echo

# if first run, remove old statistics file 
if [ $iter -eq 1 ]
    then rm ~/SPA/MonteCarlo/Vallcebre/output/stats_*
fi

# read old parameter set from file 
exec < 'old_values_VC'
read iter_old
read iota_old
read gplant_old
read capacitance_old
read root_leaf_ratio_old

# replace old with new parameter values in SPA input file
ed ~/SPA/MonteCarlo/Vallcebre/input/EnKF_setup.csv > /dev/null <<+
2 s/$iota_old/$iota/
3 s/$gplant_old/$gplant/
4 s/$capacitance_old/$capacitance/
5 s/$root_leaf_ratio_old/$root_leaf_ratio/
w
q
+

# compile and execute SPA, then plot output data
~/SPA/MonteCarlo/Vallcebre/plot_run.sh

# remove old MonteCarlo run, given present iteration number is matched
if [ -d ~/SPA/output/MonteCarlo/Vallcebre/$iter/ ]
    then rm -R ~/SPA/output/MonteCarlo/Vallcebre/$iter/
fi

# produce output directory to which output of SPA run is moved
mkdir ~/SPA/output/MonteCarlo/Vallcebre/$iter/
# move model output
mv ~/SPA/MonteCarlo/Vallcebre/output/*.png ~/SPA/output/MonteCarlo/Vallcebre/$iter/
mv ~/SPA/MonteCarlo/Vallcebre/output/filter.csv ~/SPA/output/MonteCarlo/Vallcebre/$iter/
 
# copy current dataset, which will serve as identifier for replacement with new values 
cp values_VC old_values_VC
 
# redirect standard input to terminal
exec < /dev/tty
