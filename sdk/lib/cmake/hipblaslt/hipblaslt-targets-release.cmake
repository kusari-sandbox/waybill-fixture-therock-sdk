#----------------------------------------------------------------
# Generated CMake target import file for configuration "Release".
#----------------------------------------------------------------

# Commands may need to know the format version.
set(CMAKE_IMPORT_FILE_VERSION 1)

# Import target "roc::hipblaslt" for configuration "Release"
set_property(TARGET roc::hipblaslt APPEND PROPERTY IMPORTED_CONFIGURATIONS RELEASE)
set_target_properties(roc::hipblaslt PROPERTIES
  IMPORTED_LOCATION_RELEASE "${_IMPORT_PREFIX}/lib/libhipblaslt.so.1.4"
  IMPORTED_SONAME_RELEASE "libhipblaslt.so.1"
  )

list(APPEND _cmake_import_check_targets roc::hipblaslt )
list(APPEND _cmake_import_check_files_for_roc::hipblaslt "${_IMPORT_PREFIX}/lib/libhipblaslt.so.1.4" )

# Commands beyond this point should not need to know the version.
set(CMAKE_IMPORT_FILE_VERSION)
