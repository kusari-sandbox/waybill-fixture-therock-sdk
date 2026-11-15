#----------------------------------------------------------------
# Generated CMake target import file for configuration "Release".
#----------------------------------------------------------------

# Commands may need to know the format version.
set(CMAKE_IMPORT_FILE_VERSION 1)

# Import target "rdc_bootstrap" for configuration "Release"
set_property(TARGET rdc_bootstrap APPEND PROPERTY IMPORTED_CONFIGURATIONS RELEASE)
set_target_properties(rdc_bootstrap PROPERTIES
  IMPORTED_LOCATION_RELEASE "${_IMPORT_PREFIX}/lib/librdc_bootstrap.so.1.3"
  IMPORTED_SONAME_RELEASE "librdc_bootstrap.so.1"
  )

list(APPEND _cmake_import_check_targets rdc_bootstrap )
list(APPEND _cmake_import_check_files_for_rdc_bootstrap "${_IMPORT_PREFIX}/lib/librdc_bootstrap.so.1.3" )

# Import target "rdc" for configuration "Release"
set_property(TARGET rdc APPEND PROPERTY IMPORTED_CONFIGURATIONS RELEASE)
set_target_properties(rdc PROPERTIES
  IMPORTED_LOCATION_RELEASE "${_IMPORT_PREFIX}/lib/librdc.so.1.3"
  IMPORTED_SONAME_RELEASE "librdc.so.1"
  )

list(APPEND _cmake_import_check_targets rdc )
list(APPEND _cmake_import_check_files_for_rdc "${_IMPORT_PREFIX}/lib/librdc.so.1.3" )

# Import target "rdc_client" for configuration "Release"
set_property(TARGET rdc_client APPEND PROPERTY IMPORTED_CONFIGURATIONS RELEASE)
set_target_properties(rdc_client PROPERTIES
  IMPORTED_LOCATION_RELEASE "${_IMPORT_PREFIX}/lib/librdc_client.so.1.3"
  IMPORTED_SONAME_RELEASE "librdc_client.so.1"
  )

list(APPEND _cmake_import_check_targets rdc_client )
list(APPEND _cmake_import_check_files_for_rdc_client "${_IMPORT_PREFIX}/lib/librdc_client.so.1.3" )

# Import target "rdc_rocr" for configuration "Release"
set_property(TARGET rdc_rocr APPEND PROPERTY IMPORTED_CONFIGURATIONS RELEASE)
set_target_properties(rdc_rocr PROPERTIES
  IMPORTED_LOCATION_RELEASE "${_IMPORT_PREFIX}/lib/rdc/librdc_rocr.so.1.3"
  IMPORTED_SONAME_RELEASE "librdc_rocr.so.1"
  )

list(APPEND _cmake_import_check_targets rdc_rocr )
list(APPEND _cmake_import_check_files_for_rdc_rocr "${_IMPORT_PREFIX}/lib/rdc/librdc_rocr.so.1.3" )

# Import target "rdc_rocp" for configuration "Release"
set_property(TARGET rdc_rocp APPEND PROPERTY IMPORTED_CONFIGURATIONS RELEASE)
set_target_properties(rdc_rocp PROPERTIES
  IMPORTED_LINK_DEPENDENT_LIBRARIES_RELEASE "hsa-runtime64::hsa-runtime64;amd_smi"
  IMPORTED_LOCATION_RELEASE "${_IMPORT_PREFIX}/lib/rdc/librdc_rocp.so.1.3"
  IMPORTED_SONAME_RELEASE "librdc_rocp.so.1"
  )

list(APPEND _cmake_import_check_targets rdc_rocp )
list(APPEND _cmake_import_check_files_for_rdc_rocp "${_IMPORT_PREFIX}/lib/rdc/librdc_rocp.so.1.3" )

# Commands beyond this point should not need to know the version.
set(CMAKE_IMPORT_FILE_VERSION)
