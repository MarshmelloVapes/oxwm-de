---@meta
-------------------------------------------------------------------------------
-- OXWM Configuration File
-------------------------------------------------------------------------------
-- This is the default configuration for OXWM, a dynamic window manager.
-- Edit this file and reload with Mod+Shift+R (no compilation needed)
--
-- For more information about configuring OXWM, see the documentation.
-- The Lua Language Server provides autocomplete and type checking.
-------------------------------------------------------------------------------

---Load type definitions for LSP
---@module 'oxwm'

-------------------------------------------------------------------------------
-- Variables
-------------------------------------------------------------------------------
-- Define your variables here for easy customization throughout the config.
-- This makes it simple to change keybindings, colors, and settings in one place.

-- Modifier key: "Mod4" is the Super/Windows key, "Mod1" is Alt
local modkey = "Mod4"

-- Terminal emulator command (defaults to alacritty)
local terminal = "alacritty"

-- test
-- local test_name = "alacritty -e curl wttr.in/"

-- Color palette - customize these to match your theme
-- Alternatively you can import other files in here, such as 
-- local colors = require("colors.lua") and make colors.lua a file
-- in the ~/.config/oxwm directory
local colors = {
    -- Gruv Style Colors
    gruv_lightred = "#d5c4a1",
    gruv_fg = "#fbf1c7",
    gruv_red = "#cc241d",
    gruv_bg = "#504945",
    gruv_cyan = "#8ec07c",
    gruv_green = "#8ec07c",
    gruv_lavender = "#b16286",
    gruv_grey = "#504945",
    gruv_blue = "#458588",
    gruv_lightblue = "#83a598",
    gruv_orange = "#fe8019",
    gruv_purple = "#b16286",
}

-- Workspace tags - can be numbers, names, or icons (requires a Nerd Font)
local tags = { "1", "2", "3", "4", "5", "6"}

-- Font for the status bar (use "fc-list" to see available fonts)
local bar_font = "JetBrainsMono Nerd Font:size=11"

-- Define your blocks
local blocks = {
    oxwm.bar.block.ram({
        format = "Ram: {used} GB",
        interval = 5,
        color = colors.gruv_lightblue,
        underline = false,
    }),
    oxwm.bar.block.static({
        text = " │  ",
        interval = 999999999,
        color = colors.gruv_fg,
        underline = false,
    }),
    oxwm.bar.block.battery({
         format = "Bat: {}%",
         charging = "Bat: {}%",
         discharging = "Bat: {}%",
         full = "Bat: {}%",
         interval = 30,
         color = colors.gruv_green,
         underline = false,
     }),
     oxwm.bar.block.static({
        text = " │  ",
        interval = 999999999,
        color = colors.gruv_fg,
        underline = false,
     }),
     oxwm.bar.block.shell({
    	format = "Vol: {}",
    	command = "pamixer --get-volume",
    	interval = 1,
    	color = colors.gruv_lightred,
    	underline = false,
     }),
    oxwm.bar.block.static({
        text = " │  ",
        interval = 999999999,
        color = colors.gruv_fg,
        underline = false,
    }),
    oxwm.bar.block.datetime({
        format = "{}",
        date_format = "%a, %b %d - %-H:%M",
        interval = 1,
        color = colors.gruv_orange,
        underline = false,
    }),
};

-------------------------------------------------------------------------------
-- Basic Settings
-------------------------------------------------------------------------------
oxwm.set_terminal(terminal)
oxwm.set_modkey(modkey) -- This is for Mod + mouse binds, such as drag/resize
oxwm.set_tags(tags)

-------------------------------------------------------------------------------
-- Layouts
-------------------------------------------------------------------------------
-- Set custom symbols for layouts (displayed in the status bar)
-- Available layouts: "tiling", "normie" (floating), "grid", "monocle", "tabbed"
oxwm.set_layout_symbol("tiling", "| Tiled |")
oxwm.set_layout_symbol("normie", "| Floating |")
oxwm.set_layout_symbol("tabbed", "| Tabbed |")
oxwm.set_layout_symbol("grid", "| Grid |")
oxwm.set_layout_symbol("monocle", "| Monocle |")

