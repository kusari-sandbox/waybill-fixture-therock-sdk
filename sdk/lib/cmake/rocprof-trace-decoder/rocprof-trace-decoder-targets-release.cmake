#----------------------------------------------------------------
# Generated CMake target import file for configuration "Release".
#----------------------------------------------------------------

# Commands may need to know the format version.
set(CMAKE_IMPORT_FILE_VERSION 1)

# Import target "rocprof-trace-decoder::rocprof-trace-decoder" for configuration "Release"
set_property(TARGET rocprof-trace-decoder::rocprof-trace-decoder APPEND PROPERTY IMPORTED_CONFIGURATIONS RELEASE)
set_target_properties(rocprof-trace-decoder::rocprof-trace-decoder PROPERTIES
  IMPORTED_LOCATION_RELEASE "${_IMPORT_PREFIX}/lib/librocprof-trace-decoder.so.0.2.0"
  IMPORTED_SONAME_RELEASE "librocprof-trace-decoder.so.0.2"
  )

list(APPEND _cmake_import_check_targets rocprof-trace-decoder::rocprof-trace-decoder )
list(APPEND _cmake_import_check_files_for_rocprof-trace-decoder::rocprof-trace-decoder "${_IMPORT_PREFIX}/lib/librocprof-trace-decoder.so.0.2.0" )

# Commands beyond this point should not need to know the version.
set(CMAKE_IMPORT_FILE_VERSION)
