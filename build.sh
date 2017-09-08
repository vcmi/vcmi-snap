#!/bin/bash
if [ -z "$encrypted_319916dbe2cd_key" ]; then
    exit 0
fi

mkdir -p "$HOME/.config/snapcraft"

openssl aes-256-cbc -K $encrypted_319916dbe2cd_key -iv $encrypted_319916dbe2cd_iv -in snapcraft.cfg.enc -out "$HOME/.config/snapcraft/snapcraft.cfg" -d

docker run \
-v $HOME:/root \
-v $(pwd):$(pwd) \
-t snapcore/snapcraft \
sh -c "apt update -qq && cd $(pwd) && snapcraft && snapcraft push *.snap --release edge"
