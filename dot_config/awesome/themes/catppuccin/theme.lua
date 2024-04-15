local beautiful = require("beautiful")
local gfs = require("gears.filesystem")
local config = require("config")
local helpers = require("helpers")

local palette = require("lib.catppuccin.catppuccin." .. config.theme.flavor)

local theme_assets = beautiful.theme_assets
local dpi = beautiful.xresources.apply_dpi

local theme_path = gfs.get_configuration_dir() .. "themes/catppuccin/"

local theme = {}

theme.color = {}

-- Transparent Color --
theme.color.transparent = "#00000000"

-- Base --
theme.color.crust = palette.crust.hex
theme.color.mantle = palette.mantle.hex
theme.color.base = palette.base.hex

-- Surface --
theme.color.surface0 = palette.surface0.hex
theme.color.surface1 = palette.surface1.hex
theme.color.surface2 = palette.surface2.hex

-- Overlay --
theme.color.overlay0 = palette.overlay0.hex
theme.color.overlay1 = palette.overlay1.hex
theme.color.overlay2 = palette.overlay2.hex

-- Text --
theme.color.text = palette.text.hex
theme.color.subtext0 = palette.subtext0.hex
theme.color.subtext1 = palette.subtext1.hex

theme.color.lavender = palette.lavender.hex
theme.color.blue = palette.blue.hex
theme.color.sapphire = palette.sapphire.hex
theme.color.sky = palette.sky.hex
theme.color.teal = palette.teal.hex
theme.color.green = palette.green.hex
theme.color.yellow = palette.yellow.hex
theme.color.peach = palette.peach.hex
theme.color.maroon = palette.maroon.hex
theme.color.red = palette.red.hex
theme.color.mauve = palette.mauve.hex
theme.color.pink = palette.pink.hex
theme.color.flamingo = palette.flamingo.hex
theme.color.rosewater = palette.rosewater.hex

theme.color.accent1 = theme.color[config.theme.accent1]
theme.color.accent2 = theme.color[config.theme.accent2]

theme.music = theme_path .. "assets/music.png"
theme.volume_on = theme_path .. "assets/volume-on.png"
theme.volume_off = theme_path .. "assets/volume-off.png"
theme.pfp = config.theme.pfp
theme.wallpaper = config.theme.wallpaper
theme.font = config.theme.font.family .. " " .. config.theme.font.size

theme.titlebar_bg_focus = theme.color.base
theme.titlebar_bg = theme.color.base
theme.bg_normal = theme.color.base
theme.bg_focus = theme.color.surface0
theme.bg_urgent = theme.color.red
theme.bg_minimize = theme.color.surface1
theme.bg_systray = theme.bg_normal

theme.fg_normal = theme.color.subtext1 -- text color
theme.fg_focus = theme.color.accent1
theme.fg_urgent = theme.color.text
theme.fg_minimize = theme.color.text

theme.useless_gap = dpi(10)
theme.border_width = dpi(1)
theme.border_normal = theme.color.surface0
theme.border_focus = theme.color.accent1
theme.border_marked = theme.color.maroon

theme.menu_font = helpers.ui.set_font("12", theme.font)
theme.menu_bg_focus = theme.color.base
theme.menu_fg_focus = theme.color.accent2
theme.menu_border_width = dpi(2)
theme.menu_border_color = theme.color.surface0
theme.submenu = config.icons.arr.r .. "  "
theme.menu_height = dpi(37)
theme.menu_width = dpi(194)

theme.tasklist_bg_focus = theme.color.base
theme.tasklist_fg_focus = theme.color.lavender
theme.tasklist_disable_icon = true
theme.tasklist_font = helpers.ui.set_font("11", theme.font)

theme.taglist_spacing = dpi(2)
theme.taglist_bg_focus = theme.color.base
theme.taglist_disable_icon = true
theme.taglist_font = helpers.ui.set_font("11", theme.font)
theme.taglist_fg_focus = theme.color.accent2
theme.taglist_fg_empty = theme.color.surface2
theme.taglist_fg_occupied = theme.color.sky

-- Generate taglist squares:
local taglist_square_size = dpi(0)
theme.taglist_squares_sel = theme_assets.taglist_squares_sel(taglist_square_size, theme.color.accent2)
theme.taglist_squares_unsel = theme_assets.taglist_squares_unsel(taglist_square_size, theme.taglist_fg_occupied)

-- Edge Snap
theme.snap_bg = theme.color.accent1
theme.snap_border_width = dpi(5)
theme.snap_shape = helpers.ui.rrect(0)

