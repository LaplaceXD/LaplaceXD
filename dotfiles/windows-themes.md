# Windows Theme Customization

![image](https://github.com/LaplaceXD/LaplaceXD/assets/67273056/bdfaa4b0-8fb1-497c-91cd-b7352677232c)

## Prerequisites

- [Theme Tool Patcher](https://github.com/namazso/SecureUxTheme)
- [Better Clear Type](https://github.com/bp2008/BetterClearTypeTuner)
- [7tsp](https://www.deviantart.com/devillnside/art/7TSP-GUI-2019-Edition-804769422)
- [Nexus](https://www.winstep.net/nexus.asp)

## Patching Themes

### Patching System Theme

**Themes**

- [Catpuccin](https://github.com/niivu/Windows-10-themes/tree/main/Catppuccin)
- [Paranoid Android Redux](https://github.com/niivu/Windows-10-themes/tree/main/Paranoid%20Android%20Redux)

**Steps**

1. Download `Theme Tool Patcher`.
2. Download any of the themes above.
3. Copy the contents of the themes into `C:\Windows\Resources\Themes`.
4. Run `Theme Tool Patcher` in Administrator Mode.
5. Check `Rename Default Colors`, `Ignore Background`, and `Ignore Cursor`.
6. Patch and apply.

### Patching Folder Icon Themes

**Themes**

- [Catpuccin Mocha](https://github.com/niivu/7tsp-Icon-themes/blob/main/7tsp%20themes/7tsp%20Catppuccin%20Mocha.7z)

**Steps**

1. Download `7tsp`.
2. Extract `7tsp` and rename `.ee` to `.exe`.
3. Download any of the themes above.
4. Run `7tsp` in Administrator Mode.
5. Add the downloaded theme as a Custom Pack.
6. Start patching.

**Optional**

To avoid having the weird thumbnail showing up on folder at the back of the patched theme icon. You can completely disable it using the script below. Just copy paste it to a .bat file.

```bash
@echo off

echo.
taskkill /f /im explorer.exe
timeout 2 /nobreak>nul
echo.

DEL /F /S /Q /A %LocalAppData%\Microsoft\Windows\Explorer\thumbcache_*.db

REG ADD "HKCU\Software\Classes\Local Settings\Software\Microsoft\Windows\Shell\Bags\AllFolders\Shell" /V Logo /T REG_SZ /D imageres.dll,-3 /F

timeout 2 /nobreak>nul
start explorer.exe
```

To undo it you can also use the script below.

```bash
@echo off

echo.
taskkill /f /im explorer.exe
timeout 2 /nobreak>nul
echo.

DEL /F /S /Q /A %LocalAppData%\Microsoft\Windows\Explorer\thumbcache_*.db

REG Delete "HKCU\Software\Classes\Local Settings\Software\Microsoft\Windows\Shell\Bags\AllFolders\Shell" /V Logo /F

timeout 2 /nobreak>nul
start explorer.exe
```

### Patching Windows Cursor

**Themes**

- [Material Design Cursors](https://www.deviantart.com/jepricreations/art/Material-Design-Cursors-Dark-756850032)

**Steps**

1. Download any of the cursor pack above.
2. Extract the contents of the cursor pack to `C:\Windows\Cursors`.
3. Go to `Control Panel` > `Mouse` then set your cursor.

### Patching Nexus Dock

**Themes**

- [Big Sur](https://www.deviantart.com/kamranvaliyev/art/Big-Sur-Skin-for-Nexus-Dock-878646167)

**Steps**

1. Download and setup `Nexus`.
2. Use the given theme above and apply it on `Nexus`.
3. Import the [backup settings](https://github.com/LaplaceXD/LaplaceXD/blob/master/dotfiles/nexus-dock.wbk) for `Nexus`.
