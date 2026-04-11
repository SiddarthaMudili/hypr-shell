# HyprShell — Hyprland + Quickshell Dotfiles

A complete, Hyprland desktop iterated from yahr-quickshell. Includes a unified theme system that syncs colours across every application simultaneously, 14 built-in colour schemes, a custom bar, app launcher, calendar, power menu, wallpaper picker, and more.

> **Distro:** Arch Linux (or derivatives) only. The installer uses `pacman`/`yay`/`paru`.

---

## Features

- **14 colour themes** — Catppuccin, TokyoNight, Dracula, Everforest, RosePine, Gruvbox, Kanagawa, NightFox, Material, Nord, Eldritch, Monochrome, Solarized, and more
- **One-key theme switching** — `Super+T` opens the theme switcher; selecting a theme instantly recolours Hyprland, Kitty, Neovim, GTK apps, Firefox, VS Code/Codium, Mako, hyprlock, SDDM, and the bar
- **Quickshell bar** — clock, workspace indicators, system tray, volume/network/battery widgets
- **App launcher, calendar, power menu, wallpaper picker** — all QML-based, all theme-aware
- **Clipboard history** via `cliphist` + `wofi`
- **Emoji picker** via `hypremoji` (`Super+.`)
- **Automatic app-list refresh** — `fswatch` watches `.desktop` directories and reloads Quickshell when apps are installed/removed
- **GPU auto-detection** — installer picks the right drivers for NVIDIA, AMD, Intel, or hybrid setups
- **Modular Hyprland config** — split across focused `.conf` files so individual pieces are easy to tweak

---

## Prerequisites

### Hard requirements (installer handles these)

| Package | Purpose |
|---|---|
| `hyprland` | Window manager |
| `quickshell-git` | Shell/bar framework |
| `kitty` | Terminal emulator |
| `awww` | Wayland wallpaper daemon |
| `mako` | Notification daemon |
| `wl-clipboard` | Clipboard (`wl-paste`) |
| `cliphist` | Clipboard history manager |
| `hyprpolkitagent` | Polkit authentication agent |
| `hyprlock` / `hypridle` | Lock screen / idle handler |
| `grim` + `slurp` + `hyprshot` | Screenshots |
| `wofi` | Fallback launcher / clipboard UI |
| `fswatch` | App-list change watcher |
| `hypremoji` | Emoji picker |
| `papirus-icon-theme` + `papirus-folders-git` | Icons |
| `ttf-nerd-fonts-symbols` + `noto-fonts-emoji` | Required fonts |
| Sen font (downloaded automatically) | UI text font |

### Recommended (installer offers these)

| Package | Purpose |
|---|---|
| `pipewire` + `wireplumber` + `pipewire-pulse` | Audio |
| `pavucontrol` | Audio GUI |
| `bluez` + `bluez-utils` + `blueman` | Bluetooth |
| `networkmanager` | Networking |
| `thunar` | File manager |
| `brightnessctl` | Screen brightness |
| `starship` | Shell prompt (if not using zsh/p10k) |
| `fastfetch` | System info on terminal open |
| `pacman-contrib` | `checkupdates` for update indicator |
| `zsh` + `zsh-syntax-highlighting` + `zsh-autosuggestions` | Shell |

### Optional (installer will ask)

- **Oh-My-Zsh** + **Powerlevel10k** — matches the included `.zshrc`
- **Neovim** — config included
- **Vesktop** (Discord with Vencord) — themed via `sync-vencord-theme.sh`
- **VSCodium / VS Code** — themed via `sync-vscodium-theme.sh` / `sync-vscode-theme.sh`
- **Firefox** — `userChrome.css` included, themed via `sync-firefox-theme.sh`
- **SDDM** — themed login screen, syncs with active colour scheme
- **btop / k9s / better-control** — configs included

---

## Installation

```bash
git clone https://github.com/YOUR_USERNAME/hypr-quickshell.git
cd hypr-quickshell
chmod +x install.sh
./install.sh
```

The installer will ask whether to run in **YOLO mode** (fully unattended, auto-skips optional prompts) or **Normal mode** (interactive).

After the script completes, **reboot** and select Hyprland from your display manager (or log into tty1 — `.zprofile` will auto-launch it).

