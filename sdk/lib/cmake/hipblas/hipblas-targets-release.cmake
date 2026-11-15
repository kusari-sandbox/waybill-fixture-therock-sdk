#----------------------------------------------------------------
# Generated CMake target import file for configuration "Release".
#----------------------------------------------------------------

# Commands may need to know the format version.
set(CMAKE_IMPORT_FILE_VERSION 1)

# Import target "roc::hipblas" for configuration "Release"
set_property(TARGET roc::hipblas APPEND PROPERTY IMPORTED_CONFIGURATIONS RELEASE)
set_target_properties(roc::hipblas PROPERTIES
  IMPORTED_LINK_DEPENDENT_LIBRARIES_RELEASE "roc::rocblas;roc::rocsolver"
  IMPORTED_LOCATION_RELEASE "${_IMPORT_PREFIX}/lib/libhipblas.so.3.5"
  IMPORTED_SONAME_RELEASE "libhipblas.so.3"
  )

list(APPEND _cmake_import_check_targets roc::hipblas )
list(APPEND _cmake_import_check_files_for_roc::hipblas "${_IMPORT_PREFIX}/lib/libhipblas.so.3.5" )

# Commands beyond this point should not need to know the version.
set(CMAKE_IMPORT_FILE_VERSION)