-------------------------------------------------------------------------------
-- Appearance
-------------------------------------------------------------------------------
-- Border configuration

-- Width in pixels
oxwm.border.set_width(1)
-- Color of focused window border
oxwm.border.set_focused_color(colors.gruv_bg)
-- Color of unfocused window borders
oxwm.border.set_unfocused_color(colors.gruv_grey)

-- Smart Enabled = No border if 1 window
oxwm.gaps.set_smart(enabled)
-- Inner gaps (horizontal, vertical) in pixels
oxwm.gaps.set_inner(6, 6)
-- Outer gaps (horizontal, vertical) in pixels
oxwm.gaps.set_outer(6, 6)

-------------------------------------------------------------------------------
-- Window Rules
-------------------------------------------------------------------------------
-- Rules allow you to automatically configure windows based on their properties
-- You can match windows by class, instance, title, or role
-- Available properties: floating, tag, fullscreen, etc.
--
-- Common use cases:
-- - Force floating for certain applications (dialogs, utilities)
-- - Send specific applications to specific workspaces
-- - Configure window behavior based on title or class

-- Examples (uncomment to use):
oxwm.rule.add({ instance = "gimp", floating = true })                             
-- oxwm.rule.add({ class = "Alacritty", tag = 9, focus = true })                             
-- oxwm.rule.add({ class = "firefox", tag = 2 })  
oxwm.rule.add({ instance = "kitty", floating = true })                      

-- To find window properties, use xprop and click on the window
-- WM_CLASS(STRING) shows both instance and class (instance, class)

-------------------------------------------------------------------------------
-- Status Bar Configuration
-------------------------------------------------------------------------------
-- Font configuration
oxwm.bar.set_font(bar_font)

-- Set your blocks here (defined above)
oxwm.bar.set_blocks(blocks)

-- Bar color schemes (for workspace tag display)
-- Parameters: foreground, background, border

-- Unoccupied tags
oxwm.bar.set_scheme_normal(colors.gruv_fg, colors.gruv_bg, "#444444")
-- Occupied tags
oxwm.bar.set_scheme_occupied(colors.gruv_cyan, colors.gruv_bg, colors.gruv_cyan)
-- Currently selected tag
oxwm.bar.set_scheme_selected(colors.gruv_cyan, colors.gruv_bg, colors.gruv_purple)
-- Urgent tags (windows requesting attention)
oxwm.bar.set_scheme_urgent(colors.gruv_red, colors.gruv_bg, colors.gruv_red)

-- Hide tags that have no windows and are not selected
-- oxwm.bar.set_hide_vacant_tags(true)

-------------------------------------------------------------------------------
-- Keybindings
-------------------------------------------------------------------------------
-- Keybindings are defined using oxwm.key.bind(modifiers, key, action)
-- Modifiers: {"Mod4"}, {"Mod1"}, {"Shift"}, {"Control"}, or combinations like {"Mod4", "Shift"}
-- Keys: Use uppercase for letters (e.g., "Return", "H", "J", "K", "L")
-- Actions: Functions that return actions (e.g., oxwm.spawn(), oxwm.client.kill())
--
-- A list of available keysyms can be found in the X11 keysym definitions.
-- Common keys: Return, Space, Tab, Escape, Backspace, Delete, Left, Right, Up, Down

-- Basic window management

oxwm.key.bind({ modkey }, "Return", oxwm.spawn_terminal())

-- Launch rofi
oxwm.key.bind({ modkey }, "D", oxwm.spawn({ "sh", "-c", "~/.config/rofi/launchers/type-2/launcher.sh" }))

-- Copy screenshot to clipboard
oxwm.key.bind({ modkey, "Shift" }, "S", oxwm.spawn({ "sh", "-c", "maim -s | xclip -selection clipboard -t image/png" }))

-- Kill program
oxwm.key.bind({ modkey }, "Q", oxwm.client.kill())