### First boot checklist

- [ ] Run `p10k configure` in a terminal to set up your prompt appearance
- [ ] Press `Super+T` to verify theme switching works
- [ ] Press `Super+Shift+W` to pick a wallpaper
- [ ] If SDDM was installed, run `Super+Shift+L` to sync the login screen theme

---

## Keybindings

### Applications

| Key | Action |
|---|---|
| `Super + Return` | Terminal (Kitty) |
| `Super + F` | File manager (Thunar) |
| `Super + W` | Browser (Zen) |
| `Super + S` | Chat (Slack) |
| `Super + Y` | Music (YouTube Music) |
| `Super + C` | Editor (Neovim) |
| `Super + Space` | App launcher |
| `Super + T` | Theme switcher |
| `Super + Escape` | Power menu |
| `Super + Shift+W` | Wallpaper picker |
| `Super + Print` | Screenshot menu |
| `Super + Shift+S` | Settings widget |
| `Super + N` | Restore last notification |
| `Super + .` | Emoji picker |
| `Super + C` (hold) | Clipboard history |

### Window management

| Key | Action |
|---|---|
| `Super + Q` | Close window |
| `Super + V` | Toggle floating |
| `Super + M` | Fullscreen |
| `Super + K` | Swap with next window |
| `Super + [1-0]` | Switch to workspace |
| `Super + Shift + [1-0]` | Move window to workspace |
| `Super + D` | Toggle scratchpad |
| `Super + Ctrl+E` | Reload Hyprland |
| `Super + Z` | Restart Quickshell |

### Mouse

| Action | Binding |
|---|---|
| Move window | `Super + LMB drag` |
| Resize window | `Super + RMB drag` |
| Switch workspace | `Super + Scroll` |

### Media & hardware

| Key | Action |
|---|---|
| `XF86AudioRaiseVolume` | Volume +5% |
| `XF86AudioLowerVolume` | Volume -5% |
| `XF86AudioMute` | Toggle mute |
| `XF86MonBrightnessUp/Down` | Screen brightness |
| `XF86AudioNext/Prev/Play/Pause` | Media control (playerctl) |

---

## Themes

Switch with `Super+T`. The active theme syncs across all supported applications automatically.

| Theme | Style |
|---|---|
| Catppuccin (default) | Soft pastel dark |
| TokyoNight | Vibrant dark blue |
| Dracula | Classic purple/pink dark |
| Everforest | Warm green/earth tones |
| RosePine | Muted rose dark |
| Gruvbox | Warm retro dark |
| Kanagawa | Japanese ink dark |
| NightFox | Cool blue-grey dark |
| Material | Material Design dark |
| Nord | Arctic blue dark |
| Eldritch | Purple/teal dark |
| Monochrome | Greyscale |
| Solarized | Classic Solarized dark |

---

## Directory structure

```
hypr-quickshell/
├── install.sh               # Main installer
├── install-thunar-config.sh # Thunar-specific helper
├── sync-to-live.sh          # Push repo configs → ~/.config/ (for testing)
├── sync-from-live.sh        # Pull ~/.config/ changes → repo (before committing)
│
├── hypr/                    # Hyprland config (modular)
│   ├── hyprland.conf        # Entry point — sources all sub-configs
│   ├── autostart.conf       # Startup sequence
│   ├── keybinds.conf        # All keybindings
│   ├── programs.conf        # Default application variables
│   ├── monitors.conf        # Display layout
│   ├── look-and-feel.conf   # Animations, gaps, borders
│   ├── input.conf           # Keyboard/mouse/touchpad
│   ├── rules.conf           # Window rules
│   ├── hypridle.conf        # Idle timeout
│   ├── hyprlock.conf        # Lock screen
│   └── themes/              # Per-theme colour overrides
│
├── quickshell/              # Quickshell (bar, widgets, scripts)
│   ├── shell.qml            # Entry point
│   ├── Bar.qml              # Top bar
│   ├── AppLauncher/         # App launcher widget
│   ├── Calendar/            # Calendar widget
│   ├── ThemeSwitcher/       # Theme switcher widget
│   ├── PowerMenu/           # Power menu widget
│   ├── WallpaperPicker.qml  # Wallpaper picker
│   ├── gtk-themes/          # GTK colour themes
│   ├── switch-theme.sh      # Core theme-switch script
│   └── sync-*.sh            # Per-app theme sync scripts
│
├── dotfiles/                # Shell & system dotfiles
│   ├── .zshrc               # Zsh config (Oh-My-Zsh + Powerlevel10k)
│   ├── .zprofile            # Auto-launches Hyprland on tty1
│   ├── starship.toml        # Starship prompt config
│   └── watch_apps.sh        # Installed to ~/.local/bin/
│
├── kitty/                   # Kitty terminal config
├── mako/                    # Mako notification daemon config
├── wofi/                    # Wofi launcher config (fallback)
├── fastfetch/               # Fastfetch system info config
├── hypremoji/               # Emoji picker config
├── fontconfig/              # Font configuration (emoji priority)
├── nvim/                    # Neovim config (optional)
├── btop/                    # btop config (optional)
├── k9s/                     # k9s config (optional)
├── better-control/          # better-control config (optional)
├── Thunar/                  # Thunar file manager config
└── Pictures/Wallpapers/     # Wallpapers organised by theme
```

