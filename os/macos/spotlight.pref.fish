#!/usr/bin/env fish

source "$DOT/script/utils.fish"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

print_subtitle Spotlight

execute "defaults write com.apple.spotlight orderedItems -array \
        '{\"enabled\" = 1;\"name\" = \"APPLICATIONS\";}' \
        '{\"enabled\" = 1;\"name\" = \"SYSTEM_PREFS\";}' \
        '{\"enabled\" = 1;\"name\" = \"DIRECTORIES\";}' \
        '{\"enabled\" = 1;\"name\" = \"PDF\";}' \
        '{\"enabled\" = 1;\"name\" = \"FONTS\";}' \
        '{\"enabled\" = 1;\"name\" = \"DOCUMENTS\";}' \
        '{\"enabled\" = 1;\"name\" = \"MESSAGES\";}' \
        '{\"enabled\" = 1;\"name\" = \"CONTACT\";}' \
        '{\"enabled\" = 0;\"name\" = \"EVENT_TODO\";}' \
        '{\"enabled\" = 0;\"name\" = \"IMAGES\";}' \
        '{\"enabled\" = 0;\"name\" = \"BOOKMARKS\";}' \
        '{\"enabled\" = 0;\"name\" = \"MUSIC\";}' \
        '{\"enabled\" = 0;\"name\" = \"MOVIES\";}' \
        '{\"enabled\" = 0;\"name\" = \"PRESENTATIONS\";}' \
        '{\"enabled\" = 0;\"name\" = \"SPREADSHEETS\";}' \
        '{\"enabled\" = 0;\"name\" = \"SOURCE\";}' \
        '{\"enabled\" = 1;\"name\" = \"MENU_DEFINITION\";}' \
        '{\"enabled\" = 0;\"name\" = \"MENU_OTHER\";}' \
        '{\"enabled\" = 1;\"name\" = \"MENU_CONVERSION\";}' \
        '{\"enabled\" = 1;\"name\" = \"MENU_EXPRESSION\";}' \
        '{\"enabled\" = 0;\"name\" = \"MENU_WEBSEARCH\";}' \
        '{\"enabled\" = 0;\"name\" = \"MENU_SPOTLIGHT_SUGGESTIONS\";}'" \
    "Customize Spotlight search categories"

killall mds &>/dev/null

execute "sudo mdutil -i on / >/dev/null" "Enable indexing for the main volume"

execute "sudo mdutil -E / >/dev/null" "Rebuild index"