-- Volume Controls
oxwm.key.bind({ }, "F1", oxwm.spawn({ "sh", "-c", "pactl set-sink-mute 0 toggle"  }))
oxwm.key.bind({ }, "F2", oxwm.spawn({ "sh", "-c", "pactl set-sink-volume 0 -5%"  }))
oxwm.key.bind({ }, "F3", oxwm.spawn({ "sh", "-c", "pactl set-sink-volume 0 +5%"  }))

-- Brightness Controls
oxwm.key.bind({ }, "F6", oxwm.spawn({ "sh", "-c", "brightnessctl set 5%+"  }))
oxwm.key.bind({ }, "F5", oxwm.spawn({ "sh", "-c", "brightnessctl set 5%-"  }))

-- Firefox
oxwm.key.bind({ modkey }, "F", oxwm.spawn({ "sh", "-c", "firefox"  }))

-- Keybind overlay - Shows important keybindings on screen
oxwm.key.bind({ modkey, "Shift" }, "Slash", oxwm.show_keybinds())

-- Window state toggles
oxwm.key.bind({ modkey, "Shift" }, "F", oxwm.client.toggle_fullscreen())
oxwm.key.bind({ modkey, "Shift" }, "Space", oxwm.client.toggle_floating())

-- Cycle through layouts
oxwm.key.bind({ modkey }, "N", oxwm.layout.cycle())

-- Master area controls (tiling layout)

-- Decrease/Increase master area width
oxwm.key.bind({ modkey }, "H", oxwm.set_master_factor(-5))
oxwm.key.bind({ modkey }, "L", oxwm.set_master_factor(5))
-- Increment/Decrement number of master windows
oxwm.key.bind({ modkey }, "I", oxwm.inc_num_master(1))
oxwm.key.bind({ modkey }, "P", oxwm.inc_num_master(-1))

-- Gaps toggle
oxwm.key.bind({ modkey }, "A", oxwm.toggle_gaps())

-- Window manager controls
oxwm.key.bind({ modkey, "Shift" }, "P", oxwm.quit())
oxwm.key.bind({ modkey, "Shift" }, "R", oxwm.restart())

-- Focus movement [1 for up in the stack, -1 for down]
oxwm.key.bind({ modkey }, "J", oxwm.client.focus_stack(1))
oxwm.key.bind({ modkey }, "K", oxwm.client.focus_stack(-1))

-- Window movement (swap position in stack)
oxwm.key.bind({ modkey, "Shift" }, "J", oxwm.client.move_stack(1))
oxwm.key.bind({ modkey, "Shift" }, "K", oxwm.client.move_stack(-1))

-- Multi-monitor support

-- Focus next/previous Monitors
oxwm.key.bind({ modkey }, "Comma", oxwm.monitor.focus(-1))
oxwm.key.bind({ modkey }, "Period", oxwm.monitor.focus(1))
-- Move window to next/previous Monitors
oxwm.key.bind({ modkey, "Shift" }, "Comma", oxwm.monitor.tag(-1))
oxwm.key.bind({ modkey, "Shift" }, "Period", oxwm.monitor.tag(1))

-- Workspace (tag) navigation
-- Switch to workspace N (tags are 0-indexed, so tag "1" is index 0)
oxwm.key.bind({ modkey }, "1", oxwm.tag.view(0))
oxwm.key.bind({ modkey }, "2", oxwm.tag.view(1))
oxwm.key.bind({ modkey }, "3", oxwm.tag.view(2))
oxwm.key.bind({ modkey }, "4", oxwm.tag.view(3))
oxwm.key.bind({ modkey }, "5", oxwm.tag.view(4))
oxwm.key.bind({ modkey }, "6", oxwm.tag.view(5))
oxwm.key.bind({ modkey }, "7", oxwm.tag.view(6))
oxwm.key.bind({ modkey }, "8", oxwm.tag.view(7))
oxwm.key.bind({ modkey }, "9", oxwm.tag.view(8))

