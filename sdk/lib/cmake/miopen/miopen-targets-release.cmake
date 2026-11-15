#----------------------------------------------------------------
# Generated CMake target import file for configuration "Release".
#----------------------------------------------------------------

# Commands may need to know the format version.
set(CMAKE_IMPORT_FILE_VERSION 1)

# Import target "MIOpen" for configuration "Release"
set_property(TARGET MIOpen APPEND PROPERTY IMPORTED_CONFIGURATIONS RELEASE)
set_target_properties(MIOpen PROPERTIES
  IMPORTED_LINK_DEPENDENT_LIBRARIES_RELEASE "zstd::libzstd_shared;BZip2::BZip2;roc::hipblaslt"
  IMPORTED_LOCATION_RELEASE "${_IMPORT_PREFIX}/lib/libMIOpen.so.1.0"
  IMPORTED_SONAME_RELEASE "libMIOpen.so.1"
  )

list(APPEND _cmake_import_check_targets MIOpen )
list(APPEND _cmake_import_check_files_for_MIOpen "${_IMPORT_PREFIX}/lib/libMIOpen.so.1.0" )

# Commands beyond this point should not need to know the version.
set(CMAKE_IMPORT_FILE_VERSION)
