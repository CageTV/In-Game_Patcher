# In-Game_Patcher.dll on alandtse's CommonLibSSE-NG (Skyrim 1.6.1170 and 1.7.x, SE and AE); included by E:/WorkSpace/ng-build/CMakeLists.txt (see ng_plugin there).
# The repository's own CMakeLists.txt is the older build (CommonLibVR through $ENV{COMMONLIB_SSE_FOLDER}), whose Address Library reader cannot open the
# version 5 files of Skyrim 1.7.x (the game then stops with "failed to open address library file").
# The header-only dependencies (clib-util, clib-utils-qtr, skse-mcp, skyprompt-api) are the commits pinned in cmake/ports, fetched by
# ng-build/fetch_header_port.py into ng-build/deps/In-Game_Patcher; rapidjson comes from the ng-build vcpkg manifest.
set(_igp_deps "E:/WorkSpace/ng-build/deps/In-Game_Patcher/include")
if(NOT EXISTS "${_igp_deps}/SkyPrompt/API.hpp")
    message(FATAL_ERROR "In-Game_Patcher: header dependencies missing in ${_igp_deps}; see the Skyrim 1.7.x section of README.md")
endif()
file(GLOB _igp_sources RELATIVE "${CMAKE_CURRENT_LIST_DIR}" CONFIGURE_DEPENDS "${CMAKE_CURRENT_LIST_DIR}/src/*.cpp")
find_path(IGP_RAPIDJSON_INCLUDE_DIRS "rapidjson/document.h")
ng_plugin(TARGET InGamePatcher NAME In-Game_Patcher VERSION 0.1.4.2 AUTHOR "RavenKZP" ROOT "${CMAKE_CURRENT_LIST_DIR}"
    SOURCES ${_igp_sources}
    INCLUDES "${CMAKE_CURRENT_LIST_DIR}/include" "${_igp_deps}" "${IGP_RAPIDJSON_INCLUDE_DIRS}"
    PCH "${CMAKE_CURRENT_LIST_DIR}/include/PCH.h"
    DEFINES IS_HOST_PLUGIN IGP_NG)
