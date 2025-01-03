-- Pull in the wezterm API
local wezterm = require("wezterm")

local launch_menu = {}

if wezterm.target_triple == "x86_64-pc-windows-msvc" then
    table.insert(launch_menu, {
        label = "PowerShell",
        args = {"powershell.exe", "-NoLogo"}
    })

    -- Find installed visual studio version(s) and add their compilation
    -- environment command prompts to the menu
    for _, vsvers in ipairs(wezterm.glob("Microsoft Visual Studio/20*", "C:/Program Files (x86)")) do
        local year = vsvers:gsub("Microsoft Visual Studio/", "")
        table.insert(launch_menu, {
            label = "x64 Native Tools VS " .. year,
            args = {"cmd.exe", "/k",
                    "C:/Program Files (x86)/" .. vsvers .. "/BuildTools/VC/Auxiliary/Build/vcvars64.bat"}
        })
    end
end

function scheme_for_appearance(appearance)
    if appearance:find("Dark") then
        return "Catppuccin Mocha"
    end
    return "Catppuccin Macchiato"
end

local custom = wezterm.color.get_builtin_schemes()["Catppuccin Mocha"]
custom.background = "#000000"
custom.tab_bar.background = "#040404"
custom.tab_bar.inactive_tab.bg_color = "#0f0f0f"
custom.tab_bar.new_tab.bg_color = "#080808"

local config = wezterm.config_builder()

config.default_prog = {"/bin/zsh", "-l"}
config.font = wezterm.font({
    family = "JetBrains Mono Nerd Font",
    stretch = "Expanded",
    weight = "Regular",
    harfbuzz_features = {"ss01", "ss02", "ss03", "ss04", "ss05", "ss06", "ss07", "ss08", "calt", "dlig"}
})
config.color_scheme = scheme_for_appearance(wezterm.gui.get_appearance())
config.native_macos_fullscreen_mode = true
config.hide_tab_bar_if_only_one_tab = true
config.launch_menu = launch_menu

return config
