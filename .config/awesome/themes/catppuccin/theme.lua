local beautiful = require("beautiful")
local gfs = require("gears.filesystem")
local config = require("config")
local helpers = require("helpers")

local palette = require("lib.catppuccin.catppuccin." .. config.theme.flavor)

local theme_assets = beautiful.theme_assets
local dpi = beautiful.xresources.apply_dpi

local themes_path = gfs.get_configuration_dir() .. "themes/"

local theme = {}

theme.color = {}

-- Transparent Color --
theme.transparent = "#00000000"

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

theme.music = themes_path .. "catppuccin/assets/music.png"
theme.volume_on = themes_path .. "catppuccin/assets/volume-on.png"
theme.volume_off = themes_path .. "catppuccin/assets/volume-off.png"
theme.pfp = themes_path .. "catppuccin/assets/pfp.jpg"
theme.font = "FiraCode Nerd Font Propo 10"

theme.font_name = "FiraCode Nerd Font Propo "

theme.titlebar_bg_focus = theme.color.base
theme.titlebar_bg = theme.color.base
theme.bg_normal = theme.color.base
theme.bg_focus = theme.color.surface0
theme.bg_urgent = "#ff0000"
theme.bg_minimize = "#444444"
theme.bg_systray = theme.bg_normal

theme.fg_normal = theme.color.subtext1 --Text Color
theme.fg_focus = theme.color.teal
theme.fg_urgent = "#ffffff"
theme.fg_minimize = "#ffffff"

theme.useless_gap = dpi(10)
theme.border_width = dpi(3)
theme.border_normal = theme.color.surface0
theme.border_focus = theme.color.teal
theme.border_marked = "#91231c"

theme.menu_font = "FiraCode Nerd Font 12"
theme.menu_bg_focus = theme.color.base
theme.menu_fg_focus = theme.color.blue
theme.menu_border_width = dpi(2)
--theme.menu_border_radius = dpi()
theme.menu_border_color = theme.color.surface0
--theme.menu_submenu_icon = themes_path.."catppuccin/submenu.png"
theme.submenu = "»  "
theme.menu_height = dpi(37)
theme.menu_width = dpi(194)

theme.tasklist_bg_focus = theme.color.base
theme.tasklist_fg_focus = theme.color.lavender
theme.tasklist_disable_icon = true
theme.tasklist_font = "FiraCode Nerd Font 11"

theme.taglist_spacing = dpi(2)
theme.taglist_bg_focus = theme.color.base
theme.taglist_disable_icon = true
theme.taglist_font = "FiraCode Nerd Font 11"
theme.taglist_fg_focus = theme.color.blue --"#7e9dde"
theme.taglist_fg_empty = theme.color.surface2
theme.taglist_fg_occupied = "#526c96"

-- Generate taglist squares:
local taglist_square_size = dpi(0)
theme.taglist_squares_sel = theme_assets.taglist_squares_sel(taglist_square_size, theme.color.blue)
theme.taglist_squares_unsel = theme_assets.taglist_squares_unsel(taglist_square_size, theme.taglist_fg_occupied)

-- Edge Snap
theme.snap_bg = theme.color.teal
theme.snap_border_width = dpi(5)
theme.snap_shape = helpers.ui.rrect(0)

-- Hotkey Popup
theme.hotkeys_shape = helpers.ui.rrect(12)
theme.hotkeys_border_color = theme.color.teal
theme.hotkeys_modifiers_fg = theme.color.overlay2
theme.hotkeys_font = "FiraCode Nerd Font 9"
theme.hotkeys_description_font = "FiraCode Nerd Font 9"

-- Layoutlist
theme.layoutlist_shape_selected = helpers.ui.rrect(7)

-- Tabs
theme.mstab_bar_height = 1
theme.mstab_dont_resize_slaves = true
theme.mstab_bar_padding = dpi(10)
theme.mstab_border_radius = dpi(6)
theme.mstab_bar_ontop = false
theme.mstab_tabbar_position = "top"
theme.mstab_tabbar_style = "default"
theme.mstab_bar_disable = true
--theme.tabbar_bg_focus = theme.color.surface0
--theme.tabbar_bg_normal = theme.color.surface0
--theme.tabbar_radius = dpi(6)

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
theme.tag_preview_widget_border_color = theme.color.teal
theme.tag_preview_widget_border_width = dpi(2)
theme.tag_preview_widget_margin = 4
-- Variables set for theming notifications:
-- notification_font
theme.notification_spacing = dpi(4)
theme.notification_bg = theme.color.base
-- notification_[bg|fg]
-- notification_[width|height|margin]
-- notification_[border_color|border_width|shape|opacity]

