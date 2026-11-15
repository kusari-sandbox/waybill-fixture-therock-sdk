#----------------------------------------------------------------
# Generated CMake target import file for configuration "Release".
#----------------------------------------------------------------

# Commands may need to know the format version.
set(CMAKE_IMPORT_FILE_VERSION 1)

# Import target "hiprtc::hiprtc" for configuration "Release"
set_property(TARGET hiprtc::hiprtc APPEND PROPERTY IMPORTED_CONFIGURATIONS RELEASE)
set_target_properties(hiprtc::hiprtc PROPERTIES
  IMPORTED_LOCATION_RELEASE "${_IMPORT_PREFIX}/lib/libhiprtc.so.7.14.60850-1b2a555677"
  IMPORTED_SONAME_RELEASE "libhiprtc.so.7"
  )

list(APPEND _cmake_import_check_targets hiprtc::hiprtc )
list(APPEND _cmake_import_check_files_for_hiprtc::hiprtc "${_IMPORT_PREFIX}/lib/libhiprtc.so.7.14.60850-1b2a555677" )

# Commands beyond this point should not need to know the version.
set(CMAKE_IMPORT_FILE_VERSION)
