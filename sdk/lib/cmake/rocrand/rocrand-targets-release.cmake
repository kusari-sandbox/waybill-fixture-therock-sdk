#----------------------------------------------------------------
# Generated CMake target import file for configuration "Release".
#----------------------------------------------------------------

# Commands may need to know the format version.
set(CMAKE_IMPORT_FILE_VERSION 1)

# Import target "roc::rocrand" for configuration "Release"
set_property(TARGET roc::rocrand APPEND PROPERTY IMPORTED_CONFIGURATIONS RELEASE)
set_target_properties(roc::rocrand PROPERTIES
  IMPORTED_LOCATION_RELEASE "${_IMPORT_PREFIX}/lib/librocrand.so.1.1"
  IMPORTED_SONAME_RELEASE "librocrand.so.1"
  )

list(APPEND _cmake_import_check_targets roc::rocrand )
list(APPEND _cmake_import_check_files_for_roc::rocrand "${_IMPORT_PREFIX}/lib/librocrand.so.1.1" )

# Commands beyond this point should not need to know the version.
set(CMAKE_IMPORT_FILE_VERSION)
