#!/usr/bin/env fish

set -Ux _JAVA_OPTIONS -Djavafx.cachedir="$XDG_CACHE_HOME"/openjfx -Djava.util.prefs.userRoot="$XDG_CONFIG_HOME"/java
