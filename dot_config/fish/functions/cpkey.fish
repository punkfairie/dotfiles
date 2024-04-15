#!/usr/bin/env fish

function cpkey -d "Copy the id_ed25519 public key to clipboard, generating the keypair if needed"
    if ! [ -O "~/.ssh/id_ed25519.pub" ]
        echo "=> Generating id_ed25519 keypair..."
        ssh-keygen -f "~/.ssh/id_ed25519"
    end

    more "~/.ssh/id_ed25519.pub" | copyq copy -
    echo "=> Public key copied to clipbard"
end
