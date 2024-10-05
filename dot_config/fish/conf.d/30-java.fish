#!/usr/bin/env fish

set -gx _JAVA_OPTIONS -Djavafx.cachedir="$XDG_CACHE_HOME"/openjfx -Djava.util.prefs.userRoot="$XDG_CONFIG_HOME"/java
