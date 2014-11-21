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
        echo ''
}

parseSite(){
        for line in `cat /var/log/apache2/access.log | grep -oE "^\b([0-9]{1,3}\.){3}[0-9]{1,3}.*\[(0[1-9]|[12][0-9]|3[01])\/.*\/(20[0-9][0-9]).*]" | sed 's/:.*[-+]0[0-9]00//g' | sed 's/ - - /-/g' | uniq`;do
                for date in `echo $line | cut -d"-" -f2`;do
                        echo -ne "${red}Date:${nocolor} $date - "
                done
                for ip in `echo -n $line | cut -d"-" -f1`;do
                        echo -ne "${red}IP:${nocolor} $ip - "
                        echo -ne "${red}Country:${nocolor}" `whois $ip | grep -iE ^country: | uniq | tr -d " \t" | cut -d":" -f2`
                done
                echo ""
        done
}

clear
header
parseSite