#----------------------------------------------------------------
# Generated CMake target import file for configuration "Release".
#----------------------------------------------------------------

# Commands may need to know the format version.
set(CMAKE_IMPORT_FILE_VERSION 1)

# Import target "roc::hipsparselt" for configuration "Release"
set_property(TARGET roc::hipsparselt APPEND PROPERTY IMPORTED_CONFIGURATIONS RELEASE)
set_target_properties(roc::hipsparselt PROPERTIES
  IMPORTED_LOCATION_RELEASE "${_IMPORT_PREFIX}/lib/libhipsparselt.so.0.2"
  IMPORTED_SONAME_RELEASE "libhipsparselt.so.0"
  )

list(APPEND _cmake_import_check_targets roc::hipsparselt )
list(APPEND _cmake_import_check_files_for_roc::hipsparselt "${_IMPORT_PREFIX}/lib/libhipsparselt.so.0.2" )

# Commands beyond this point should not need to know the version.
set(CMAKE_IMPORT_FILE_VERSION)
