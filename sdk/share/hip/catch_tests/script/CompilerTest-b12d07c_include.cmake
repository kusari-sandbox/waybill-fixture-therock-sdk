
file(REAL_PATH ${CMAKE_CURRENT_LIST_FILE} FULL_FILE_PATH)
get_filename_component(CTEST_CURRENT_DIR ${FULL_FILE_PATH} DIRECTORY)
file(REAL_PATH ${CTEST_CURRENT_DIR}/.. EXE_PATH)

set(LIB_PATH ${EXE_PATH}/../../../lib)
file(GLOB HIP_LIBS "${LIB_PATH}/libamdhip64*")
if(HIP_LIBS)
    set(LIB_PATH ${LIB_PATH} ${LIB_PATH}/rocm_sysdeps/lib)
else()
    set(LIB_PATH "/opt/rocm/lib")
endif()
 
# File has been updated by hip-tests/catch folder for portability
if(EXISTS "CompilerTest")
  if(NOT EXISTS "CompilerTest-b12d07c_tests.cmake" OR
     NOT "CompilerTest-b12d07c_tests.cmake" IS_NEWER_THAN "CompilerTest" OR
     NOT "CompilerTest-b12d07c_tests.cmake" IS_NEWER_THAN "${CMAKE_CURRENT_LIST_FILE}")
    include("${CTEST_CURRENT_DIR}/CatchAddTests.cmake")
    catch_discover_tests_impl(
      TEST_EXECUTABLE  ${EXE_PATH}/CompilerTest
      TEST_EXECUTOR [==[]==]
      TEST_WORKING_DIR  ${EXE_PATH}
      TEST_SPEC [==[]==]
      TEST_EXTRA_ARGS [==[]==]
      TEST_PROPERTIES [==[SKIP_RETURN_CODE;4]==]
      TEST_PREFIX [==[]==]
      TEST_SUFFIX [==[]==]
      TEST_LIST [==[CompilerTest_TESTS]==]
      TEST_REPORTER [==[]==]
      TEST_OUTPUT_DIR [==[]==]
      TEST_OUTPUT_PREFIX [==[]==]
      TEST_OUTPUT_SUFFIX [==[]==]
      CTEST_FILE ${CTEST_CURRENT_DIR}/CompilerTest-b12d07c_tests.cmake
      TEST_DL_PATHS  ${LIB_PATH}
      TEST_DL_FRAMEWORK_PATHS [==[]==]
      ADD_TAGS_AS_LABELS [==[TRUE]==]
    )
  endif()
  include("${CTEST_CURRENT_DIR}/CompilerTest-b12d07c_tests.cmake")
else()
  add_test(CompilerTest_NOT_BUILT CompilerTest_NOT_BUILT)
endif()
