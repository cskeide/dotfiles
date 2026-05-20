-- Hyprland configuration
-- https://wiki.hypr.land/Configuring/Start/

------------------
---- MONITORS ----
------------------

-- See https://wiki.hypr.land/Configuring/Basics/Monitors/
-- Default fallback — host-specific monitors are set in host-files/monitors.lua
hl.monitor({
    output   = "",
    mode     = "preferred",
    position = "auto",
    scale    = "auto",
})


---------------------
---- MY PROGRAMS ----
---------------------

local home         = os.getenv("HOME")
local hypr_scripts = home .. "/.config/hypr/scripts"

local terminal    = "ghostty --gtk-single-instance=true"
local editor      = "code"
local fileManager = "nautilus"
local browser     = "google-chrome-stable"
local menu        = hypr_scripts .. "/launcher.sh menu"
local appmenu     = hypr_scripts .. "/launcher.sh appmenu"
local runmenu     = hypr_scripts .. "/launcher.sh run"


-------------------
---- AUTOSTART ----
-------------------

-- See https://wiki.hypr.land/Configuring/Basics/Autostart/
hl.on("hyprland.start", function()
    hl.exec_cmd("wl-paste --type text --watch cliphist store")
    hl.exec_cmd("wl-paste --type image --watch cliphist store")
    hl.exec_cmd("hyprctl setcursor catppuccin-mocha-dark-cursors 28")
    hl.exec_cmd("systemctl --user start hyprpolkitagent")
    hl.exec_cmd("hypridle")
    hl.exec_cmd("hyprpaper")
    hl.exec_cmd("waybar")
    hl.exec_cmd("nextcloud")
    hl.exec_cmd(terminal .. " --quit-after-last-window-closed=false --initial-window=false")
    hl.exec_cmd(hypr_scripts .. "/launcher.sh")
end)


-------------------------------
---- ENVIRONMENT VARIABLES ----
-------------------------------

hl.env("XDG_CURRENT_DESKTOP", "Hyprland")
hl.env("XDG_SESSION_TYPE", "wayland")
hl.env("XDG_SESSION_DESKTOP", "Hyprland")

-- See https://wiki.hypr.land/Configuring/Advanced-and-Cool/Environment-variables/
hl.env("XCURSOR_SIZE", "24")
hl.env("HYPRCURSOR_SIZE", "24")

-- Qt environment variables
hl.env("QT_QPA_PLATFORM", "wayland")
hl.env("QT_QPA_PLATFORMTHEME", "qt6ct")
hl.env("QT_WAYLAND_DISABLE_WINDOWDECORATION", "1")
hl.env("QT_AUTO_SCREEN_SCALE_FACTOR", "1")
hl.env("QT_STYLE_OVERRIDE", "kvantum")


-----------------------
---- LOOK AND FEEL ----
-----------------------

-- Colorscheme (managed by theme-switch.sh)
require("theme")

-- Refer to https://wiki.hypr.land/Configuring/Basics/Variables/
hl.config({
    general = {
        gaps_in  = 5,
        gaps_out = 10,

        border_size = 2,

        col = {
            active_border   = colors.accent,
            inactive_border = colors.overlay1,
        },

        resize_on_border = true,
        allow_tearing    = false,
        layout           = "dwindle",
    },
})

hl.config({
    decoration = {
        rounding       = 10,
        rounding_power = 2,

        active_opacity   = 1.0,
        inactive_opacity = 1.0,

        shadow = {
            enabled      = true,
            range        = 6,
            render_power = 3,
            color        = colors.mantle,
        },

        blur = {
            enabled  = true,
            size     = 3,
            passes   = 1,
            vibrancy = 0.1696,
        },
    },
})

-- https://wiki.hypr.land/Configuring/Advanced-and-Cool/Animations/
hl.config({
    animations = {
        enabled = true,
    },
})

hl.curve("easeOutQuint",   { type = "bezier", points = { {0.23, 1},    {0.32, 1}    } })
hl.curve("easeInOutCubic", { type = "bezier", points = { {0.65, 0.05}, {0.36, 1}    } })
hl.curve("linear",         { type = "bezier", points = { {0, 0},       {1, 1}       } })
hl.curve("almostLinear",   { type = "bezier", points = { {0.5, 0.5},   {0.75, 1.0}  } })
hl.curve("quick",          { type = "bezier", points = { {0.15, 0},    {0.1, 1}     } })

