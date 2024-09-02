#!/usr/bin/env bash
set -eu -o pipefail
shopt -s nocasematch

declare -A FILTERS
FILTERS[DeepHighContrast]='fx_color_presets 4,22,78,11,9,10,1,26,1,1,1,1,1,1,1,1,1,1,1,45,1,1,32,1,1,1,1,1,1,1,512,100,0,0,0,0,0,0,0,50,50,"0","0","0","0","0","0","0","0","0","0","0","0","0","0","0","0","0","0","0","0","0","0","0","0","0","0","0","0","0","0"'
FILTERS[Domingo145]='fx_color_presets 23,12,6,6,9,14,15,41,1,7,6,5,15,11,8,1,10,8,20,91,24,46,32,12,14,26,1,10,6,54,512,100,0,0,0,0,0,0,0,50,50,"0","0","0","0","0","0","0","0","0","0","0","0","0","0","0","0","0","0","0","0","0","0","0","0","0","0","0","0","0","0"'
FILTERS[Fatos]='fx_color_presets 6,22,78,11,9,30,34,18,1,1,1,1,1,1,1,1,1,1,1,45,1,1,32,1,1,1,1,1,1,1,512,100,0,0,0,0,0,0,0,50,50,"0","0","0","0","0","0","0","0","0","0","0","0","0","0","0","0","0","0","0","0","0","0","0","0","0","0","0","0","0","0"'
FILTERS[Fezzle]='fx_color_presets 6,22,78,11,9,30,34,19,1,1,1,1,1,1,1,1,1,1,1,45,1,1,32,1,1,1,1,1,1,1,512,100,0,0,0,0,0,0,0,50,50,"0","0","0","0","0","0","0","0","0","0","0","0","0","0","0","0","0","0","0","0","0","0","0","0","0","0","0","0","0","0"'
FILTERS[NeopanAcros100]='fx_simulate_film 0,5,31,2,16,1,24,3,13,12,512,100,0,0,0,0,0,0,0,50,50'
FILTERS[Warmteal]='fx_color_presets 4,18,1,1,1,30,1,26,1,1,1,1,1,1,1,1,1,1,1,45,1,1,32,1,1,1,1,1,1,1,512,100,0,0,0,0,0,0,0,50,50,"0","0","0","0","0","0","0","0","0","0","0","0","0","0","0","0","0","0","0","0","0","0","0","0","0","0","0","0","0","0"'

function check_generated {
    inputFile="$1"
    inputFilename="$(basename "$inputFile")"

    for filterName in "${!FILTERS[@]}"; do
        if echo "$inputFilename" | grep -E -q ".+ \($filterName\)\..+"; then
            echo "🙈 Already generated: $inputFile"
            return 1
        fi
    done
}

function apply_filter {
    inputFile="$1"
    filterName="$2"
    filterValue="$3"
    
    inputFolder="$(dirname "$inputFile")"
    inputFilename="$(basename "$inputFile")"
    targetFile="$inputFolder/${inputFilename%.*} ($filterName).${inputFilename##*.}"

    if [ -f "$targetFile" ]; then
        echo "👍 File already exists: $targetFile"
    else
        echo "✅ Apply filter $filterName: $targetFile"
        gmic input "$inputFile" $filterValue output "$targetFile" >/dev/null 2>&1
    fi
}

for file in "$@"; do
    if ! [ -f "$file" ]; then
        echo "❌ Invalid file: $file"
    elif ! check_generated "$file"; then
        continue
    else
        for filterName in "${!FILTERS[@]}"; do
            filterValue=${FILTERS[$filterName]}
            apply_filter "$file" "$filterName" "$filterValue"
        done
    fi
done
