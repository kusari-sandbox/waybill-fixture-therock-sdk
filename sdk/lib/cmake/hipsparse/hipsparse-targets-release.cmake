#----------------------------------------------------------------
# Generated CMake target import file for configuration "Release".
#----------------------------------------------------------------

# Commands may need to know the format version.
set(CMAKE_IMPORT_FILE_VERSION 1)

# Import target "roc::hipsparse" for configuration "Release"
set_property(TARGET roc::hipsparse APPEND PROPERTY IMPORTED_CONFIGURATIONS RELEASE)
set_target_properties(roc::hipsparse PROPERTIES
  IMPORTED_LINK_DEPENDENT_LIBRARIES_RELEASE "roc::rocsparse"
  IMPORTED_LOCATION_RELEASE "${_IMPORT_PREFIX}/lib/libhipsparse.so.4.6.0"
  IMPORTED_SONAME_RELEASE "libhipsparse.so.4"
  )

list(APPEND _cmake_import_check_targets roc::hipsparse )
list(APPEND _cmake_import_check_files_for_roc::hipsparse "${_IMPORT_PREFIX}/lib/libhipsparse.so.4.6.0" )

# Commands beyond this point should not need to know the version.
set(CMAKE_IMPORT_FILE_VERSION)