hl.animation({ leaf = "global",        enabled = true,  speed = 10,   bezier = "default"      })
hl.animation({ leaf = "border",        enabled = true,  speed = 5.39, bezier = "easeOutQuint" })
hl.animation({ leaf = "windows",       enabled = true,  speed = 4.79, bezier = "easeOutQuint" })
hl.animation({ leaf = "windowsIn",     enabled = true,  speed = 4.1,  bezier = "easeOutQuint", style = "popin 87%" })
hl.animation({ leaf = "windowsOut",    enabled = true,  speed = 1.49, bezier = "linear",       style = "popin 87%" })
hl.animation({ leaf = "fadeIn",        enabled = true,  speed = 1.73, bezier = "almostLinear" })
hl.animation({ leaf = "fadeOut",       enabled = true,  speed = 1.46, bezier = "almostLinear" })
hl.animation({ leaf = "fade",          enabled = true,  speed = 3.03, bezier = "quick"        })
hl.animation({ leaf = "layers",        enabled = true,  speed = 3.81, bezier = "easeOutQuint" })
hl.animation({ leaf = "layersIn",      enabled = true,  speed = 4,    bezier = "easeOutQuint", style = "fade" })
hl.animation({ leaf = "layersOut",     enabled = true,  speed = 1.5,  bezier = "linear",       style = "fade" })
hl.animation({ leaf = "fadeLayersIn",  enabled = true,  speed = 1.79, bezier = "almostLinear" })
hl.animation({ leaf = "fadeLayersOut", enabled = true,  speed = 1.39, bezier = "almostLinear" })
hl.animation({ leaf = "workspaces",    enabled = true,  speed = 1.94, bezier = "almostLinear", style = "fade" })
hl.animation({ leaf = "workspacesIn",  enabled = true,  speed = 1.21, bezier = "almostLinear", style = "fade" })
hl.animation({ leaf = "workspacesOut", enabled = true,  speed = 1.94, bezier = "almostLinear", style = "fade" })

-- See https://wiki.hypr.land/Configuring/Layouts/Dwindle-Layout/
hl.config({
    dwindle = {
        preserve_split = true,
    },
})

-- See https://wiki.hypr.land/Configuring/Layouts/Master-Layout/
hl.config({
    master = {
        new_status = "master",
    },
})

-- https://wiki.hypr.land/Configuring/Basics/Variables/#misc
hl.config({
    misc = {
        force_default_wallpaper = 0,
        disable_hyprland_logo   = true,
    },
})


---------------
---- INPUT ----
---------------

-- Base input config; overridden per-host in host-files/inputs.lua
hl.config({
    input = {
        force_no_accel     = false,
        numlock_by_default = true,
    },
})

-- See https://wiki.hypr.land/Configuring/Basics/Gestures/
hl.gesture({
    fingers   = 3,
    direction = "horizontal",
    action    = "workspace",
})

-- Host-specific monitor and input overrides
require("host-files/monitors")
require("host-files/inputs")


---------------------
---- KEYBINDINGS ----
---------------------

-- See https://wiki.hypr.land/Configuring/Basics/Binds/
local mainMod = "SUPER"

hl.bind(mainMod .. " + T",             hl.dsp.exec_cmd(terminal),                 { description = "Open terminal" })
hl.bind(mainMod .. " + Return",        hl.dsp.exec_cmd(terminal),                 { description = "Open terminal" })
hl.bind(mainMod .. " + Q",             hl.dsp.window.close(),                     { description = "Close active window" })
hl.bind("ALT + F4",                    hl.dsp.window.close(),                     { description = "Close active window" })
hl.bind(mainMod .. " + SHIFT + E",     hl.dsp.exit(),                             { description = "Exit Hyprland" })
hl.bind(mainMod .. " + L",             hl.dsp.exec_cmd("loginctl lock-session"),  { description = "Lock screen" })
hl.bind(mainMod .. " + E",             hl.dsp.exec_cmd(fileManager),              { description = "Open file manager" })
hl.bind(mainMod .. " + Y",             hl.dsp.exec_cmd(terminal .. " -e yazi"),   { description = "Open terminal file manager" })
hl.bind(mainMod .. " + B",             hl.dsp.exec_cmd(browser),                  { description = "Open web browser" })
hl.bind(mainMod .. " + D",             hl.dsp.exec_cmd(editor),                   { description = "Open Visual Studio Code" })
hl.bind(mainMod .. " + V",             hl.dsp.window.float(),                     { description = "Toggle floating mode" })
hl.bind(mainMod .. " + SUPER_L",       hl.dsp.exec_cmd(appmenu),                  { release = true, description = "Open menu" })
hl.bind(mainMod .. " + SPACE",         hl.dsp.exec_cmd(menu),                     { description = "Open application menu" })
hl.bind(mainMod .. " + R",             hl.dsp.exec_cmd(runmenu),                  { description = "Open run menu" })
hl.bind(mainMod .. " + P",             hl.dsp.window.pseudo(),                    { description = "Toggle pseudo mode" })
hl.bind(mainMod .. " + J",             hl.dsp.layout("togglesplit"),              { description = "Toggle window split" })
hl.bind(mainMod .. " + F",             hl.dsp.window.fullscreen(),                { description = "Toggle fullscreen" })
hl.bind("CTRL + ALT + Delete",         hl.dsp.exec_cmd("wlogout"),                { description = "Show logout menu" })

