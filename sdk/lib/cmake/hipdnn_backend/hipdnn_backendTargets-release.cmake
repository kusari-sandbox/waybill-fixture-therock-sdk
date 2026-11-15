#----------------------------------------------------------------
# Generated CMake target import file for configuration "Release".
#----------------------------------------------------------------

# Commands may need to know the format version.
set(CMAKE_IMPORT_FILE_VERSION 1)

# Import target "hipdnn_backend" for configuration "Release"
set_property(TARGET hipdnn_backend APPEND PROPERTY IMPORTED_CONFIGURATIONS RELEASE)
set_target_properties(hipdnn_backend PROPERTIES
  IMPORTED_LOCATION_RELEASE "${_IMPORT_PREFIX}/lib/libhipdnn_backend.so"
  IMPORTED_SONAME_RELEASE "libhipdnn_backend.so"
  )

list(APPEND _cmake_import_check_targets hipdnn_backend )
list(APPEND _cmake_import_check_files_for_hipdnn_backend "${_IMPORT_PREFIX}/lib/libhipdnn_backend.so" )

# Commands beyond this point should not need to know the version.
set(CMAKE_IMPORT_FILE_VERSION)
