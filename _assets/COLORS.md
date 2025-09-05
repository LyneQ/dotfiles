# 🎨 Color Scheme

This repository uses a small, punchy neon-accent palette on a dark background, inspired by Wildberries.

## Preview

Below is a quick visual preview of the palette.

- Background glass: <span style="display:inline-block;width:14px;height:14px;border-radius:3px;background:rgba(4,4,4,0.85);border:1px solid #111;vertical-align:middle"></span> rgba(4, 4, 4, 0.85)
- Surface: <span style="display:inline-block;width:14px;height:14px;border-radius:3px;background:#1a1a1a;border:1px solid #222;vertical-align:middle"></span> #1a1a1a
- Text: <span style="display:inline-block;width:14px;height:14px;border-radius:3px;background:#e0e0e0;border:1px solid #bbb;vertical-align:middle"></span> #e0e0e0
- Primary accent: <span style="display:inline-block;width:14px;height:14px;border-radius:3px;background:#f50a1c;border:1px solid #b50712;vertical-align:middle"></span> #f50a1c
- Cyan accent: <span style="display:inline-block;width:14px;height:14px;border-radius:3px;background:#46ebeb;border:1px solid #1fbaba;vertical-align:middle"></span> #46ebeb
- Accent glow: <span style="display:inline-block;width:14px;height:14px;border-radius:3px;background:rgba(245,10,28,0.25);border:1px solid #f50a1c;vertical-align:middle"></span> rgba(245, 10, 28, 0.25)

Example UI combo: dark glass background with neon red borders and selections, with subtle cyan highlights for hover/secondary elements.

<!-- Compact terminal palette swatches -->
<div style="margin-top:8px;">
  <div><strong>Terminal base (0–7)</strong></div>
  <div>
    <span style="display:inline-block;width:14px;height:14px;background:#000;border:1px solid #111;margin-right:4px" title="color0 #000000"></span>
    <span style="display:inline-block;width:14px;height:14px;background:#ff005f;border:1px solid #b30042;margin-right:4px" title="color1 #ff005f"></span>
    <span style="display:inline-block;width:14px;height:14px;background:#00ff9f;border:1px solid #00b370;margin-right:4px" title="color2 #00ff9f"></span>
    <span style="display:inline-block;width:14px;height:14px;background:#fcee09;border:1px solid #b3a807;margin-right:4px" title="color3 #fcee09"></span>
    <span style="display:inline-block;width:14px;height:14px;background:#00ffe7;border:1px solid #00b3a6;margin-right:4px" title="color4 #00ffe7"></span>
    <span style="display:inline-block;width:14px;height:14px;background:#ff00d4;border:1px solid #b30095;margin-right:4px" title="color5 #ff00d4"></span>
    <span style="display:inline-block;width:14px;height:14px;background:#00d3ff;border:1px solid #0099b3;margin-right:4px" title="color6 #00d3ff"></span>
    <span style="display:inline-block;width:14px;height:14px;background:#e5e5e5;border:1px solid #bbb;margin-right:4px" title="color7 #e5e5e5"></span>
  </div>
  <div style="margin-top:4px;"><strong>Terminal bright (8–15)</strong></div>
  <div>
    <span style="display:inline-block;width:14px;height:14px;background:#7f7f7f;border:1px solid #666;margin-right:4px" title="color8 #7f7f7f"></span>
    <span style="display:inline-block;width:14px;height:14px;background:#ff2040;border:1px solid #b3172d;margin-right:4px" title="color9 #ff2040"></span>
    <span style="display:inline-block;width:14px;height:14px;background:#00ffaa;border:1px solid #00b37a;margin-right:4px" title="color10 #00ffaa"></span>
    <span style="display:inline-block;width:14px;height:14px;background:#fff75a;border:1px solid #b3ae3f;margin-right:4px" title="color11 #fff75a"></span>
    <span style="display:inline-block;width:14px;height:14px;background:#46f9ff;border:1px solid #1fb3b8;margin-right:4px" title="color12 #46f9ff"></span>
    <span style="display:inline-block;width:14px;height:14px;background:#ff67f5;border:1px solid #b349ad;margin-right:4px" title="color13 #ff67f5"></span>
    <span style="display:inline-block;width:14px;height:14px;background:#7de5ff;border:1px solid #59b3c2;margin-right:4px" title="color14 #7de5ff"></span>
    <span style="display:inline-block;width:14px;height:14px;background:#ffffff;border:1px solid #cfcfcf;margin-right:4px" title="color15 #ffffff"></span>
  </div>
</div>

---

## Backgrounds & Surfaces
- bg-glass: rgba(4, 4, 4, 0.85)
  - Used by: Waybar window, Wofi window
- bg-surface: #1a1a1a
  - Used by: Wofi input, tooltips background

## Text & Neutrals
- text: #e0e0e0
  - Used by: General UI text (Waybar/Wofi)
- text-inverted: #ffffff
  - Used by: Selected items on red background (Wofi)
- neutrals (examples): #e5e5e5, #7f7f7f
  - Used by: Terminal palette grays, disabled-ish states

## Accents
- primary-accent (red): #f50a1c
  - Subtitles / usage:
    - Waybar: tooltip border, active workspace
    - Wofi: window border, selected entry background
    - Dunst: frame/separator
- cyan-accent: #46ebeb
  - Subtitles / usage:
    - Wofi: arrow color
    - Waybar: hover state for workspace buttons
- accent-glow (red shadow): rgba(245, 10, 28, 0.25)
  - Subtitles / usage:
    - Wofi/Waybar: drop shadow/glow effects

## States / Feedback
- success/check (Hyprlock): rgb(252, 238, 9)  (≈ #fcee09)
- error/fail (Hyprlock): rgb(255, 0, 95)      (≈ #ff005f)

## Terminal (kitty) 16-color palette
- color0  #000000
- color1  #ff005f
- color2  #00ff9f
- color3  #fcee09
- color4  #00ffe7
- color5  #ff00d4
- color6  #00d3ff
- color7  #e5e5e5
- color8  #7f7f7f
- color9  #ff2040
- color10 #00ffaa
- color11 #fff75a
- color12 #46f9ff
- color13 #ff67f5
- color14 #7de5ff
- color15 #ffffff

## Copy-paste variables (CSS-like)
```
--bg-glass: rgba(4, 4, 4, 0.85);
--bg-surface: #1a1a1a;
--fg: #e0e0e0;
--accent: #f50a1c;
--accent-2: #46ebeb;
--accent-glow: rgba(245, 10, 28, 0.25);
```

## Credits
- Wildberries for the global color inspiration
