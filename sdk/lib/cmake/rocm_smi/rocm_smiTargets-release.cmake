#----------------------------------------------------------------
# Generated CMake target import file for configuration "Release".
#----------------------------------------------------------------

# Commands may need to know the format version.
set(CMAKE_IMPORT_FILE_VERSION 1)

# Import target "rocm_smi64" for configuration "Release"
set_property(TARGET rocm_smi64 APPEND PROPERTY IMPORTED_CONFIGURATIONS RELEASE)
set_target_properties(rocm_smi64 PROPERTIES
  IMPORTED_LOCATION_RELEASE "${_IMPORT_PREFIX}/lib/librocm_smi64.so.1.0"
  IMPORTED_SONAME_RELEASE "librocm_smi64.so.1"
  )

list(APPEND _cmake_import_check_targets rocm_smi64 )
list(APPEND _cmake_import_check_files_for_rocm_smi64 "${_IMPORT_PREFIX}/lib/librocm_smi64.so.1.0" )

# Import target "oam" for configuration "Release"
set_property(TARGET oam APPEND PROPERTY IMPORTED_CONFIGURATIONS RELEASE)
set_target_properties(oam PROPERTIES
  IMPORTED_LOCATION_RELEASE "${_IMPORT_PREFIX}/lib/liboam.so.1.0"
  IMPORTED_SONAME_RELEASE "liboam.so.1"
  )

list(APPEND _cmake_import_check_targets oam )
list(APPEND _cmake_import_check_files_for_oam "${_IMPORT_PREFIX}/lib/liboam.so.1.0" )

# Commands beyond this point should not need to know the version.
set(CMAKE_IMPORT_FILE_VERSION)