-- Move focused window to workspace N
oxwm.key.bind({ modkey, "Shift" }, "1", oxwm.tag.move_to(0))
oxwm.key.bind({ modkey, "Shift" }, "2", oxwm.tag.move_to(1))
oxwm.key.bind({ modkey, "Shift" }, "3", oxwm.tag.move_to(2))
oxwm.key.bind({ modkey, "Shift" }, "4", oxwm.tag.move_to(3))
oxwm.key.bind({ modkey, "Shift" }, "5", oxwm.tag.move_to(4))
oxwm.key.bind({ modkey, "Shift" }, "6", oxwm.tag.move_to(5))
oxwm.key.bind({ modkey, "Shift" }, "7", oxwm.tag.move_to(6))
oxwm.key.bind({ modkey, "Shift" }, "8", oxwm.tag.move_to(7))
oxwm.key.bind({ modkey, "Shift" }, "9", oxwm.tag.move_to(8))

-- Combo view (view multiple tags at once) {argos_nothing}
-- Example: Mod+Ctrl+2 while on tag 1 will show BOTH tags 1 and 2
oxwm.key.bind({ modkey, "Control" }, "1", oxwm.tag.toggleview(0))
oxwm.key.bind({ modkey, "Control" }, "2", oxwm.tag.toggleview(1))
oxwm.key.bind({ modkey, "Control" }, "3", oxwm.tag.toggleview(2))
oxwm.key.bind({ modkey, "Control" }, "4", oxwm.tag.toggleview(3))
oxwm.key.bind({ modkey, "Control" }, "5", oxwm.tag.toggleview(4))
oxwm.key.bind({ modkey, "Control" }, "6", oxwm.tag.toggleview(5))
oxwm.key.bind({ modkey, "Control" }, "7", oxwm.tag.toggleview(6))
oxwm.key.bind({ modkey, "Control" }, "8", oxwm.tag.toggleview(7))
oxwm.key.bind({ modkey, "Control" }, "9", oxwm.tag.toggleview(8))

-- Multi tag (window on multiple tags)
-- Example: Mod+Ctrl+Shift+2 puts focused window on BOTH current tag and tag 2
oxwm.key.bind({ modkey, "Control", "Shift" }, "1", oxwm.tag.toggletag(0))
oxwm.key.bind({ modkey, "Control", "Shift" }, "2", oxwm.tag.toggletag(1))
oxwm.key.bind({ modkey, "Control", "Shift" }, "3", oxwm.tag.toggletag(2))
oxwm.key.bind({ modkey, "Control", "Shift" }, "4", oxwm.tag.toggletag(3))
oxwm.key.bind({ modkey, "Control", "Shift" }, "5", oxwm.tag.toggletag(4))
oxwm.key.bind({ modkey, "Control", "Shift" }, "6", oxwm.tag.toggletag(5))
oxwm.key.bind({ modkey, "Control", "Shift" }, "7", oxwm.tag.toggletag(6))
oxwm.key.bind({ modkey, "Control", "Shift" }, "8", oxwm.tag.toggletag(7))
oxwm.key.bind({ modkey, "Control", "Shift" }, "9", oxwm.tag.toggletag(8))

-------------------------------------------------------------------------------
-- Advanced: Keychords
-------------------------------------------------------------------------------
-- Keychords allow you to bind multiple-key sequences (like Emacs or Vim)
-- Format: {{modifiers}, key1}, {{modifiers}, key2}, ...
-- Example: Press Mod4+Space, then release and press T to spawn a terminal
oxwm.key.chord({
    { { modkey }, "Space" },
    { {},         "B" }
}, oxwm.spawn({ "sh", "-c", "alacritty -e bluetui" }))
oxwm.key.chord({
    { { modkey }, "Space" },
    { {},         "W" }
}, oxwm.spawn({ "sh", "-c", "alacritty -e ~/.scripts/WTTR/wttr" }))
oxwm.key.chord({
    { { modkey }, "Space" },
    { {},         "S" }
}, oxwm.spawn({ "sh", "-c", "kitty -e ~/.scripts/BTC-Price/WatchList" }))

-------------------------------------------------------------------------------
-- Autostart
-------------------------------------------------------------------------------
-- Commands to run once when OXWM starts
-- Uncomment and modify these examples, or add your own

oxwm.autostart("picom")                                  
oxwm.autostart("feh --bg-scale ~/Downloads/background-3.png") 
-- oxwm.autostart("nm-applet")
