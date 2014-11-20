#!/bin/bash
#
# Parser script to extract the country origin of visitor

red='\e[0;31m'
nocolor='\e[0m'

header() {
        echo ''
        echo '   mm          m                    mmmmm'
        echo '   ##   mmmm   #       mmm    mmmm  #   "#  mmm    m mm   mmm    mmm    m mm'
        echo '  #  #  #" "#  #      #" "#  #" "#  #mmm#" "   #   #"  " #   "  #"  #   #"  ""'
        echo '  #mm#  #   #  #      #   #  #   #  #      m"""#   #      """m  #""""   #'
        echo ' #    # ##m#"  #mmmmm "#m#"  "#m"#  #      "mm"#   #     "mmm"  "#mm"   #'
        echo '        #                     m  #'
        echo '        "                      ""'
        echo '                                                                  @jasonsslim'
        echo ' Parser to extract the country origin of site visitor'
}

parseSite(){
        for ip in `cat /var/log/apache2/access.log | grep -oE "^\b([0-9]{1,3}\.){3}[0-9]{1,3}\b" | sort | uniq`;do
                echo -ne "IP: ${red}$ip${nocolor} >> "
                echo -n `whois $ip | grep -iE ^country: | uniq | tr -d " \t" | cut -d":" -f2`' '
                echo ""
        done
}

clear
header
parseSite
