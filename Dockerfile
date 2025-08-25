FROM ubuntu:24.04

# Install dependencies
RUN apt-get update && apt-get install -y \
    curl git unzip python3 python3-pip wget fuse libglib2.0-bin && \
    apt-get clean && rm -rf /var/lib/apt/lists/*

# Download latest Neovim AppImage
RUN wget -O nvim.appimage https://github.com/neovim/neovim/releases/latest/download/nvim.appimage && \
    chmod u+x nvim.appimage && \
    mv nvim.appimage /usr/local/bin/nvim

# Optional: symlink
RUN ln -s /usr/local/bin/nvim /usr/bin/nvim

WORKDIR /workspace

CMD ["bash"]

#LAZYGIT_VERSION=$(curl -s "https://api.github.com/repos/jesseduffield/lazygit/releases/latest" | \grep -Po '"tag_name": *"v\K[^"]*')
#curl -Lo lazygit.tar.gz "https://github.com/jesseduffield/lazygit/releases/download/v${LAZYGIT_VERSION}/lazygit_${LAZYGIT_VERSION}_Linux_x86_64.tar.gz"
#tar xf lazygit.tar.gz lazygit
#sudo install lazygit -D -t /usr/local/bin/
