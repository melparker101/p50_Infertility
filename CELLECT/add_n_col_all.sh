########################################
# Add N column to summary stats
# melodyjparker14@gmail.com - Apr 23
# This script creates a "directions" file per sumstats which tells us which studies each SNP is present in.
# 1 = SNP present in study, 0 = SNP not present in study
########################################

calcNeff() {
  local n_cases=$1
  local n_controls=$2
  local N_eff=$(echo "2 / (1 / $n_cases + 1 / $n_controls)" | bc -l)
  echo "$N_eff"
}

# Infertility1 case/control variables:

# Define FinnGen variables
FinnGen_N_Cases=14759
FinnGen_N_Controls=111583
FinnGen_N_eff=$(calcNeff $FinnGen_N_Cases $FinnGen_N_Controls)  # 26069.77

# Define UKBB variables
UKBB_N_Cases=3447
UKBB_N_Controls=245591
UKBB_N_eff=$(calcNeff $UKBB_N_Cases $UKBB_N_Controls)  # 6798.578

# Define EstBB variables
EstBB_N_Cases=12027
EstBB_N_Controls=111395
EstBB_N_eff=$(calcNeff $EstBB_N_Cases $EstBB_N_Controls)  # 21710.03

# Hormones variables

# cohort  sample_size
# UKBB    10155
# EstBB   3353
# ALSPAC  3102

awk -v c1="$COHORT1" -v c2="$COHORT2" -v c3="$COHORT3" \
        'NR==1 {print $1, c1, c2, c3; next} NR==FNR {printf "%s ", $1; gsub(/.{1}/,"& ",$2); print $2}' "$OUT"/"$FILENAME" \
        
awk 'NR==2 {print $2}' cohorts/FSH_F_EUR.txt


############################

# Path for sumstats files
IN=data/sumstats/original
OUT=data/sumstats/other

