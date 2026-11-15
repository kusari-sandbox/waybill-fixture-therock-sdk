#----------------------------------------------------------------
# Generated CMake target import file for configuration "Release".
#----------------------------------------------------------------

# Commands may need to know the format version.
set(CMAKE_IMPORT_FILE_VERSION 1)

# Import target "rocprofiler-register::rocprofiler-register" for configuration "Release"
set_property(TARGET rocprofiler-register::rocprofiler-register APPEND PROPERTY IMPORTED_CONFIGURATIONS RELEASE)
set_target_properties(rocprofiler-register::rocprofiler-register PROPERTIES
  IMPORTED_LOCATION_RELEASE "${_IMPORT_PREFIX}/lib/librocprofiler-register.so.0.6.0"
  IMPORTED_SONAME_RELEASE "librocprofiler-register.so.0"
  )

list(APPEND _cmake_import_check_targets rocprofiler-register::rocprofiler-register )
list(APPEND _cmake_import_check_files_for_rocprofiler-register::rocprofiler-register "${_IMPORT_PREFIX}/lib/librocprofiler-register.so.0.6.0" )

# Commands beyond this point should not need to know the version.
set(CMAKE_IMPORT_FILE_VERSION)