-- Waybar toggle
hl.bind(mainMod .. " + apostrophe",          hl.dsp.exec_cmd(hypr_scripts .. "/waybarctl.sh toggle"),  { description = "Toggle Waybar" })
hl.bind(mainMod .. " + SHIFT + apostrophe",  hl.dsp.exec_cmd(hypr_scripts .. "/waybarctl.sh restart"), { description = "Restart Waybar" })

-- Random wallpaper
hl.bind(mainMod .. " + W", hl.dsp.exec_cmd(hypr_scripts .. "/random-wallpaper.sh"), { description = "Change wallpaper" })

-- Theme switching
hl.bind(mainMod .. " + SHIFT + T", hl.dsp.exec_cmd(hypr_scripts .. "/theme-switch.sh"), { description = "Toggle theme" })

-- Show keybindings
hl.bind(mainMod .. " + SHIFT + K", hl.dsp.exec_cmd(hypr_scripts .. "/show-keybindings.sh"), { description = "Show keybindings" })

-- Web apps
hl.bind(mainMod .. " + A", hl.dsp.exec_cmd(browser .. " --app=https://claude.ai"),               { description = "Open Claude" })
hl.bind(mainMod .. " + M", hl.dsp.exec_cmd(browser .. " --app=https://gmail.com"),               { description = "Open Gmail" })
hl.bind(mainMod .. " + C", hl.dsp.exec_cmd(browser .. " --app=https://calendar.google.com"),     { description = "Open Calendar" })

-- Swaync notifications
hl.bind(mainMod .. " + N",            hl.dsp.exec_cmd("swaync-client --toggle-panel"),  { description = "Toggle notification panel" })
hl.bind(mainMod .. " + SHIFT + N",    hl.dsp.exec_cmd("swaync-client --close-latest"),  { description = "Close latest notification" })
hl.bind(mainMod .. " + CTRL + N",     hl.dsp.exec_cmd("swaync-client --close-all"),     { description = "Close all notifications" })
hl.bind(mainMod .. " + ALT + N",      hl.dsp.exec_cmd("swaync-client --toggle-dnd"),    { description = "Toggle do not disturb" })

-- Screenshots
hl.bind("Print",                    hl.dsp.exec_cmd("hyprshot -m output -m active -o ~/Pictures/Screenshots"),  { description = "Screenshot active output" })
hl.bind("SHIFT + Print",            hl.dsp.exec_cmd("hyprshot -m window -m active -o ~/Pictures/Screenshots"),  { description = "Screenshot active window" })
hl.bind(mainMod .. " + SHIFT + Print", hl.dsp.exec_cmd("hyprshot -m region -o ~/Pictures/Screenshots"),        { description = "Screenshot selected region" })

-- Move focus with mainMod + arrow keys
hl.bind(mainMod .. " + left",  hl.dsp.focus({ direction = "l" }), { description = "Move focus left" })
hl.bind(mainMod .. " + right", hl.dsp.focus({ direction = "r" }), { description = "Move focus right" })
hl.bind(mainMod .. " + up",    hl.dsp.focus({ direction = "u" }), { description = "Move focus up" })
hl.bind(mainMod .. " + down",  hl.dsp.focus({ direction = "d" }), { description = "Move focus down" })
hl.bind("ALT + Tab",           hl.dsp.window.cycle_next(),         { description = "Cycle through windows" })

-- Switch workspaces with mainMod + [0-9]
-- Move active window to a workspace with mainMod + SHIFT + [0-9]
for i = 1, 10 do
    local key = i % 10 -- 10 maps to key 0
    hl.bind(mainMod .. " + " .. key,         hl.dsp.focus({ workspace = i }),          { description = "Switch to workspace " .. i })
    hl.bind(mainMod .. " + SHIFT + " .. key, hl.dsp.window.move({ workspace = i }),    { description = "Move to workspace " .. i })
end

-- Special workspace (scratchpad)
hl.bind(mainMod .. " + S",         hl.dsp.workspace.toggle_special("magic"), { description = "Toggle scratchpad" })
hl.bind(mainMod .. " + SHIFT + S", hl.dsp.window.move({ workspace = "special:magic" }), { description = "Move to scratchpad" })

-- Scroll through workspaces
hl.bind(mainMod .. " + mouse_down",  hl.dsp.focus({ workspace = "e+1" }), { description = "Next workspace" })
hl.bind(mainMod .. " + mouse_up",    hl.dsp.focus({ workspace = "e-1" }), { description = "Previous workspace" })
hl.bind(mainMod .. " + CTRL + Right",  hl.dsp.focus({ workspace = "r+1"   }), { description = "Next workspace" })
hl.bind(mainMod .. " + CTRL + Left",   hl.dsp.focus({ workspace = "r-1"   }), { description = "Previous workspace" })
hl.bind(mainMod .. " + CTRL + Down",   hl.dsp.focus({ workspace = "empty" }), { description = "Switch to empty workspace" })

