#----------------------------------------------------------------
# Generated CMake target import file for configuration "Release".
#----------------------------------------------------------------

# Commands may need to know the format version.
set(CMAKE_IMPORT_FILE_VERSION 1)

# Import target "hip::hipfft" for configuration "Release"
set_property(TARGET hip::hipfft APPEND PROPERTY IMPORTED_CONFIGURATIONS RELEASE)
set_target_properties(hip::hipfft PROPERTIES
  IMPORTED_LINK_DEPENDENT_LIBRARIES_RELEASE "roc::rocfft"
  IMPORTED_LOCATION_RELEASE "${_IMPORT_PREFIX}/lib/libhipfft.so.0.1"
  IMPORTED_SONAME_RELEASE "libhipfft.so.0"
  )

list(APPEND _cmake_import_check_targets hip::hipfft )
list(APPEND _cmake_import_check_files_for_hip::hipfft "${_IMPORT_PREFIX}/lib/libhipfft.so.0.1" )

# Import target "hip::hipfftw" for configuration "Release"
set_property(TARGET hip::hipfftw APPEND PROPERTY IMPORTED_CONFIGURATIONS RELEASE)
set_target_properties(hip::hipfftw PROPERTIES
  IMPORTED_LINK_DEPENDENT_LIBRARIES_RELEASE "roc::rocfft"
  IMPORTED_LOCATION_RELEASE "${_IMPORT_PREFIX}/lib/libhipfftw.so.0.1"
  IMPORTED_SONAME_RELEASE "libhipfftw.so.0"
  )

list(APPEND _cmake_import_check_targets hip::hipfftw )
list(APPEND _cmake_import_check_files_for_hip::hipfftw "${_IMPORT_PREFIX}/lib/libhipfftw.so.0.1" )

# Commands beyond this point should not need to know the version.
set(CMAKE_IMPORT_FILE_VERSION)
