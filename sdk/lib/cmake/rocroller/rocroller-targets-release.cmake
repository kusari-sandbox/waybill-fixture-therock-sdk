#----------------------------------------------------------------
# Generated CMake target import file for configuration "Release".
#----------------------------------------------------------------

# Commands may need to know the format version.
set(CMAKE_IMPORT_FILE_VERSION 1)

# Import target "roc::rocroller" for configuration "Release"
set_property(TARGET roc::rocroller APPEND PROPERTY IMPORTED_CONFIGURATIONS RELEASE)
set_target_properties(roc::rocroller PROPERTIES
  IMPORTED_LINK_DEPENDENT_LIBRARIES_RELEASE "amd_comgr"
  IMPORTED_LOCATION_RELEASE "${_IMPORT_PREFIX}/lib/librocroller.so.1.0.0"
  IMPORTED_SONAME_RELEASE "librocroller.so.1"
  )

list(APPEND _cmake_import_check_targets roc::rocroller )
list(APPEND _cmake_import_check_files_for_roc::rocroller "${_IMPORT_PREFIX}/lib/librocroller.so.1.0.0" )

# Commands beyond this point should not need to know the version.
set(CMAKE_IMPORT_FILE_VERSION)
