#----------------------------------------------------------------
# Generated CMake target import file for configuration "Release".
#----------------------------------------------------------------

# Commands may need to know the format version.
set(CMAKE_IMPORT_FILE_VERSION 1)

# Import target "rocprofiler-systems::rocprofiler-systems-user-library" for configuration "Release"
set_property(TARGET rocprofiler-systems::rocprofiler-systems-user-library APPEND PROPERTY IMPORTED_CONFIGURATIONS RELEASE)
set_target_properties(rocprofiler-systems::rocprofiler-systems-user-library PROPERTIES
  IMPORTED_LOCATION_RELEASE "${_IMPORT_PREFIX}/lib/librocprof-sys-user.so.1.7.0"
  IMPORTED_SONAME_RELEASE "librocprof-sys-user.so.1"
  )

list(APPEND _cmake_import_check_targets rocprofiler-systems::rocprofiler-systems-user-library )
list(APPEND _cmake_import_check_files_for_rocprofiler-systems::rocprofiler-systems-user-library "${_IMPORT_PREFIX}/lib/librocprof-sys-user.so.1.7.0" )

# Commands beyond this point should not need to know the version.
set(CMAKE_IMPORT_FILE_VERSION)
