#===============================================================================
#
#         FILE:  ~/.bashrc
#
#  DESCRIPTION:  local bash configuration
#
#      OPTIONS:  ---
# REQUIREMENTS:  ---
#         BUGS:  ---
#        NOTES:  ---
#       AUTHOR:  John van Zantvoort (JvZ)
#      CREATED:
#     REVISION:  $Revision: 1.6 $
#===============================================================================


# Source global definitions
# --------------------------------------
if [ -f /etc/bashrc ]; then
  . /etc/bashrc
fi

OSNAME=$(uname -s)
SHN=$(uname -n | cut -d\. -f 1)

if [ -f "${HOME}/.bashrc.${OSNAME}" ]
then
  source "${HOME}/.bashrc.${OSNAME}"
fi

if [ -f "${HOME}/.prompt.${SHN}" ]
then
  . "${HOME}/.prompt.${SHN}"
fi

bcd()
{
  if [ -z "${WORKSPACE}" ]
  then
    cd ${HOME}/$*
  else
    cd "${WORKSPACE}/$*"
  fi
}

# GNU tools aliases

#if [ "$OSNAME" = "Linux" ]
#then
        #export PATH="$HOME/myprogs/bin_linux:$PATH"
        #export PATH="/home/nsterren/public/cctools_linux/bin:$PATH"

if [ "$OSNAME" = "SunOS" ]
then
        cadenv ggrep
        cadenv gawk
        cadenv vim
        alias grep=ggrep
        alias awk=gawk
        alias diff=gdiff
        alias vi=vim
fi

export EDITOR=vim
export WINEDITOR=vim

for i in $HOME/.profile.d/*.sh ; do
    if [ -r "$i" ]; then
        if [ "${-#*i}" != "$-" ]; then
            . $i
        else
            . $i >/dev/null 2>&1
        fi
    fi
done
case "$TERM" in
screen)
    export PROMPT_COMMAND='echo -ne "\033k$HOSTNAME\033\\"'
    #PS1='\u@\h:\w\[\033k\033\\\]\$'
    ;;
esac
#export PATH="${PATH/\:\.\:/\:}:/mnt/local_builds/apps/bin"
export CLEARCASE_USE_KDIFF3=on
unset -v SSH_ASKPASS

function set_screen_display {
export $(grep DISPLAY $HOME/screen_env)
}

function set_screen_env {
env > $HOME/screen_env
}

GIT_PROMPT_ONLY_IN_REPO=1
GIT_PROMPT_STATUS_COMMAND=gitstatus_pre-1.7.10.sh
GIT_PROMPT_THEME=Single-line

#source ~/.bash-git-prompt/gitprompt.sh
#source ~/git-completion.bash
