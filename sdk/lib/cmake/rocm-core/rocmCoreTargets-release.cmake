#----------------------------------------------------------------
# Generated CMake target import file for configuration "Release".
#----------------------------------------------------------------

# Commands may need to know the format version.
set(CMAKE_IMPORT_FILE_VERSION 1)

# Import target "rocm-core" for configuration "Release"
set_property(TARGET rocm-core APPEND PROPERTY IMPORTED_CONFIGURATIONS RELEASE)
set_target_properties(rocm-core PROPERTIES
  IMPORTED_LOCATION_RELEASE "${_IMPORT_PREFIX}/lib/librocm-core.so.1.0.71400"
  IMPORTED_SONAME_RELEASE "librocm-core.so.1"
  )

list(APPEND _cmake_import_check_targets rocm-core )
list(APPEND _cmake_import_check_files_for_rocm-core "${_IMPORT_PREFIX}/lib/librocm-core.so.1.0.71400" )

# Commands beyond this point should not need to know the version.
set(CMAKE_IMPORT_FILE_VERSION)
