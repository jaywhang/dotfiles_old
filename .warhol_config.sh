# CUDA-related exports
# Currently uses CUDA 8.0 and cuDNN 6.0 for TensorFlow.
export LD_LIBRARY_PATH="$LD_LIBRARY_PATH:/opt/cuda/lib64:/opt/cuda/extras/CUPTI/lib64"
export CUDA_HOME=/opt/cuda

# Adjust scaling of GTK/QT apps for 4K screen
export GDK_SCALE=2
export GDK_DPI_SCALE=0.5
export QT_DEVICE_PIXEL_RATIO=2

# Turn off monitor (until mouse movement or keyboard input)
alias off='xset dpms force off'

# Ruby gem executables
export PATH=$HOME/.gem/ruby/2.3.0/bin:$PATH

# Always colorize output, even when it's piped to non-terminal.
alias yaourt='yaourt --color'

# Set the default browser.
export BROWSER='google-chrome-stable'

alias open='xdg-open'

# Conda binary path.
export CONDA_BIN=/home/bluejay/.anaconda3/bin

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/home/bluejay/.google-cloud-sdk/path.zsh.inc' ]; then source '/home/bluejay/.google-cloud-sdk/path.zsh.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/home/bluejay/.google-cloud-sdk/completion.zsh.inc' ]; then source '/home/bluejay/.google-cloud-sdk/completion.zsh.inc'; fi
