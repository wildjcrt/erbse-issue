ARG BASE_IMAGE_TAG=3.1-bullseye

FROM ruby:${BASE_IMAGE_TAG}

LABEL maintainer "Michael Baudino <michael.baudino@alpine-lab.com>"

# Explicitely define locale
# as advised in https://github.com/docker-library/docs/blob/master/ruby/content.md#encoding
ENV LANG="C.UTF-8"

# Define dependencies base versions
ENV RUBYGEMS_VERSION="3.3.22" \
    BUNDLER_VERSION="2.3.22"

# Define some default variables
ENV BUNDLE_PATH="/bundle" \
    BUNDLE_BIN="/bundle/bin" \
    BUNDLE_APP_CONFIG="/bundle" \
    GEM_HOME="/bundle/global" \
    PATH="/bundle/bin:/bundle/global/bin:${PATH}" \
    HISTFILE="/config/.bash_history" \
    GIT_COMMITTER_NAME="Just some fake name to be able to git-clone" \
    GIT_COMMITTER_EMAIL="whatever@this-user-is-not-supposed-to-git-push.anyway" \
    EDITOR="vim"

# Install APT dependencies
RUN sed -i '/bullseye-updates/d' /etc/apt/sources.list \
 && apt-get update \
 && apt-get install --assume-yes --no-install-recommends --no-install-suggests \
      vim \
      ripgrep \
 && rm -rf /var/lib/apt/lists/*

# Install GEM dependencies
RUN gem update --system ${RUBYGEMS_VERSION} \
 && gem install bundler:${BUNDLER_VERSION}

# Install oh-my-zsh
RUN sh -c "$(curl -sSL https://github.com/deluan/zsh-in-docker/releases/download/v1.1.1/zsh-in-docker.sh)" -- \
       -t robbyrussell \
       -p 'history-substring-search' \
       -a 'bindkey "\$terminfo[kcuu1]" history-substring-search-up' \
       -a 'bindkey "\$terminfo[kcud1]" history-substring-search-down'

# Configure the main working directory.
WORKDIR /app

# Use wrappers that check and maintain Ruby & JS dependencies (if necessary) as entrypoint
ENTRYPOINT ["bash"]
