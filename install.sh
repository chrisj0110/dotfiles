current_dir=$(pwd)

# bash
cp .bashrc ~

# nvim
if [ "$NVIM_CONFIG" == "" ]
then
    echo "Warning: NVIM_CONFIG not set, skipping nvim."
else
    cp nvim/init.lua $NVIM_CONFIG
    cp -R nvim/lua $NVIM_CONFIG
    cp -R nvim/after $NVIM_CONFIG
fi

# mypy
cp mypy.ini ~

# rich
if command -v pip &> /dev/null
then
    echo "Installing python packages..."
    pip install rich-cli
else
    echo "INFO: No pip found, skipping python packages..."
fi

# fzf
if ! command -v fzf &> /dev/null
then
    if [ ! -d ~/.fzf ]; then
        echo "Installing fzf..."
        git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
        ~/.fzf/install
    fi
fi

# ctags
cp .ctags ~