-- Variables set for theming the menu:
-- menu_[bg|fg]_[normal|focus]
-- menu_[border_color|border_width]

-- You can add as many variables as
-- you wish and access them by using
-- beautiful.variable in your rc.lua
--theme.bg_widget = "#cc0000"

-- Define the image to load
theme.titlebar_close_button_normal = themes_path .. "catppuccin/titlebar/unfocus.svg"
theme.titlebar_close_button_focus = themes_path .. "catppuccin/titlebar/close.svg"
theme.titlebar_close_button_normal_hover = themes_path .. "catppuccin/titlebar/close_hover.svg"
theme.titlebar_close_button_focus_hover = themes_path .. "catppuccin/titlebar/close_hover.svg"

theme.titlebar_minimize_button_normal = themes_path .. "catppuccin/titlebar/unfocus.svg"
theme.titlebar_minimize_button_focus = themes_path .. "catppuccin/titlebar/minimize.svg"
theme.titlebar_minimize_button_normal_hover = themes_path .. "catppuccin/titlebar/minimize_hover.svg"
theme.titlebar_minimize_button_focus_hover = themes_path .. "catppuccin/titlebar/minimize_hover.svg"

theme.titlebar_ontop_button_normal_inactive = themes_path .. "catppuccin/titlebar/unfocus.svg"
theme.titlebar_ontop_button_focus_inactive = themes_path .. "catppuccin/titlebar/ontop.svg"

theme.titlebar_ontop_button_normal_active = themes_path .. "catppuccin/titlebar/unfocus.svg"
theme.titlebar_ontop_button_focus_active = themes_path .. "catppuccin/titlebar/ontop.svg"

theme.titlebar_maximized_button_normal_active = themes_path .. "catppuccin/titlebar/unfocus.svg"
theme.titlebar_maximized_button_focus_active = themes_path .. "catppuccin/titlebar/maximize.svg"
theme.titlebar_maximized_button_normal_active_hover = themes_path .. "catppuccin/titlebar/maximize_hover.svg"
theme.titlebar_maximized_button_focus_active_hover = themes_path .. "catppuccin/titlebar/maximize_hover.svg"

theme.titlebar_maximized_button_normal_inactive = themes_path .. "catppuccin/titlebar/unfocus.svg"
theme.titlebar_maximized_button_focus_inactive = themes_path .. "catppuccin/titlebar/maximize.svg"
theme.titlebar_maximized_button_normal_inactive_hover = themes_path .. "catppuccin/titlebar/maximize_hover.svg"
theme.titlebar_maximized_button_focus_inactive_hover = themes_path .. "catppuccin/titlebar/maximize_hover.svg"

-- You can use your own layout icons like this:
theme.layout_floating = themes_path .. "catppuccin/layouts/floating.png"
theme.layout_max = themes_path .. "catppuccin/layouts/max.png"
theme.layout_tile = themes_path .. "catppuccin/layouts/tile.png"
theme.layout_dwindle = themes_path .. "catppuccin/layouts/dwindle.png"
theme.layout_centered = themes_path .. "catppuccin/layouts/centered.png"
theme.layout_mstab = themes_path .. "catppuccin/layouts/mstab.png"
theme.layout_equalarea = themes_path .. "catppuccin/layouts/equalarea.png"
theme.layout_machi = themes_path .. "catppuccin/layouts/machi.png"

-- Generate Awesome icon:
theme.awesome_icon = theme_assets.awesome_icon(theme.menu_height, theme.bg_focus, theme.fg_focus)

-- Define the icon theme for application icons. If not set then the icons
-- from /usr/share/icons and /usr/share/icons/hicolor will be used.
theme.icon_theme = "Tela-circle-dark"

return theme
