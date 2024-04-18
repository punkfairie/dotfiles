#!/usr/bin/env fish

set -gx BW_CLIENTID czvWnI1nGIyNm7G6VjLkcl3Ct9ukQb
set -gx BW_CLIENTSECRET user.d18b72ce-c550-4ac7-9df0-b0f60049ab30

if status is-interactive
    set -gx BW_SESSION (bw login --apikey &>/dev/null && bw unlock --raw)
end
