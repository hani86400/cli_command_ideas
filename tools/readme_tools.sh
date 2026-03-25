function send_email() {
CURL_OPT=(
  -s
  -X POST
  -k 
  --http1.1   
  -u "${URLL_USER}:${URLL_PASSWORD}"  
  "$EMAIL_API_URL"
)

CURL_HEADERS=(
  -H "Authorization: Bearer ${EMAIL_API_KEY}"
  -H "Content-Type: application/json"
)

CURL_DATA=(
  -d "$JSON_DATA"
)


 
 
EMAIL_FROM="$1"
EMAIL_TO="$2"
EMAIL_SUBJECT="$3"
EMAIL_HTML="$4"

JSON_DATA=$(jq -n \
  --arg from "$EMAIL_FROM" \
  --arg to "$EMAIL_TO" \
  --arg subject "${EMAIL_SUBJECT}" \
  --arg html "$EMAIL_HTML" \
  '{from:$from,to:$to,subject:$subject,html:$html}')

echo 'curl "${CURL_OPT[@]}" "${CURL_HEADERS[@]}" "${CURL_DATA[@]}"'
set -x
      curl "${CURL_OPT[@]}" "${CURL_HEADERS[@]}" "${CURL_DATA[@]}"
set +x
}

function func1(){
if [ $# -lt 1 ]
then
# Show usage 
echo
echo -e "Usage: function_name <argument1> [argument2] [argument3]"
echo
echo 'OR'
echo
# Show usage with color
echo -e "Usage: \e[1;97mfunction_name\e[0m \e[1;95m<argument1>\e[0m \e[1;92m[argument2]\e[0m \e[1;93m[argument3]\e[0m"
echo

return 1
fi 
}

show_colors(){
export CE0="\x1B[0m" CEB="\x1B[1m"
export FG_03="\x1B[30m"  FG_R3="\x1B[31m"  FG_G3="\x1B[32m"  FG_Y3="\x1B[33m"  FG_B3="\x1B[34m"  FG_P3="\x1B[35m"  FG_C3="\x1B[36m"  FG_W3="\x1B[37m"
export FG_09="\x1B[90m"  FG_R9="\x1B[91m"  FG_G9="\x1B[92m"  FG_Y9="\x1B[93m"  FG_B9="\x1B[94m"  FG_P9="\x1B[95m"  FG_C9="\x1B[96m"  FG_W9="\x1B[97m"
export BG_04="\x1B[40m"  BG_R4="\x1B[41m"  BG_G4="\x1B[42m"  BG_Y4="\x1B[43m"  BG_B4="\x1B[44m"  BG_P4="\x1B[45m"  BG_C4="\x1B[46m"  BG_W4="\x1B[47m"
export BG_0H="\x1B[100m" BG_RH="\x1B[101m" BG_GH="\x1B[102m" BG_YH="\x1B[103m" BG_BH="\x1B[104m" BG_PH="\x1B[105m" BG_CH="\x1B[106m" BG_WH="\x1B[107m"
echo
echo -e "FGx3N ${FG_03}FG_03 ${FG_R3}FG_R3 ${FG_G3}FG_G3 ${FG_Y3}FG_Y3 ${FG_B3}FG_B3 ${FG_P3}FG_P3 ${FG_C3}FG_C3 ${FG_W3}FG_W3 ${CE0} \n"
echo -e "FGx3B ${CEB}${FG_03}FG_03 ${FG_R3}FG_R3 ${FG_G3}FG_G3 ${FG_Y3}FG_Y3 ${FG_B3}FG_B3 ${FG_P3}FG_P3 ${FG_C3}FG_C3 ${FG_W3}FG_W3 ${CE0} \n"
echo -e "FGx9N ${FG_09}FG_09 ${FG_R9}FG_R9 ${FG_G9}FG_G9 ${FG_Y9}FG_Y9 ${FG_B9}FG_B9 ${FG_P9}FG_P9 ${FG_C9}FG_C9 ${FG_W9}FG_W9 ${CE0} \n"
echo -e "FGx9B ${CEB}${FG_09}FG_09 ${FG_R9}FG_R9 ${FG_G9}FG_G9 ${FG_Y9}FG_Y9 ${FG_B9}FG_B9 ${FG_P9}FG_P9 ${FG_C9}FG_C9 ${FG_W9}FG_W9 ${CE0} \n"
echo -e "BGx4- ${BG_04}BG_04 ${BG_R4}BG_R4 ${BG_G4}BG_G4 ${BG_Y4}BG_Y4 ${BG_B4}BG_B4 ${BG_P4}BG_P4 ${BG_C4}BG_C4 ${BG_W4}BG_W4 ${CE0} \n"
echo -e "BGxH- ${BG_0H}BG_0H ${BG_RH}BG_RH ${BG_GH}BG_GH ${BG_YH}BG_YH ${BG_BH}BG_BH ${BG_PH}BG_PH ${BG_CH}BG_CH ${BG_WH}BG_WH ${CE0} \n"
echo
}

reorder() {
    local file="$1"
    local pattern="$2"

    local i=1
    local tmp
    tmp="$(mktemp)"
    #tmp="TEMP.TXT"

    while IFS= read -r line || [[ -n "$line" ]]; do
        
        if [[ $line =~ $pattern ]]; then
            
            prefix="${BASH_REMATCH[1]}"
            printf -v num "%04d" "$i"

            line="$(sed -E "s/${prefix}[0-9]{4}/${prefix}${num}/" <<< "$line")"

            ((i++))
        fi
        
        echo "$line" >> "$tmp"

    done < "$file"

    'mv' "$tmp" "$file"
}


readme_table_date() {

cat <<EOTABLE
| Description | Command | Output |
|-------------|---------|--------|
|YY-MM-DD_hh:mm:ss             | date +%F_%T                | $( date +%F_%T                ) |
|YYMMDD_hhmmss                 | date +%Y%m%d_%H%M%S        | $( date +%Y%m%d_%H%M%S        ) |
|-------------|---------|--------|
|YYMMDD_hhmmss (UTC version)   | date --utc +%Y%m%d_%H%M%SZ | $( date --utc +%Y%m%d_%H%M%SZ ) |
|YYMMDD_hhmmss (with local TZ) | date +%Y%m%d_%H%M%S%Z      | $( date +%Y%m%d_%H%M%S%Z      ) |
|ISO8601 UTC timestamp         | date --utc +%FT%TZ         | $( date --utc +%FT%TZ         ) |
|ISO8601 Local TZ timestamp    | date +%FT%T%Z              | $( date +%FT%T%Z              ) |
|ISO8601 UTC timestamp + ms    | date --utc +%FT%T.%3NZ     | $( date --utc +%FT%T.%3NZ     ) |
|-------------|---------|--------|
|YYMMSShhmmss                  | date +%Y%m%d%H%M%S         | $( date +%Y%m%d%H%M%S         ) |
|YYMMSShhmmssnnnnnnnnn         | date +%Y%m%d%H%M%S%N       | $( date +%Y%m%d%H%M%S%N       ) |
|Seconds only:                 | date +%S                   | $( date +%S                   ) |
|Meliseconds only:             | date +%N | cut -b1-6       | $( date +%N | cut -b1-6 ) |
|Nanoseconds only:             | date +%N                   | $( date +%N                   ) |
|Day  of year (001..366)       | date +%j                   | $( date +%j                   ) |
|Week of year (01..52 )        | date +%U                   | $( date +%U                   ) |
|-------------|---------|--------|
|Seconds since UNIX epoch:     | date +%s                   | $( date +%s                   ) |
|Nanoseconds since UNIX epoch: | date +%s%N                 | $( date +%s%N                 ) |
|cvt UNIX second to date       | date -d @1234567890        | $( date -d @1234567890        ) |
|End of Unix time              | date -ud @2147483647       | $( date -ud @2147483647       ) |
EOTABLE
}