#----------------------------------------------------------------
# Generated CMake target import file for configuration "Release".
#----------------------------------------------------------------

# Commands may need to know the format version.
set(CMAKE_IMPORT_FILE_VERSION 1)

# Import target "roc::rocsolver" for configuration "Release"
set_property(TARGET roc::rocsolver APPEND PROPERTY IMPORTED_CONFIGURATIONS RELEASE)
set_target_properties(roc::rocsolver PROPERTIES
  IMPORTED_LOCATION_RELEASE "${_IMPORT_PREFIX}/lib/librocsolver.so.0.10"
  IMPORTED_SONAME_RELEASE "librocsolver.so.0"
  )

list(APPEND _cmake_import_check_targets roc::rocsolver )
list(APPEND _cmake_import_check_files_for_roc::rocsolver "${_IMPORT_PREFIX}/lib/librocsolver.so.0.10" )

# Commands beyond this point should not need to know the version.
set(CMAKE_IMPORT_FILE_VERSION)