---

## Syncing changes

Two helper scripts keep the repo and live configs in sync:

```bash
# Push repo configs to ~/.config/ (use when testing changes from the repo)
./sync-to-live.sh

# Pull live ~/.config/ changes back into the repo (use before committing)
./sync-from-live.sh
```

> `sync-from-live.sh` excludes `settings.json`, `ThemeManager.qml`, and `*.backup` files.

---

## Customisation

### Changing default applications

Edit [hypr/programs.conf](hypr/programs.conf):

```bash
$terminal  = kitty
$browser   = zen-browser
$fileManager = thunar
$chat      = slack
$music     = youtube-music-desktop-app
$editor    = nvim
```

### Changing monitors

Edit [hypr/monitors.conf](hypr/monitors.conf). Refer to the [Hyprland monitor docs](https://wiki.hypr.land/Configuring/Monitors/).

### Adding a new theme

1. Create `hypr/themes/MyTheme.conf` with colour variables matching the existing theme files.
2. Add a corresponding entry to `quickshell/ThemeManager.qml`.
3. Add a wallpaper folder `Pictures/Wallpapers/MyTheme/`.

---

## Troubleshooting

**Quickshell doesn't start**
Run `quickshell` in a terminal to see error output. Most issues are missing QML dependencies — make sure `qt6-wayland` and `qt6-5compat` are installed.

**Wallpaper not applying**
Ensure `awww-daemon` is running: `pgrep awww-daemon`. If not, run `awww-daemon &` then retry.

**Theme switching fails silently**
Check that `papirus-folders` has passwordless sudo configured (`/etc/sudoers.d/papirus-folders`). Re-run `setup_papirus` from the installer if needed.

**Zsh prompt looks broken**
Run `p10k configure` to regenerate `~/.p10k.zsh` for your terminal and font setup.

**App launcher shows stale apps**
Ensure `~/.local/bin/watch_apps.sh` is executable and `fswatch` is installed. The script is started by `autostart.conf`.

---

## Credits

This configuration is based on and heavily inspired by [yahr-quickshell](https://github.com/bgibson72/yahr-quickshell) by [bgibson72](https://github.com/bgibson72) — **YAHR** (Yet Another Hyprland Rice). The Quickshell widget system, theme-switching architecture, and overall desktop environment structure originate from that project.

- [bgibson72](https://github.com/bgibson72) — original [yahr-quickshell](https://github.com/bgibson72/yahr-quickshell) project, the foundation this configuration builds upon
- [Quickshell](https://quickshell.outfoxxed.me/) — the shell framework powering the bar and widgets
- [Hyprland](https://hyprland.org/) — the Wayland compositor
- [Catppuccin](https://github.com/catppuccin/catppuccin) — default colour palette
- [Papirus Icon Theme](https://github.com/PapirusDevelopmentTeam/papirus-icon-theme)
- [Oh-My-Zsh](https://ohmyz.sh/) + [Powerlevel10k](https://github.com/romkatv/powerlevel10k)
- Sen font by [Philatype](https://fonts.google.com/specimen/Sen)
