#----------------------------------------------------------------
# Generated CMake target import file for configuration "Release".
#----------------------------------------------------------------

# Commands may need to know the format version.
set(CMAKE_IMPORT_FILE_VERSION 1)

# Import target "OpenMP::omp" for configuration "Release"
set_property(TARGET OpenMP::omp APPEND PROPERTY IMPORTED_CONFIGURATIONS RELEASE)
set_target_properties(OpenMP::omp PROPERTIES
  IMPORTED_LOCATION_RELEASE "${_IMPORT_PREFIX}/lib/libomp.so"
  IMPORTED_SONAME_RELEASE "libomp.so"
  )

list(APPEND _cmake_import_check_targets OpenMP::omp )
list(APPEND _cmake_import_check_files_for_OpenMP::omp "${_IMPORT_PREFIX}/lib/libomp.so" )

# Commands beyond this point should not need to know the version.
set(CMAKE_IMPORT_FILE_VERSION)
