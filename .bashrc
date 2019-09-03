################################################################################
# Variables
################################################################################
# Don't put duplicate lines in the history and do not add lines that start with
# a space
export HISTCONTROL=erasedups:ignoredups:ignorespace

export PATH=/Users/littlemonster/Library/Python/3.7/bin:/Users/littlemonster/Library/Python/2.7/bin/:$PATH

export NDK_PATH=/Users/littlemonster/Library/Android/sdk/ndk-bundle/

export XTENSA_PATH=/Users/littlemonster/Library/Arduino15/packages/esp32/tools/xtensa-esp32-elf-gcc/1.22.0-80-g6c4433a-5.2.0/bin

################################################################################
# Sourcing
################################################################################

################################################################################
# Commands
################################################################################
# Check the window size after each command and, if necessary, update the values
# of LINES and COLUMNS
shopt -s checkwinsize

# Causes bash to append to history instead of overwriting it so if you start a
# new terminal, you have old session history
shopt -s histappend

# Enable the specific colors for ls (need Coreutils)
eval `gdircolors ~/.dir_colors`

################################################################################
# Aliases
################################################################################
alias grep='grep --color=auto'
alias ls='gls -axFh --color=auto'
alias ll='gls -alFh --color=auto'
alias valgrind='colour-valgrind'
alias flash-hex='st-flash --format ihex write'
alias engine-valgrind='valgrind --leak-check=full --gen-suppressions=all --suppressions=/Users/littlemonster/chirp/chirp-core/auxiliary/valgrind/osx.suppressions --leak-check=yes --error-exitcode=1'
alias sdk-valgrind='valgrind --leak-check=full --leak-check=yes --show-leak-kinds=all --gen-suppressions=all --suppressions=/Users/littlemonster/chirp/chirp-c-sdk/tests/macOS.suppressions  --error-exitcode=1'

################################################################################
# Functions
################################################################################

# Copy file with a progress bar
cpp()
{
  set -e
  strace -q -ewrite cp -- "${1}" "${2}" 2>&1 \
  | awk '{
    count += $NF
    if (count % 10 == 0) {
      percent = count / total_size * 100
      printf "%3d%% [", percent
      for (i=0;i<=percent;i++)
      printf "="
      printf ">"
      for (i=percent;i<100;i++)
      printf " "
      printf "]\r"
    }
  }
  END { print "" }' total_size=$(stat -c '%s' "${1}") count=0
}

# Copy and go to the directory
cpg ()
{
  if [ -d "$2" ];then
    cp $1 $2 && cd $2
  else
    cp $1 $2
  fi
}

# Move and go to the directory
mvg ()
{
  if [ -d "$2" ];then
    mv $1 $2 && cd $2
  else
    mv $1 $2
  fi
}

# Create and go to the directory
mkdirg ()
{
  mkdir -p $1
  cd $1
}

up ()
{
	local d=""
	limit=$1
	for ((i=1 ; i <= limit ; i++))
		do
			d=$d/..
		done
	d=$(echo $d | sed 's/^\///')
	if [ -z "$d" ]; then
		d=..
	fi
	cd $d
}

#Color Man page
man() {
  env LESS_TERMCAP_mb=$'\E[01;31m' \
  LESS_TERMCAP_md=$'\E[01;38;5;74m' \
  LESS_TERMCAP_me=$'\E[0m' \
  LESS_TERMCAP_se=$'\E[0m' \
  LESS_TERMCAP_so=$'\E[38;5;246m' \
  LESS_TERMCAP_ue=$'\E[0m' \
  LESS_TERMCAP_us=$'\E[04;38;5;146m' \
  man "$@"
}

parse_git_repo() {
  remote=$(git config --get remote.origin.url 2> /dev/null)
  res=$?
  repo=$(echo ${remote##*/} | cut -f 1 -d '.')
  if [[ ! $res -eq 0 ]]; then
    printf "✕"
  else
    printf "%s ->" $repo
  fi
}

# parse_git_branch() {
#   branch=$(git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ \1/' -e 's/^[[:space:]]*//'; exit ${PIPESTATUS[0]})
#   res=$?
#   if [[ ! $res -eq 0 ]]; then
#     printf "✕"
#   else
#     printf "%s" $branch
#   fi
# }

################################################################################
# Prompt
################################################################################
# unstaged (*) and staged (+) changes will be displayed
GIT_PS1_SHOWDIRTYSTATE=1
# Show stash state
GIT_PS1_SHOWSTASHSTATE=1
# Show untracked files by displaying '%'
GIT_PS1_SHOWUNTRACKEDFILES=1
# Colored hint about the current dirty state
# GIT_PS1_SHOWCOLORHINTS=1

  # Define colors
LIGHTGRAY="\[\033[0;37m\]"
WHITE="\[\033[1;37m\]"
BLACK="\[\033[0;30m\]"
DARKGRAY="\[\033[1;30m\]"
RED="\[\033[0;31m\]"
LIGHTRED="\[\033[1;31m\]"
GREEN="\[\033[0;32m\]"
LIGHTGREEN="\[\033[1;32m\]"
YELLOW="\[\033[0;33m\]"
BROWN="\[\033[1;33m\]"
BLUE="\[\033[0;34m\]"
LIGHTBLUE="\[\033[1;34m\]"
MAGENTA="\[\033[0;35m\]"
LIGHTMAGENTA="\[\033[1;35m\]"
CYAN="\[\033[0;36m\]"
LIGHTCYAN="\[\033[1;36m\]"
NOCOLOR="\[\033[0m\]"

PS1="${GREEN}\u\n${YELLOW}├ ${BLUE}\w\n${YELLOW}├─${RED} \$(parse_git_repo) \$(__git_ps1 "[%s]")${YELLOW}\n└── ${MAGENTA}\$ ${NOCOLOR}"