-- Move active workspace to next monitor
hl.bind(mainMod .. " + SHIFT + M", hl.dsp.workspace.move({ monitor = "+1" }), { description = "Move workspace to next monitor" })

-- Resize windows
hl.bind(mainMod .. " + SHIFT + Right", hl.dsp.window.resize({ x = 30,  y = 0,   relative = true }), { repeating = true, description = "Resize window right" })
hl.bind(mainMod .. " + SHIFT + Left",  hl.dsp.window.resize({ x = -30, y = 0,   relative = true }), { repeating = true, description = "Resize window left" })
hl.bind(mainMod .. " + SHIFT + Up",    hl.dsp.window.resize({ x = 0,   y = -30, relative = true }), { repeating = true, description = "Resize window up" })
hl.bind(mainMod .. " + SHIFT + Down",  hl.dsp.window.resize({ x = 0,   y = 30,  relative = true }), { repeating = true, description = "Resize window down" })

-- Move/resize windows with mainMod + LMB/RMB and dragging
hl.bind(mainMod .. " + mouse:272", hl.dsp.window.drag(),   { mouse = true, description = "Move window with mouse" })
hl.bind(mainMod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true, description = "Resize window with mouse" })

-- Multimedia / laptop keys
hl.bind("XF86AudioRaiseVolume",  hl.dsp.exec_cmd("wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+"), { repeating = true, locked = true, description = "Increase volume" })
hl.bind("XF86AudioLowerVolume",  hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"),      { repeating = true, locked = true, description = "Decrease volume" })
hl.bind("XF86AudioMute",         hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"),     { repeating = true, locked = true, description = "Toggle mute" })
hl.bind("XF86AudioMicMute",      hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"),   { repeating = true, locked = true, description = "Toggle microphone" })
hl.bind("XF86MonBrightnessUp",   hl.dsp.exec_cmd("brightnessctl s 10%+"),                           { repeating = true, locked = true, description = "Increase brightness" })
hl.bind("XF86MonBrightnessDown", hl.dsp.exec_cmd("brightnessctl s 10%-"),                           { repeating = true, locked = true, description = "Decrease brightness" })

-- Laptop lid switch
hl.bind("switch:on:Lid Switch",  hl.dsp.exec_cmd("hyprctl keyword monitor eDP-1,disable && sleep 0.5 && " .. hypr_scripts .. "/waybarctl.sh restart"),              { locked = true })
hl.bind("switch:off:Lid Switch", hl.dsp.exec_cmd("hyprctl keyword monitor eDP-1,preferred,auto,1.2 && sleep 0.5 && " .. hypr_scripts .. "/waybarctl.sh restart"),  { locked = true })

-- Media controls
hl.bind("XF86AudioNext",  hl.dsp.exec_cmd("playerctl next"),        { locked = true, description = "Next track" })
hl.bind("XF86AudioPause", hl.dsp.exec_cmd("playerctl play-pause"),  { locked = true, description = "Play/pause media" })
hl.bind("XF86AudioPlay",  hl.dsp.exec_cmd("playerctl play-pause"),  { locked = true, description = "Play/pause media" })
hl.bind("XF86AudioPrev",  hl.dsp.exec_cmd("playerctl previous"),    { locked = true, description = "Previous track" })


--------------------------------
---- WINDOWS AND WORKSPACES ----
--------------------------------

-- See https://wiki.hypr.land/Configuring/Basics/Window-Rules/

-- Pin app classes to specific workspaces
hl.window_rule({ match = { class = "firefox"       }, workspace = "2" })
hl.window_rule({ match = { class = "google-chrome" }, workspace = "2" })
hl.window_rule({ match = { class = "Code"          }, workspace = "3" })
hl.window_rule({ match = { class = "Spotify"       }, workspace = "4" })

-- Ignore maximize requests from all apps
hl.window_rule({
    name           = "suppress-maximize-events",
    match          = { class = ".*" },
    suppress_event = "maximize",
})

-- Fix some dragging issues with XWayland
hl.window_rule({
    name     = "fix-xwayland-drags",
    match    = {
        class      = "^$",
        title      = "^$",
        xwayland   = true,
        float      = true,
        fullscreen = false,
        pin        = false,
    },
    no_focus = true,
})

-- Hyprland-run float and position
hl.window_rule({
    name  = "move-hyprland-run",
    match = { class = "hyprland-run" },
    move  = "20 monitor_h-120",
    float = true,
})
