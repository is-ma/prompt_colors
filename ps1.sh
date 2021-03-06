# is there a .git/ directory here?
function is_git(){
  if [[ -d ".git" ]]
    then return 0;
  fi
  return -1;
}

# is my working directory clean?
function is_green (){
  if [ -z "$(git status --porcelain)" ]; then return 0; fi;  # green
  return -1;  # red
}

# define PS1
              PS1="${txtred}\T"       #        hour
PS1="$PS1${txtpur}|${txtylw}\H"       # pipe & host
PS1="$PS1${txtpur}|${txtgrn}\w"       # pipe & path

# PS1 for git
PS1="$PS1\$(if is_git; then echo -n '\e[0;35m|'; fi)" # pipe (for master)
PS1="$PS1${txtblu}\$(__git_ps1 "%s")"                 # master (if any)
PS1="$PS1\$(if is_git; then if is_green; then echo '\e[1;32m ✓'; else echo '\e[1;31m ✗'; fi; fi)"  # git mark

# last PS1 tunning
PS1="$PS1${txtrst}\n"

export PS1

# could be useful
# \$(if is_green; then echo '\e[1;32m'; else echo '\e[1;31m'; fi)