# Subset the hormones sumstats data to only include the 'ID' and 'Direction' columns
for f in "$IN"/*EUR_filtered.txt
  do awk '{print $1, $12}' "$f" > "$OUT/$(basename -- "${f%_filtered.txt}")_directions.txt"
done

# Subset the infertility sumstats data to only include the 'MarkerName' and 'Direction' columns
awk '{print $1, $11}' "$IN"/female_infertility_analysis1_UKBB_Finngen_EstBB_noMACfilter_March20231.out > "$OUT"/Infertility1_F_EUR_directions.txt

COHORTS="data/sumstats/cohorts"

# Define a set of shell variables for each summary stats file
LH_F_EUR_cohort1=$(awk 'NR==2 {print $1}' "$COHORTS"/FSH_F_EUR.txt)  # "UKBB"
LH_F_EUR_cohort2=$(awk 'NR==3 {print $1}' "$COHORTS"/FSH_F_EUR.txt)  # "EstBB"
LH_F_EUR_cohort3=$(awk 'NR==4 {print $1}' "$COHORTS"/FSH_F_EUR.txt)  # "ALSPAC"
LH_F_EUR_sample_size1=$(awk 'NR==2 {print $2}' "$COHORTS"/FSH_F_EUR.txt)
LH_F_EUR_sample_size2=$(awk 'NR==3 {print $2}' "$COHORTS"/FSH_F_EUR.txt)
LH_F_EUR_sample_size3=$(awk 'NR==4 {print $2}' "$COHORTS"/FSH_F_EUR.txt)
LH_F_EUR_filename="LH_F_EUR_directions.txt"

FSH_F_EUR_cohort1="UKBB"
FSH_F_EUR_cohort2="EstBB"
FSH_F_EUR_cohort3="ALSPAC"
FSH_F_EUR_filename="FSH_F_EUR_directions.txt"

Testosterone_F_EUR_cohort1="UKBB"
Testosterone_F_EUR_cohort2="EstBB"
Testosterone_F_EUR_cohort3="ALSPAC"
Testosterone_F_EUR_filename="Testosterone_F_EUR_directions.txt"

Progesterone_F_EUR_cohort1="UKBB"
Progesterone_F_EUR_cohort2="EstBB"
Progesterone_F_EUR_cohort3="Pott"
Progesterone_F_EUR_filename="Progesterone_F_EUR_directions.txt"

Oestradiol_F_EUR_cohort1="UKBB"
Oestradiol_F_EUR_cohort2="EstBB"
Oestradiol_F_EUR_cohort3="Pott"
Oestradiol_F_EUR_filename="Oestradiol_F_EUR_directions.txt"

Testosterone_sex_comb_EUR_cohort1="UKBB"
Testosterone_sex_comb_EUR_cohort2="EstBB"
Testosterone_sex_comb_EUR_cohort3="Pott"
Testosterone_sex_comb_EUR_filename="Testosterone_sex_comb_EUR_directions.txt"

Infertility1_F_EUR_cohort1="FinnGen"
Infertility1_F_EUR_cohort2="UKBB"
Infertility1_F_EUR_cohort3="EstBB"
Infertility1_F_EUR_filename="Infertility1_F_EUR_directions.txt"

##################################################
# test loop
for phenotype in LH_F_EUR FSH_F_EUR Testosterone_F_EUR Progesterone_F_EUR Oestradiol_F_EUR Testosterone_sex_comb_EUR # Infertility1_F_EUR
do
    COHORT1=$(awk 'NR==2 {print $1}' "$COHORTS"/${phenotype}.txt)
    COHORT2=$(awk 'NR==3 {print $1}' "$COHORTS"/${phenotype}.txt)
    COHORT3=$(awk 'NR==4 {print $1}' "$COHORTS"/${phenotype}.txt)
    SAMPLE_SIZE1=$(awk 'NR==2 {print $2}' "$COHORTS"/${phenotype}.txt)
    SAMPLE_SIZE2=$(awk 'NR==3 {print $2}' "$COHORTS"/${phenotype}.txt)
    SAMPLE_SIZE3=$(awk 'NR==4 {print $2}' "$COHORTS"/${phenotype}.txt)
    FILENAME=${phenotype}_directions.txt
    
    echo "$OUT"/Ncol_${phenotype}.txt
done

    echo "${COHORT1} ${COHORT2} ${COHORT3}"
    echo "${SAMPLE_SIZE1}"
    echo "${SAMPLE_SIZE2}"
    echo "${SAMPLE_SIZE3}"


awk -v c1="$COHORT1" -v c2="$COHORT2" -v c3="$COHORT3" '{ print $1*c1 + $2*c2 + $3*c3 }' directions.txt > output.txt


# try this with a test
head $OUT/Progesterone_F_EUR_directions.txt > test_directions.txt





# add a column

# Ncol outfile name
# "$OUT"/Ncol_${phenotype}.txt




#######################################################


# Loop through and edit each summary stats directions file
for phenotype in LH_F_EUR FSH_F_EUR Testosterone_F_EUR Progesterone_F_EUR Oestradiol_F_EUR Testosterone_sex_comb_EUR Infertility1_F_EUR
do
    # Set shell variables
    eval "COHORT1=\${${phenotype}_cohort1}"
    eval "COHORT2=\${${phenotype}_cohort2}"
    eval "COHORT3=\${${phenotype}_cohort3}"
    eval "FILENAME=\${${phenotype}_filename}"
    
    
    # Print variable names
    echo "$COHORT1 $COHORT2 $COHORT3 $FILENAME"
    
    # Split up the characters of the 'Direction' column and name columns by study name
    # Use -v to pass shell variables into awk command
    # Overwrite file
    awk -v c1="$COHORT1" -v c2="$COHORT2" -v c3="$COHORT3" \
        'NR==1 {print $1, c1, c2, c3; next} NR==FNR {printf "%s ", $1; gsub(/.{1}/,"& ",$2); print $2}' "$OUT"/"$FILENAME" \
            > tmp && mv tmp "$OUT"/"$FILENAME"

    # Change ? to 0 and +/- to 1
    awk '{gsub(/\?/,"0"); gsub(/[+-]/,"1"); print}' "$OUT"/"$FILENAME" > tmp && mv tmp "$OUT"/"$FILENAME"
done