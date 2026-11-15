#----------------------------------------------------------------
# Generated CMake target import file for configuration "Release".
#----------------------------------------------------------------

# Commands may need to know the format version.
set(CMAKE_IMPORT_FILE_VERSION 1)

# Import target "rocm::rocm_kpack" for configuration "Release"
set_property(TARGET rocm::rocm_kpack APPEND PROPERTY IMPORTED_CONFIGURATIONS RELEASE)
set_target_properties(rocm::rocm_kpack PROPERTIES
  IMPORTED_LOCATION_RELEASE "${_IMPORT_PREFIX}/lib/librocm_kpack.so.0.1.0"
  IMPORTED_SONAME_RELEASE "librocm_kpack.so.0"
  )

list(APPEND _cmake_import_check_targets rocm::rocm_kpack )
list(APPEND _cmake_import_check_files_for_rocm::rocm_kpack "${_IMPORT_PREFIX}/lib/librocm_kpack.so.0.1.0" )

# Commands beyond this point should not need to know the version.
set(CMAKE_IMPORT_FILE_VERSION)
