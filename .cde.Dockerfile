# trunk-ignore-all(checkov/CKV_DOCKER_2)
# trunk-ignore(checkov/CKV_DOCKER_7)
# trunk-ignore(hadolint/DL3007)
FROM gitpod/workspace-base:latest

USER gitpod

# Install Homebrew
RUN /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)" && \
    echo 'eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"' >> ~/.bashrc

# Update Homebrew, Install Terraform & Azure CLI
RUN eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)" && \
    brew update && \
    brew tap hashicorp/tap && \
    brew install hashicorp/tap/terraform && \
    brew upgrade terraform && \
    brew install azure-cli  && \
    brew install aztfexport

RUN curl https://get.trunk.io -fsSL | bash -s -- -y
