#----------------------------------------------------------------
# Generated CMake target import file for configuration "Release".
#----------------------------------------------------------------

# Commands may need to know the format version.
set(CMAKE_IMPORT_FILE_VERSION 1)

# Import target "roc::rocblas" for configuration "Release"
set_property(TARGET roc::rocblas APPEND PROPERTY IMPORTED_CONFIGURATIONS RELEASE)
set_target_properties(roc::rocblas PROPERTIES
  IMPORTED_LINK_DEPENDENT_LIBRARIES_RELEASE "roc::hipblaslt"
  IMPORTED_LOCATION_RELEASE "${_IMPORT_PREFIX}/lib/librocblas.so.5.5"
  IMPORTED_SONAME_RELEASE "librocblas.so.5"
  )

list(APPEND _cmake_import_check_targets roc::rocblas )
list(APPEND _cmake_import_check_files_for_roc::rocblas "${_IMPORT_PREFIX}/lib/librocblas.so.5.5" )

# Commands beyond this point should not need to know the version.
set(CMAKE_IMPORT_FILE_VERSION)
