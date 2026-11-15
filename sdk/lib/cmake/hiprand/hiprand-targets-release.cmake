#----------------------------------------------------------------
# Generated CMake target import file for configuration "Release".
#----------------------------------------------------------------

# Commands may need to know the format version.
set(CMAKE_IMPORT_FILE_VERSION 1)

# Import target "hip::hiprand" for configuration "Release"
set_property(TARGET hip::hiprand APPEND PROPERTY IMPORTED_CONFIGURATIONS RELEASE)
set_target_properties(hip::hiprand PROPERTIES
  IMPORTED_LOCATION_RELEASE "${_IMPORT_PREFIX}/lib/libhiprand.so.1.1"
  IMPORTED_SONAME_RELEASE "libhiprand.so.1"
  )

list(APPEND _cmake_import_check_targets hip::hiprand )
list(APPEND _cmake_import_check_files_for_hip::hiprand "${_IMPORT_PREFIX}/lib/libhiprand.so.1.1" )

# Commands beyond this point should not need to know the version.
set(CMAKE_IMPORT_FILE_VERSION)
