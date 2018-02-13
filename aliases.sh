# Custom aliases
alias dir='dir --color=always'
alias vdir='vdir --color=always'
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'
alias ll='ls -l'
alias la='ls -A'
alias lh='ls -h'
alias llh='ls -l -h'
alias l='ls -xF'
alias less='less -R'
alias lss='ls -x --color=always | less -R'
alias dush='du -sh'
alias cd..='cd ..'
alias mv='mv -i'
alias rm='rm -i'
alias cp='cp -i'
alias tmux='tmux -2'  # Force tmux to assume the terminal supports 256 colours.
alias ta='tmux attach'
alias tt='tmux attach -t'
alias tdt='tmux attach -d -t'
alias tls='tmux list-sessions'
alias tns='tmux new -s'
alias mmmm='Rscript -e "data = as.numeric (readLines (\"stdin\")); summary(data); s = sum(data); sd = sd(data); cat(\"sum: \",s,\"\\n\"); cat(\"stddev: \",sd,\"\\n\");"'
alias csvawk='awk -F "," -v OFS=","'
alias wl='wc -l'
alias ipy='DISPLAY=:0 ipython'
alias nb='jupyter notebook'
alias pyserv='python -m http.server 8080'
alias lc='latexmk -c'  # Remove junk from LaTeX compilation.
alias gd='git rev-parse && cd "$(git rev-parse --show-cdup)"'  # Move to git root directory

if [[ `uname` == 'Darwin' ]]
then
  alias ls='ls -x -G'
else
  alias ls='ls -x --color=always'
fi

# Stanford servers
alias rice='ssh -l jaywhang rice.stanford.edu'  # FarmShare 2
alias rye01='ssh -l jaywhang rye01.stanford.edu'
alias rye02='ssh -l jaywhang rye02.stanford.edu'
alias corn='ssh -l jaywhang corn.stanford.edu'

# Anaconda environment management.
if [[ -z $CONDA_BIN ]]; then
  alias pyenv='conda create -n'
  alias pyon='source activate'
  alias pyoff='source deactivate'
else
  alias conda='$CONDA_BIN/conda'
  alias pyenv='$CONDA_BIN/conda create -n'
  alias pyon='source $CONDA_BIN/activate'
  alias pyoff='source $CONDA_BIN/deactivate'
  alias py36='source $CONDA_BIN/activate py36'
fi


# Google Compute Engine aliases
alias gc='gcloud compute'
alias gci='gcloud compute instances'
