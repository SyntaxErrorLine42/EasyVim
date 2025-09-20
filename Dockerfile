# Dockerfile for testing
FROM alpine:latest

# Install dependencies
RUN apk add docker git nodejs neovim go ripgrep grep curl build-base wget --update

RUN git clone https://github.com/jesseduffield/lazydocker.git && \
    cd lazydocker && \
    go install && \
    mv ~/go/bin/lazydocker /usr/bin
    

RUN LAZYGIT_VERSION=$(curl -s "https://api.github.com/repos/jesseduffield/lazygit/releases/latest" | \grep -Po '"tag_name": *"v\K[^"]*') && \
    curl -Lo lazygit.tar.gz "https://github.com/jesseduffield/lazygit/releases/download/v${LAZYGIT_VERSION}/lazygit_${LAZYGIT_VERSION}_Linux_x86_64.tar.gz" && \
    tar xf lazygit.tar.gz lazygit && \
    install lazygit -D -t /usr/local/bin/

WORKDIR /workspace

CMD ["sh"]

