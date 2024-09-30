#!/usr/bin/env fish

function cpkey -d "Copy the id_ed25519 public key to clipboard, generating the keypair if needed"
    if ! [ -O "$HOME/.ssh/id_ed25519.pub" ]
        echo "=> Generating id_ed25519 keypair..."
        ssh-keygen -f "$HOME/.ssh/id_ed25519"
    end

    if command -v copyq &>/dev/null
        more "$HOME/.ssh/id_ed25519.pub" | copyq copy -
    else if command -v pbcopy &>/dev/null
        more "$HOME/.ssh/id_ed25519.pub" | pbcopy
    else
        echo "=> Unsupported OS - please add your copy command to this script :)"
        return 1
    end
    echo "=> Public key copied to clipbard"
end