-- Hotkey Popup
theme.hotkeys_shape = helpers.ui.rrect(12)
theme.hotkeys_border_color = theme.color.accent1
theme.hotkeys_modifiers_fg = theme.color.overlay2
theme.hotkeys_font = helpers.ui.set_font("10", theme.font)
theme.hotkeys_description_font = helpers.ui.set_font("10", theme.font)

-- Layoutlist
theme.layoutlist_shape_selected = helpers.ui.rrect(7)

-- Tabs
theme.mstab_bar_height = dpi(1)
theme.mstab_dont_resize_slaves = true
theme.mstab_bar_padding = dpi(10)
theme.mstab_border_radius = dpi(6)
theme.mstab_bar_ontop = false
theme.mstab_tabbar_position = "top"
theme.mstab_tabbar_style = "default"
theme.mstab_bar_disable = true

-- Layout Machi
theme.machi_switcher_border_color = theme.color.surface0
theme.machi_switcher_border_opacity = 0.4
theme.machi_editor_border_color = theme.color.surface1
theme.machi_editor_border_opacity = 0.4
theme.machi_editor_active_opacity = 0.4

-- Bling
theme.tag_preview_widget_border_radius = dpi(6)
theme.tag_preview_client_border_radius = dpi(6)
theme.tag_preview_client_opacity = 1
theme.tag_preview_client_bg = theme.color.base
theme.tag_preview_client_border_color = theme.color.surface0
theme.tag_preview_client_border_width = dpi(2)
theme.tag_preview_widget_border_color = theme.color.accent1
theme.tag_preview_widget_border_width = dpi(2)
theme.tag_preview_widget_margin = 4

-- Notifications
theme.notification_spacing = dpi(4)
theme.notification_bg = theme.color.base

-- Titlebar icons
theme.titlebar_close_button_normal = theme_path .. "titlebar/unfocus.svg"
theme.titlebar_close_button_focus = theme_path .. "titlebar/close.svg"
theme.titlebar_close_button_normal_hover = theme_path .. "titlebar/close_hover.svg"
theme.titlebar_close_button_focus_hover = theme_path .. "titlebar/close_hover.svg"

theme.titlebar_minimize_button_normal = theme_path .. "titlebar/unfocus.svg"
theme.titlebar_minimize_button_focus = theme_path .. "titlebar/minimize.svg"
theme.titlebar_minimize_button_normal_hover = theme_path .. "titlebar/minimize_hover.svg"
theme.titlebar_minimize_button_focus_hover = theme_path .. "titlebar/minimize_hover.svg"

theme.titlebar_ontop_button_normal_inactive = theme_path .. "titlebar/unfocus.svg"
theme.titlebar_ontop_button_focus_inactive = theme_path .. "titlebar/ontop.svg"

theme.titlebar_ontop_button_normal_active = theme_path .. "titlebar/unfocus.svg"
theme.titlebar_ontop_button_focus_active = theme_path .. "titlebar/ontop.svg"

theme.titlebar_maximized_button_normal_active = theme_path .. "titlebar/unfocus.svg"
theme.titlebar_maximized_button_focus_active = theme_path .. "titlebar/maximize.svg"
theme.titlebar_maximized_button_normal_active_hover = theme_path .. "titlebar/maximize_hover.svg"
theme.titlebar_maximized_button_focus_active_hover = theme_path .. "titlebar/maximize_hover.svg"

theme.titlebar_maximized_button_normal_inactive = theme_path .. "titlebar/unfocus.svg"
theme.titlebar_maximized_button_focus_inactive = theme_path .. "titlebar/maximize.svg"
theme.titlebar_maximized_button_normal_inactive_hover = theme_path .. "titlebar/maximize_hover.svg"
theme.titlebar_maximized_button_focus_inactive_hover = theme_path .. "titlebar/maximize_hover.svg"

-- Layout icons
theme.layout_floating = theme_path .. "layouts/floating.png"
theme.layout_max = theme_path .. "layouts/max.png"
theme.layout_tile = theme_path .. "layouts/tile.png"
theme.layout_dwindle = theme_path .. "layouts/dwindle.png"
theme.layout_centered = theme_path .. "layouts/centered.png"
theme.layout_mstab = theme_path .. "layouts/mstab.png"
theme.layout_equalarea = theme_path .. "layouts/equalarea.png"
theme.layout_machi = theme_path .. "layouts/machi.png"

-- Generate Awesome icon:
theme.awesome_icon = theme_assets.awesome_icon(theme.menu_height, theme.bg_focus, theme.fg_focus)

-- Define the icon theme for application icons. If not set then the icons
-- from /usr/share/icons and /usr/share/icons/hicolor will be used.
theme.icon_theme = config.theme.icon_theme

return theme
