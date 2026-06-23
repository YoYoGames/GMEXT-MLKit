cmake_minimum_required(VERSION 3.18)

# -----------------------------------------------------------------------------
# Core "bag of usage requirements" the main target links to
# -----------------------------------------------------------------------------
add_library(ext_third_party INTERFACE)

# List of runtime files to bubble up to parent
set(_EXT_TP_RUNTIME_DLLS "")

# =============================================================================
# WINDOWS (MSVC/ClangCL)
# =============================================================================
if(WIN32)
# =============================================================================
# APPLE: split macOS vs iOS/tvOS
# =============================================================================
elseif(APPLE)
  # ----------------------
  # iOS (mobile)
  # ----------------------
  if(CMAKE_OSX_SYSROOT MATCHES "iphone")

    # The MLKit frameworks are provided by CocoaPods inside the GameMaker
    # exported Xcode project (Podfile must contain `pod 'GoogleMLKit/Translate'`
    # and `pod install` must have been run). We only need the framework headers
    # on the search path so that `#import <MLKitTranslate/MLKitTranslate.h>`
    # (and its transitive MLKitCommon imports) resolve while compiling the
    # extension's static library. The MLKit binaries are linked into the final
    # app by CocoaPods, not into this static lib.
    get_filename_component(EXT_GM_PARENT_DIR "${EXT_GM_XCODEPROJ_OVERRIDE}" DIRECTORY)
    set(POD_ROOT "${EXT_GM_PARENT_DIR}/Pods")

    if(NOT EXISTS "${POD_ROOT}")
      message(FATAL_ERROR
        "[third_party] Pods directory not found at: ${POD_ROOT}\n"
        "Set EXT_GM_XCODEPROJ_OVERRIDE (in src/CMakeLists.txt) to your exported "
        "GameMaker .xcodeproj and run `pod install` first.")
    endif()

    # Slice token to select inside each *.xcframework (device vs simulator).
    if(CMAKE_OSX_SYSROOT MATCHES "simulator")
      set(_SLICE "ios-arm64_x86_64-simulator")
      set(_SLICE_ALT "ios-arm64-simulator")
    else()
      set(_SLICE "ios-arm64")
      set(_SLICE_ALT "ios-arm64")
    endif()

    # Find every .framework installed by the pods (both prebuilt .xcframework
    # slices and plain .framework layouts) and collect their parent dirs.
    file(GLOB_RECURSE _FW_DIRS LIST_DIRECTORIES true "${POD_ROOT}/*.framework")

    set(_FW_SEARCH_DIRS "")
    foreach(_fw IN LISTS _FW_DIRS)
      if(NOT IS_DIRECTORY "${_fw}")
        continue()
      endif()

      # For frameworks that live inside an .xcframework, keep only the slice
      # that matches the SDK we are currently building for.
      if("${_fw}" MATCHES "\\.xcframework/")
        if(NOT ("${_fw}" MATCHES "/${_SLICE}/" OR "${_fw}" MATCHES "/${_SLICE_ALT}/"))
          continue()
        endif()
      endif()

      get_filename_component(_parent "${_fw}" DIRECTORY)
      list(APPEND _FW_SEARCH_DIRS "${_parent}")
    endforeach()

    list(REMOVE_DUPLICATES _FW_SEARCH_DIRS)

    if(NOT _FW_SEARCH_DIRS)
      message(FATAL_ERROR
        "[third_party] No .framework found under ${POD_ROOT}.\n"
        "Make sure `pod 'GoogleMLKit/Translate'` is in the Podfile and "
        "`pod install` has been run for sysroot ${CMAKE_OSX_SYSROOT}.")
    endif()

    message(STATUS "[third_party] MLKit framework search dirs (${CMAKE_OSX_SYSROOT}):")
    foreach(_d IN LISTS _FW_SEARCH_DIRS)
      message(STATUS "  -F${_d}")
      # Header search for the compile, link search for parity (harmless on a
      # static lib; the app links MLKit through CocoaPods).
      target_compile_options(ext_third_party INTERFACE "-F${_d}")
      target_link_options(ext_third_party INTERFACE "-F${_d}")
    endforeach()

  # ----------------------
  # macOS (desktop)
  # ----------------------
  else()
  endif() # macOS

# =============================================================================
# ANDROID (handled via Gradle dependencies, not here)
# =============================================================================
elseif(ANDROID)
# =============================================================================
# LINUX
# =============================================================================
elseif(UNIX)
endif()

# =============================================================================
# Bubble up runtime list to parent
# =============================================================================
set(EXT_TP_RUNTIME_DLLS "${_EXT_TP_RUNTIME_DLLS}" PARENT_SCOPE)
