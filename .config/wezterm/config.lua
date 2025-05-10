local wezterm = require("wezterm")
local config = {}

-- The filled in variant of the < symbol
local SOLID_LEFT_ARROW = wezterm.nerdfonts.pl_right_hard_divider
-- The filled in variant of the > symbol
local SOLID_RIGHT_ARROW = wezterm.nerdfonts.pl_left_hard_divider

if wezterm.config_builder then
	config = wezterm.config_builder()
end

-- Key bindings configuration
local keys = {
	{
		key = "Backspace",
		mods = "CMD",
		action = wezterm.action.SendString("\x15"), -- CTRL+U
	},
	{
		key = "Backspace",
		mods = "ALT",
		action = wezterm.action.SendString("\x17"), -- CTRL+W
	},
	{
		key = "r",
		mods = "CMD",
		action = wezterm.action.ClearScrollback("ScrollbackAndViewport"),
	},
}

-- Config settings
config.default_cursor_style = "BlinkingBar"
config.automatically_reload_config = true
config.window_close_confirmation = "NeverPrompt"
config.adjust_window_size_when_changing_font_size = false
config.window_decorations = "RESIZE"
config.check_for_updates = false
config.use_fancy_tab_bar = false
config.tab_bar_at_bottom = false
config.font_size = 13
config.max_fps = 144
config.font = wezterm.font({
	family = "JetBrainsMono Nerd Font",
	weight = "Regular",
})
config.enable_tab_bar = true
config.window_padding = {
	left = 3,
	right = 3,
	top = 0,
	bottom = 0,
}
config.animation_fps = 1
config.cursor_blink_rate = 800
config.enable_scroll_bar = false
config.enable_kitty_graphics = true
config.front_end = "WebGpu"
config.webgpu_power_preference = "HighPerformance"
config.window_background_opacity = 0
config.initial_cols = 120
config.initial_rows = 35
config.keys = keys

-- Background image and color
config.background = {
	{
		source = {
			File = "/Users/" .. os.getenv("USER") .. "/.config/wezterm/rem.jpg",
		},
		hsb = {
			hue = 1.0,
			saturation = 1.0,
			brightness = 0.25,
		},
	},
	{
		source = {
			Color = wezterm.color.parse("#2C202C"),
		},
		width = "100%",
		height = "100%",
		opacity = 0.8,
	},
}

-- Hyperlink matching rules
config.hyperlink_rules = {
	{ regex = "\\((\\w+://\\S+)\\)", format = "$1", highlight = 1 },
	{ regex = "\\[(\\w+://\\S+)\\]", format = "$1", highlight = 1 },
	{ regex = "\\{(\\w+://\\S+)\\}", format = "$1", highlight = 1 },
	{ regex = "<(\\w+://\\S+)>", format = "$1", highlight = 1 },
	{ regex = "[^(]\\b(\\w+://\\S+[)/a-zA-Z0-9-]+)", format = "$1", highlight = 1 },
	{ regex = "\\b\\w+@[\\w-]+(\\.[\\w-]+)+\\b", format = "mailto:$0" },
}

-- Dynamic tab title formatting
config.color_scheme = "Catppuccin Mocha"

return config
