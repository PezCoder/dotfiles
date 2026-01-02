# Nerd Font Patching Guide

**Last Updated:** 2026-01-02
**Tested With:** Operator Mono on macOS 14.6 (Sonoma)

## Overview

This guide documents the process for patching custom fonts with [Nerd Fonts](https://github.com/ryanoasis/nerd-fonts) to add icon glyphs (Font Awesome, Material Design Icons, Powerline symbols, etc.) while preserving font features like ligatures.

**What this achieves:**
- Adds 3,600+ icon glyphs to your custom fonts
- Preserves existing ligatures (if any)
- Maintains font family structure for proper bold/italic rendering
- Enables proper icon rendering in terminal, Neovim, tmux, etc.

## Prerequisites

### Required Tools

1. **FontForge** - Font editing tool with Python scripting
   ```bash
   brew install fontforge
   ```

2. **Nerd Fonts Repository** - Contains the font-patcher script
   ```bash
   cd ~/Downloads
   git clone --depth 1 https://github.com/ryanoasis/nerd-fonts.git
   ```
   *Note: Use shallow clone to avoid downloading all pre-patched fonts (~2GB)*

3. **Source Fonts** - Your original font files (.otf or .ttf format)
   - Located in: `fonts/OpenType/` in this repo
   - Backup recommended before patching

### Verification

```bash
# Check FontForge is installed
fontforge --version

# Check font-patcher exists
ls -la ~/Downloads/nerd-fonts/font-patcher
```

## Step-by-Step Process

### 1. Setup Working Directory

```bash
# Create temporary patching directory
mkdir -p ~/Downloads/font-patching
cd ~/Downloads/font-patching

# Copy source fonts
cp /path/to/dotfiles/fonts/OpenType/*.otf .
```

### 2. Create Patching Script

Create `patch-fonts.sh` with the following content:

```bash
#!/bin/bash
set -e

PATCHER="$HOME/Downloads/nerd-fonts/font-patcher"
FONTS_DIR="."
OUTPUT_DIR="./patched"

mkdir -p "$OUTPUT_DIR"

echo "🔧 Patching fonts with Nerd Fonts..."

# Common flags for all fonts
COMMON_FLAGS="--complete --careful --adjust-line-height --outputdir $OUTPUT_DIR"

# Patch each font variant
for font in "$FONTS_DIR"/*.otf; do
    [ -f "$font" ] || continue
    echo "Processing: $(basename "$font")"
    fontforge -script "$PATCHER" $COMMON_FLAGS "$font"
    echo "✅ Completed: $(basename "$font")"
done

echo ""
echo "🎉 All fonts patched successfully!"
echo "Output location: $OUTPUT_DIR"
```

**Flag Explanation:**
- `--complete`: Add all available icon sets (Font Awesome, Material Design, Octicons, Powerline, etc.)
- `--careful`: Skip glyphs that would overwrite existing characters (e.g., prevents Material Design Icons from overwriting "j")
- `--adjust-line-height`: Better vertical alignment for Powerline separators
- `--outputdir`: Specify output location

**Important Flags NOT Used:**
- `--mono`: Forces single-width glyphs, which **breaks ligatures**. Only use if ligatures aren't needed.
- `--removeligs`: Explicitly removes ligatures. By default, ligatures are preserved.

### 3. Execute Patching

```bash
# Make script executable
chmod +x patch-fonts.sh

# Run patching (takes ~1-2 minutes per font)
./patch-fonts.sh
```

**Expected Output:**
- Progress bars showing glyph addition (Seti-UI, Devicons, Font Awesome, etc.)
- Patched fonts in `./patched/` directory
- Font names will include "Nerd Font" (e.g., `OperatorMonoLigNerdFont-Regular.otf`)

### 4. Install Patched Fonts

```bash
# Copy to user fonts directory
cp ./patched/*.otf ~/Library/Fonts/

# Verify installation
fc-list | grep "Nerd Font"
```

**Alternative:** Use Font Book app to install (double-click .otf files)

### 5. Organize in Repository

```bash
# Create nerd fonts directory
mkdir -p /path/to/dotfiles/fonts/OpenType/nerd

# Copy patched fonts to repo
cp ./patched/*.otf /path/to/dotfiles/fonts/OpenType/nerd/

# Verify structure
ls -lh /path/to/dotfiles/fonts/OpenType/
# Should show:
# - Original fonts in OpenType/
# - Patched fonts in OpenType/nerd/
```

## Configuration Updates

### Alacritty Terminal

**File:** `config/alacritty.yml`

Update font family names to use "Nerd Font" variants:

```yaml
font:
  normal:
    family: OperatorMonoLig Nerd Font  # Was: Operator Mono Lig
    style: Regular                      # Was: Book (style may change)

  bold:
    family: OperatorMono Nerd Font      # Was: Operator Mono
    style: Medium

  italic:
    family: OperatorMono Nerd Font      # Was: Operator Mono
    style: Italic                       # Was: Book Italic

  bold_italic:
    family: OperatorMono Nerd Font      # Was: Operator Mono
    style: Bold Italic
```

**Important:** Check exact style names using `fc-list`:
```bash
fc-list : family style | grep "Nerd Font"
```

### Other Terminal Emulators

- **iTerm2**: Preferences → Profiles → Text → Font
- **kitty**: Update `font_family` in `~/.config/kitty/kitty.conf`
- **WezTerm**: Update `font` in `~/.wezterm.lua`

### Neovim/Vim

If using font-specific plugins (e.g., `vim-devicons`), no changes needed - icons should render automatically.

**For custom status lines**, verify icon glyphs render:
```vim
:echo "\uf179"  " Should show Git branch icon
```

## Verification & Testing

### Create Test Script

Save as `test-nerd-fonts.sh`:

```bash
#!/bin/bash

echo "======================================"
echo "  Nerd Fonts Icon Test"
echo "======================================"
echo ""

echo "Testing Nerd Font Icons:"
echo "------------------------"
echo -e " Git branch:   \ue0a0"
echo -e " Folder:       \uf07b"
echo -e " File:         \uf016"
echo -e " Node.js:      \ue781"
echo -e " Python:       \ue73c"
echo ""

echo "Testing Powerline Symbols:"
echo "-------------------------"
echo -e " Right arrow:  \ue0b0"
echo -e " Left arrow:   \ue0b2"
echo ""

echo "Testing Ligatures:"
echo "-----------------"
echo "  != !== === => >= <= -> <-"
echo ""
```

### Run Tests

```bash
chmod +x test-nerd-fonts.sh
./test-nerd-fonts.sh
```

**Expected Results:**
- ✅ Icons render as proper glyphs (not `\ue0a0` text or boxes with X)
- ✅ Powerline arrows display correctly
- ✅ Ligatures render as single combined symbols

### Additional Verification

**In Terminal:**
```bash
# Test with exa (if installed)
exa --icons

# Test in tmux
tmux  # Check status line icons
```

**In Neovim:**
- Open any file and check CoC completion icons
- Verify status line icons (if using lightline/lualine)
- Check file explorer icons (if using NERDTree/nvim-tree)

## Troubleshooting

### Icons Show as Boxes with X

**Cause:** Font not loaded or terminal not using patched font

**Solutions:**
1. Verify font installation: `fc-list | grep "Nerd Font"`
2. Check terminal font config matches installed font name
3. Restart terminal completely (not just reload config)
4. Clear font cache: `atsutil databases -remove` (macOS)

### Ligatures Disappeared

**Cause:** Used `--mono` or `--removeligs` flag

**Solution:** Re-patch without these flags. Ligatures are preserved by default.

### "j" Character Shows as Icon

**Cause:** Material Design Icons overwrote the "j" character

**Solution:** Re-patch with `--careful` flag (prevents glyph conflicts)

### Font Not Recognized in Terminal

**Cause:** Font family name mismatch

**Solutions:**
1. Get exact font name: `fc-list : family style | grep "Nerd"`
2. Use exact name from output in config
3. Check for typos (e.g., "OperatorMono" vs "Operator Mono")

### Powerline Separators Misaligned

**Solutions:**
1. Use `--adjust-line-height` flag (already in script)
2. Adjust line height in terminal config:
   - Alacritty: `offset.y` in font section
   - kitty: `adjust_line_height` setting

### Icons Too Wide/Narrow

**Cause:** Non-monospace icon widths

**Solution:** Use `--mono` flag to force single-width (but loses ligatures)

## Cleanup

After successful patching and verification:

```bash
# Remove temporary patching directory
rm -rf ~/Downloads/font-patching

# Remove Nerd Fonts repository (optional, if space is limited)
rm -rf ~/Downloads/nerd-fonts

# Remove backup configs (if created)
rm ~/path/to/config.backup
```

## Reference: What Was Patched

**For Operator Mono (completed 2026-01-02):**

| Original Font | Patched Font | Purpose |
|--------------|--------------|---------|
| `OperatorMonoLig-Book.otf` | `OperatorMonoLigNerdFont-Regular.otf` | Normal text with ligatures |
| `OperatorMono-Medium.otf` | `OperatorMonoNerdFont-Medium.otf` | Bold weight |
| `OperatorMono-BookItalic.otf` | `OperatorMonoNerdFont-Italic.otf` | Italic |
| `OperatorMono-BoldItalic.otf` | `OperatorMonoNerdFont-BoldItalic.otf` | Bold italic |

**Glyph Sets Added:**
- Seti-UI + Custom (191 glyphs)
- Heavy Angle Brackets (6 glyphs)
- Box Drawing (160 glyphs)
- Progress Indicators (12 glyphs)
- Devicons (496 glyphs)
- Font Awesome (675+ glyphs)
- Font Awesome Extension (170 glyphs)
- Material Design Icons (4,000+ glyphs)
- Octicons (200+ glyphs)
- Powerline symbols (10 glyphs)
- And more...

**Total:** ~3,600+ icon glyphs added

## Tips for LLMs

When asked to patch fonts in the future:

1. **Always use these flags:** `--complete --careful --adjust-line-height`
2. **Never use `--mono`** if ligatures should be preserved
3. **Check font names** with `fc-list` before updating configs
4. **Keep originals** - create `nerd/` subfolder for patched fonts
5. **Test thoroughly** before cleanup
6. **Update configs** for all affected applications (terminal, Neovim, etc.)
7. **Document changes** in `docs/todo.md`

## Resources

- [Nerd Fonts Official Site](https://www.nerdfonts.com/)
- [Nerd Fonts GitHub](https://github.com/ryanoasis/nerd-fonts)
- [Font Patcher Documentation](https://github.com/ryanoasis/nerd-fonts#font-patcher)
- [Nerd Fonts Cheat Sheet](https://www.nerdfonts.com/cheat-sheet) - Browse available icons

## Version History

- **2026-01-02**: Initial documentation - Operator Mono patching completed
