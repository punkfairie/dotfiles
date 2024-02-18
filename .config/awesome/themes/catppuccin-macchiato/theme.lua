local palette = require("lib.catppuccin.catppuccin.macchiato")
local filesystem = require("gears.filesystem")
local dpi = require("beautiful.xresources").apply_dpi
local theme_assets = require("beautiful.theme_assets")
local helpers = require("helpers")

local theme_path = filesystem.get_configuration_dir() .. "themes/catppuccin-macchiato"

local theme = {}

-- Transparent Color
theme.transparent = "#00000000"

-- Theme colors
theme.color = {
	base = palette.base.hex,
	mantle = palette.mantle.hex,
	crust = palette.crust.hex,

	surface0 = palette.surface0.hex,
	surface1 = palette.surface1.hex,
	surface2 = palette.surface2.hex,

	text = palette.text.hex,
	subtext0 = palette.subtext0.hex,
	subtext1 = palette.subtext1.hex,

	overlay0 = palette.overlay0.hex,
	overlay1 = palette.overlay1.hex,
	overlay2 = palette.overlay2.hex,

	rosewater = palette.rosewater.hex,
	flamingo = palette.flamingo.hex,
	pink = palette.pink.hex,
	mauve = palette.mauve.hex,
	red = palette.red.hex,
	maroon = palette.maroon.hex,
	peach = palette.peach.hex,
	yellow = palette.yellow.hex,
	green = palette.green.hex,
	teal = palette.teal.hex,
	sky = palette.sky.hex,
	sapphire = palette.sapphire.hex,
	blue = palette.blue.hex,
	lavender = palette.lavender.hex,
}

-- Font
theme.font_name = "FiraCode Nerd Font Propo" .. " "
theme.font = theme.font_name .. "10"

-- Assets
theme.music = theme_path .. "assets/music.png"
theme.volume_on = theme_path .. "assets/volume-on.png"
theme.volume_off = theme_path .. "assets/volume-off.png"
theme.pfp = theme_path .. "assets/pfp.jpg"

-- Theme --
theme.titlebar_bg_focus = palette.base.hex
theme.titlebar_bg = palette.base.hex
theme.bg_normal = palette.base.hex
theme.bg_focus = palette.surface0.hex
theme.bg_urgent = palette.red.hex
theme.bg_minimize = "#444"
theme.bg_systray = theme.bg_normal

theme.fg_normal = palette.text.hex
theme.fg_focus = palette.pink.hex
theme.fg_urgent = "#fff"
theme.fg_minimize = "#fff"

theme.useless_gap = dpi(10)
theme.border_width = dpi(3)
theme.border_normal = palette.surface0.hex
theme.border_focus = palette.pink.hex
theme.border_marked = palette.red.hex

theme.menu_font = theme.font_name .. "12"
theme.menu_bg_focus = palette.base.hex
theme.menu_fg_focus = palette.blue.hex
theme.menu_border_width = dpi(2)
theme.submenu = "»  "
theme.menu_height = dpi(37)
theme.menu_width = dpi(194)

theme.tasklist_bg_focus = palette.base.hex
theme.tasklist_fg_focus = palette.lavender.hex
theme.tasklist_disable_icon = true
theme.tasklist_font = theme.font_name .. "11"

theme.taglist_spacing = dpi(2)
theme.taglist_bg_focus = palette.base.hex
theme.taglist_disable_icon = true
theme.taglist_font = theme.font_name .. "11"
theme.taglist_fg_focus = palette.blue.hex
theme.taglist_fg_empty = palette.surface2.hex
theme.taglist_fg_occupied = "#526c96"

-- Generate taglist squares.
local taglist_square_size = dpi(0)
theme.taglist_squares_sel = theme_assets.taglist_squares_sel(taglist_square_size, palette.blue.hex)
theme.taglist_squares_unsel = theme_assets.taglist_squares_unsel(taglist_square_size, theme.taglist_fg_occupied)

-- Edge snap.
theme.snap_bg = palette.pink.hex
theme.snap_border_width = dpi(5)
theme.snap_shape = helpers.ui.rrect(0)

-- Hotkey popup.
theme.hotkeys_shape = helpers.ui.rrect(12)
theme.hotkeys_border_color = palette.pink.hex
theme.hotkeys_modifiers_fg = palette.overlay2.hex
theme.hotkeys_font = theme.font_name .. "9"
theme.hotkeys_description_font = theme.hotkeys_font

-- Layout list.
theme.layoutlist_shape_selected = helpers.ui.rrect(7)

-- Tabs.
theme.mstab_bar_height = 1
theme.mstab_dont_resize_slaves = true
theme.mstab_bar_padding = dpi(10)
theme.mstab_border_radius = dpi(6)
theme.mstab_bar_ontop = false
theme.mstab_tabbar_position = "top"
theme.mstab_tabbar_style = "default"
theme.mstab_bar_disable = true

-- Layout machi.
theme.machi_switcher_border_color = palette.surface0.hex
theme.machi_switcher_border_opacity = 0.4
theme.machi_editor_border_color = palette.surface1.hex
theme.machi_editor_border_opacity = 0.4
theme.machi_editor_active_opacity = 0.4

-- Bling.
theme.tag_preview_widget_border_radius = dpi(6)
theme.tag_preview_client_border_radius = dpi(6)
theme.tag_preview_client_opacity = 1
theme.tag_preview_client_bg = palette.base.hex
theme.tag_preview_client_border_color = palette.surface0.hex
theme.tag_preview_client_border_width = dpi(2)
theme.tag_preview_widget_border_color = palette.pink.hex
theme.tag_preview_widget_border_width = dpi(2)
theme.tag_preview_widget_margin = 4

-- Notifications.
theme.notification_spacing = dpi(4)
theme.notification_bg = palette.base.hex

-- Titlebar images.
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

theme.wallpaper = theme_path .. "buttons.png"

theme.layout_floating = theme_path .. "layouts/floating.png"
theme.layout_max = theme_path .. "layouts/max.png"
theme.layout_tile = theme_path .. "layouts/tile.png"
theme.layout_dwindle = theme_path .. "layouts/dwindle.png"
theme.layout_centered = theme_path .. "layouts/centered.png"
theme.layout_mstab = theme_path .. "layouts/mstab.png"
theme.layout_equalarea = theme_path .. "layouts/equalarea.png"
theme.layout_machi = theme_path .. "layouts/machi.png"

-- Generate Awesome icon.
theme.awesome_icon = theme_assets.awesome_icon(theme.menu_height, theme.bg_focus, theme.fg_focus)

-- Define the icon theme for application icons.
theme.icon_theme = "Papirus"

return theme
