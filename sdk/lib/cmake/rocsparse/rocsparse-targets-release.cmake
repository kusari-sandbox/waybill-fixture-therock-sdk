#----------------------------------------------------------------
# Generated CMake target import file for configuration "Release".
#----------------------------------------------------------------

# Commands may need to know the format version.
set(CMAKE_IMPORT_FILE_VERSION 1)

# Import target "roc::rocsparse" for configuration "Release"
set_property(TARGET roc::rocsparse APPEND PROPERTY IMPORTED_CONFIGURATIONS RELEASE)
set_target_properties(roc::rocsparse PROPERTIES
  IMPORTED_LINK_DEPENDENT_LIBRARIES_RELEASE "roc::rocblas"
  IMPORTED_LOCATION_RELEASE "${_IMPORT_PREFIX}/lib/librocsparse.so.1.0"
  IMPORTED_SONAME_RELEASE "librocsparse.so.1"
  )

list(APPEND _cmake_import_check_targets roc::rocsparse )
list(APPEND _cmake_import_check_files_for_roc::rocsparse "${_IMPORT_PREFIX}/lib/librocsparse.so.1.0" )

# Commands beyond this point should not need to know the version.
set(CMAKE_IMPORT_FILE_VERSION)
