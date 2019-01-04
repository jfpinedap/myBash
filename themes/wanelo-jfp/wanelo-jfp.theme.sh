#!/usr/bin/env bash
#
# This file echoes a bunch of color codes to the terminal to demonstrate
# what's available. Each line is the color code of one forground color,
# out of 17 (default + 16 escapes), followed by a test use of that color
# on all nine background colors (default + 8 escapes).
#
#T='gYw'   # The test text
#echo -e "\n                 40m     41m     42m     43m     44m     45m     46m     47m";
#for FGs in '    m' '   1m' '  30m' '1;30m' '  31m' '1;31m' '  32m' '1;32m' '  33m' '1;33m' '  34m' '1;34m' '  35m' '1;35m' '  36m' '1;36m' '  37m' '1;37m';
#  do FG=${FGs// /}
#  echo -en " $FGs \033[$FG  $T  "
#  for BG in 40m 41m 42m 43m 44m 45m 46m 47m;
#    do echo -en "$EINS \033[$FG\033[$BG  $T \033[0m\033[$BG \033[0m";
#  done
#  echo;
#done
#echo


c="\[\033["

# IMPORTANT THINGS TO CHANGE ==================================================

# Show IP in prompt
# One thing to be weary about if you have slow Internets
IP_ENABLED=1

SCM_THEME_PROMPT_DIRTY=" ${red}✗"
SCM_THEME_PROMPT_CLEAN=" ${bold_green}✓"
SCM_THEME_PROMPT_PREFIX=" |"
SCM_THEME_PROMPT_SUFFIX="${green}|"

GIT_THEME_PROMPT_DIRTY=" ${red}✗"
GIT_THEME_PROMPT_CLEAN=" ${bold_green}✓"
GIT_THEME_PROMPT_PREFIX=" ${green}|"
GIT_THEME_PROMPT_SUFFIX="${green}|"

RVM_THEME_PROMPT_PREFIX="|"
RVM_THEME_PROMPT_SUFFIX="|"

# COLORS ======================================================================
ORANGE='\[\e[0;33m\]'


# FUNCS =======================================================================

function get_ip_info {
    echo -e "$(ips | sed -e 's/addr://' | sed -e :a -e '$!N;s/\n/,/;ta' | sed -e 's/127\.0\.0\.1\,//g')"
}

# Displays ip prompt 
function ip_prompt_info() {
    if [[ $IP_ENABLED == 1 ]]; then
        echo -e " ${green}|${ORANGE}$(get_ip_info)${green}|"
    fi 
}

# Displays the current prompt
function prompt_command() {
    if [ $? -eq 0 ]; then
      status=❤️
    else
      status=💔
    fi
    PS1="\n ${green}$status  ${c}36m\]\\j ${purple}\u${ORANGE}@${purple}\h${ORANGE}$(ip_prompt_info) ${reset_color}${green}\w \n ${blue}|$(clock_prompt)|${green}$(scm_prompt_info) ${green}→${reset_color} "
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    #PS1="\e[40m\n ${green}$status  ${c}36m\]\\j ${purple}\u${ORANGE}@${purple}\h${ORANGE}$(ip_prompt_info) ${reset_color}${green}\w \n ${blue}|$(clock_prompt)|${green}$(scm_prompt_info) ${green}→${reset_color} \e[46m"
    #PS1="\n ${green}$status  ${purple}\u${ORANGE}@${purple}\h${ORANGE}$(ip_prompt_info) ${reset_color}${green}\w ${c}36m\]\$(/bin/ls -lah | grep -m 1 total | /bin/sed 's/total //')\n ${blue}|$(clock_prompt)|${green}$(scm_prompt_info) ${green}→${reset_color} "
#PS1="\n${p}╔ǁ ${c}1;3\$(if [ \$? -eq 0 ]; then echo '2'; else echo '1'; fi)m\]*$p ǁ ${c}36m\]\@ \d$p ǁ ${c}35m\]\j$p ǁ ${c}30m\]\u${c}33m\]@\h$p ǁ ${c}1;34m\]\w$p ǁ ${c}32m\]\$(/bin/ls -1 | /usr/bin/wc -l) files, \$(/bin/ls -lah | grep -m 1 total | /bin/sed 's/total //')${c}m\]$p ǁ═╗\n╚═${c}1;3\$(if [ ${EUID} -eq 0 ]; then echo '1'; else echo '4'; fi)m\]»${c}m\] "
}

THEME_CLOCK_COLOR=${THEME_CLOCK_COLOR:-"$blue"}

PROMPT_COMMAND=prompt_command;

