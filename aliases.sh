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
alias lc='latexmk -c'  # Remove junk from LaTeX compilation.
alias gd='git rev-parse && cd "$(git rev-parse --show-cdup)"'  # Move to git root directory
alias tf='tail -f'

if [[ `uname` == 'Darwin' ]]
then
  alias ls='ls -x -G'
else
  alias ls='ls -x --color=always'
fi

# School servers
alias rice='ssh -l jaywhang rice.stanford.edu'  # FarmShare 2
alias sc='ssh -l jaywhang sc.stanford.edu -i ~/.ssh/sc_rsa'
alias aws='mosh --ssh="ssh -l ubuntu -i ~/Dropbox/archive/aws.pem"'
alias suvpn='sudo openconnect --authgroup="Full Traffic non-split-tunnel" --user=jaywhang su-vpn.stanford.edu'
alias sirius='mosh --ssh="ssh -i ~/.ssh/sshkey_hockney -l jay" -p 8090:8099 sirius.ece.utexas.edu'
alias sirius-ssh='ssh -i ~/.ssh/sshkey_hockney -l jay sirius.ece.utexas.edu'  # 10.157.90.229
alias sirius-admin='ssh -l jay-admin sirius.ece.utexas.edu'
alias aries='ssh -i ~/.ssh/sshkey_hockney jay@aries.ece.utexas.edu'

# TACC servers
alias maverick='ssh -i ~/.ssh/sshkey_hockney jaywhang@maverick2.tacc.utexas.edu'
alias longhorn='ssh -i ~/.ssh/sshkey_hockney jaywhang@login1.longhorn.tacc.utexas.edu'

# Python-related
alias pyon='conda activate'
alias pyoff='conda deactivate'
alias ipy='DISPLAY=:0 ipython'
alias nb='jupyter notebook'
alias pyserv='python3 -m http.server 8080'

# Tensorboard
alias tb='tensorboard --port 8090 --bind_all --logdir'

# Google Compute Engine aliases
alias gc='gcloud compute'
alias gci='gcloud compute instances'
