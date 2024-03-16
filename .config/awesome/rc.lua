pcall(require, "luarocks.loader")

local gears = require("gears")
local beautiful = require("beautiful")
local awful = require("awful")

require("awful.autofocus")

-- Theme --
beautiful.init(gears.filesystem.get_configuration_dir() .. "themes/catppuccin/theme.lua")

-- Main/Configuration --
require("main")

-- Libraries/Modules --
require("lib")

-- Signals/Monitoring --
require("signals")

-- Ui/Panels --
require("ui")

-- Autostart --
awful.spawn.with_shell("picom")
awful.spawn.with_shell("~/.config/.fehbg")
