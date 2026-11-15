#----------------------------------------------------------------
# Generated CMake target import file for configuration "Release".
#----------------------------------------------------------------

# Commands may need to know the format version.
set(CMAKE_IMPORT_FILE_VERSION 1)

# Import target "rocprofiler-sdk-roctx::rocprofiler-sdk-roctx-shared-library" for configuration "Release"
set_property(TARGET rocprofiler-sdk-roctx::rocprofiler-sdk-roctx-shared-library APPEND PROPERTY IMPORTED_CONFIGURATIONS RELEASE)
set_target_properties(rocprofiler-sdk-roctx::rocprofiler-sdk-roctx-shared-library PROPERTIES
  IMPORTED_LINK_DEPENDENT_LIBRARIES_RELEASE "rocprofiler-register::rocprofiler-register"
  IMPORTED_LOCATION_RELEASE "${_IMPORT_PREFIX}/lib/librocprofiler-sdk-roctx.so.1.3.1"
  IMPORTED_SONAME_RELEASE "librocprofiler-sdk-roctx.so.1"
  )

list(APPEND _cmake_import_check_targets rocprofiler-sdk-roctx::rocprofiler-sdk-roctx-shared-library )
list(APPEND _cmake_import_check_files_for_rocprofiler-sdk-roctx::rocprofiler-sdk-roctx-shared-library "${_IMPORT_PREFIX}/lib/librocprofiler-sdk-roctx.so.1.3.1" )

# Commands beyond this point should not need to know the version.
set(CMAKE_IMPORT_FILE_VERSION)
