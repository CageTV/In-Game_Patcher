#### YOU NEED CMAKE < 3.5 !

#### WINDOWS ENVIRONMENT VARIABLES TO SET

1. **`COMMONLIB_SSE_FOLDER`**: The path to your clone of Commonlib.
2. **`VCPKG_ROOT`**: The path to your clone of [vcpkg](https://github.com/microsoft/vcpkg).
3. (optional) **`SKYRIM_FOLDER`**: path of your Skyrim Special Edition folder.
4. (optional) **`SKYRIM_MODS_FOLDER`**: path of the folder where your mods are.

#### THINGS TO EDIT

1. In LICENSE:
- **`YEAR`**
- **`YOURNAME`**
2. CMakeLists.txt
- **`AUTHORNAME`**
- **`MDDNAME`**
- (optional) Your plugin version. Default: `0.1.0.0`
3. vcpkg.json
- **`name`**: Your plugin's name.
- **`version-string`**: Your plugin version. Default: `0.1.0.0`

#### FEATURES
Automatically imports:
- [CLibUtil](https://github.com/powerof3/CLibUtil) by powerof3
- [SKSE Menu Framework](https://www.nexusmods.com/skyrimspecialedition/mods/120352) by Thiago099

## Fork: Skyrim 1.7.x

The CommonLibVR that `CMakeLists.txt` builds against cannot read the version 5 Address Library files of Skyrim 1.7.x, and the game stops with "failed to open address library file". `ng.cmake` builds `In-Game_Patcher.dll` on alandtse's CommonLibSSE-NG for Skyrim 1.6.1170 and 1.7.x; it is included from a parent CMake project that defines `ng_plugin()` (a thin wrapper around `add_commonlibsse_plugin`) and provides `rapidjson` through vcpkg. `IGP_NG` is defined in that build and switches the few places where alandtse's library differs: `CFilter` is a struct, the pick data's collector is `closestRayHitCollector`, `Console::GetSelectedRef()` picks the right address for every AE version, and the HUD message is `SendHUDMessage::ShowHUDMessage`.

The header-only dependencies are the commits pinned in `cmake/ports` (clib-util, clib-utils-qtr, skse-mcp, skyprompt-api); the build expects their `include` folders (`ClibUtil`, `CLibUtilsQTR`, `SKSEMCP`, `SkyPrompt`) in one directory, which `ng.cmake` names in `_igp_deps`. I checked the two engine calls (Address Library ids 34456 and 77988) and the `PlayerCharacter` update slot (0xAD) against SkyrimSE.exe 1.7.104.

The release zip contains only the DLL. Install In-Game Patcher from Nexus first and let the DLL overwrite its own.
