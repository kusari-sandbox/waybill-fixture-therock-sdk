#----------------------------------------------------------------
# Generated CMake target import file for configuration "Release".
#----------------------------------------------------------------

# Commands may need to know the format version.
set(CMAKE_IMPORT_FILE_VERSION 1)

# Import target "amd_smi" for configuration "Release"
set_property(TARGET amd_smi APPEND PROPERTY IMPORTED_CONFIGURATIONS RELEASE)
set_target_properties(amd_smi PROPERTIES
  IMPORTED_LINK_DEPENDENT_LIBRARIES_RELEASE "libnl::genl;libmnl::libmnl"
  IMPORTED_LOCATION_RELEASE "${_IMPORT_PREFIX}/lib/libamd_smi.so.26.5.0"
  IMPORTED_SONAME_RELEASE "libamd_smi.so.26"
  )

list(APPEND _cmake_import_check_targets amd_smi )
list(APPEND _cmake_import_check_files_for_amd_smi "${_IMPORT_PREFIX}/lib/libamd_smi.so.26.5.0" )

# Import target "amdsminic" for configuration "Release"
set_property(TARGET amdsminic APPEND PROPERTY IMPORTED_CONFIGURATIONS RELEASE)
set_target_properties(amdsminic PROPERTIES
  IMPORTED_LINK_INTERFACE_LANGUAGES_RELEASE "CXX"
  IMPORTED_LOCATION_RELEASE "${_IMPORT_PREFIX}/lib/libamdsminic.a"
  )

list(APPEND _cmake_import_check_targets amdsminic )
list(APPEND _cmake_import_check_files_for_amdsminic "${_IMPORT_PREFIX}/lib/libamdsminic.a" )

# Import target "amd_smi_static" for configuration "Release"
set_property(TARGET amd_smi_static APPEND PROPERTY IMPORTED_CONFIGURATIONS RELEASE)
set_target_properties(amd_smi_static PROPERTIES
  IMPORTED_LINK_INTERFACE_LANGUAGES_RELEASE "C;CXX"
  IMPORTED_LOCATION_RELEASE "${_IMPORT_PREFIX}/lib/libamd_smi_static.a"
  )

list(APPEND _cmake_import_check_targets amd_smi_static )
list(APPEND _cmake_import_check_files_for_amd_smi_static "${_IMPORT_PREFIX}/lib/libamd_smi_static.a" )

# Commands beyond this point should not need to know the version.
set(CMAKE_IMPORT_FILE_VERSION)
