{{- if lookPath "fish" -}}
#!/bin/env bash

if [ "$SHELL" != "$(which fish)" ]; then
	chsh -s "$(which fish)"
fi

{{- end -}}
