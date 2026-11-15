#----------------------------------------------------------------
# Generated CMake target import file for configuration "Release".
#----------------------------------------------------------------

# Commands may need to know the format version.
set(CMAKE_IMPORT_FILE_VERSION 1)

# Import target "roc::hipsolver" for configuration "Release"
set_property(TARGET roc::hipsolver APPEND PROPERTY IMPORTED_CONFIGURATIONS RELEASE)
set_target_properties(roc::hipsolver PROPERTIES
  IMPORTED_LINK_DEPENDENT_LIBRARIES_RELEASE "roc::rocblas;roc::rocsolver;roc::rocsparse;SuiteSparse::CHOLMOD"
  IMPORTED_LOCATION_RELEASE "${_IMPORT_PREFIX}/lib/libhipsolver.so.1.2"
  IMPORTED_SONAME_RELEASE "libhipsolver.so.1"
  )

list(APPEND _cmake_import_check_targets roc::hipsolver )
list(APPEND _cmake_import_check_files_for_roc::hipsolver "${_IMPORT_PREFIX}/lib/libhipsolver.so.1.2" )

# Commands beyond this point should not need to know the version.
set(CMAKE_IMPORT_FILE_VERSION)
