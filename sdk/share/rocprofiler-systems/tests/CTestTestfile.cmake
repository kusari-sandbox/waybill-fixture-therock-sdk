# Auto-generated CTest definitions from rocprofiler-systems pytest suite
# DO NOT EDIT — regenerate via: pytest <dir> --ctest-mode=generate
#
# Run with: ctest --test-dir <directory containing this file>
#
# Supported environment variables:
#   ROCPROFSYS_TEST_DIR         - Path to test package directory or .pyz file
#   ROCPROFSYS_TEST_EXECUTABLE  - Python or pytest executable to use
#   ROCPROFSYS_PYTHON_HINTS     - Additional search paths for versioned Python interpreters
#

if(DEFINED ENV{ROCPROFSYS_TEST_DIR} AND NOT DEFINED ROCPROFSYS_TEST_DIR)
    set(ROCPROFSYS_TEST_DIR "$ENV{ROCPROFSYS_TEST_DIR}")
endif()
if(DEFINED ENV{ROCPROFSYS_TEST_EXECUTABLE} AND NOT DEFINED ROCPROFSYS_TEST_EXECUTABLE)
    set(ROCPROFSYS_TEST_EXECUTABLE "$ENV{ROCPROFSYS_TEST_EXECUTABLE}")
endif()
if(DEFINED ENV{ROCPROFSYS_PYTHON_HINTS} AND NOT DEFINED ROCPROFSYS_PYTHON_HINTS)
    set(ROCPROFSYS_PYTHON_HINTS "$ENV{ROCPROFSYS_PYTHON_HINTS}")
endif()

execute_process(COMMAND pwd OUTPUT_VARIABLE _CTEST_DIR OUTPUT_STRIP_TRAILING_WHITESPACE)
if(NOT DEFINED ROCPROFSYS_TEST_DIR)
    set(ROCPROFSYS_TEST_DIR "${_CTEST_DIR}")
endif()

set(_INSTALL_PATH "${ROCPROFSYS_TEST_DIR}/rocprofsys-tests.pyz")
set(_BUILD_PATH "${ROCPROFSYS_TEST_DIR}/../share/rocprofiler-systems/tests/pytest/")
set(_TEST_ARGS "-s" "--ctest-mode" "run")

if(EXISTS "${_INSTALL_PATH}")
    if(NOT DEFINED ROCPROFSYS_TEST_EXECUTABLE)
        find_program(ROCPROFSYS_TEST_EXECUTABLE NAMES python3 python HINTS ${ROCPROFSYS_PYTHON_HINTS})
    endif()
    if(NOT ROCPROFSYS_TEST_EXECUTABLE)
        message(FATAL_ERROR
            "python executable not found. "
            "Set ROCPROFSYS_TEST_EXECUTABLE to the correct path "
            "or provide ROCPROFSYS_PYTHON_HINTS to search for the executable.")
    endif()
    set(_ROCPROFSYS_EXE "${ROCPROFSYS_TEST_EXECUTABLE}")
    set(_ROCPROFSYS_EXE_ARGS "${_INSTALL_PATH}")
    set(_ROCPROFSYS_NODEID_PFX "")
    set(_ROCPROFSYS_EXTRA_ARGS "${_TEST_ARGS}")
elseif(EXISTS "${_BUILD_PATH}")
    if(NOT DEFINED ROCPROFSYS_TEST_EXECUTABLE)
        find_program(ROCPROFSYS_TEST_EXECUTABLE NAMES pytest pytest3 HINTS ${ROCPROFSYS_PYTHON_HINTS})
    endif()
    if(NOT ROCPROFSYS_TEST_EXECUTABLE)
        message(FATAL_ERROR
            "pytest executable not found. "
            "Set ROCPROFSYS_TEST_EXECUTABLE to the correct path "
            "or provide ROCPROFSYS_PYTHON_HINTS to search for the executable.")
    endif()
    set(_ROCPROFSYS_EXE "${ROCPROFSYS_TEST_EXECUTABLE}")
    set(_ROCPROFSYS_EXE_ARGS "")
    set(_ROCPROFSYS_NODEID_PFX "${_BUILD_PATH}")
    set(_ROCPROFSYS_EXTRA_ARGS "${_TEST_ARGS}")
else()
    message(FATAL_ERROR "Cannot find test package. Set ROCPROFSYS_TEST_DIR=/path/to/rocprofsys-tests.pyz")
endif()

if(DEFINED ENV{ROCPROFSYS_CI_TIMEOUT})
    set(_ROCPROFSYS_CI_TIMEOUT "$ENV{ROCPROFSYS_CI_TIMEOUT}")
endif()

add_test("rocprofiler-systems-pytest-config" "${_ROCPROFSYS_EXE}" "${_ROCPROFSYS_EXE_ARGS}" "${_ROCPROFSYS_NODEID_PFX}" "--show-config-only")
set_tests_properties("rocprofiler-systems-pytest-config" PROPERTIES
    FIXTURES_SETUP "rocprofsys-global-tmp-files"
    LABELS "prerequisite;global"
    TIMEOUT 10
)

if(DEFINED _ROCPROFSYS_CI_TIMEOUT)
    math(EXPR _TEST_TIMEOUT "${_ROCPROFSYS_CI_TIMEOUT} + 30")
else()
    set(_TEST_TIMEOUT 330)
endif()

add_test("annotate-parallel-overhead-sampling" "${_ROCPROFSYS_EXE}" "${_ROCPROFSYS_EXE_ARGS}" "${_ROCPROFSYS_NODEID_PFX}test_annotate.py::TestAnnotate::test_parallel_overhead[sampling]" ${_ROCPROFSYS_EXTRA_ARGS})
set_tests_properties("annotate-parallel-overhead-sampling" PROPERTIES
    LABELS "annotate;sampling"
    TIMEOUT ${_TEST_TIMEOUT}
    SKIP_RETURN_CODE 77
    FIXTURES_REQUIRED "rocprofsys-global-tmp-files"
)

if(DEFINED _ROCPROFSYS_CI_TIMEOUT)
    math(EXPR _TEST_TIMEOUT "${_ROCPROFSYS_CI_TIMEOUT} + 30")
else()
    set(_TEST_TIMEOUT 330)
endif()

add_test("annotate-parallel-overhead-binary-rewrite" "${_ROCPROFSYS_EXE}" "${_ROCPROFSYS_EXE_ARGS}" "${_ROCPROFSYS_NODEID_PFX}test_annotate.py::TestAnnotate::test_parallel_overhead[binary_rewrite]" ${_ROCPROFSYS_EXTRA_ARGS})
set_tests_properties("annotate-parallel-overhead-binary-rewrite" PROPERTIES
    LABELS "annotate;binary_rewrite"
    TIMEOUT ${_TEST_TIMEOUT}
    SKIP_RETURN_CODE 77
    FIXTURES_REQUIRED "rocprofsys-global-tmp-files"
)

if(DEFINED _ROCPROFSYS_CI_TIMEOUT)
    math(EXPR _TEST_TIMEOUT "${_ROCPROFSYS_CI_TIMEOUT} + 30")
else()
    set(_TEST_TIMEOUT 330)
endif()

add_test("annotate-parallel-overhead-sys-run" "${_ROCPROFSYS_EXE}" "${_ROCPROFSYS_EXE_ARGS}" "${_ROCPROFSYS_NODEID_PFX}test_annotate.py::TestAnnotate::test_parallel_overhead[sys_run]" ${_ROCPROFSYS_EXTRA_ARGS})
set_tests_properties("annotate-parallel-overhead-sys-run" PROPERTIES
    LABELS "annotate;sys_run"
    TIMEOUT ${_TEST_TIMEOUT}
    SKIP_RETURN_CODE 77
    FIXTURES_REQUIRED "rocprofsys-global-tmp-files"
)

if(DEFINED _ROCPROFSYS_CI_TIMEOUT)
    math(EXPR _TEST_TIMEOUT "${_ROCPROFSYS_CI_TIMEOUT} + 30")
else()
    set(_TEST_TIMEOUT 330)
endif()

add_test("attach-parallel-overhead" "${_ROCPROFSYS_EXE}" "${_ROCPROFSYS_EXE_ARGS}" "${_ROCPROFSYS_NODEID_PFX}test_attach.py::TestAttach::test_parallel_overhead" ${_ROCPROFSYS_EXTRA_ARGS})
set_tests_properties("attach-parallel-overhead" PROPERTIES
    LABELS "attach;runtime_instrument"
    TIMEOUT ${_TEST_TIMEOUT}
    SKIP_RETURN_CODE 77
    FIXTURES_REQUIRED "rocprofsys-global-tmp-files"
)

if(DEFINED _ROCPROFSYS_CI_TIMEOUT)
    math(EXPR _TEST_TIMEOUT "${_ROCPROFSYS_CI_TIMEOUT} + 30")
else()
    set(_TEST_TIMEOUT 75)
endif()

add_test("rocprofiler-systems-instrument-help" "${_ROCPROFSYS_EXE}" "${_ROCPROFSYS_EXE_ARGS}" "${_ROCPROFSYS_NODEID_PFX}test_binaries.py::TestRocprofilerSystemsInstrument::test_help" ${_ROCPROFSYS_EXTRA_ARGS})
set_tests_properties("rocprofiler-systems-instrument-help" PROPERTIES
    LABELS "instrument;rocprof_binary"
    TIMEOUT ${_TEST_TIMEOUT}
    SKIP_RETURN_CODE 77
    FIXTURES_REQUIRED "rocprofsys-global-tmp-files"
)

if(DEFINED _ROCPROFSYS_CI_TIMEOUT)
    math(EXPR _TEST_TIMEOUT "${_ROCPROFSYS_CI_TIMEOUT} + 30")
else()
    set(_TEST_TIMEOUT 270)
endif()

add_test("rocprofiler-systems-instrument-simulate-ls" "${_ROCPROFSYS_EXE}" "${_ROCPROFSYS_EXE_ARGS}" "${_ROCPROFSYS_NODEID_PFX}test_binaries.py::TestRocprofilerSystemsInstrument::test_simulate_ls" ${_ROCPROFSYS_EXTRA_ARGS})
set_tests_properties("rocprofiler-systems-instrument-simulate-ls" PROPERTIES
    LABELS "instrument;rocprof_binary"
    TIMEOUT ${_TEST_TIMEOUT}
    SKIP_RETURN_CODE 77
    FIXTURES_REQUIRED "rocprofsys-global-tmp-files"
)

if(DEFINED _ROCPROFSYS_CI_TIMEOUT)
    math(EXPR _TEST_TIMEOUT "${_ROCPROFSYS_CI_TIMEOUT} + 30")
else()
    set(_TEST_TIMEOUT 150)
endif()

add_test("rocprofiler-systems-instrument-simulate-lib" "${_ROCPROFSYS_EXE}" "${_ROCPROFSYS_EXE_ARGS}" "${_ROCPROFSYS_NODEID_PFX}test_binaries.py::TestRocprofilerSystemsInstrument::test_simulate_lib" ${_ROCPROFSYS_EXTRA_ARGS})
set_tests_properties("rocprofiler-systems-instrument-simulate-lib" PROPERTIES
    LABELS "instrument;rocprof_binary"
    TIMEOUT ${_TEST_TIMEOUT}
    SKIP_RETURN_CODE 77
    FIXTURES_REQUIRED "rocprofsys-global-tmp-files"
)

if(DEFINED _ROCPROFSYS_CI_TIMEOUT)
    math(EXPR _TEST_TIMEOUT "${_ROCPROFSYS_CI_TIMEOUT} + 30")
else()
    set(_TEST_TIMEOUT 150)
endif()

add_test("rocprofiler-systems-instrument-simulate-lib-basename" "${_ROCPROFSYS_EXE}" "${_ROCPROFSYS_EXE_ARGS}" "${_ROCPROFSYS_NODEID_PFX}test_binaries.py::TestRocprofilerSystemsInstrument::test_simulate_lib_basename" ${_ROCPROFSYS_EXTRA_ARGS})
set_tests_properties("rocprofiler-systems-instrument-simulate-lib-basename" PROPERTIES
    LABELS "instrument;rocprof_binary"
    TIMEOUT ${_TEST_TIMEOUT}
    SKIP_RETURN_CODE 77
    FIXTURES_REQUIRED "rocprofsys-global-tmp-files"
)

if(DEFINED _ROCPROFSYS_CI_TIMEOUT)
    math(EXPR _TEST_TIMEOUT "${_ROCPROFSYS_CI_TIMEOUT} + 30")
else()
    set(_TEST_TIMEOUT 150)
endif()

add_test("rocprofiler-systems-instrument-write-log" "${_ROCPROFSYS_EXE}" "${_ROCPROFSYS_EXE_ARGS}" "${_ROCPROFSYS_NODEID_PFX}test_binaries.py::TestRocprofilerSystemsInstrument::test_write_log" ${_ROCPROFSYS_EXTRA_ARGS})
set_tests_properties("rocprofiler-systems-instrument-write-log" PROPERTIES
    LABELS "instrument;rocprof_binary"
    TIMEOUT ${_TEST_TIMEOUT}
    SKIP_RETURN_CODE 77
    FIXTURES_REQUIRED "rocprofsys-global-tmp-files"
)

if(DEFINED _ROCPROFSYS_CI_TIMEOUT)
    math(EXPR _TEST_TIMEOUT "${_ROCPROFSYS_CI_TIMEOUT} + 30")
else()
    set(_TEST_TIMEOUT 75)
endif()

add_test("rocprofiler-systems-avail-help" "${_ROCPROFSYS_EXE}" "${_ROCPROFSYS_EXE_ARGS}" "${_ROCPROFSYS_NODEID_PFX}test_binaries.py::TestRocprofilerSystemsAvail::test_help" ${_ROCPROFSYS_EXTRA_ARGS})
set_tests_properties("rocprofiler-systems-avail-help" PROPERTIES
    LABELS "avail;rocprof_binary"
    TIMEOUT ${_TEST_TIMEOUT}
    SKIP_RETURN_CODE 77
    FIXTURES_REQUIRED "rocprofsys-global-tmp-files"
)

if(DEFINED _ROCPROFSYS_CI_TIMEOUT)
    math(EXPR _TEST_TIMEOUT "${_ROCPROFSYS_CI_TIMEOUT} + 30")
else()
    set(_TEST_TIMEOUT 75)
endif()

add_test("rocprofiler-systems-avail-all" "${_ROCPROFSYS_EXE}" "${_ROCPROFSYS_EXE_ARGS}" "${_ROCPROFSYS_NODEID_PFX}test_binaries.py::TestRocprofilerSystemsAvail::test_all" ${_ROCPROFSYS_EXTRA_ARGS})
set_tests_properties("rocprofiler-systems-avail-all" PROPERTIES
    LABELS "avail;rocprof_binary"
    TIMEOUT ${_TEST_TIMEOUT}
    SKIP_RETURN_CODE 77
    FIXTURES_REQUIRED "rocprofsys-global-tmp-files"
)

if(DEFINED _ROCPROFSYS_CI_TIMEOUT)
    math(EXPR _TEST_TIMEOUT "${_ROCPROFSYS_CI_TIMEOUT} + 30")
else()
    set(_TEST_TIMEOUT 75)
endif()

add_test("rocprofiler-systems-avail-all-expand-keys" "${_ROCPROFSYS_EXE}" "${_ROCPROFSYS_EXE_ARGS}" "${_ROCPROFSYS_NODEID_PFX}test_binaries.py::TestRocprofilerSystemsAvail::test_all_expand_keys" ${_ROCPROFSYS_EXTRA_ARGS})
set_tests_properties("rocprofiler-systems-avail-all-expand-keys" PROPERTIES
    LABELS "avail;rocprof_binary"
    TIMEOUT ${_TEST_TIMEOUT}
    SKIP_RETURN_CODE 77
    FIXTURES_REQUIRED "rocprofsys-global-tmp-files"
)

if(DEFINED _ROCPROFSYS_CI_TIMEOUT)
    math(EXPR _TEST_TIMEOUT "${_ROCPROFSYS_CI_TIMEOUT} + 30")
else()
    set(_TEST_TIMEOUT 75)
endif()

add_test("rocprofiler-systems-avail-all-only-available-alphabetical" "${_ROCPROFSYS_EXE}" "${_ROCPROFSYS_EXE_ARGS}" "${_ROCPROFSYS_NODEID_PFX}test_binaries.py::TestRocprofilerSystemsAvail::test_all_only_available_alphabetical" ${_ROCPROFSYS_EXTRA_ARGS})
set_tests_properties("rocprofiler-systems-avail-all-only-available-alphabetical" PROPERTIES
    LABELS "avail;rocprof_binary"
    TIMEOUT ${_TEST_TIMEOUT}
    SKIP_RETURN_CODE 77
    FIXTURES_REQUIRED "rocprofsys-global-tmp-files"
)

if(DEFINED _ROCPROFSYS_CI_TIMEOUT)
    math(EXPR _TEST_TIMEOUT "${_ROCPROFSYS_CI_TIMEOUT} + 30")
else()
    set(_TEST_TIMEOUT 75)
endif()

add_test("rocprofiler-systems-avail-all-csv" "${_ROCPROFSYS_EXE}" "${_ROCPROFSYS_EXE_ARGS}" "${_ROCPROFSYS_NODEID_PFX}test_binaries.py::TestRocprofilerSystemsAvail::test_all_csv" ${_ROCPROFSYS_EXTRA_ARGS})
set_tests_properties("rocprofiler-systems-avail-all-csv" PROPERTIES
    LABELS "avail;rocprof_binary"
    TIMEOUT ${_TEST_TIMEOUT}
    SKIP_RETURN_CODE 77
    FIXTURES_REQUIRED "rocprofsys-global-tmp-files"
)

if(DEFINED _ROCPROFSYS_CI_TIMEOUT)
    math(EXPR _TEST_TIMEOUT "${_ROCPROFSYS_CI_TIMEOUT} + 30")
else()
    set(_TEST_TIMEOUT 75)
endif()

add_test("rocprofiler-systems-avail-filter-wall-clock-available" "${_ROCPROFSYS_EXE}" "${_ROCPROFSYS_EXE_ARGS}" "${_ROCPROFSYS_NODEID_PFX}test_binaries.py::TestRocprofilerSystemsAvail::test_filter_wall_clock_available" ${_ROCPROFSYS_EXTRA_ARGS})
set_tests_properties("rocprofiler-systems-avail-filter-wall-clock-available" PROPERTIES
    LABELS "avail;rocprof_binary"
    TIMEOUT ${_TEST_TIMEOUT}
    SKIP_RETURN_CODE 77
    FIXTURES_REQUIRED "rocprofsys-global-tmp-files"
)

if(DEFINED _ROCPROFSYS_CI_TIMEOUT)
    math(EXPR _TEST_TIMEOUT "${_ROCPROFSYS_CI_TIMEOUT} + 30")
else()
    set(_TEST_TIMEOUT 75)
endif()

add_test("rocprofiler-systems-avail-category-filter-rocprofiler-systems" "${_ROCPROFSYS_EXE}" "${_ROCPROFSYS_EXE_ARGS}" "${_ROCPROFSYS_NODEID_PFX}test_binaries.py::TestRocprofilerSystemsAvail::test_category_filter_rocprofiler_systems" ${_ROCPROFSYS_EXTRA_ARGS})
set_tests_properties("rocprofiler-systems-avail-category-filter-rocprofiler-systems" PROPERTIES
    LABELS "avail;rocprof_binary"
    TIMEOUT ${_TEST_TIMEOUT}
    SKIP_RETURN_CODE 77
    FIXTURES_REQUIRED "rocprofsys-global-tmp-files"
)

if(DEFINED _ROCPROFSYS_CI_TIMEOUT)
    math(EXPR _TEST_TIMEOUT "${_ROCPROFSYS_CI_TIMEOUT} + 30")
else()
    set(_TEST_TIMEOUT 75)
endif()

add_test("rocprofiler-systems-avail-category-filter-timemory" "${_ROCPROFSYS_EXE}" "${_ROCPROFSYS_EXE_ARGS}" "${_ROCPROFSYS_NODEID_PFX}test_binaries.py::TestRocprofilerSystemsAvail::test_category_filter_timemory" ${_ROCPROFSYS_EXTRA_ARGS})
set_tests_properties("rocprofiler-systems-avail-category-filter-timemory" PROPERTIES
    LABELS "avail;rocprof_binary"
    TIMEOUT ${_TEST_TIMEOUT}
    SKIP_RETURN_CODE 77
    FIXTURES_REQUIRED "rocprofsys-global-tmp-files"
)

if(DEFINED _ROCPROFSYS_CI_TIMEOUT)
    math(EXPR _TEST_TIMEOUT "${_ROCPROFSYS_CI_TIMEOUT} + 30")
else()
    set(_TEST_TIMEOUT 75)
endif()

add_test("rocprofiler-systems-avail-regex-negation" "${_ROCPROFSYS_EXE}" "${_ROCPROFSYS_EXE_ARGS}" "${_ROCPROFSYS_NODEID_PFX}test_binaries.py::TestRocprofilerSystemsAvail::test_regex_negation" ${_ROCPROFSYS_EXTRA_ARGS})
set_tests_properties("rocprofiler-systems-avail-regex-negation" PROPERTIES
    LABELS "avail;rocprof_binary"
    TIMEOUT ${_TEST_TIMEOUT}
    SKIP_RETURN_CODE 77
    FIXTURES_REQUIRED "rocprofsys-global-tmp-files"
)

if(DEFINED _ROCPROFSYS_CI_TIMEOUT)
    math(EXPR _TEST_TIMEOUT "${_ROCPROFSYS_CI_TIMEOUT} + 30")
else()
    set(_TEST_TIMEOUT 75)
endif()

add_test("rocprofiler-systems-avail-write-config" "${_ROCPROFSYS_EXE}" "${_ROCPROFSYS_EXE_ARGS}" "${_ROCPROFSYS_NODEID_PFX}test_binaries.py::TestRocprofilerSystemsAvail::test_write_config" ${_ROCPROFSYS_EXTRA_ARGS})
set_tests_properties("rocprofiler-systems-avail-write-config" PROPERTIES
    LABELS "avail;rocprof_binary"
    TIMEOUT ${_TEST_TIMEOUT}
    SKIP_RETURN_CODE 77
    FIXTURES_REQUIRED "rocprofsys-global-tmp-files"
)

if(DEFINED _ROCPROFSYS_CI_TIMEOUT)
    math(EXPR _TEST_TIMEOUT "${_ROCPROFSYS_CI_TIMEOUT} + 30")
else()
    set(_TEST_TIMEOUT 75)
endif()

add_test("rocprofiler-systems-avail-write-config-tweak" "${_ROCPROFSYS_EXE}" "${_ROCPROFSYS_EXE_ARGS}" "${_ROCPROFSYS_NODEID_PFX}test_binaries.py::TestRocprofilerSystemsAvail::test_write_config_tweak" ${_ROCPROFSYS_EXTRA_ARGS})
set_tests_properties("rocprofiler-systems-avail-write-config-tweak" PROPERTIES
    LABELS "avail;rocprof_binary"
    TIMEOUT ${_TEST_TIMEOUT}
    SKIP_RETURN_CODE 77
    FIXTURES_REQUIRED "rocprofsys-global-tmp-files"
)

if(DEFINED _ROCPROFSYS_CI_TIMEOUT)
    math(EXPR _TEST_TIMEOUT "${_ROCPROFSYS_CI_TIMEOUT} + 30")
else()
    set(_TEST_TIMEOUT 75)
endif()

add_test("rocprofiler-systems-avail-format-consistency" "${_ROCPROFSYS_EXE}" "${_ROCPROFSYS_EXE_ARGS}" "${_ROCPROFSYS_NODEID_PFX}test_binaries.py::TestRocprofilerSystemsAvail::test_format_consistency" ${_ROCPROFSYS_EXTRA_ARGS})
set_tests_properties("rocprofiler-systems-avail-format-consistency" PROPERTIES
    LABELS "avail;rocprof_binary"
    TIMEOUT ${_TEST_TIMEOUT}
    SKIP_RETURN_CODE 77
    FIXTURES_REQUIRED "rocprofsys-global-tmp-files"
)

if(DEFINED _ROCPROFSYS_CI_TIMEOUT)
    math(EXPR _TEST_TIMEOUT "${_ROCPROFSYS_CI_TIMEOUT} + 30")
else()
    set(_TEST_TIMEOUT 75)
endif()

add_test("rocprofiler-systems-avail-list-keys" "${_ROCPROFSYS_EXE}" "${_ROCPROFSYS_EXE_ARGS}" "${_ROCPROFSYS_NODEID_PFX}test_binaries.py::TestRocprofilerSystemsAvail::test_list_keys" ${_ROCPROFSYS_EXTRA_ARGS})
set_tests_properties("rocprofiler-systems-avail-list-keys" PROPERTIES
    LABELS "avail;rocprof_binary"
    TIMEOUT ${_TEST_TIMEOUT}
    SKIP_RETURN_CODE 77
    FIXTURES_REQUIRED "rocprofsys-global-tmp-files"
)

if(DEFINED _ROCPROFSYS_CI_TIMEOUT)
    math(EXPR _TEST_TIMEOUT "${_ROCPROFSYS_CI_TIMEOUT} + 30")
else()
    set(_TEST_TIMEOUT 75)
endif()

add_test("rocprofiler-systems-avail-list-keys-markdown" "${_ROCPROFSYS_EXE}" "${_ROCPROFSYS_EXE_ARGS}" "${_ROCPROFSYS_NODEID_PFX}test_binaries.py::TestRocprofilerSystemsAvail::test_list_keys_markdown" ${_ROCPROFSYS_EXTRA_ARGS})
set_tests_properties("rocprofiler-systems-avail-list-keys-markdown" PROPERTIES
    LABELS "avail;rocprof_binary"
    TIMEOUT ${_TEST_TIMEOUT}
    SKIP_RETURN_CODE 77
    FIXTURES_REQUIRED "rocprofsys-global-tmp-files"
)

if(DEFINED _ROCPROFSYS_CI_TIMEOUT)
    math(EXPR _TEST_TIMEOUT "${_ROCPROFSYS_CI_TIMEOUT} + 30")
else()
    set(_TEST_TIMEOUT 75)
endif()

add_test("rocprofiler-systems-avail-list-categories" "${_ROCPROFSYS_EXE}" "${_ROCPROFSYS_EXE_ARGS}" "${_ROCPROFSYS_NODEID_PFX}test_binaries.py::TestRocprofilerSystemsAvail::test_list_categories" ${_ROCPROFSYS_EXTRA_ARGS})
set_tests_properties("rocprofiler-systems-avail-list-categories" PROPERTIES
    LABELS "avail;rocprof_binary"
    TIMEOUT ${_TEST_TIMEOUT}
    SKIP_RETURN_CODE 77
    FIXTURES_REQUIRED "rocprofsys-global-tmp-files"
)

if(DEFINED _ROCPROFSYS_CI_TIMEOUT)
    math(EXPR _TEST_TIMEOUT "${_ROCPROFSYS_CI_TIMEOUT} + 30")
else()
    set(_TEST_TIMEOUT 75)
endif()

add_test("rocprofiler-systems-avail-core-categories" "${_ROCPROFSYS_EXE}" "${_ROCPROFSYS_EXE_ARGS}" "${_ROCPROFSYS_NODEID_PFX}test_binaries.py::TestRocprofilerSystemsAvail::test_core_categories" ${_ROCPROFSYS_EXTRA_ARGS})
set_tests_properties("rocprofiler-systems-avail-core-categories" PROPERTIES
    LABELS "avail;rocprof_binary"
    TIMEOUT ${_TEST_TIMEOUT}
    SKIP_RETURN_CODE 77
    FIXTURES_REQUIRED "rocprofsys-global-tmp-files"
)

if(DEFINED _ROCPROFSYS_CI_TIMEOUT)
    math(EXPR _TEST_TIMEOUT "${_ROCPROFSYS_CI_TIMEOUT} + 30")
else()
    set(_TEST_TIMEOUT 75)
endif()

add_test("rocprofiler-systems-avail-list-domains" "${_ROCPROFSYS_EXE}" "${_ROCPROFSYS_EXE_ARGS}" "${_ROCPROFSYS_NODEID_PFX}test_binaries.py::TestRocprofilerSystemsAvail::test_list_domains" ${_ROCPROFSYS_EXTRA_ARGS})
set_tests_properties("rocprofiler-systems-avail-list-domains" PROPERTIES
    LABELS "avail;rocprof_binary"
    TIMEOUT ${_TEST_TIMEOUT}
    SKIP_RETURN_CODE 77
    FIXTURES_REQUIRED "rocprofsys-global-tmp-files"
)

if(DEFINED _ROCPROFSYS_CI_TIMEOUT)
    math(EXPR _TEST_TIMEOUT "${_ROCPROFSYS_CI_TIMEOUT} + 30")
else()
    set(_TEST_TIMEOUT 75)
endif()

add_test("rocprofiler-systems-avail-list-operations-no-domain" "${_ROCPROFSYS_EXE}" "${_ROCPROFSYS_EXE_ARGS}" "${_ROCPROFSYS_NODEID_PFX}test_binaries.py::TestRocprofilerSystemsAvail::test_list_operations[no-domain]" ${_ROCPROFSYS_EXTRA_ARGS})
set_tests_properties("rocprofiler-systems-avail-list-operations-no-domain" PROPERTIES
    LABELS "avail;rocprof_binary"
    TIMEOUT ${_TEST_TIMEOUT}
    SKIP_RETURN_CODE 77
    FIXTURES_REQUIRED "rocprofsys-global-tmp-files"
)

if(DEFINED _ROCPROFSYS_CI_TIMEOUT)
    math(EXPR _TEST_TIMEOUT "${_ROCPROFSYS_CI_TIMEOUT} + 30")
else()
    set(_TEST_TIMEOUT 75)
endif()

add_test("rocprofiler-systems-avail-list-operations-found" "${_ROCPROFSYS_EXE}" "${_ROCPROFSYS_EXE_ARGS}" "${_ROCPROFSYS_NODEID_PFX}test_binaries.py::TestRocprofilerSystemsAvail::test_list_operations[found]" ${_ROCPROFSYS_EXTRA_ARGS})
set_tests_properties("rocprofiler-systems-avail-list-operations-found" PROPERTIES
    LABELS "avail;rocprof_binary"
    TIMEOUT ${_TEST_TIMEOUT}
    SKIP_RETURN_CODE 77
    FIXTURES_REQUIRED "rocprofsys-global-tmp-files"
)

if(DEFINED _ROCPROFSYS_CI_TIMEOUT)
    math(EXPR _TEST_TIMEOUT "${_ROCPROFSYS_CI_TIMEOUT} + 30")
else()
    set(_TEST_TIMEOUT 75)
endif()

add_test("rocprofiler-systems-avail-list-operations-error" "${_ROCPROFSYS_EXE}" "${_ROCPROFSYS_EXE_ARGS}" "${_ROCPROFSYS_NODEID_PFX}test_binaries.py::TestRocprofilerSystemsAvail::test_list_operations[error]" ${_ROCPROFSYS_EXTRA_ARGS})
set_tests_properties("rocprofiler-systems-avail-list-operations-error" PROPERTIES
    LABELS "avail;rocprof_binary"
    TIMEOUT ${_TEST_TIMEOUT}
    SKIP_RETURN_CODE 77
    FIXTURES_REQUIRED "rocprofsys-global-tmp-files"
)

if(DEFINED _ROCPROFSYS_CI_TIMEOUT)
    math(EXPR _TEST_TIMEOUT "${_ROCPROFSYS_CI_TIMEOUT} + 30")
else()
    set(_TEST_TIMEOUT 75)
endif()

add_test("rocprofiler-systems-avail-settings-no-gpu" "${_ROCPROFSYS_EXE}" "${_ROCPROFSYS_EXE_ARGS}" "${_ROCPROFSYS_NODEID_PFX}test_binaries.py::TestRocprofilerSystemsAvail::test_settings_no_gpu" ${_ROCPROFSYS_EXTRA_ARGS})
set_tests_properties("rocprofiler-systems-avail-settings-no-gpu" PROPERTIES
    LABELS "avail;rocprof_binary"
    TIMEOUT ${_TEST_TIMEOUT}
    SKIP_RETURN_CODE 77
    FIXTURES_REQUIRED "rocprofsys-global-tmp-files"
)

if(DEFINED _ROCPROFSYS_CI_TIMEOUT)
    math(EXPR _TEST_TIMEOUT "${_ROCPROFSYS_CI_TIMEOUT} + 30")
else()
    set(_TEST_TIMEOUT 75)
endif()

add_test("rocprofiler-systems-avail-components-no-gpu" "${_ROCPROFSYS_EXE}" "${_ROCPROFSYS_EXE_ARGS}" "${_ROCPROFSYS_NODEID_PFX}test_binaries.py::TestRocprofilerSystemsAvail::test_components_no_gpu" ${_ROCPROFSYS_EXTRA_ARGS})
set_tests_properties("rocprofiler-systems-avail-components-no-gpu" PROPERTIES
    LABELS "avail;rocprof_binary"
    TIMEOUT ${_TEST_TIMEOUT}
    SKIP_RETURN_CODE 77
    FIXTURES_REQUIRED "rocprofsys-global-tmp-files"
)

if(DEFINED _ROCPROFSYS_CI_TIMEOUT)
    math(EXPR _TEST_TIMEOUT "${_ROCPROFSYS_CI_TIMEOUT} + 30")
else()
    set(_TEST_TIMEOUT 75)
endif()

add_test("rocprofiler-systems-avail-settings-description-no-gpu" "${_ROCPROFSYS_EXE}" "${_ROCPROFSYS_EXE_ARGS}" "${_ROCPROFSYS_NODEID_PFX}test_binaries.py::TestRocprofilerSystemsAvail::test_settings_description_no_gpu" ${_ROCPROFSYS_EXTRA_ARGS})
set_tests_properties("rocprofiler-systems-avail-settings-description-no-gpu" PROPERTIES
    LABELS "avail;rocprof_binary"
    TIMEOUT ${_TEST_TIMEOUT}
    SKIP_RETURN_CODE 77
    FIXTURES_REQUIRED "rocprofsys-global-tmp-files"
)

if(DEFINED _ROCPROFSYS_CI_TIMEOUT)
    math(EXPR _TEST_TIMEOUT "${_ROCPROFSYS_CI_TIMEOUT} + 30")
else()
    set(_TEST_TIMEOUT 75)
endif()

add_test("rocprofiler-systems-avail-settings-rocm-available" "${_ROCPROFSYS_EXE}" "${_ROCPROFSYS_EXE_ARGS}" "${_ROCPROFSYS_NODEID_PFX}test_binaries.py::TestRocprofilerSystemsAvail::test_settings_rocm_available" ${_ROCPROFSYS_EXTRA_ARGS})
set_tests_properties("rocprofiler-systems-avail-settings-rocm-available" PROPERTIES
    LABELS "avail;gpu;rocprof_binary"
    TIMEOUT ${_TEST_TIMEOUT}
    SKIP_RETURN_CODE 77
    FIXTURES_REQUIRED "rocprofsys-global-tmp-files"
)

if(DEFINED _ROCPROFSYS_CI_TIMEOUT)
    math(EXPR _TEST_TIMEOUT "${_ROCPROFSYS_CI_TIMEOUT} + 30")
else()
    set(_TEST_TIMEOUT 75)
endif()

add_test("rocprofiler-systems-run-help" "${_ROCPROFSYS_EXE}" "${_ROCPROFSYS_EXE_ARGS}" "${_ROCPROFSYS_NODEID_PFX}test_binaries.py::TestRocprofilerSystemsRun::test_help" ${_ROCPROFSYS_EXTRA_ARGS})
set_tests_properties("rocprofiler-systems-run-help" PROPERTIES
    LABELS "rocprof_binary;sys_run"
    TIMEOUT ${_TEST_TIMEOUT}
    SKIP_RETURN_CODE 77
    FIXTURES_REQUIRED "rocprofsys-global-tmp-files"
)

if(DEFINED _ROCPROFSYS_CI_TIMEOUT)
    math(EXPR _TEST_TIMEOUT "${_ROCPROFSYS_CI_TIMEOUT} + 30")
else()
    set(_TEST_TIMEOUT 75)
endif()

add_test("rocprofiler-systems-run-args" "${_ROCPROFSYS_EXE}" "${_ROCPROFSYS_EXE_ARGS}" "${_ROCPROFSYS_NODEID_PFX}test_binaries.py::TestRocprofilerSystemsRun::test_args" ${_ROCPROFSYS_EXTRA_ARGS})
set_tests_properties("rocprofiler-systems-run-args" PROPERTIES
    LABELS "rocprof_binary;sys_run"
    TIMEOUT ${_TEST_TIMEOUT}
    SKIP_RETURN_CODE 77
    FIXTURES_REQUIRED "rocprofsys-global-tmp-files"
)

if(DEFINED _ROCPROFSYS_CI_TIMEOUT)
    math(EXPR _TEST_TIMEOUT "${_ROCPROFSYS_CI_TIMEOUT} + 30")
else()
    set(_TEST_TIMEOUT 630)
endif()

add_test("causal-baseline-cpu-rocprofsys" "${_ROCPROFSYS_EXE}" "${_ROCPROFSYS_EXE_ARGS}" "${_ROCPROFSYS_NODEID_PFX}test_causal.py::TestCausal::test_baseline[cpu-rocprofsys]" ${_ROCPROFSYS_EXTRA_ARGS})
set_tests_properties("causal-baseline-cpu-rocprofsys" PROPERTIES
    LABELS "causal"
    TIMEOUT ${_TEST_TIMEOUT}
    SKIP_RETURN_CODE 77
    FIXTURES_REQUIRED "rocprofsys-global-tmp-files"
)

if(DEFINED _ROCPROFSYS_CI_TIMEOUT)
    math(EXPR _TEST_TIMEOUT "${_ROCPROFSYS_CI_TIMEOUT} + 30")
else()
    set(_TEST_TIMEOUT 630)
endif()

add_test("causal-baseline-both-rocprofsys" "${_ROCPROFSYS_EXE}" "${_ROCPROFSYS_EXE_ARGS}" "${_ROCPROFSYS_NODEID_PFX}test_causal.py::TestCausal::test_baseline[both-rocprofsys]" ${_ROCPROFSYS_EXTRA_ARGS})
set_tests_properties("causal-baseline-both-rocprofsys" PROPERTIES
    LABELS "causal"
    TIMEOUT ${_TEST_TIMEOUT}
    SKIP_RETURN_CODE 77
    FIXTURES_REQUIRED "rocprofsys-global-tmp-files"
)

if(DEFINED _ROCPROFSYS_CI_TIMEOUT)
    math(EXPR _TEST_TIMEOUT "${_ROCPROFSYS_CI_TIMEOUT} + 30")
else()
    set(_TEST_TIMEOUT 630)
endif()

add_test("causal-baseline-lulesh-rocprofsys" "${_ROCPROFSYS_EXE}" "${_ROCPROFSYS_EXE_ARGS}" "${_ROCPROFSYS_NODEID_PFX}test_causal.py::TestCausal::test_baseline[lulesh-rocprofsys]" ${_ROCPROFSYS_EXTRA_ARGS})
set_tests_properties("causal-baseline-lulesh-rocprofsys" PROPERTIES
    LABELS "causal;lulesh"
    TIMEOUT ${_TEST_TIMEOUT}
    SKIP_RETURN_CODE 77
    FIXTURES_REQUIRED "rocprofsys-global-tmp-files"
)

if(DEFINED _ROCPROFSYS_CI_TIMEOUT)
    math(EXPR _TEST_TIMEOUT "${_ROCPROFSYS_CI_TIMEOUT} + 30")
else()
    set(_TEST_TIMEOUT 630)
endif()

add_test("causal-cpu-rocprofsys-function" "${_ROCPROFSYS_EXE}" "${_ROCPROFSYS_EXE_ARGS}" "${_ROCPROFSYS_NODEID_PFX}test_causal.py::TestCausal::test[cpu-rocprofsys-function]" ${_ROCPROFSYS_EXTRA_ARGS})
set_tests_properties("causal-cpu-rocprofsys-function" PROPERTIES
    LABELS "causal"
    TIMEOUT ${_TEST_TIMEOUT}
    SKIP_RETURN_CODE 77
    FIXTURES_REQUIRED "rocprofsys-global-tmp-files"
)

if(DEFINED _ROCPROFSYS_CI_TIMEOUT)
    math(EXPR _TEST_TIMEOUT "${_ROCPROFSYS_CI_TIMEOUT} + 30")
else()
    set(_TEST_TIMEOUT 630)
endif()

add_test("causal-cpu-rocprofsys-line" "${_ROCPROFSYS_EXE}" "${_ROCPROFSYS_EXE_ARGS}" "${_ROCPROFSYS_NODEID_PFX}test_causal.py::TestCausal::test[cpu-rocprofsys-line]" ${_ROCPROFSYS_EXTRA_ARGS})
set_tests_properties("causal-cpu-rocprofsys-line" PROPERTIES
    LABELS "causal"
    TIMEOUT ${_TEST_TIMEOUT}
    SKIP_RETURN_CODE 77
    FIXTURES_REQUIRED "rocprofsys-global-tmp-files"
)

if(DEFINED _ROCPROFSYS_CI_TIMEOUT)
    math(EXPR _TEST_TIMEOUT "${_ROCPROFSYS_CI_TIMEOUT} + 30")
else()
    set(_TEST_TIMEOUT 630)
endif()

add_test("causal-cpu-rocprofsys-ndebug-function" "${_ROCPROFSYS_EXE}" "${_ROCPROFSYS_EXE_ARGS}" "${_ROCPROFSYS_NODEID_PFX}test_causal.py::TestCausal::test[cpu-rocprofsys-ndebug-function]" ${_ROCPROFSYS_EXTRA_ARGS})
set_tests_properties("causal-cpu-rocprofsys-ndebug-function" PROPERTIES
    LABELS "causal"
    TIMEOUT ${_TEST_TIMEOUT}
    SKIP_RETURN_CODE 77
    FIXTURES_REQUIRED "rocprofsys-global-tmp-files"
)

if(DEFINED _ROCPROFSYS_CI_TIMEOUT)
    math(EXPR _TEST_TIMEOUT "${_ROCPROFSYS_CI_TIMEOUT} + 30")
else()
    set(_TEST_TIMEOUT 630)
endif()

add_test("causal-lulesh-rocprofsys-function" "${_ROCPROFSYS_EXE}" "${_ROCPROFSYS_EXE_ARGS}" "${_ROCPROFSYS_NODEID_PFX}test_causal.py::TestCausal::test[lulesh-rocprofsys-function]" ${_ROCPROFSYS_EXTRA_ARGS})
set_tests_properties("causal-lulesh-rocprofsys-function" PROPERTIES
    LABELS "causal;lulesh"
    TIMEOUT ${_TEST_TIMEOUT}
    SKIP_RETURN_CODE 77
    FIXTURES_REQUIRED "rocprofsys-global-tmp-files"
)

if(DEFINED _ROCPROFSYS_CI_TIMEOUT)
    math(EXPR _TEST_TIMEOUT "${_ROCPROFSYS_CI_TIMEOUT} + 30")
else()
    set(_TEST_TIMEOUT 630)
endif()

add_test("causal-lulesh-rocprofsys-ndebug-function" "${_ROCPROFSYS_EXE}" "${_ROCPROFSYS_EXE_ARGS}" "${_ROCPROFSYS_NODEID_PFX}test_causal.py::TestCausal::test[lulesh-rocprofsys-ndebug-function]" ${_ROCPROFSYS_EXTRA_ARGS})
set_tests_properties("causal-lulesh-rocprofsys-ndebug-function" PROPERTIES
    LABELS "causal;lulesh"
    TIMEOUT ${_TEST_TIMEOUT}
    SKIP_RETURN_CODE 77
    FIXTURES_REQUIRED "rocprofsys-global-tmp-files"
)

if(DEFINED _ROCPROFSYS_CI_TIMEOUT)
    math(EXPR _TEST_TIMEOUT "${_ROCPROFSYS_CI_TIMEOUT} + 30")
else()
    set(_TEST_TIMEOUT 630)
endif()

add_test("causal-lulesh-rocprofsys-line" "${_ROCPROFSYS_EXE}" "${_ROCPROFSYS_EXE_ARGS}" "${_ROCPROFSYS_NODEID_PFX}test_causal.py::TestCausal::test[lulesh-rocprofsys-line]" ${_ROCPROFSYS_EXTRA_ARGS})
set_tests_properties("causal-lulesh-rocprofsys-line" PROPERTIES
    LABELS "causal;lulesh"
    TIMEOUT ${_TEST_TIMEOUT}
    SKIP_RETURN_CODE 77
    FIXTURES_REQUIRED "rocprofsys-global-tmp-files"
)

if(DEFINED _ROCPROFSYS_CI_TIMEOUT)
    math(EXPR _TEST_TIMEOUT "${_ROCPROFSYS_CI_TIMEOUT} + 30")
else()
    set(_TEST_TIMEOUT 630)
endif()

add_test("causal-config-both-rocprofsys-function" "${_ROCPROFSYS_EXE}" "${_ROCPROFSYS_EXE_ARGS}" "${_ROCPROFSYS_NODEID_PFX}test_causal.py::TestCausal::test_config[both-rocprofsys-function]" ${_ROCPROFSYS_EXTRA_ARGS})
set_tests_properties("causal-config-both-rocprofsys-function" PROPERTIES
    LABELS "causal"
    TIMEOUT ${_TEST_TIMEOUT}
    SKIP_RETURN_CODE 77
    FIXTURES_REQUIRED "rocprofsys-global-tmp-files"
)

if(DEFINED _ROCPROFSYS_CI_TIMEOUT)
    math(EXPR _TEST_TIMEOUT "${_ROCPROFSYS_CI_TIMEOUT} + 30")
else()
    set(_TEST_TIMEOUT 630)
endif()

add_test("causal-e2e-cpu-rocprofsys-func-slow" "${_ROCPROFSYS_EXE}" "${_ROCPROFSYS_EXE_ARGS}" "${_ROCPROFSYS_NODEID_PFX}test_causal.py::TestCausalE2E::test[cpu-rocprofsys-func-slow]" ${_ROCPROFSYS_EXTRA_ARGS})
set_tests_properties("causal-e2e-cpu-rocprofsys-func-slow" PROPERTIES
    LABELS "causal;causal_e2e;slow"
    TIMEOUT ${_TEST_TIMEOUT}
    SKIP_RETURN_CODE 77
    FIXTURES_REQUIRED "rocprofsys-global-tmp-files"
)

if(DEFINED _ROCPROFSYS_CI_TIMEOUT)
    math(EXPR _TEST_TIMEOUT "${_ROCPROFSYS_CI_TIMEOUT} + 30")
else()
    set(_TEST_TIMEOUT 630)
endif()

add_test("causal-e2e-cpu-rocprofsys-func-fast" "${_ROCPROFSYS_EXE}" "${_ROCPROFSYS_EXE_ARGS}" "${_ROCPROFSYS_NODEID_PFX}test_causal.py::TestCausalE2E::test[cpu-rocprofsys-func-fast]" ${_ROCPROFSYS_EXTRA_ARGS})
set_tests_properties("causal-e2e-cpu-rocprofsys-func-fast" PROPERTIES
    LABELS "causal;causal_e2e;slow"
    TIMEOUT ${_TEST_TIMEOUT}
    SKIP_RETURN_CODE 77
    FIXTURES_REQUIRED "rocprofsys-global-tmp-files"
)

if(DEFINED _ROCPROFSYS_CI_TIMEOUT)
    math(EXPR _TEST_TIMEOUT "${_ROCPROFSYS_CI_TIMEOUT} + 30")
else()
    set(_TEST_TIMEOUT 630)
endif()

add_test("causal-e2e-cpu-rocprofsys-line-103" "${_ROCPROFSYS_EXE}" "${_ROCPROFSYS_EXE_ARGS}" "${_ROCPROFSYS_NODEID_PFX}test_causal.py::TestCausalE2E::test[cpu-rocprofsys-line-103]" ${_ROCPROFSYS_EXTRA_ARGS})
set_tests_properties("causal-e2e-cpu-rocprofsys-line-103" PROPERTIES
    LABELS "causal;causal_e2e;slow"
    TIMEOUT ${_TEST_TIMEOUT}
    SKIP_RETURN_CODE 77
    FIXTURES_REQUIRED "rocprofsys-global-tmp-files"
)

if(DEFINED _ROCPROFSYS_CI_TIMEOUT)
    math(EXPR _TEST_TIMEOUT "${_ROCPROFSYS_CI_TIMEOUT} + 30")
else()
    set(_TEST_TIMEOUT 630)
endif()

add_test("causal-e2e-cpu-rocprofsys-line-113" "${_ROCPROFSYS_EXE}" "${_ROCPROFSYS_EXE_ARGS}" "${_ROCPROFSYS_NODEID_PFX}test_causal.py::TestCausalE2E::test[cpu-rocprofsys-line-113]" ${_ROCPROFSYS_EXTRA_ARGS})
set_tests_properties("causal-e2e-cpu-rocprofsys-line-113" PROPERTIES
    LABELS "causal;causal_e2e;slow"
    TIMEOUT ${_TEST_TIMEOUT}
    SKIP_RETURN_CODE 77
    FIXTURES_REQUIRED "rocprofsys-global-tmp-files"
)

if(DEFINED _ROCPROFSYS_CI_TIMEOUT)
    math(EXPR _TEST_TIMEOUT "${_ROCPROFSYS_CI_TIMEOUT} + 30")
else()
    set(_TEST_TIMEOUT 330)
endif()

add_test("code-coverage-base-binary-rewrite" "${_ROCPROFSYS_EXE}" "${_ROCPROFSYS_EXE_ARGS}" "${_ROCPROFSYS_NODEID_PFX}test_code_coverage.py::TestCodeCoverage::test[base-binary_rewrite]" ${_ROCPROFSYS_EXTRA_ARGS})
set_tests_properties("code-coverage-base-binary-rewrite" PROPERTIES
    LABELS "binary_rewrite;code_coverage"
    TIMEOUT ${_TEST_TIMEOUT}
    SKIP_RETURN_CODE 77
    FIXTURES_REQUIRED "rocprofsys-global-tmp-files"
)

if(DEFINED _ROCPROFSYS_CI_TIMEOUT)
    math(EXPR _TEST_TIMEOUT "${_ROCPROFSYS_CI_TIMEOUT} + 30")
else()
    set(_TEST_TIMEOUT 330)
endif()

add_test("code-coverage-base-runtime-instrument" "${_ROCPROFSYS_EXE}" "${_ROCPROFSYS_EXE_ARGS}" "${_ROCPROFSYS_NODEID_PFX}test_code_coverage.py::TestCodeCoverage::test[base-runtime_instrument]" ${_ROCPROFSYS_EXTRA_ARGS})
set_tests_properties("code-coverage-base-runtime-instrument" PROPERTIES
    LABELS "code_coverage;runtime_instrument"
    TIMEOUT ${_TEST_TIMEOUT}
    SKIP_RETURN_CODE 77
    FIXTURES_REQUIRED "rocprofsys-global-tmp-files"
)

if(DEFINED _ROCPROFSYS_CI_TIMEOUT)
    math(EXPR _TEST_TIMEOUT "${_ROCPROFSYS_CI_TIMEOUT} + 30")
else()
    set(_TEST_TIMEOUT 330)
endif()

add_test("code-coverage-base-hybrid-binary-rewrite" "${_ROCPROFSYS_EXE}" "${_ROCPROFSYS_EXE_ARGS}" "${_ROCPROFSYS_NODEID_PFX}test_code_coverage.py::TestCodeCoverage::test[base_hybrid-binary_rewrite]" ${_ROCPROFSYS_EXTRA_ARGS})
set_tests_properties("code-coverage-base-hybrid-binary-rewrite" PROPERTIES
    LABELS "binary_rewrite;code_coverage"
    TIMEOUT ${_TEST_TIMEOUT}
    SKIP_RETURN_CODE 77
    FIXTURES_REQUIRED "rocprofsys-global-tmp-files"
)

if(DEFINED _ROCPROFSYS_CI_TIMEOUT)
    math(EXPR _TEST_TIMEOUT "${_ROCPROFSYS_CI_TIMEOUT} + 30")
else()
    set(_TEST_TIMEOUT 330)
endif()

add_test("code-coverage-base-hybrid-runtime-instrument" "${_ROCPROFSYS_EXE}" "${_ROCPROFSYS_EXE_ARGS}" "${_ROCPROFSYS_NODEID_PFX}test_code_coverage.py::TestCodeCoverage::test[base_hybrid-runtime_instrument]" ${_ROCPROFSYS_EXTRA_ARGS})
set_tests_properties("code-coverage-base-hybrid-runtime-instrument" PROPERTIES
    LABELS "code_coverage;runtime_instrument"
    TIMEOUT ${_TEST_TIMEOUT}
    SKIP_RETURN_CODE 77
    FIXTURES_REQUIRED "rocprofsys-global-tmp-files"
)

if(DEFINED _ROCPROFSYS_CI_TIMEOUT)
    math(EXPR _TEST_TIMEOUT "${_ROCPROFSYS_CI_TIMEOUT} + 30")
else()
    set(_TEST_TIMEOUT 330)
endif()

add_test("code-coverage-basic-blocks-binary-rewrite" "${_ROCPROFSYS_EXE}" "${_ROCPROFSYS_EXE_ARGS}" "${_ROCPROFSYS_NODEID_PFX}test_code_coverage.py::TestCodeCoverage::test[basic_blocks-binary_rewrite]" ${_ROCPROFSYS_EXTRA_ARGS})
set_tests_properties("code-coverage-basic-blocks-binary-rewrite" PROPERTIES
    LABELS "binary_rewrite;code_coverage"
    TIMEOUT ${_TEST_TIMEOUT}
    SKIP_RETURN_CODE 77
    FIXTURES_REQUIRED "rocprofsys-global-tmp-files"
)

if(DEFINED _ROCPROFSYS_CI_TIMEOUT)
    math(EXPR _TEST_TIMEOUT "${_ROCPROFSYS_CI_TIMEOUT} + 30")
else()
    set(_TEST_TIMEOUT 330)
endif()

add_test("code-coverage-basic-blocks-runtime-instrument" "${_ROCPROFSYS_EXE}" "${_ROCPROFSYS_EXE_ARGS}" "${_ROCPROFSYS_NODEID_PFX}test_code_coverage.py::TestCodeCoverage::test[basic_blocks-runtime_instrument]" ${_ROCPROFSYS_EXTRA_ARGS})
set_tests_properties("code-coverage-basic-blocks-runtime-instrument" PROPERTIES
    LABELS "code_coverage;runtime_instrument"
    TIMEOUT ${_TEST_TIMEOUT}
    SKIP_RETURN_CODE 77
    FIXTURES_REQUIRED "rocprofsys-global-tmp-files"
)

if(DEFINED _ROCPROFSYS_CI_TIMEOUT)
    math(EXPR _TEST_TIMEOUT "${_ROCPROFSYS_CI_TIMEOUT} + 30")
else()
    set(_TEST_TIMEOUT 330)
endif()

add_test("code-coverage-basic-blocks-hybrid-binary-rewrite" "${_ROCPROFSYS_EXE}" "${_ROCPROFSYS_EXE_ARGS}" "${_ROCPROFSYS_NODEID_PFX}test_code_coverage.py::TestCodeCoverage::test[basic_blocks_hybrid-binary_rewrite]" ${_ROCPROFSYS_EXTRA_ARGS})
set_tests_properties("code-coverage-basic-blocks-hybrid-binary-rewrite" PROPERTIES
    LABELS "binary_rewrite;code_coverage"
    TIMEOUT ${_TEST_TIMEOUT}
    SKIP_RETURN_CODE 77
    FIXTURES_REQUIRED "rocprofsys-global-tmp-files"
)

if(DEFINED _ROCPROFSYS_CI_TIMEOUT)
    math(EXPR _TEST_TIMEOUT "${_ROCPROFSYS_CI_TIMEOUT} + 30")
else()
    set(_TEST_TIMEOUT 330)
endif()

add_test("code-coverage-basic-blocks-hybrid-runtime-instrument" "${_ROCPROFSYS_EXE}" "${_ROCPROFSYS_EXE_ARGS}" "${_ROCPROFSYS_NODEID_PFX}test_code_coverage.py::TestCodeCoverage::test[basic_blocks_hybrid-runtime_instrument]" ${_ROCPROFSYS_EXTRA_ARGS})
set_tests_properties("code-coverage-basic-blocks-hybrid-runtime-instrument" PROPERTIES
    LABELS "code_coverage;runtime_instrument"
    TIMEOUT ${_TEST_TIMEOUT}
    SKIP_RETURN_CODE 77
    FIXTURES_REQUIRED "rocprofsys-global-tmp-files"
)

if(DEFINED _ROCPROFSYS_CI_TIMEOUT)
    math(EXPR _TEST_TIMEOUT "${_ROCPROFSYS_CI_TIMEOUT} + 30")
else()
    set(_TEST_TIMEOUT 150)
endif()

add_test("code-coverage-python-3.10" "${_ROCPROFSYS_EXE}" "${_ROCPROFSYS_EXE_ARGS}" "${_ROCPROFSYS_NODEID_PFX}test_code_coverage.py::TestCodeCoverage::test_python[3.10]" "--python-versions=3.10" ${_ROCPROFSYS_EXTRA_ARGS})
set_tests_properties("code-coverage-python-3.10" PROPERTIES
    LABELS "code_coverage;python"
    TIMEOUT ${_TEST_TIMEOUT}
    SKIP_RETURN_CODE 77
    FIXTURES_REQUIRED "rocprofsys-global-tmp-files"
    DEPENDS "code-coverage-basic-blocks-binary-rewrite;code-coverage-basic-blocks-hybrid-runtime-instrument"
)

if(DEFINED _ROCPROFSYS_CI_TIMEOUT)
    math(EXPR _TEST_TIMEOUT "${_ROCPROFSYS_CI_TIMEOUT} + 30")
else()
    set(_TEST_TIMEOUT 150)
endif()

add_test("code-coverage-python-3.11" "${_ROCPROFSYS_EXE}" "${_ROCPROFSYS_EXE_ARGS}" "${_ROCPROFSYS_NODEID_PFX}test_code_coverage.py::TestCodeCoverage::test_python[3.11]" "--python-versions=3.11" ${_ROCPROFSYS_EXTRA_ARGS})
set_tests_properties("code-coverage-python-3.11" PROPERTIES
    LABELS "code_coverage;python"
    TIMEOUT ${_TEST_TIMEOUT}
    SKIP_RETURN_CODE 77
    FIXTURES_REQUIRED "rocprofsys-global-tmp-files"
    DEPENDS "code-coverage-basic-blocks-binary-rewrite;code-coverage-basic-blocks-hybrid-runtime-instrument"
)

if(DEFINED _ROCPROFSYS_CI_TIMEOUT)
    math(EXPR _TEST_TIMEOUT "${_ROCPROFSYS_CI_TIMEOUT} + 30")
else()
    set(_TEST_TIMEOUT 150)
endif()

add_test("code-coverage-python-3.12" "${_ROCPROFSYS_EXE}" "${_ROCPROFSYS_EXE_ARGS}" "${_ROCPROFSYS_NODEID_PFX}test_code_coverage.py::TestCodeCoverage::test_python[3.12]" "--python-versions=3.12" ${_ROCPROFSYS_EXTRA_ARGS})
set_tests_properties("code-coverage-python-3.12" PROPERTIES
    LABELS "code_coverage;python"
    TIMEOUT ${_TEST_TIMEOUT}
    SKIP_RETURN_CODE 77
    FIXTURES_REQUIRED "rocprofsys-global-tmp-files"
    DEPENDS "code-coverage-basic-blocks-binary-rewrite;code-coverage-basic-blocks-hybrid-runtime-instrument"
)

if(DEFINED _ROCPROFSYS_CI_TIMEOUT)
    math(EXPR _TEST_TIMEOUT "${_ROCPROFSYS_CI_TIMEOUT} + 30")
else()
    set(_TEST_TIMEOUT 150)
endif()

add_test("code-coverage-python-3.13" "${_ROCPROFSYS_EXE}" "${_ROCPROFSYS_EXE_ARGS}" "${_ROCPROFSYS_NODEID_PFX}test_code_coverage.py::TestCodeCoverage::test_python[3.13]" "--python-versions=3.13" ${_ROCPROFSYS_EXTRA_ARGS})
set_tests_properties("code-coverage-python-3.13" PROPERTIES
    LABELS "code_coverage;python"
    TIMEOUT ${_TEST_TIMEOUT}
    SKIP_RETURN_CODE 77
    FIXTURES_REQUIRED "rocprofsys-global-tmp-files"
    DEPENDS "code-coverage-basic-blocks-binary-rewrite;code-coverage-basic-blocks-hybrid-runtime-instrument"
)

if(DEFINED _ROCPROFSYS_CI_TIMEOUT)
    math(EXPR _TEST_TIMEOUT "${_ROCPROFSYS_CI_TIMEOUT} + 30")
else()
    set(_TEST_TIMEOUT 330)
endif()

add_test("config-invalid" "${_ROCPROFSYS_EXE}" "${_ROCPROFSYS_EXE_ARGS}" "${_ROCPROFSYS_NODEID_PFX}test_config.py::TestConfig::test_invalid" ${_ROCPROFSYS_EXTRA_ARGS})
set_tests_properties("config-invalid" PROPERTIES
    LABELS "rocprof_config"
    TIMEOUT ${_TEST_TIMEOUT}
    SKIP_RETURN_CODE 77
    FIXTURES_REQUIRED "rocprofsys-global-tmp-files"
)

if(DEFINED _ROCPROFSYS_CI_TIMEOUT)
    math(EXPR _TEST_TIMEOUT "${_ROCPROFSYS_CI_TIMEOUT} + 30")
else()
    set(_TEST_TIMEOUT 150)
endif()

add_test("config-missing" "${_ROCPROFSYS_EXE}" "${_ROCPROFSYS_EXE_ARGS}" "${_ROCPROFSYS_NODEID_PFX}test_config.py::TestConfig::test_missing" ${_ROCPROFSYS_EXTRA_ARGS})
set_tests_properties("config-missing" PROPERTIES
    LABELS "rocprof_config"
    TIMEOUT ${_TEST_TIMEOUT}
    SKIP_RETURN_CODE 77
    FIXTURES_REQUIRED "rocprofsys-global-tmp-files"
)

if(DEFINED _ROCPROFSYS_CI_TIMEOUT)
    math(EXPR _TEST_TIMEOUT "${_ROCPROFSYS_CI_TIMEOUT} + 30")
else()
    set(_TEST_TIMEOUT 330)
endif()

add_test("fork-baseline" "${_ROCPROFSYS_EXE}" "${_ROCPROFSYS_EXE_ARGS}" "${_ROCPROFSYS_NODEID_PFX}test_fork.py::TestFork::test[-baseline]" ${_ROCPROFSYS_EXTRA_ARGS})
set_tests_properties("fork-baseline" PROPERTIES
    LABELS "baseline;fork;rocm"
    TIMEOUT ${_TEST_TIMEOUT}
    SKIP_RETURN_CODE 77
    FIXTURES_REQUIRED "rocprofsys-global-tmp-files"
)

if(DEFINED _ROCPROFSYS_CI_TIMEOUT)
    math(EXPR _TEST_TIMEOUT "${_ROCPROFSYS_CI_TIMEOUT} + 30")
else()
    set(_TEST_TIMEOUT 330)
endif()

add_test("fork-sampling" "${_ROCPROFSYS_EXE}" "${_ROCPROFSYS_EXE_ARGS}" "${_ROCPROFSYS_NODEID_PFX}test_fork.py::TestFork::test[-sampling]" ${_ROCPROFSYS_EXTRA_ARGS})
set_tests_properties("fork-sampling" PROPERTIES
    LABELS "fork;rocm;sampling"
    TIMEOUT ${_TEST_TIMEOUT}
    SKIP_RETURN_CODE 77
    FIXTURES_REQUIRED "rocprofsys-global-tmp-files"
)

if(DEFINED _ROCPROFSYS_CI_TIMEOUT)
    math(EXPR _TEST_TIMEOUT "${_ROCPROFSYS_CI_TIMEOUT} + 30")
else()
    set(_TEST_TIMEOUT 330)
endif()

add_test("fork-binary-rewrite" "${_ROCPROFSYS_EXE}" "${_ROCPROFSYS_EXE_ARGS}" "${_ROCPROFSYS_NODEID_PFX}test_fork.py::TestFork::test[-binary_rewrite]" ${_ROCPROFSYS_EXTRA_ARGS})
set_tests_properties("fork-binary-rewrite" PROPERTIES
    LABELS "binary_rewrite;fork;rocm"
    TIMEOUT ${_TEST_TIMEOUT}
    SKIP_RETURN_CODE 77
    FIXTURES_REQUIRED "rocprofsys-global-tmp-files"
)

if(DEFINED _ROCPROFSYS_CI_TIMEOUT)
    math(EXPR _TEST_TIMEOUT "${_ROCPROFSYS_CI_TIMEOUT} + 30")
else()
    set(_TEST_TIMEOUT 330)
endif()

add_test("fork-sys-run" "${_ROCPROFSYS_EXE}" "${_ROCPROFSYS_EXE_ARGS}" "${_ROCPROFSYS_NODEID_PFX}test_fork.py::TestFork::test[-sys_run]" ${_ROCPROFSYS_EXTRA_ARGS})
set_tests_properties("fork-sys-run" PROPERTIES
    LABELS "fork;rocm;sys_run"
    TIMEOUT ${_TEST_TIMEOUT}
    SKIP_RETURN_CODE 77
    FIXTURES_REQUIRED "rocprofsys-global-tmp-files"
)

if(DEFINED _ROCPROFSYS_CI_TIMEOUT)
    math(EXPR _TEST_TIMEOUT "${_ROCPROFSYS_CI_TIMEOUT} + 30")
else()
    set(_TEST_TIMEOUT 330)
endif()

add_test("fork-runtime-instrument" "${_ROCPROFSYS_EXE}" "${_ROCPROFSYS_EXE_ARGS}" "${_ROCPROFSYS_NODEID_PFX}test_fork.py::TestFork::test[-runtime_instrument]" ${_ROCPROFSYS_EXTRA_ARGS})
set_tests_properties("fork-runtime-instrument" PROPERTIES
    LABELS "fork;runtime_instrument;slow"
    TIMEOUT ${_TEST_TIMEOUT}
    SKIP_RETURN_CODE 77
    FIXTURES_REQUIRED "rocprofsys-global-tmp-files"
)

if(DEFINED _ROCPROFSYS_CI_TIMEOUT)
    math(EXPR _TEST_TIMEOUT "${_ROCPROFSYS_CI_TIMEOUT} + 30")
else()
    set(_TEST_TIMEOUT 330)
endif()

add_test("fork-hipmallocconcurrencymproc-baseline" "${_ROCPROFSYS_EXE}" "${_ROCPROFSYS_EXE_ARGS}" "${_ROCPROFSYS_NODEID_PFX}test_fork.py::TestFork::test[hipMallocConcurrencyMproc-baseline]" ${_ROCPROFSYS_EXTRA_ARGS})
set_tests_properties("fork-hipmallocconcurrencymproc-baseline" PROPERTIES
    LABELS "baseline;fork;gpu;rocm"
    TIMEOUT ${_TEST_TIMEOUT}
    SKIP_RETURN_CODE 77
    FIXTURES_REQUIRED "rocprofsys-global-tmp-files"
)

if(DEFINED _ROCPROFSYS_CI_TIMEOUT)
    math(EXPR _TEST_TIMEOUT "${_ROCPROFSYS_CI_TIMEOUT} + 30")
else()
    set(_TEST_TIMEOUT 330)
endif()

add_test("fork-hipmallocconcurrencymproc-sampling" "${_ROCPROFSYS_EXE}" "${_ROCPROFSYS_EXE_ARGS}" "${_ROCPROFSYS_NODEID_PFX}test_fork.py::TestFork::test[hipMallocConcurrencyMproc-sampling]" ${_ROCPROFSYS_EXTRA_ARGS})
set_tests_properties("fork-hipmallocconcurrencymproc-sampling" PROPERTIES
    LABELS "fork;gpu;rocm;sampling"
    TIMEOUT ${_TEST_TIMEOUT}
    SKIP_RETURN_CODE 77
    FIXTURES_REQUIRED "rocprofsys-global-tmp-files"
)

if(DEFINED _ROCPROFSYS_CI_TIMEOUT)
    math(EXPR _TEST_TIMEOUT "${_ROCPROFSYS_CI_TIMEOUT} + 30")
else()
    set(_TEST_TIMEOUT 330)
endif()

add_test("fork-hipmallocconcurrencymproc-binary-rewrite" "${_ROCPROFSYS_EXE}" "${_ROCPROFSYS_EXE_ARGS}" "${_ROCPROFSYS_NODEID_PFX}test_fork.py::TestFork::test[hipMallocConcurrencyMproc-binary_rewrite]" ${_ROCPROFSYS_EXTRA_ARGS})
set_tests_properties("fork-hipmallocconcurrencymproc-binary-rewrite" PROPERTIES
    LABELS "binary_rewrite;fork;gpu;rocm"
    TIMEOUT ${_TEST_TIMEOUT}
    SKIP_RETURN_CODE 77
    FIXTURES_REQUIRED "rocprofsys-global-tmp-files"
)

if(DEFINED _ROCPROFSYS_CI_TIMEOUT)
    math(EXPR _TEST_TIMEOUT "${_ROCPROFSYS_CI_TIMEOUT} + 30")
else()
    set(_TEST_TIMEOUT 330)
endif()

add_test("fork-hipmallocconcurrencymproc-sys-run" "${_ROCPROFSYS_EXE}" "${_ROCPROFSYS_EXE_ARGS}" "${_ROCPROFSYS_NODEID_PFX}test_fork.py::TestFork::test[hipMallocConcurrencyMproc-sys_run]" ${_ROCPROFSYS_EXTRA_ARGS})
set_tests_properties("fork-hipmallocconcurrencymproc-sys-run" PROPERTIES
    LABELS "fork;gpu;rocm;sys_run"
    TIMEOUT ${_TEST_TIMEOUT}
    SKIP_RETURN_CODE 77
    FIXTURES_REQUIRED "rocprofsys-global-tmp-files"
)

if(DEFINED _ROCPROFSYS_CI_TIMEOUT)
    math(EXPR _TEST_TIMEOUT "${_ROCPROFSYS_CI_TIMEOUT} + 30")
else()
    set(_TEST_TIMEOUT 330)
endif()

add_test("fork-hipmallocconcurrencymproc-runtime-instrument" "${_ROCPROFSYS_EXE}" "${_ROCPROFSYS_EXE_ARGS}" "${_ROCPROFSYS_NODEID_PFX}test_fork.py::TestFork::test[hipMallocConcurrencyMproc-runtime_instrument]" ${_ROCPROFSYS_EXTRA_ARGS})
set_tests_properties("fork-hipmallocconcurrencymproc-runtime-instrument" PROPERTIES
    LABELS "fork;gpu;rocm;runtime_instrument;slow"
    TIMEOUT ${_TEST_TIMEOUT}
    SKIP_RETURN_CODE 77
    FIXTURES_REQUIRED "rocprofsys-global-tmp-files"
)

if(DEFINED _ROCPROFSYS_CI_TIMEOUT)
    math(EXPR _TEST_TIMEOUT "${_ROCPROFSYS_CI_TIMEOUT} + 30")
else()
    set(_TEST_TIMEOUT 150)
endif()

add_test("transferbench-sys-run" "${_ROCPROFSYS_EXE}" "${_ROCPROFSYS_EXE_ARGS}" "${_ROCPROFSYS_NODEID_PFX}test_gpu_connect.py::TestTransferBench::test[sys_run]" ${_ROCPROFSYS_EXTRA_ARGS})
set_tests_properties("transferbench-sys-run" PROPERTIES
    LABELS "gpu;multi_gpu[2];rocm;rocpd;sys_run;xgmi"
    TIMEOUT ${_TEST_TIMEOUT}
    SKIP_RETURN_CODE 77
    FIXTURES_REQUIRED "rocprofsys-global-tmp-files"
)

if(DEFINED _ROCPROFSYS_CI_TIMEOUT)
    math(EXPR _TEST_TIMEOUT "${_ROCPROFSYS_CI_TIMEOUT} + 30")
else()
    set(_TEST_TIMEOUT 330)
endif()

add_test("gfx1250-uses-gfx1250-counter-set" "${_ROCPROFSYS_EXE}" "${_ROCPROFSYS_EXE_ARGS}" "${_ROCPROFSYS_NODEID_PFX}test_gpu_info.py::test_gfx1250_uses_gfx1250_counter_set" ${_ROCPROFSYS_EXTRA_ARGS})
set_tests_properties("gfx1250-uses-gfx1250-counter-set" PROPERTIES
    LABELS "unit_tests"
    TIMEOUT ${_TEST_TIMEOUT}
    SKIP_RETURN_CODE 77
    FIXTURES_REQUIRED "rocprofsys-global-tmp-files"
)

if(DEFINED _ROCPROFSYS_CI_TIMEOUT)
    math(EXPR _TEST_TIMEOUT "${_ROCPROFSYS_CI_TIMEOUT} + 30")
else()
    set(_TEST_TIMEOUT 330)
endif()

add_test("mi300-and-later-keep-ta-ta-busy" "${_ROCPROFSYS_EXE}" "${_ROCPROFSYS_EXE_ARGS}" "${_ROCPROFSYS_NODEID_PFX}test_gpu_info.py::test_mi300_and_later_keep_ta_ta_busy" ${_ROCPROFSYS_EXTRA_ARGS})
set_tests_properties("mi300-and-later-keep-ta-ta-busy" PROPERTIES
    LABELS "unit_tests"
    TIMEOUT ${_TEST_TIMEOUT}
    SKIP_RETURN_CODE 77
    FIXTURES_REQUIRED "rocprofsys-global-tmp-files"
)

if(DEFINED _ROCPROFSYS_CI_TIMEOUT)
    math(EXPR _TEST_TIMEOUT "${_ROCPROFSYS_CI_TIMEOUT} + 30")
else()
    set(_TEST_TIMEOUT 330)
endif()

add_test("non-mi300-non-gfx1250-keep-single-counter" "${_ROCPROFSYS_EXE}" "${_ROCPROFSYS_EXE_ARGS}" "${_ROCPROFSYS_NODEID_PFX}test_gpu_info.py::test_non_mi300_non_gfx1250_keep_single_counter" ${_ROCPROFSYS_EXTRA_ARGS})
set_tests_properties("non-mi300-non-gfx1250-keep-single-counter" PROPERTIES
    LABELS "unit_tests"
    TIMEOUT ${_TEST_TIMEOUT}
    SKIP_RETURN_CODE 77
    FIXTURES_REQUIRED "rocprofsys-global-tmp-files"
)

if(DEFINED _ROCPROFSYS_CI_TIMEOUT)
    math(EXPR _TEST_TIMEOUT "${_ROCPROFSYS_CI_TIMEOUT} + 30")
else()
    set(_TEST_TIMEOUT 330)
endif()

add_test("jacobi-usm-sys-run" "${_ROCPROFSYS_EXE}" "${_ROCPROFSYS_EXE_ARGS}" "${_ROCPROFSYS_NODEID_PFX}test_hpc.py::TestJacobi::test_usm[sys_run]" ${_ROCPROFSYS_EXTRA_ARGS})
set_tests_properties("jacobi-usm-sys-run" PROPERTIES
    LABELS "gpu;hpc;openmp;rocpd;slow;sys_run;xnack"
    TIMEOUT ${_TEST_TIMEOUT}
    SKIP_RETURN_CODE 77
    FIXTURES_REQUIRED "rocprofsys-global-tmp-files"
)

if(DEFINED _ROCPROFSYS_CI_TIMEOUT)
    math(EXPR _TEST_TIMEOUT "${_ROCPROFSYS_CI_TIMEOUT} + 30")
else()
    set(_TEST_TIMEOUT 330)
endif()

add_test("jacobi-roctx-binary-rewrite" "${_ROCPROFSYS_EXE}" "${_ROCPROFSYS_EXE_ARGS}" "${_ROCPROFSYS_NODEID_PFX}test_hpc.py::TestJacobi::test_roctx[binary_rewrite]" ${_ROCPROFSYS_EXTRA_ARGS})
set_tests_properties("jacobi-roctx-binary-rewrite" PROPERTIES
    LABELS "binary_rewrite;gpu;hpc;openmp;roctx"
    TIMEOUT ${_TEST_TIMEOUT}
    SKIP_RETURN_CODE 77
    FIXTURES_REQUIRED "rocprofsys-global-tmp-files"
)

if(DEFINED _ROCPROFSYS_CI_TIMEOUT)
    math(EXPR _TEST_TIMEOUT "${_ROCPROFSYS_CI_TIMEOUT} + 30")
else()
    set(_TEST_TIMEOUT 330)
endif()

add_test("jacobi-roctx-sys-run" "${_ROCPROFSYS_EXE}" "${_ROCPROFSYS_EXE_ARGS}" "${_ROCPROFSYS_NODEID_PFX}test_hpc.py::TestJacobi::test_roctx[sys_run]" ${_ROCPROFSYS_EXTRA_ARGS})
set_tests_properties("jacobi-roctx-sys-run" PROPERTIES
    LABELS "gpu;hpc;openmp;roctx;sys_run"
    TIMEOUT ${_TEST_TIMEOUT}
    SKIP_RETURN_CODE 77
    FIXTURES_REQUIRED "rocprofsys-global-tmp-files"
)

if(DEFINED _ROCPROFSYS_CI_TIMEOUT)
    math(EXPR _TEST_TIMEOUT "${_ROCPROFSYS_CI_TIMEOUT} + 30")
else()
    set(_TEST_TIMEOUT 330)
endif()

add_test("jacobi-hip-sys-run" "${_ROCPROFSYS_EXE}" "${_ROCPROFSYS_EXE_ARGS}" "${_ROCPROFSYS_NODEID_PFX}test_hpc.py::TestJacobi::test_hip[sys_run]" ${_ROCPROFSYS_EXTRA_ARGS})
set_tests_properties("jacobi-hip-sys-run" PROPERTIES
    LABELS "gpu;hip;hpc;mpi;multi_gpu[2];rocpd;sys_run"
    TIMEOUT ${_TEST_TIMEOUT}
    SKIP_RETURN_CODE 77
    FIXTURES_REQUIRED "rocprofsys-global-tmp-files"
)

if(DEFINED _ROCPROFSYS_CI_TIMEOUT)
    math(EXPR _TEST_TIMEOUT "${_ROCPROFSYS_CI_TIMEOUT} + 30")
else()
    set(_TEST_TIMEOUT 330)
endif()

add_test("matrix-exponential-binary-rewrite" "${_ROCPROFSYS_EXE}" "${_ROCPROFSYS_EXE_ARGS}" "${_ROCPROFSYS_NODEID_PFX}test_hpc.py::TestMatrixExponential::test[binary_rewrite]" ${_ROCPROFSYS_EXTRA_ARGS})
set_tests_properties("matrix-exponential-binary-rewrite" PROPERTIES
    LABELS "binary_rewrite;gpu;hip;hpc;openmp;rocpd;roctx"
    TIMEOUT ${_TEST_TIMEOUT}
    SKIP_RETURN_CODE 77
    FIXTURES_REQUIRED "rocprofsys-global-tmp-files"
)

if(DEFINED _ROCPROFSYS_CI_TIMEOUT)
    math(EXPR _TEST_TIMEOUT "${_ROCPROFSYS_CI_TIMEOUT} + 30")
else()
    set(_TEST_TIMEOUT 330)
endif()

add_test("matrix-exponential-sys-run" "${_ROCPROFSYS_EXE}" "${_ROCPROFSYS_EXE_ARGS}" "${_ROCPROFSYS_NODEID_PFX}test_hpc.py::TestMatrixExponential::test[sys_run]" ${_ROCPROFSYS_EXTRA_ARGS})
set_tests_properties("matrix-exponential-sys-run" PROPERTIES
    LABELS "gpu;hip;hpc;openmp;rocpd;roctx;sys_run"
    TIMEOUT ${_TEST_TIMEOUT}
    SKIP_RETURN_CODE 77
    FIXTURES_REQUIRED "rocprofsys-global-tmp-files"
)

if(DEFINED _ROCPROFSYS_CI_TIMEOUT)
    math(EXPR _TEST_TIMEOUT "${_ROCPROFSYS_CI_TIMEOUT} + 30")
else()
    set(_TEST_TIMEOUT 330)
endif()

add_test("split-copy-compute-hw-queues-sys-run" "${_ROCPROFSYS_EXE}" "${_ROCPROFSYS_EXE_ARGS}" "${_ROCPROFSYS_NODEID_PFX}test_hpc.py::TestSplitCopyComputeHWQueues::test[sys_run]" ${_ROCPROFSYS_EXTRA_ARGS})
set_tests_properties("split-copy-compute-hw-queues-sys-run" PROPERTIES
    LABELS "gpu;hip;hpc;rocm;rocpd;sys_run"
    TIMEOUT ${_TEST_TIMEOUT}
    SKIP_RETURN_CODE 77
    FIXTURES_REQUIRED "rocprofsys-global-tmp-files"
)

if(DEFINED _ROCPROFSYS_CI_TIMEOUT)
    math(EXPR _TEST_TIMEOUT "${_ROCPROFSYS_CI_TIMEOUT} + 30")
else()
    set(_TEST_TIMEOUT 150)
endif()

add_test("jpeg-decode-sampling" "${_ROCPROFSYS_EXE}" "${_ROCPROFSYS_EXE_ARGS}" "${_ROCPROFSYS_NODEID_PFX}test_jpegdecode.py::TestJPEGDecode::test[sampling]" ${_ROCPROFSYS_EXTRA_ARGS})
set_tests_properties("jpeg-decode-sampling" PROPERTIES
    LABELS "decode;gpu;jpegdecode;rocm;rocpd;sampling"
    TIMEOUT ${_TEST_TIMEOUT}
    SKIP_RETURN_CODE 77
    FIXTURES_REQUIRED "rocprofsys-global-tmp-files"
)

if(DEFINED _ROCPROFSYS_CI_TIMEOUT)
    math(EXPR _TEST_TIMEOUT "${_ROCPROFSYS_CI_TIMEOUT} + 30")
else()
    set(_TEST_TIMEOUT 150)
endif()

add_test("jpeg-decode-sys-run" "${_ROCPROFSYS_EXE}" "${_ROCPROFSYS_EXE_ARGS}" "${_ROCPROFSYS_NODEID_PFX}test_jpegdecode.py::TestJPEGDecode::test[sys_run]" ${_ROCPROFSYS_EXTRA_ARGS})
set_tests_properties("jpeg-decode-sys-run" PROPERTIES
    LABELS "decode;gpu;jpegdecode;rocm;sys_run"
    TIMEOUT ${_TEST_TIMEOUT}
    SKIP_RETURN_CODE 77
    FIXTURES_REQUIRED "rocprofsys-global-tmp-files"
)

if(DEFINED _ROCPROFSYS_CI_TIMEOUT)
    math(EXPR _TEST_TIMEOUT "${_ROCPROFSYS_CI_TIMEOUT} + 30")
else()
    set(_TEST_TIMEOUT 330)
endif()

add_test("julia-vecadd-sys-run" "${_ROCPROFSYS_EXE}" "${_ROCPROFSYS_EXE_ARGS}" "${_ROCPROFSYS_NODEID_PFX}test_julia.py::TestJulia::test_vecadd[sys_run]" ${_ROCPROFSYS_EXTRA_ARGS})
set_tests_properties("julia-vecadd-sys-run" PROPERTIES
    LABELS "gpu;hpc;julia;sys_run"
    TIMEOUT ${_TEST_TIMEOUT}
    SKIP_RETURN_CODE 77
    FIXTURES_REQUIRED "rocprofsys-global-tmp-files"
)

if(DEFINED _ROCPROFSYS_CI_TIMEOUT)
    math(EXPR _TEST_TIMEOUT "${_ROCPROFSYS_CI_TIMEOUT} + 30")
else()
    set(_TEST_TIMEOUT 150)
endif()

add_test("kfd-events-sys-run" "${_ROCPROFSYS_EXE}" "${_ROCPROFSYS_EXE_ARGS}" "${_ROCPROFSYS_NODEID_PFX}test_kfd.py::TestKFD::test_events[sys_run]" ${_ROCPROFSYS_EXTRA_ARGS})
set_tests_properties("kfd-events-sys-run" PROPERTIES
    LABELS "gpu;hip;kfd;rocpd;sys_run;xnack"
    TIMEOUT ${_TEST_TIMEOUT}
    SKIP_RETURN_CODE 77
    FIXTURES_REQUIRED "rocprofsys-global-tmp-files"
)

if(DEFINED _ROCPROFSYS_CI_TIMEOUT)
    math(EXPR _TEST_TIMEOUT "${_ROCPROFSYS_CI_TIMEOUT} + 30")
else()
    set(_TEST_TIMEOUT 150)
endif()

add_test("kfd-prefetch-events-sys-run" "${_ROCPROFSYS_EXE}" "${_ROCPROFSYS_EXE_ARGS}" "${_ROCPROFSYS_NODEID_PFX}test_kfd.py::TestKFD::test_prefetch_events[sys_run]" ${_ROCPROFSYS_EXTRA_ARGS})
set_tests_properties("kfd-prefetch-events-sys-run" PROPERTIES
    LABELS "gpu;hip;kfd;rocpd;sys_run;xnack"
    TIMEOUT ${_TEST_TIMEOUT}
    SKIP_RETURN_CODE 77
    FIXTURES_REQUIRED "rocprofsys-global-tmp-files"
)

if(DEFINED _ROCPROFSYS_CI_TIMEOUT)
    math(EXPR _TEST_TIMEOUT "${_ROCPROFSYS_CI_TIMEOUT} + 30")
else()
    set(_TEST_TIMEOUT 210)
endif()

add_test("kfd-memory-pressure-sys-run" "${_ROCPROFSYS_EXE}" "${_ROCPROFSYS_EXE_ARGS}" "${_ROCPROFSYS_NODEID_PFX}test_kfd.py::TestKFD::test_memory_pressure[sys_run]" ${_ROCPROFSYS_EXTRA_ARGS})
set_tests_properties("kfd-memory-pressure-sys-run" PROPERTIES
    LABELS "gpu;hip;kfd;rocpd;sys_run;xnack"
    TIMEOUT ${_TEST_TIMEOUT}
    SKIP_RETURN_CODE 77
    FIXTURES_REQUIRED "rocprofsys-global-tmp-files"
)

if(DEFINED _ROCPROFSYS_CI_TIMEOUT)
    math(EXPR _TEST_TIMEOUT "${_ROCPROFSYS_CI_TIMEOUT} + 30")
else()
    set(_TEST_TIMEOUT 330)
endif()

add_test("lulesh-baseline" "${_ROCPROFSYS_EXE}" "${_ROCPROFSYS_EXE_ARGS}" "${_ROCPROFSYS_NODEID_PFX}test_lulesh.py::TestLulesh::test[baseline]" ${_ROCPROFSYS_EXTRA_ARGS})
set_tests_properties("lulesh-baseline" PROPERTIES
    LABELS "baseline;lulesh;openmp"
    TIMEOUT ${_TEST_TIMEOUT}
    SKIP_RETURN_CODE 77
    FIXTURES_REQUIRED "rocprofsys-global-tmp-files"
)

if(DEFINED _ROCPROFSYS_CI_TIMEOUT)
    math(EXPR _TEST_TIMEOUT "${_ROCPROFSYS_CI_TIMEOUT} + 30")
else()
    set(_TEST_TIMEOUT 330)
endif()

add_test("lulesh-sampling" "${_ROCPROFSYS_EXE}" "${_ROCPROFSYS_EXE_ARGS}" "${_ROCPROFSYS_NODEID_PFX}test_lulesh.py::TestLulesh::test[sampling]" ${_ROCPROFSYS_EXTRA_ARGS})
set_tests_properties("lulesh-sampling" PROPERTIES
    LABELS "lulesh;openmp;sampling"
    TIMEOUT ${_TEST_TIMEOUT}
    SKIP_RETURN_CODE 77
    FIXTURES_REQUIRED "rocprofsys-global-tmp-files"
)

if(DEFINED _ROCPROFSYS_CI_TIMEOUT)
    math(EXPR _TEST_TIMEOUT "${_ROCPROFSYS_CI_TIMEOUT} + 30")
else()
    set(_TEST_TIMEOUT 330)
endif()

add_test("lulesh-binary-rewrite" "${_ROCPROFSYS_EXE}" "${_ROCPROFSYS_EXE_ARGS}" "${_ROCPROFSYS_NODEID_PFX}test_lulesh.py::TestLulesh::test[binary_rewrite]" ${_ROCPROFSYS_EXTRA_ARGS})
set_tests_properties("lulesh-binary-rewrite" PROPERTIES
    LABELS "binary_rewrite;lulesh;openmp"
    TIMEOUT ${_TEST_TIMEOUT}
    SKIP_RETURN_CODE 77
    FIXTURES_REQUIRED "rocprofsys-global-tmp-files"
)

if(DEFINED _ROCPROFSYS_CI_TIMEOUT)
    math(EXPR _TEST_TIMEOUT "${_ROCPROFSYS_CI_TIMEOUT} + 30")
else()
    set(_TEST_TIMEOUT 330)
endif()

add_test("lulesh-runtime-instrument" "${_ROCPROFSYS_EXE}" "${_ROCPROFSYS_EXE_ARGS}" "${_ROCPROFSYS_NODEID_PFX}test_lulesh.py::TestLulesh::test[runtime_instrument]" ${_ROCPROFSYS_EXTRA_ARGS})
set_tests_properties("lulesh-runtime-instrument" PROPERTIES
    LABELS "lulesh;openmp;runtime_instrument"
    TIMEOUT ${_TEST_TIMEOUT}
    SKIP_RETURN_CODE 77
    FIXTURES_REQUIRED "rocprofsys-global-tmp-files"
)

if(DEFINED _ROCPROFSYS_CI_TIMEOUT)
    math(EXPR _TEST_TIMEOUT "${_ROCPROFSYS_CI_TIMEOUT} + 30")
else()
    set(_TEST_TIMEOUT 330)
endif()

add_test("lulesh-sys-run" "${_ROCPROFSYS_EXE}" "${_ROCPROFSYS_EXE_ARGS}" "${_ROCPROFSYS_NODEID_PFX}test_lulesh.py::TestLulesh::test[sys_run]" ${_ROCPROFSYS_EXTRA_ARGS})
set_tests_properties("lulesh-sys-run" PROPERTIES
    LABELS "lulesh;openmp;sys_run"
    TIMEOUT ${_TEST_TIMEOUT}
    SKIP_RETURN_CODE 77
    FIXTURES_REQUIRED "rocprofsys-global-tmp-files"
)

if(DEFINED _ROCPROFSYS_CI_TIMEOUT)
    math(EXPR _TEST_TIMEOUT "${_ROCPROFSYS_CI_TIMEOUT} + 30")
else()
    set(_TEST_TIMEOUT 330)
endif()

add_test("lulesh-baseline-kokkosp-librocprof-sys" "${_ROCPROFSYS_EXE}" "${_ROCPROFSYS_EXE_ARGS}" "${_ROCPROFSYS_NODEID_PFX}test_lulesh.py::TestLulesh::test_baseline_kokkosp[librocprof-sys]" ${_ROCPROFSYS_EXTRA_ARGS})
set_tests_properties("lulesh-baseline-kokkosp-librocprof-sys" PROPERTIES
    LABELS "baseline;lulesh;openmp"
    TIMEOUT ${_TEST_TIMEOUT}
    SKIP_RETURN_CODE 77
    FIXTURES_REQUIRED "rocprofsys-global-tmp-files"
)

if(DEFINED _ROCPROFSYS_CI_TIMEOUT)
    math(EXPR _TEST_TIMEOUT "${_ROCPROFSYS_CI_TIMEOUT} + 30")
else()
    set(_TEST_TIMEOUT 330)
endif()

add_test("lulesh-baseline-kokkosp-librocprof-sys-dl" "${_ROCPROFSYS_EXE}" "${_ROCPROFSYS_EXE_ARGS}" "${_ROCPROFSYS_NODEID_PFX}test_lulesh.py::TestLulesh::test_baseline_kokkosp[librocprof-sys-dl]" ${_ROCPROFSYS_EXTRA_ARGS})
set_tests_properties("lulesh-baseline-kokkosp-librocprof-sys-dl" PROPERTIES
    LABELS "baseline;lulesh;openmp"
    TIMEOUT ${_TEST_TIMEOUT}
    SKIP_RETURN_CODE 77
    FIXTURES_REQUIRED "rocprofsys-global-tmp-files"
)

if(DEFINED _ROCPROFSYS_CI_TIMEOUT)
    math(EXPR _TEST_TIMEOUT "${_ROCPROFSYS_CI_TIMEOUT} + 30")
else()
    set(_TEST_TIMEOUT 330)
endif()

add_test("lulesh-kokkosp-sampling" "${_ROCPROFSYS_EXE}" "${_ROCPROFSYS_EXE_ARGS}" "${_ROCPROFSYS_NODEID_PFX}test_lulesh.py::TestLulesh::test_kokkosp[sampling]" ${_ROCPROFSYS_EXTRA_ARGS})
set_tests_properties("lulesh-kokkosp-sampling" PROPERTIES
    LABELS "lulesh;openmp;sampling"
    TIMEOUT ${_TEST_TIMEOUT}
    SKIP_RETURN_CODE 77
    FIXTURES_REQUIRED "rocprofsys-global-tmp-files"
)

if(DEFINED _ROCPROFSYS_CI_TIMEOUT)
    math(EXPR _TEST_TIMEOUT "${_ROCPROFSYS_CI_TIMEOUT} + 30")
else()
    set(_TEST_TIMEOUT 330)
endif()

add_test("lulesh-kokkosp-binary-rewrite" "${_ROCPROFSYS_EXE}" "${_ROCPROFSYS_EXE_ARGS}" "${_ROCPROFSYS_NODEID_PFX}test_lulesh.py::TestLulesh::test_kokkosp[binary_rewrite]" ${_ROCPROFSYS_EXTRA_ARGS})
set_tests_properties("lulesh-kokkosp-binary-rewrite" PROPERTIES
    LABELS "binary_rewrite;lulesh;openmp"
    TIMEOUT ${_TEST_TIMEOUT}
    SKIP_RETURN_CODE 77
    FIXTURES_REQUIRED "rocprofsys-global-tmp-files"
)

if(DEFINED _ROCPROFSYS_CI_TIMEOUT)
    math(EXPR _TEST_TIMEOUT "${_ROCPROFSYS_CI_TIMEOUT} + 30")
else()
    set(_TEST_TIMEOUT 330)
endif()

add_test("lulesh-kokkosp-runtime-instrument" "${_ROCPROFSYS_EXE}" "${_ROCPROFSYS_EXE_ARGS}" "${_ROCPROFSYS_NODEID_PFX}test_lulesh.py::TestLulesh::test_kokkosp[runtime_instrument]" ${_ROCPROFSYS_EXTRA_ARGS})
set_tests_properties("lulesh-kokkosp-runtime-instrument" PROPERTIES
    LABELS "lulesh;openmp;runtime_instrument"
    TIMEOUT ${_TEST_TIMEOUT}
    SKIP_RETURN_CODE 77
    FIXTURES_REQUIRED "rocprofsys-global-tmp-files"
)

if(DEFINED _ROCPROFSYS_CI_TIMEOUT)
    math(EXPR _TEST_TIMEOUT "${_ROCPROFSYS_CI_TIMEOUT} + 30")
else()
    set(_TEST_TIMEOUT 330)
endif()

add_test("lulesh-kokkosp-sys-run" "${_ROCPROFSYS_EXE}" "${_ROCPROFSYS_EXE_ARGS}" "${_ROCPROFSYS_NODEID_PFX}test_lulesh.py::TestLulesh::test_kokkosp[sys_run]" ${_ROCPROFSYS_EXTRA_ARGS})
set_tests_properties("lulesh-kokkosp-sys-run" PROPERTIES
    LABELS "lulesh;openmp;sys_run"
    TIMEOUT ${_TEST_TIMEOUT}
    SKIP_RETURN_CODE 77
    FIXTURES_REQUIRED "rocprofsys-global-tmp-files"
)

if(DEFINED _ROCPROFSYS_CI_TIMEOUT)
    math(EXPR _TEST_TIMEOUT "${_ROCPROFSYS_CI_TIMEOUT} + 30")
else()
    set(_TEST_TIMEOUT 330)
endif()

add_test("lulesh-perfetto-sampling" "${_ROCPROFSYS_EXE}" "${_ROCPROFSYS_EXE_ARGS}" "${_ROCPROFSYS_NODEID_PFX}test_lulesh.py::TestLulesh::test_perfetto[sampling]" ${_ROCPROFSYS_EXTRA_ARGS})
set_tests_properties("lulesh-perfetto-sampling" PROPERTIES
    LABELS "lulesh;openmp;sampling"
    TIMEOUT ${_TEST_TIMEOUT}
    SKIP_RETURN_CODE 77
    FIXTURES_REQUIRED "rocprofsys-global-tmp-files"
)

if(DEFINED _ROCPROFSYS_CI_TIMEOUT)
    math(EXPR _TEST_TIMEOUT "${_ROCPROFSYS_CI_TIMEOUT} + 30")
else()
    set(_TEST_TIMEOUT 330)
endif()

add_test("lulesh-perfetto-binary-rewrite" "${_ROCPROFSYS_EXE}" "${_ROCPROFSYS_EXE_ARGS}" "${_ROCPROFSYS_NODEID_PFX}test_lulesh.py::TestLulesh::test_perfetto[binary_rewrite]" ${_ROCPROFSYS_EXTRA_ARGS})
set_tests_properties("lulesh-perfetto-binary-rewrite" PROPERTIES
    LABELS "binary_rewrite;lulesh;openmp"
    TIMEOUT ${_TEST_TIMEOUT}
    SKIP_RETURN_CODE 77
    FIXTURES_REQUIRED "rocprofsys-global-tmp-files"
)

if(DEFINED _ROCPROFSYS_CI_TIMEOUT)
    math(EXPR _TEST_TIMEOUT "${_ROCPROFSYS_CI_TIMEOUT} + 30")
else()
    set(_TEST_TIMEOUT 330)
endif()

add_test("lulesh-perfetto-runtime-instrument" "${_ROCPROFSYS_EXE}" "${_ROCPROFSYS_EXE_ARGS}" "${_ROCPROFSYS_NODEID_PFX}test_lulesh.py::TestLulesh::test_perfetto[runtime_instrument]" ${_ROCPROFSYS_EXTRA_ARGS})
set_tests_properties("lulesh-perfetto-runtime-instrument" PROPERTIES
    LABELS "lulesh;openmp;runtime_instrument"
    TIMEOUT ${_TEST_TIMEOUT}
    SKIP_RETURN_CODE 77
    FIXTURES_REQUIRED "rocprofsys-global-tmp-files"
)

if(DEFINED _ROCPROFSYS_CI_TIMEOUT)
    math(EXPR _TEST_TIMEOUT "${_ROCPROFSYS_CI_TIMEOUT} + 30")
else()
    set(_TEST_TIMEOUT 330)
endif()

add_test("lulesh-perfetto-sys-run" "${_ROCPROFSYS_EXE}" "${_ROCPROFSYS_EXE_ARGS}" "${_ROCPROFSYS_NODEID_PFX}test_lulesh.py::TestLulesh::test_perfetto[sys_run]" ${_ROCPROFSYS_EXTRA_ARGS})
set_tests_properties("lulesh-perfetto-sys-run" PROPERTIES
    LABELS "lulesh;openmp;sys_run"
    TIMEOUT ${_TEST_TIMEOUT}
    SKIP_RETURN_CODE 77
    FIXTURES_REQUIRED "rocprofsys-global-tmp-files"
)

if(DEFINED _ROCPROFSYS_CI_TIMEOUT)
    math(EXPR _TEST_TIMEOUT "${_ROCPROFSYS_CI_TIMEOUT} + 30")
else()
    set(_TEST_TIMEOUT 330)
endif()

add_test("lulesh-timemory-baseline" "${_ROCPROFSYS_EXE}" "${_ROCPROFSYS_EXE_ARGS}" "${_ROCPROFSYS_NODEID_PFX}test_lulesh.py::TestLulesh::test_timemory[baseline]" ${_ROCPROFSYS_EXTRA_ARGS})
set_tests_properties("lulesh-timemory-baseline" PROPERTIES
    LABELS "baseline;lulesh;openmp"
    TIMEOUT ${_TEST_TIMEOUT}
    SKIP_RETURN_CODE 77
    FIXTURES_REQUIRED "rocprofsys-global-tmp-files"
)

if(DEFINED _ROCPROFSYS_CI_TIMEOUT)
    math(EXPR _TEST_TIMEOUT "${_ROCPROFSYS_CI_TIMEOUT} + 30")
else()
    set(_TEST_TIMEOUT 330)
endif()

add_test("lulesh-timemory-sampling" "${_ROCPROFSYS_EXE}" "${_ROCPROFSYS_EXE_ARGS}" "${_ROCPROFSYS_NODEID_PFX}test_lulesh.py::TestLulesh::test_timemory[sampling]" ${_ROCPROFSYS_EXTRA_ARGS})
set_tests_properties("lulesh-timemory-sampling" PROPERTIES
    LABELS "lulesh;openmp;sampling"
    TIMEOUT ${_TEST_TIMEOUT}
    SKIP_RETURN_CODE 77
    FIXTURES_REQUIRED "rocprofsys-global-tmp-files"
)

if(DEFINED _ROCPROFSYS_CI_TIMEOUT)
    math(EXPR _TEST_TIMEOUT "${_ROCPROFSYS_CI_TIMEOUT} + 30")
else()
    set(_TEST_TIMEOUT 330)
endif()

add_test("lulesh-timemory-binary-rewrite" "${_ROCPROFSYS_EXE}" "${_ROCPROFSYS_EXE_ARGS}" "${_ROCPROFSYS_NODEID_PFX}test_lulesh.py::TestLulesh::test_timemory[binary_rewrite]" ${_ROCPROFSYS_EXTRA_ARGS})
set_tests_properties("lulesh-timemory-binary-rewrite" PROPERTIES
    LABELS "binary_rewrite;lulesh;openmp"
    TIMEOUT ${_TEST_TIMEOUT}
    SKIP_RETURN_CODE 77
    FIXTURES_REQUIRED "rocprofsys-global-tmp-files"
)

if(DEFINED _ROCPROFSYS_CI_TIMEOUT)
    math(EXPR _TEST_TIMEOUT "${_ROCPROFSYS_CI_TIMEOUT} + 30")
else()
    set(_TEST_TIMEOUT 330)
endif()

add_test("lulesh-timemory-runtime-instrument" "${_ROCPROFSYS_EXE}" "${_ROCPROFSYS_EXE_ARGS}" "${_ROCPROFSYS_NODEID_PFX}test_lulesh.py::TestLulesh::test_timemory[runtime_instrument]" ${_ROCPROFSYS_EXTRA_ARGS})
set_tests_properties("lulesh-timemory-runtime-instrument" PROPERTIES
    LABELS "lulesh;openmp;runtime_instrument"
    TIMEOUT ${_TEST_TIMEOUT}
    SKIP_RETURN_CODE 77
    FIXTURES_REQUIRED "rocprofsys-global-tmp-files"
)

if(DEFINED _ROCPROFSYS_CI_TIMEOUT)
    math(EXPR _TEST_TIMEOUT "${_ROCPROFSYS_CI_TIMEOUT} + 30")
else()
    set(_TEST_TIMEOUT 330)
endif()

add_test("lulesh-timemory-sys-run" "${_ROCPROFSYS_EXE}" "${_ROCPROFSYS_EXE_ARGS}" "${_ROCPROFSYS_NODEID_PFX}test_lulesh.py::TestLulesh::test_timemory[sys_run]" ${_ROCPROFSYS_EXTRA_ARGS})
set_tests_properties("lulesh-timemory-sys-run" PROPERTIES
    LABELS "lulesh;openmp;sys_run"
    TIMEOUT ${_TEST_TIMEOUT}
    SKIP_RETURN_CODE 77
    FIXTURES_REQUIRED "rocprofsys-global-tmp-files"
)

if(DEFINED _ROCPROFSYS_CI_TIMEOUT)
    math(EXPR _TEST_TIMEOUT "${_ROCPROFSYS_CI_TIMEOUT} + 30")
else()
    set(_TEST_TIMEOUT 330)
endif()

add_test("minimal-recursion-binary-rewrite" "${_ROCPROFSYS_EXE}" "${_ROCPROFSYS_EXE_ARGS}" "${_ROCPROFSYS_NODEID_PFX}test_minimal.py::TestMinimal::test_recursion[binary_rewrite]" ${_ROCPROFSYS_EXTRA_ARGS})
set_tests_properties("minimal-recursion-binary-rewrite" PROPERTIES
    LABELS "binary_rewrite;minimal;rocpd"
    TIMEOUT ${_TEST_TIMEOUT}
    SKIP_RETURN_CODE 77
    FIXTURES_REQUIRED "rocprofsys-global-tmp-files"
)

if(DEFINED _ROCPROFSYS_CI_TIMEOUT)
    math(EXPR _TEST_TIMEOUT "${_ROCPROFSYS_CI_TIMEOUT} + 30")
else()
    set(_TEST_TIMEOUT 330)
endif()

add_test("minimal-recursion-runtime-instrument" "${_ROCPROFSYS_EXE}" "${_ROCPROFSYS_EXE_ARGS}" "${_ROCPROFSYS_NODEID_PFX}test_minimal.py::TestMinimal::test_recursion[runtime_instrument]" ${_ROCPROFSYS_EXTRA_ARGS})
set_tests_properties("minimal-recursion-runtime-instrument" PROPERTIES
    LABELS "minimal;rocpd;runtime_instrument"
    TIMEOUT ${_TEST_TIMEOUT}
    SKIP_RETURN_CODE 77
    FIXTURES_REQUIRED "rocprofsys-global-tmp-files"
)

if(DEFINED _ROCPROFSYS_CI_TIMEOUT)
    math(EXPR _TEST_TIMEOUT "${_ROCPROFSYS_CI_TIMEOUT} + 30")
else()
    set(_TEST_TIMEOUT 330)
endif()

add_test("mpi-baseline" "${_ROCPROFSYS_EXE}" "${_ROCPROFSYS_EXE_ARGS}" "${_ROCPROFSYS_NODEID_PFX}test_mpi.py::TestMPI::test[baseline]" ${_ROCPROFSYS_EXTRA_ARGS})
set_tests_properties("mpi-baseline" PROPERTIES
    LABELS "baseline;mpi"
    TIMEOUT ${_TEST_TIMEOUT}
    SKIP_RETURN_CODE 77
    FIXTURES_REQUIRED "rocprofsys-global-tmp-files"
)

if(DEFINED _ROCPROFSYS_CI_TIMEOUT)
    math(EXPR _TEST_TIMEOUT "${_ROCPROFSYS_CI_TIMEOUT} + 30")
else()
    set(_TEST_TIMEOUT 330)
endif()

add_test("mpi-sampling" "${_ROCPROFSYS_EXE}" "${_ROCPROFSYS_EXE_ARGS}" "${_ROCPROFSYS_NODEID_PFX}test_mpi.py::TestMPI::test[sampling]" ${_ROCPROFSYS_EXTRA_ARGS})
set_tests_properties("mpi-sampling" PROPERTIES
    LABELS "mpi;sampling"
    TIMEOUT ${_TEST_TIMEOUT}
    SKIP_RETURN_CODE 77
    FIXTURES_REQUIRED "rocprofsys-global-tmp-files"
)

if(DEFINED _ROCPROFSYS_CI_TIMEOUT)
    math(EXPR _TEST_TIMEOUT "${_ROCPROFSYS_CI_TIMEOUT} + 30")
else()
    set(_TEST_TIMEOUT 330)
endif()

add_test("mpi-binary-rewrite" "${_ROCPROFSYS_EXE}" "${_ROCPROFSYS_EXE_ARGS}" "${_ROCPROFSYS_NODEID_PFX}test_mpi.py::TestMPI::test[binary_rewrite]" ${_ROCPROFSYS_EXTRA_ARGS})
set_tests_properties("mpi-binary-rewrite" PROPERTIES
    LABELS "binary_rewrite;mpi"
    TIMEOUT ${_TEST_TIMEOUT}
    SKIP_RETURN_CODE 77
    FIXTURES_REQUIRED "rocprofsys-global-tmp-files"
)

if(DEFINED _ROCPROFSYS_CI_TIMEOUT)
    math(EXPR _TEST_TIMEOUT "${_ROCPROFSYS_CI_TIMEOUT} + 30")
else()
    set(_TEST_TIMEOUT 330)
endif()

add_test("mpi-sys-run" "${_ROCPROFSYS_EXE}" "${_ROCPROFSYS_EXE_ARGS}" "${_ROCPROFSYS_NODEID_PFX}test_mpi.py::TestMPI::test[sys_run]" ${_ROCPROFSYS_EXTRA_ARGS})
set_tests_properties("mpi-sys-run" PROPERTIES
    LABELS "mpi;sys_run"
    TIMEOUT ${_TEST_TIMEOUT}
    SKIP_RETURN_CODE 77
    FIXTURES_REQUIRED "rocprofsys-global-tmp-files"
)

if(DEFINED _ROCPROFSYS_CI_TIMEOUT)
    math(EXPR _TEST_TIMEOUT "${_ROCPROFSYS_CI_TIMEOUT} + 30")
else()
    set(_TEST_TIMEOUT 330)
endif()

add_test("mpi-perfetto-merge-sampling" "${_ROCPROFSYS_EXE}" "${_ROCPROFSYS_EXE_ARGS}" "${_ROCPROFSYS_NODEID_PFX}test_mpi.py::TestMPI::test_perfetto_merge[sampling]" ${_ROCPROFSYS_EXTRA_ARGS})
set_tests_properties("mpi-perfetto-merge-sampling" PROPERTIES
    LABELS "mpi;sampling"
    TIMEOUT ${_TEST_TIMEOUT}
    SKIP_RETURN_CODE 77
    FIXTURES_REQUIRED "rocprofsys-global-tmp-files"
)

if(DEFINED _ROCPROFSYS_CI_TIMEOUT)
    math(EXPR _TEST_TIMEOUT "${_ROCPROFSYS_CI_TIMEOUT} + 30")
else()
    set(_TEST_TIMEOUT 330)
endif()

add_test("mpi-perfetto-merge-binary-rewrite" "${_ROCPROFSYS_EXE}" "${_ROCPROFSYS_EXE_ARGS}" "${_ROCPROFSYS_NODEID_PFX}test_mpi.py::TestMPI::test_perfetto_merge[binary_rewrite]" ${_ROCPROFSYS_EXTRA_ARGS})
set_tests_properties("mpi-perfetto-merge-binary-rewrite" PROPERTIES
    LABELS "binary_rewrite;mpi"
    TIMEOUT ${_TEST_TIMEOUT}
    SKIP_RETURN_CODE 77
    FIXTURES_REQUIRED "rocprofsys-global-tmp-files"
)

if(DEFINED _ROCPROFSYS_CI_TIMEOUT)
    math(EXPR _TEST_TIMEOUT "${_ROCPROFSYS_CI_TIMEOUT} + 30")
else()
    set(_TEST_TIMEOUT 330)
endif()

add_test("mpi-perfetto-merge-sys-run" "${_ROCPROFSYS_EXE}" "${_ROCPROFSYS_EXE_ARGS}" "${_ROCPROFSYS_NODEID_PFX}test_mpi.py::TestMPI::test_perfetto_merge[sys_run]" ${_ROCPROFSYS_EXTRA_ARGS})
set_tests_properties("mpi-perfetto-merge-sys-run" PROPERTIES
    LABELS "mpi;sys_run"
    TIMEOUT ${_TEST_TIMEOUT}
    SKIP_RETURN_CODE 77
    FIXTURES_REQUIRED "rocprofsys-global-tmp-files"
)

if(DEFINED _ROCPROFSYS_CI_TIMEOUT)
    math(EXPR _TEST_TIMEOUT "${_ROCPROFSYS_CI_TIMEOUT} + 30")
else()
    set(_TEST_TIMEOUT 330)
endif()

add_test("mpip-mpi-all2all-binary-rewrite" "${_ROCPROFSYS_EXE}" "${_ROCPROFSYS_EXE_ARGS}" "${_ROCPROFSYS_NODEID_PFX}test_mpi.py::TestMPIP::test[mpi-all2all-binary_rewrite]" ${_ROCPROFSYS_EXTRA_ARGS})
set_tests_properties("mpip-mpi-all2all-binary-rewrite" PROPERTIES
    LABELS "binary_rewrite;mpi"
    TIMEOUT ${_TEST_TIMEOUT}
    SKIP_RETURN_CODE 77
    FIXTURES_REQUIRED "rocprofsys-global-tmp-files"
)

if(DEFINED _ROCPROFSYS_CI_TIMEOUT)
    math(EXPR _TEST_TIMEOUT "${_ROCPROFSYS_CI_TIMEOUT} + 30")
else()
    set(_TEST_TIMEOUT 330)
endif()

add_test("mpip-mpi-all2all-sys-run" "${_ROCPROFSYS_EXE}" "${_ROCPROFSYS_EXE_ARGS}" "${_ROCPROFSYS_NODEID_PFX}test_mpi.py::TestMPIP::test[mpi-all2all-sys_run]" ${_ROCPROFSYS_EXTRA_ARGS})
set_tests_properties("mpip-mpi-all2all-sys-run" PROPERTIES
    LABELS "mpi;sys_run"
    TIMEOUT ${_TEST_TIMEOUT}
    SKIP_RETURN_CODE 77
    FIXTURES_REQUIRED "rocprofsys-global-tmp-files"
)

if(DEFINED _ROCPROFSYS_CI_TIMEOUT)
    math(EXPR _TEST_TIMEOUT "${_ROCPROFSYS_CI_TIMEOUT} + 30")
else()
    set(_TEST_TIMEOUT 330)
endif()

add_test("mpip-mpi-allgather-binary-rewrite" "${_ROCPROFSYS_EXE}" "${_ROCPROFSYS_EXE_ARGS}" "${_ROCPROFSYS_NODEID_PFX}test_mpi.py::TestMPIP::test[mpi-allgather-binary_rewrite]" ${_ROCPROFSYS_EXTRA_ARGS})
set_tests_properties("mpip-mpi-allgather-binary-rewrite" PROPERTIES
    LABELS "binary_rewrite;mpi"
    TIMEOUT ${_TEST_TIMEOUT}
    SKIP_RETURN_CODE 77
    FIXTURES_REQUIRED "rocprofsys-global-tmp-files"
)

if(DEFINED _ROCPROFSYS_CI_TIMEOUT)
    math(EXPR _TEST_TIMEOUT "${_ROCPROFSYS_CI_TIMEOUT} + 30")
else()
    set(_TEST_TIMEOUT 330)
endif()

add_test("mpip-mpi-allgather-sys-run" "${_ROCPROFSYS_EXE}" "${_ROCPROFSYS_EXE_ARGS}" "${_ROCPROFSYS_NODEID_PFX}test_mpi.py::TestMPIP::test[mpi-allgather-sys_run]" ${_ROCPROFSYS_EXTRA_ARGS})
set_tests_properties("mpip-mpi-allgather-sys-run" PROPERTIES
    LABELS "mpi;sys_run"
    TIMEOUT ${_TEST_TIMEOUT}
    SKIP_RETURN_CODE 77
    FIXTURES_REQUIRED "rocprofsys-global-tmp-files"
)

if(DEFINED _ROCPROFSYS_CI_TIMEOUT)
    math(EXPR _TEST_TIMEOUT "${_ROCPROFSYS_CI_TIMEOUT} + 30")
else()
    set(_TEST_TIMEOUT 330)
endif()

add_test("mpip-mpi-allreduce-binary-rewrite" "${_ROCPROFSYS_EXE}" "${_ROCPROFSYS_EXE_ARGS}" "${_ROCPROFSYS_NODEID_PFX}test_mpi.py::TestMPIP::test[mpi-allreduce-binary_rewrite]" ${_ROCPROFSYS_EXTRA_ARGS})
set_tests_properties("mpip-mpi-allreduce-binary-rewrite" PROPERTIES
    LABELS "binary_rewrite;mpi"
    TIMEOUT ${_TEST_TIMEOUT}
    SKIP_RETURN_CODE 77
    FIXTURES_REQUIRED "rocprofsys-global-tmp-files"
)

if(DEFINED _ROCPROFSYS_CI_TIMEOUT)
    math(EXPR _TEST_TIMEOUT "${_ROCPROFSYS_CI_TIMEOUT} + 30")
else()
    set(_TEST_TIMEOUT 330)
endif()

add_test("mpip-mpi-allreduce-sys-run" "${_ROCPROFSYS_EXE}" "${_ROCPROFSYS_EXE_ARGS}" "${_ROCPROFSYS_NODEID_PFX}test_mpi.py::TestMPIP::test[mpi-allreduce-sys_run]" ${_ROCPROFSYS_EXTRA_ARGS})
set_tests_properties("mpip-mpi-allreduce-sys-run" PROPERTIES
    LABELS "mpi;sys_run"
    TIMEOUT ${_TEST_TIMEOUT}
    SKIP_RETURN_CODE 77
    FIXTURES_REQUIRED "rocprofsys-global-tmp-files"
)

if(DEFINED _ROCPROFSYS_CI_TIMEOUT)
    math(EXPR _TEST_TIMEOUT "${_ROCPROFSYS_CI_TIMEOUT} + 30")
else()
    set(_TEST_TIMEOUT 330)
endif()

add_test("mpip-mpi-bcast-binary-rewrite" "${_ROCPROFSYS_EXE}" "${_ROCPROFSYS_EXE_ARGS}" "${_ROCPROFSYS_NODEID_PFX}test_mpi.py::TestMPIP::test[mpi-bcast-binary_rewrite]" ${_ROCPROFSYS_EXTRA_ARGS})
set_tests_properties("mpip-mpi-bcast-binary-rewrite" PROPERTIES
    LABELS "binary_rewrite;mpi"
    TIMEOUT ${_TEST_TIMEOUT}
    SKIP_RETURN_CODE 77
    FIXTURES_REQUIRED "rocprofsys-global-tmp-files"
)

if(DEFINED _ROCPROFSYS_CI_TIMEOUT)
    math(EXPR _TEST_TIMEOUT "${_ROCPROFSYS_CI_TIMEOUT} + 30")
else()
    set(_TEST_TIMEOUT 330)
endif()

add_test("mpip-mpi-bcast-sys-run" "${_ROCPROFSYS_EXE}" "${_ROCPROFSYS_EXE_ARGS}" "${_ROCPROFSYS_NODEID_PFX}test_mpi.py::TestMPIP::test[mpi-bcast-sys_run]" ${_ROCPROFSYS_EXTRA_ARGS})
set_tests_properties("mpip-mpi-bcast-sys-run" PROPERTIES
    LABELS "mpi;sys_run"
    TIMEOUT ${_TEST_TIMEOUT}
    SKIP_RETURN_CODE 77
    FIXTURES_REQUIRED "rocprofsys-global-tmp-files"
)

if(DEFINED _ROCPROFSYS_CI_TIMEOUT)
    math(EXPR _TEST_TIMEOUT "${_ROCPROFSYS_CI_TIMEOUT} + 30")
else()
    set(_TEST_TIMEOUT 330)
endif()

add_test("mpip-mpi-reduce-binary-rewrite" "${_ROCPROFSYS_EXE}" "${_ROCPROFSYS_EXE_ARGS}" "${_ROCPROFSYS_NODEID_PFX}test_mpi.py::TestMPIP::test[mpi-reduce-binary_rewrite]" ${_ROCPROFSYS_EXTRA_ARGS})
set_tests_properties("mpip-mpi-reduce-binary-rewrite" PROPERTIES
    LABELS "binary_rewrite;mpi"
    TIMEOUT ${_TEST_TIMEOUT}
    SKIP_RETURN_CODE 77
    FIXTURES_REQUIRED "rocprofsys-global-tmp-files"
)

if(DEFINED _ROCPROFSYS_CI_TIMEOUT)
    math(EXPR _TEST_TIMEOUT "${_ROCPROFSYS_CI_TIMEOUT} + 30")
else()
    set(_TEST_TIMEOUT 330)
endif()

add_test("mpip-mpi-reduce-sys-run" "${_ROCPROFSYS_EXE}" "${_ROCPROFSYS_EXE_ARGS}" "${_ROCPROFSYS_NODEID_PFX}test_mpi.py::TestMPIP::test[mpi-reduce-sys_run]" ${_ROCPROFSYS_EXTRA_ARGS})
set_tests_properties("mpip-mpi-reduce-sys-run" PROPERTIES
    LABELS "mpi;sys_run"
    TIMEOUT ${_TEST_TIMEOUT}
    SKIP_RETURN_CODE 77
    FIXTURES_REQUIRED "rocprofsys-global-tmp-files"
)

if(DEFINED _ROCPROFSYS_CI_TIMEOUT)
    math(EXPR _TEST_TIMEOUT "${_ROCPROFSYS_CI_TIMEOUT} + 30")
else()
    set(_TEST_TIMEOUT 330)
endif()

add_test("mpip-mpi-scatter-gather-binary-rewrite" "${_ROCPROFSYS_EXE}" "${_ROCPROFSYS_EXE_ARGS}" "${_ROCPROFSYS_NODEID_PFX}test_mpi.py::TestMPIP::test[mpi-scatter-gather-binary_rewrite]" ${_ROCPROFSYS_EXTRA_ARGS})
set_tests_properties("mpip-mpi-scatter-gather-binary-rewrite" PROPERTIES
    LABELS "binary_rewrite;mpi"
    TIMEOUT ${_TEST_TIMEOUT}
    SKIP_RETURN_CODE 77
    FIXTURES_REQUIRED "rocprofsys-global-tmp-files"
)

if(DEFINED _ROCPROFSYS_CI_TIMEOUT)
    math(EXPR _TEST_TIMEOUT "${_ROCPROFSYS_CI_TIMEOUT} + 30")
else()
    set(_TEST_TIMEOUT 330)
endif()

add_test("mpip-mpi-scatter-gather-sys-run" "${_ROCPROFSYS_EXE}" "${_ROCPROFSYS_EXE_ARGS}" "${_ROCPROFSYS_NODEID_PFX}test_mpi.py::TestMPIP::test[mpi-scatter-gather-sys_run]" ${_ROCPROFSYS_EXTRA_ARGS})
set_tests_properties("mpip-mpi-scatter-gather-sys-run" PROPERTIES
    LABELS "mpi;sys_run"
    TIMEOUT ${_TEST_TIMEOUT}
    SKIP_RETURN_CODE 77
    FIXTURES_REQUIRED "rocprofsys-global-tmp-files"
)

if(DEFINED _ROCPROFSYS_CI_TIMEOUT)
    math(EXPR _TEST_TIMEOUT "${_ROCPROFSYS_CI_TIMEOUT} + 30")
else()
    set(_TEST_TIMEOUT 330)
endif()

add_test("mpip-mpi-send-recv-binary-rewrite" "${_ROCPROFSYS_EXE}" "${_ROCPROFSYS_EXE_ARGS}" "${_ROCPROFSYS_NODEID_PFX}test_mpi.py::TestMPIP::test[mpi-send-recv-binary_rewrite]" ${_ROCPROFSYS_EXTRA_ARGS})
set_tests_properties("mpip-mpi-send-recv-binary-rewrite" PROPERTIES
    LABELS "binary_rewrite;mpi"
    TIMEOUT ${_TEST_TIMEOUT}
    SKIP_RETURN_CODE 77
    FIXTURES_REQUIRED "rocprofsys-global-tmp-files"
)

if(DEFINED _ROCPROFSYS_CI_TIMEOUT)
    math(EXPR _TEST_TIMEOUT "${_ROCPROFSYS_CI_TIMEOUT} + 30")
else()
    set(_TEST_TIMEOUT 330)
endif()

add_test("mpip-mpi-send-recv-sys-run" "${_ROCPROFSYS_EXE}" "${_ROCPROFSYS_EXE_ARGS}" "${_ROCPROFSYS_NODEID_PFX}test_mpi.py::TestMPIP::test[mpi-send-recv-sys_run]" ${_ROCPROFSYS_EXTRA_ARGS})
set_tests_properties("mpip-mpi-send-recv-sys-run" PROPERTIES
    LABELS "mpi;sys_run"
    TIMEOUT ${_TEST_TIMEOUT}
    SKIP_RETURN_CODE 77
    FIXTURES_REQUIRED "rocprofsys-global-tmp-files"
)

if(DEFINED _ROCPROFSYS_CI_TIMEOUT)
    math(EXPR _TEST_TIMEOUT "${_ROCPROFSYS_CI_TIMEOUT} + 30")
else()
    set(_TEST_TIMEOUT 330)
endif()

add_test("mpip-flat-sampling" "${_ROCPROFSYS_EXE}" "${_ROCPROFSYS_EXE_ARGS}" "${_ROCPROFSYS_NODEID_PFX}test_mpi.py::TestMPIP::test_flat[sampling]" ${_ROCPROFSYS_EXTRA_ARGS})
set_tests_properties("mpip-flat-sampling" PROPERTIES
    LABELS "mpi;sampling"
    TIMEOUT ${_TEST_TIMEOUT}
    SKIP_RETURN_CODE 77
    FIXTURES_REQUIRED "rocprofsys-global-tmp-files"
)

if(DEFINED _ROCPROFSYS_CI_TIMEOUT)
    math(EXPR _TEST_TIMEOUT "${_ROCPROFSYS_CI_TIMEOUT} + 30")
else()
    set(_TEST_TIMEOUT 330)
endif()

add_test("mpip-flat-binary-rewrite" "${_ROCPROFSYS_EXE}" "${_ROCPROFSYS_EXE_ARGS}" "${_ROCPROFSYS_NODEID_PFX}test_mpi.py::TestMPIP::test_flat[binary_rewrite]" ${_ROCPROFSYS_EXTRA_ARGS})
set_tests_properties("mpip-flat-binary-rewrite" PROPERTIES
    LABELS "binary_rewrite;mpi"
    TIMEOUT ${_TEST_TIMEOUT}
    SKIP_RETURN_CODE 77
    FIXTURES_REQUIRED "rocprofsys-global-tmp-files"
)

if(DEFINED _ROCPROFSYS_CI_TIMEOUT)
    math(EXPR _TEST_TIMEOUT "${_ROCPROFSYS_CI_TIMEOUT} + 30")
else()
    set(_TEST_TIMEOUT 330)
endif()

add_test("mpip-flat-sys-run" "${_ROCPROFSYS_EXE}" "${_ROCPROFSYS_EXE_ARGS}" "${_ROCPROFSYS_NODEID_PFX}test_mpi.py::TestMPIP::test_flat[sys_run]" ${_ROCPROFSYS_EXTRA_ARGS})
set_tests_properties("mpip-flat-sys-run" PROPERTIES
    LABELS "mpi;sys_run"
    TIMEOUT ${_TEST_TIMEOUT}
    SKIP_RETURN_CODE 77
    FIXTURES_REQUIRED "rocprofsys-global-tmp-files"
)

if(DEFINED _ROCPROFSYS_CI_TIMEOUT)
    math(EXPR _TEST_TIMEOUT "${_ROCPROFSYS_CI_TIMEOUT} + 30")
else()
    set(_TEST_TIMEOUT 330)
endif()

add_test("nic-performance" "${_ROCPROFSYS_EXE}" "${_ROCPROFSYS_EXE_ARGS}" "${_ROCPROFSYS_NODEID_PFX}test_nic_perf.py::TestNIC::test_performance" ${_ROCPROFSYS_EXTRA_ARGS})
set_tests_properties("nic-performance" PROPERTIES
    LABELS "network;nic"
    TIMEOUT ${_TEST_TIMEOUT}
    SKIP_RETURN_CODE 77
    FIXTURES_REQUIRED "rocprofsys-global-tmp-files"
)

if(DEFINED _ROCPROFSYS_CI_TIMEOUT)
    math(EXPR _TEST_TIMEOUT "${_ROCPROFSYS_CI_TIMEOUT} + 30")
else()
    set(_TEST_TIMEOUT 210)
endif()

add_test("openmpcg-sampling" "${_ROCPROFSYS_EXE}" "${_ROCPROFSYS_EXE_ARGS}" "${_ROCPROFSYS_NODEID_PFX}test_openmp.py::TestOpenMPCG::test[sampling]" ${_ROCPROFSYS_EXTRA_ARGS})
set_tests_properties("openmpcg-sampling" PROPERTIES
    LABELS "openmp;sampling"
    TIMEOUT ${_TEST_TIMEOUT}
    SKIP_RETURN_CODE 77
    FIXTURES_REQUIRED "rocprofsys-global-tmp-files"
)

if(DEFINED _ROCPROFSYS_CI_TIMEOUT)
    math(EXPR _TEST_TIMEOUT "${_ROCPROFSYS_CI_TIMEOUT} + 30")
else()
    set(_TEST_TIMEOUT 210)
endif()

add_test("openmpcg-binary-rewrite" "${_ROCPROFSYS_EXE}" "${_ROCPROFSYS_EXE_ARGS}" "${_ROCPROFSYS_NODEID_PFX}test_openmp.py::TestOpenMPCG::test[binary_rewrite]" ${_ROCPROFSYS_EXTRA_ARGS})
set_tests_properties("openmpcg-binary-rewrite" PROPERTIES
    LABELS "binary_rewrite;openmp"
    TIMEOUT ${_TEST_TIMEOUT}
    SKIP_RETURN_CODE 77
    FIXTURES_REQUIRED "rocprofsys-global-tmp-files"
)

if(DEFINED _ROCPROFSYS_CI_TIMEOUT)
    math(EXPR _TEST_TIMEOUT "${_ROCPROFSYS_CI_TIMEOUT} + 30")
else()
    set(_TEST_TIMEOUT 330)
endif()

add_test("openmpcg-sampling-duration" "${_ROCPROFSYS_EXE}" "${_ROCPROFSYS_EXE_ARGS}" "${_ROCPROFSYS_NODEID_PFX}test_openmp.py::TestOpenMPCG::test_sampling_duration" ${_ROCPROFSYS_EXTRA_ARGS})
set_tests_properties("openmpcg-sampling-duration" PROPERTIES
    LABELS "openmp;sampling_duration"
    TIMEOUT ${_TEST_TIMEOUT}
    SKIP_RETURN_CODE 77
    FIXTURES_REQUIRED "rocprofsys-global-tmp-files"
)

if(DEFINED _ROCPROFSYS_CI_TIMEOUT)
    math(EXPR _TEST_TIMEOUT "${_ROCPROFSYS_CI_TIMEOUT} + 30")
else()
    set(_TEST_TIMEOUT 330)
endif()

add_test("openmpcg-no-tmp-files" "${_ROCPROFSYS_EXE}" "${_ROCPROFSYS_EXE_ARGS}" "${_ROCPROFSYS_NODEID_PFX}test_openmp.py::TestOpenMPCG::test_no_tmp_files" ${_ROCPROFSYS_EXTRA_ARGS})
set_tests_properties("openmpcg-no-tmp-files" PROPERTIES
    LABELS "no_tmp_files;openmp"
    TIMEOUT ${_TEST_TIMEOUT}
    SKIP_RETURN_CODE 77
    FIXTURES_REQUIRED "rocprofsys-global-tmp-files"
)

if(DEFINED _ROCPROFSYS_CI_TIMEOUT)
    math(EXPR _TEST_TIMEOUT "${_ROCPROFSYS_CI_TIMEOUT} + 30")
else()
    set(_TEST_TIMEOUT 210)
endif()

add_test("openmplu-baseline" "${_ROCPROFSYS_EXE}" "${_ROCPROFSYS_EXE_ARGS}" "${_ROCPROFSYS_NODEID_PFX}test_openmp.py::TestOpenMPLU::test[baseline]" ${_ROCPROFSYS_EXTRA_ARGS})
set_tests_properties("openmplu-baseline" PROPERTIES
    LABELS "baseline;openmp"
    TIMEOUT ${_TEST_TIMEOUT}
    SKIP_RETURN_CODE 77
    FIXTURES_REQUIRED "rocprofsys-global-tmp-files"
)

if(DEFINED _ROCPROFSYS_CI_TIMEOUT)
    math(EXPR _TEST_TIMEOUT "${_ROCPROFSYS_CI_TIMEOUT} + 30")
else()
    set(_TEST_TIMEOUT 210)
endif()

add_test("openmplu-sampling" "${_ROCPROFSYS_EXE}" "${_ROCPROFSYS_EXE_ARGS}" "${_ROCPROFSYS_NODEID_PFX}test_openmp.py::TestOpenMPLU::test[sampling]" ${_ROCPROFSYS_EXTRA_ARGS})
set_tests_properties("openmplu-sampling" PROPERTIES
    LABELS "openmp;sampling"
    TIMEOUT ${_TEST_TIMEOUT}
    SKIP_RETURN_CODE 77
    FIXTURES_REQUIRED "rocprofsys-global-tmp-files"
)

if(DEFINED _ROCPROFSYS_CI_TIMEOUT)
    math(EXPR _TEST_TIMEOUT "${_ROCPROFSYS_CI_TIMEOUT} + 30")
else()
    set(_TEST_TIMEOUT 210)
endif()

add_test("openmplu-binary-rewrite" "${_ROCPROFSYS_EXE}" "${_ROCPROFSYS_EXE_ARGS}" "${_ROCPROFSYS_NODEID_PFX}test_openmp.py::TestOpenMPLU::test[binary_rewrite]" ${_ROCPROFSYS_EXTRA_ARGS})
set_tests_properties("openmplu-binary-rewrite" PROPERTIES
    LABELS "binary_rewrite;openmp"
    TIMEOUT ${_TEST_TIMEOUT}
    SKIP_RETURN_CODE 77
    FIXTURES_REQUIRED "rocprofsys-global-tmp-files"
)

if(DEFINED _ROCPROFSYS_CI_TIMEOUT)
    math(EXPR _TEST_TIMEOUT "${_ROCPROFSYS_CI_TIMEOUT} + 30")
else()
    set(_TEST_TIMEOUT 330)
endif()

add_test("openmplu-sampling-duration" "${_ROCPROFSYS_EXE}" "${_ROCPROFSYS_EXE_ARGS}" "${_ROCPROFSYS_NODEID_PFX}test_openmp.py::TestOpenMPLU::test_sampling_duration" ${_ROCPROFSYS_EXTRA_ARGS})
set_tests_properties("openmplu-sampling-duration" PROPERTIES
    LABELS "openmp;sampling_duration"
    TIMEOUT ${_TEST_TIMEOUT}
    SKIP_RETURN_CODE 77
    FIXTURES_REQUIRED "rocprofsys-global-tmp-files"
)

if(DEFINED _ROCPROFSYS_CI_TIMEOUT)
    math(EXPR _TEST_TIMEOUT "${_ROCPROFSYS_CI_TIMEOUT} + 30")
else()
    set(_TEST_TIMEOUT 330)
endif()

add_test("openmp-target-baseline" "${_ROCPROFSYS_EXE}" "${_ROCPROFSYS_EXE_ARGS}" "${_ROCPROFSYS_NODEID_PFX}test_openmp.py::TestOpenMPTarget::test[baseline]" ${_ROCPROFSYS_EXTRA_ARGS})
set_tests_properties("openmp-target-baseline" PROPERTIES
    LABELS "baseline;gpu;openmp;rocm"
    TIMEOUT ${_TEST_TIMEOUT}
    SKIP_RETURN_CODE 77
    FIXTURES_REQUIRED "rocprofsys-global-tmp-files"
)

if(DEFINED _ROCPROFSYS_CI_TIMEOUT)
    math(EXPR _TEST_TIMEOUT "${_ROCPROFSYS_CI_TIMEOUT} + 30")
else()
    set(_TEST_TIMEOUT 330)
endif()

add_test("openmp-target-sampling" "${_ROCPROFSYS_EXE}" "${_ROCPROFSYS_EXE_ARGS}" "${_ROCPROFSYS_NODEID_PFX}test_openmp.py::TestOpenMPTarget::test[sampling]" ${_ROCPROFSYS_EXTRA_ARGS})
set_tests_properties("openmp-target-sampling" PROPERTIES
    LABELS "gpu;openmp;rocm;rocpd;sampling"
    TIMEOUT ${_TEST_TIMEOUT}
    SKIP_RETURN_CODE 77
    FIXTURES_REQUIRED "rocprofsys-global-tmp-files"
)

if(DEFINED _ROCPROFSYS_CI_TIMEOUT)
    math(EXPR _TEST_TIMEOUT "${_ROCPROFSYS_CI_TIMEOUT} + 30")
else()
    set(_TEST_TIMEOUT 330)
endif()

add_test("openmp-target-sys-run" "${_ROCPROFSYS_EXE}" "${_ROCPROFSYS_EXE_ARGS}" "${_ROCPROFSYS_NODEID_PFX}test_openmp.py::TestOpenMPTarget::test[sys_run]" ${_ROCPROFSYS_EXTRA_ARGS})
set_tests_properties("openmp-target-sys-run" PROPERTIES
    LABELS "gpu;openmp;rocm;sys_run"
    TIMEOUT ${_TEST_TIMEOUT}
    SKIP_RETURN_CODE 77
    FIXTURES_REQUIRED "rocprofsys-global-tmp-files"
)

if(DEFINED _ROCPROFSYS_CI_TIMEOUT)
    math(EXPR _TEST_TIMEOUT "${_ROCPROFSYS_CI_TIMEOUT} + 30")
else()
    set(_TEST_TIMEOUT 330)
endif()

add_test("openmp-fortran-host-baseline" "${_ROCPROFSYS_EXE}" "${_ROCPROFSYS_EXE_ARGS}" "${_ROCPROFSYS_NODEID_PFX}test_openmp.py::TestOpenMPFortran::test_host[baseline]" ${_ROCPROFSYS_EXTRA_ARGS})
set_tests_properties("openmp-fortran-host-baseline" PROPERTIES
    LABELS "baseline;fortran;openmp"
    TIMEOUT ${_TEST_TIMEOUT}
    SKIP_RETURN_CODE 77
    FIXTURES_REQUIRED "rocprofsys-global-tmp-files"
)

if(DEFINED _ROCPROFSYS_CI_TIMEOUT)
    math(EXPR _TEST_TIMEOUT "${_ROCPROFSYS_CI_TIMEOUT} + 30")
else()
    set(_TEST_TIMEOUT 330)
endif()

add_test("openmp-fortran-host-sampling" "${_ROCPROFSYS_EXE}" "${_ROCPROFSYS_EXE_ARGS}" "${_ROCPROFSYS_NODEID_PFX}test_openmp.py::TestOpenMPFortran::test_host[sampling]" ${_ROCPROFSYS_EXTRA_ARGS})
set_tests_properties("openmp-fortran-host-sampling" PROPERTIES
    LABELS "fortran;openmp;sampling"
    TIMEOUT ${_TEST_TIMEOUT}
    SKIP_RETURN_CODE 77
    FIXTURES_REQUIRED "rocprofsys-global-tmp-files"
)

if(DEFINED _ROCPROFSYS_CI_TIMEOUT)
    math(EXPR _TEST_TIMEOUT "${_ROCPROFSYS_CI_TIMEOUT} + 30")
else()
    set(_TEST_TIMEOUT 330)
endif()

add_test("openmp-fortran-host-binary-rewrite" "${_ROCPROFSYS_EXE}" "${_ROCPROFSYS_EXE_ARGS}" "${_ROCPROFSYS_NODEID_PFX}test_openmp.py::TestOpenMPFortran::test_host[binary_rewrite]" ${_ROCPROFSYS_EXTRA_ARGS})
set_tests_properties("openmp-fortran-host-binary-rewrite" PROPERTIES
    LABELS "binary_rewrite;fortran;openmp"
    TIMEOUT ${_TEST_TIMEOUT}
    SKIP_RETURN_CODE 77
    FIXTURES_REQUIRED "rocprofsys-global-tmp-files"
)

if(DEFINED _ROCPROFSYS_CI_TIMEOUT)
    math(EXPR _TEST_TIMEOUT "${_ROCPROFSYS_CI_TIMEOUT} + 30")
else()
    set(_TEST_TIMEOUT 330)
endif()

add_test("openmp-fortran-host-runtime-instrument" "${_ROCPROFSYS_EXE}" "${_ROCPROFSYS_EXE_ARGS}" "${_ROCPROFSYS_NODEID_PFX}test_openmp.py::TestOpenMPFortran::test_host[runtime_instrument]" ${_ROCPROFSYS_EXTRA_ARGS})
set_tests_properties("openmp-fortran-host-runtime-instrument" PROPERTIES
    LABELS "fortran;openmp;runtime_instrument"
    TIMEOUT ${_TEST_TIMEOUT}
    SKIP_RETURN_CODE 77
    FIXTURES_REQUIRED "rocprofsys-global-tmp-files"
)

if(DEFINED _ROCPROFSYS_CI_TIMEOUT)
    math(EXPR _TEST_TIMEOUT "${_ROCPROFSYS_CI_TIMEOUT} + 30")
else()
    set(_TEST_TIMEOUT 330)
endif()

add_test("openmp-fortran-host-sys-run" "${_ROCPROFSYS_EXE}" "${_ROCPROFSYS_EXE_ARGS}" "${_ROCPROFSYS_NODEID_PFX}test_openmp.py::TestOpenMPFortran::test_host[sys_run]" ${_ROCPROFSYS_EXTRA_ARGS})
set_tests_properties("openmp-fortran-host-sys-run" PROPERTIES
    LABELS "fortran;openmp;sys_run"
    TIMEOUT ${_TEST_TIMEOUT}
    SKIP_RETURN_CODE 77
    FIXTURES_REQUIRED "rocprofsys-global-tmp-files"
)

if(DEFINED _ROCPROFSYS_CI_TIMEOUT)
    math(EXPR _TEST_TIMEOUT "${_ROCPROFSYS_CI_TIMEOUT} + 30")
else()
    set(_TEST_TIMEOUT 330)
endif()

add_test("openmp-fortran-offload-baseline" "${_ROCPROFSYS_EXE}" "${_ROCPROFSYS_EXE_ARGS}" "${_ROCPROFSYS_NODEID_PFX}test_openmp.py::TestOpenMPFortran::test_offload[baseline]" ${_ROCPROFSYS_EXTRA_ARGS})
set_tests_properties("openmp-fortran-offload-baseline" PROPERTIES
    LABELS "baseline;fortran;gpu;openmp"
    TIMEOUT ${_TEST_TIMEOUT}
    SKIP_RETURN_CODE 77
    FIXTURES_REQUIRED "rocprofsys-global-tmp-files"
)

if(DEFINED _ROCPROFSYS_CI_TIMEOUT)
    math(EXPR _TEST_TIMEOUT "${_ROCPROFSYS_CI_TIMEOUT} + 30")
else()
    set(_TEST_TIMEOUT 330)
endif()

add_test("openmp-fortran-offload-sampling" "${_ROCPROFSYS_EXE}" "${_ROCPROFSYS_EXE_ARGS}" "${_ROCPROFSYS_NODEID_PFX}test_openmp.py::TestOpenMPFortran::test_offload[sampling]" ${_ROCPROFSYS_EXTRA_ARGS})
set_tests_properties("openmp-fortran-offload-sampling" PROPERTIES
    LABELS "fortran;gpu;openmp;sampling"
    TIMEOUT ${_TEST_TIMEOUT}
    SKIP_RETURN_CODE 77
    FIXTURES_REQUIRED "rocprofsys-global-tmp-files"
)

if(DEFINED _ROCPROFSYS_CI_TIMEOUT)
    math(EXPR _TEST_TIMEOUT "${_ROCPROFSYS_CI_TIMEOUT} + 30")
else()
    set(_TEST_TIMEOUT 330)
endif()

add_test("openmp-fortran-offload-binary-rewrite" "${_ROCPROFSYS_EXE}" "${_ROCPROFSYS_EXE_ARGS}" "${_ROCPROFSYS_NODEID_PFX}test_openmp.py::TestOpenMPFortran::test_offload[binary_rewrite]" ${_ROCPROFSYS_EXTRA_ARGS})
set_tests_properties("openmp-fortran-offload-binary-rewrite" PROPERTIES
    LABELS "binary_rewrite;fortran;gpu;openmp"
    TIMEOUT ${_TEST_TIMEOUT}
    SKIP_RETURN_CODE 77
    FIXTURES_REQUIRED "rocprofsys-global-tmp-files"
)

if(DEFINED _ROCPROFSYS_CI_TIMEOUT)
    math(EXPR _TEST_TIMEOUT "${_ROCPROFSYS_CI_TIMEOUT} + 30")
else()
    set(_TEST_TIMEOUT 330)
endif()

add_test("openmp-fortran-offload-sys-run" "${_ROCPROFSYS_EXE}" "${_ROCPROFSYS_EXE_ARGS}" "${_ROCPROFSYS_NODEID_PFX}test_openmp.py::TestOpenMPFortran::test_offload[sys_run]" ${_ROCPROFSYS_EXTRA_ARGS})
set_tests_properties("openmp-fortran-offload-sys-run" PROPERTIES
    LABELS "fortran;gpu;openmp;sys_run"
    TIMEOUT ${_TEST_TIMEOUT}
    SKIP_RETURN_CODE 77
    FIXTURES_REQUIRED "rocprofsys-global-tmp-files"
)

if(DEFINED _ROCPROFSYS_CI_TIMEOUT)
    math(EXPR _TEST_TIMEOUT "${_ROCPROFSYS_CI_TIMEOUT} + 30")
else()
    set(_TEST_TIMEOUT 330)
endif()

add_test("openmp-fortran-offload-runtime-instrument" "${_ROCPROFSYS_EXE}" "${_ROCPROFSYS_EXE_ARGS}" "${_ROCPROFSYS_NODEID_PFX}test_openmp.py::TestOpenMPFortran::test_offload[runtime_instrument]" ${_ROCPROFSYS_EXTRA_ARGS})
set_tests_properties("openmp-fortran-offload-runtime-instrument" PROPERTIES
    LABELS "fortran;gpu;openmp;runtime_instrument;slow"
    TIMEOUT ${_TEST_TIMEOUT}
    SKIP_RETURN_CODE 77
    FIXTURES_REQUIRED "rocprofsys-global-tmp-files"
    RUN_SERIAL TRUE
)

if(DEFINED _ROCPROFSYS_CI_TIMEOUT)
    math(EXPR _TEST_TIMEOUT "${_ROCPROFSYS_CI_TIMEOUT} + 30")
else()
    set(_TEST_TIMEOUT 330)
endif()

add_test("overflow-parallel-overhead-sampling" "${_ROCPROFSYS_EXE}" "${_ROCPROFSYS_EXE_ARGS}" "${_ROCPROFSYS_NODEID_PFX}test_overflow.py::TestOverflow::test_parallel_overhead[sampling]" ${_ROCPROFSYS_EXTRA_ARGS})
set_tests_properties("overflow-parallel-overhead-sampling" PROPERTIES
    LABELS "overflow;sampling"
    TIMEOUT ${_TEST_TIMEOUT}
    SKIP_RETURN_CODE 77
    FIXTURES_REQUIRED "rocprofsys-global-tmp-files"
)

if(DEFINED _ROCPROFSYS_CI_TIMEOUT)
    math(EXPR _TEST_TIMEOUT "${_ROCPROFSYS_CI_TIMEOUT} + 30")
else()
    set(_TEST_TIMEOUT 330)
endif()

add_test("overflow-parallel-overhead-binary-rewrite" "${_ROCPROFSYS_EXE}" "${_ROCPROFSYS_EXE_ARGS}" "${_ROCPROFSYS_NODEID_PFX}test_overflow.py::TestOverflow::test_parallel_overhead[binary_rewrite]" ${_ROCPROFSYS_EXTRA_ARGS})
set_tests_properties("overflow-parallel-overhead-binary-rewrite" PROPERTIES
    LABELS "binary_rewrite;overflow"
    TIMEOUT ${_TEST_TIMEOUT}
    SKIP_RETURN_CODE 77
    FIXTURES_REQUIRED "rocprofsys-global-tmp-files"
)

if(DEFINED _ROCPROFSYS_CI_TIMEOUT)
    math(EXPR _TEST_TIMEOUT "${_ROCPROFSYS_CI_TIMEOUT} + 30")
else()
    set(_TEST_TIMEOUT 330)
endif()

add_test("overflow-parallel-overhead-runtime-instrument" "${_ROCPROFSYS_EXE}" "${_ROCPROFSYS_EXE_ARGS}" "${_ROCPROFSYS_NODEID_PFX}test_overflow.py::TestOverflow::test_parallel_overhead[runtime_instrument]" ${_ROCPROFSYS_EXTRA_ARGS})
set_tests_properties("overflow-parallel-overhead-runtime-instrument" PROPERTIES
    LABELS "overflow;runtime_instrument"
    TIMEOUT ${_TEST_TIMEOUT}
    SKIP_RETURN_CODE 77
    FIXTURES_REQUIRED "rocprofsys-global-tmp-files"
)

if(DEFINED _ROCPROFSYS_CI_TIMEOUT)
    math(EXPR _TEST_TIMEOUT "${_ROCPROFSYS_CI_TIMEOUT} + 30")
else()
    set(_TEST_TIMEOUT 330)
endif()

add_test("overflow-parallel-overhead-sys-run" "${_ROCPROFSYS_EXE}" "${_ROCPROFSYS_EXE_ARGS}" "${_ROCPROFSYS_NODEID_PFX}test_overflow.py::TestOverflow::test_parallel_overhead[sys_run]" ${_ROCPROFSYS_EXTRA_ARGS})
set_tests_properties("overflow-parallel-overhead-sys-run" PROPERTIES
    LABELS "overflow;sys_run"
    TIMEOUT ${_TEST_TIMEOUT}
    SKIP_RETURN_CODE 77
    FIXTURES_REQUIRED "rocprofsys-global-tmp-files"
)

if(DEFINED _ROCPROFSYS_CI_TIMEOUT)
    math(EXPR _TEST_TIMEOUT "${_ROCPROFSYS_CI_TIMEOUT} + 30")
else()
    set(_TEST_TIMEOUT 90)
endif()

add_test("sample-presets-preset-balanced" "${_ROCPROFSYS_EXE}" "${_ROCPROFSYS_EXE_ARGS}" "${_ROCPROFSYS_NODEID_PFX}test_presets.py::TestSamplePresets::test_preset[balanced]" ${_ROCPROFSYS_EXTRA_ARGS})
set_tests_properties("sample-presets-preset-balanced" PROPERTIES
    LABELS "presets;sampling"
    TIMEOUT ${_TEST_TIMEOUT}
    SKIP_RETURN_CODE 77
    FIXTURES_REQUIRED "rocprofsys-global-tmp-files"
)

if(DEFINED _ROCPROFSYS_CI_TIMEOUT)
    math(EXPR _TEST_TIMEOUT "${_ROCPROFSYS_CI_TIMEOUT} + 30")
else()
    set(_TEST_TIMEOUT 90)
endif()

add_test("sample-presets-preset-profile-only" "${_ROCPROFSYS_EXE}" "${_ROCPROFSYS_EXE_ARGS}" "${_ROCPROFSYS_NODEID_PFX}test_presets.py::TestSamplePresets::test_preset[profile-only]" ${_ROCPROFSYS_EXTRA_ARGS})
set_tests_properties("sample-presets-preset-profile-only" PROPERTIES
    LABELS "presets;sampling"
    TIMEOUT ${_TEST_TIMEOUT}
    SKIP_RETURN_CODE 77
    FIXTURES_REQUIRED "rocprofsys-global-tmp-files"
)

if(DEFINED _ROCPROFSYS_CI_TIMEOUT)
    math(EXPR _TEST_TIMEOUT "${_ROCPROFSYS_CI_TIMEOUT} + 30")
else()
    set(_TEST_TIMEOUT 90)
endif()

add_test("sample-presets-preset-detailed" "${_ROCPROFSYS_EXE}" "${_ROCPROFSYS_EXE_ARGS}" "${_ROCPROFSYS_NODEID_PFX}test_presets.py::TestSamplePresets::test_preset[detailed]" ${_ROCPROFSYS_EXTRA_ARGS})
set_tests_properties("sample-presets-preset-detailed" PROPERTIES
    LABELS "presets;sampling"
    TIMEOUT ${_TEST_TIMEOUT}
    SKIP_RETURN_CODE 77
    FIXTURES_REQUIRED "rocprofsys-global-tmp-files"
)

if(DEFINED _ROCPROFSYS_CI_TIMEOUT)
    math(EXPR _TEST_TIMEOUT "${_ROCPROFSYS_CI_TIMEOUT} + 30")
else()
    set(_TEST_TIMEOUT 90)
endif()

add_test("sample-presets-preset-trace-hpc" "${_ROCPROFSYS_EXE}" "${_ROCPROFSYS_EXE_ARGS}" "${_ROCPROFSYS_NODEID_PFX}test_presets.py::TestSamplePresets::test_preset[trace-hpc]" ${_ROCPROFSYS_EXTRA_ARGS})
set_tests_properties("sample-presets-preset-trace-hpc" PROPERTIES
    LABELS "presets;sampling"
    TIMEOUT ${_TEST_TIMEOUT}
    SKIP_RETURN_CODE 77
    FIXTURES_REQUIRED "rocprofsys-global-tmp-files"
)

if(DEFINED _ROCPROFSYS_CI_TIMEOUT)
    math(EXPR _TEST_TIMEOUT "${_ROCPROFSYS_CI_TIMEOUT} + 30")
else()
    set(_TEST_TIMEOUT 90)
endif()

add_test("sample-presets-preset-sys-trace" "${_ROCPROFSYS_EXE}" "${_ROCPROFSYS_EXE_ARGS}" "${_ROCPROFSYS_NODEID_PFX}test_presets.py::TestSamplePresets::test_preset[sys-trace]" ${_ROCPROFSYS_EXTRA_ARGS})
set_tests_properties("sample-presets-preset-sys-trace" PROPERTIES
    LABELS "presets;sampling"
    TIMEOUT ${_TEST_TIMEOUT}
    SKIP_RETURN_CODE 77
    FIXTURES_REQUIRED "rocprofsys-global-tmp-files"
)

if(DEFINED _ROCPROFSYS_CI_TIMEOUT)
    math(EXPR _TEST_TIMEOUT "${_ROCPROFSYS_CI_TIMEOUT} + 30")
else()
    set(_TEST_TIMEOUT 90)
endif()

add_test("sample-presets-preset-runtime-trace" "${_ROCPROFSYS_EXE}" "${_ROCPROFSYS_EXE_ARGS}" "${_ROCPROFSYS_NODEID_PFX}test_presets.py::TestSamplePresets::test_preset[runtime-trace]" ${_ROCPROFSYS_EXTRA_ARGS})
set_tests_properties("sample-presets-preset-runtime-trace" PROPERTIES
    LABELS "presets;sampling"
    TIMEOUT ${_TEST_TIMEOUT}
    SKIP_RETURN_CODE 77
    FIXTURES_REQUIRED "rocprofsys-global-tmp-files"
)

if(DEFINED _ROCPROFSYS_CI_TIMEOUT)
    math(EXPR _TEST_TIMEOUT "${_ROCPROFSYS_CI_TIMEOUT} + 30")
else()
    set(_TEST_TIMEOUT 90)
endif()

add_test("sample-presets-preset-trace-gpu" "${_ROCPROFSYS_EXE}" "${_ROCPROFSYS_EXE_ARGS}" "${_ROCPROFSYS_NODEID_PFX}test_presets.py::TestSamplePresets::test_preset[trace-gpu]" ${_ROCPROFSYS_EXTRA_ARGS})
set_tests_properties("sample-presets-preset-trace-gpu" PROPERTIES
    LABELS "presets;sampling"
    TIMEOUT ${_TEST_TIMEOUT}
    SKIP_RETURN_CODE 77
    FIXTURES_REQUIRED "rocprofsys-global-tmp-files"
)

if(DEFINED _ROCPROFSYS_CI_TIMEOUT)
    math(EXPR _TEST_TIMEOUT "${_ROCPROFSYS_CI_TIMEOUT} + 30")
else()
    set(_TEST_TIMEOUT 90)
endif()

add_test("sample-presets-preset-trace-openmp" "${_ROCPROFSYS_EXE}" "${_ROCPROFSYS_EXE_ARGS}" "${_ROCPROFSYS_NODEID_PFX}test_presets.py::TestSamplePresets::test_preset[trace-openmp]" ${_ROCPROFSYS_EXTRA_ARGS})
set_tests_properties("sample-presets-preset-trace-openmp" PROPERTIES
    LABELS "presets;sampling"
    TIMEOUT ${_TEST_TIMEOUT}
    SKIP_RETURN_CODE 77
    FIXTURES_REQUIRED "rocprofsys-global-tmp-files"
)

if(DEFINED _ROCPROFSYS_CI_TIMEOUT)
    math(EXPR _TEST_TIMEOUT "${_ROCPROFSYS_CI_TIMEOUT} + 30")
else()
    set(_TEST_TIMEOUT 90)
endif()

add_test("sample-presets-preset-profile-mpi" "${_ROCPROFSYS_EXE}" "${_ROCPROFSYS_EXE_ARGS}" "${_ROCPROFSYS_NODEID_PFX}test_presets.py::TestSamplePresets::test_preset[profile-mpi]" ${_ROCPROFSYS_EXTRA_ARGS})
set_tests_properties("sample-presets-preset-profile-mpi" PROPERTIES
    LABELS "presets;sampling"
    TIMEOUT ${_TEST_TIMEOUT}
    SKIP_RETURN_CODE 77
    FIXTURES_REQUIRED "rocprofsys-global-tmp-files"
)

if(DEFINED _ROCPROFSYS_CI_TIMEOUT)
    math(EXPR _TEST_TIMEOUT "${_ROCPROFSYS_CI_TIMEOUT} + 30")
else()
    set(_TEST_TIMEOUT 90)
endif()

add_test("sample-presets-preset-trace-hw-counters" "${_ROCPROFSYS_EXE}" "${_ROCPROFSYS_EXE_ARGS}" "${_ROCPROFSYS_NODEID_PFX}test_presets.py::TestSamplePresets::test_preset[trace-hw-counters]" ${_ROCPROFSYS_EXTRA_ARGS})
set_tests_properties("sample-presets-preset-trace-hw-counters" PROPERTIES
    LABELS "presets;sampling"
    TIMEOUT ${_TEST_TIMEOUT}
    SKIP_RETURN_CODE 77
    FIXTURES_REQUIRED "rocprofsys-global-tmp-files"
)

if(DEFINED _ROCPROFSYS_CI_TIMEOUT)
    math(EXPR _TEST_TIMEOUT "${_ROCPROFSYS_CI_TIMEOUT} + 30")
else()
    set(_TEST_TIMEOUT 90)
endif()

add_test("sample-presets-preset-rocpd-workload-trace" "${_ROCPROFSYS_EXE}" "${_ROCPROFSYS_EXE_ARGS}" "${_ROCPROFSYS_NODEID_PFX}test_presets.py::TestSamplePresets::test_preset_rocpd[workload-trace]" ${_ROCPROFSYS_EXTRA_ARGS})
set_tests_properties("sample-presets-preset-rocpd-workload-trace" PROPERTIES
    LABELS "gpu;presets;rocpd;sampling"
    TIMEOUT ${_TEST_TIMEOUT}
    SKIP_RETURN_CODE 77
    FIXTURES_REQUIRED "rocprofsys-global-tmp-files"
)

if(DEFINED _ROCPROFSYS_CI_TIMEOUT)
    math(EXPR _TEST_TIMEOUT "${_ROCPROFSYS_CI_TIMEOUT} + 30")
else()
    set(_TEST_TIMEOUT 90)
endif()

add_test("run-presets-preset-balanced" "${_ROCPROFSYS_EXE}" "${_ROCPROFSYS_EXE_ARGS}" "${_ROCPROFSYS_NODEID_PFX}test_presets.py::TestRunPresets::test_preset[balanced]" ${_ROCPROFSYS_EXTRA_ARGS})
set_tests_properties("run-presets-preset-balanced" PROPERTIES
    LABELS "presets;sys_run"
    TIMEOUT ${_TEST_TIMEOUT}
    SKIP_RETURN_CODE 77
    FIXTURES_REQUIRED "rocprofsys-global-tmp-files"
)

if(DEFINED _ROCPROFSYS_CI_TIMEOUT)
    math(EXPR _TEST_TIMEOUT "${_ROCPROFSYS_CI_TIMEOUT} + 30")
else()
    set(_TEST_TIMEOUT 90)
endif()

add_test("run-presets-preset-profile-only" "${_ROCPROFSYS_EXE}" "${_ROCPROFSYS_EXE_ARGS}" "${_ROCPROFSYS_NODEID_PFX}test_presets.py::TestRunPresets::test_preset[profile-only]" ${_ROCPROFSYS_EXTRA_ARGS})
set_tests_properties("run-presets-preset-profile-only" PROPERTIES
    LABELS "presets;sys_run"
    TIMEOUT ${_TEST_TIMEOUT}
    SKIP_RETURN_CODE 77
    FIXTURES_REQUIRED "rocprofsys-global-tmp-files"
)

if(DEFINED _ROCPROFSYS_CI_TIMEOUT)
    math(EXPR _TEST_TIMEOUT "${_ROCPROFSYS_CI_TIMEOUT} + 30")
else()
    set(_TEST_TIMEOUT 90)
endif()

add_test("run-presets-preset-detailed" "${_ROCPROFSYS_EXE}" "${_ROCPROFSYS_EXE_ARGS}" "${_ROCPROFSYS_NODEID_PFX}test_presets.py::TestRunPresets::test_preset[detailed]" ${_ROCPROFSYS_EXTRA_ARGS})
set_tests_properties("run-presets-preset-detailed" PROPERTIES
    LABELS "presets;sys_run"
    TIMEOUT ${_TEST_TIMEOUT}
    SKIP_RETURN_CODE 77
    FIXTURES_REQUIRED "rocprofsys-global-tmp-files"
)

if(DEFINED _ROCPROFSYS_CI_TIMEOUT)
    math(EXPR _TEST_TIMEOUT "${_ROCPROFSYS_CI_TIMEOUT} + 30")
else()
    set(_TEST_TIMEOUT 90)
endif()

add_test("run-presets-preset-trace-hpc" "${_ROCPROFSYS_EXE}" "${_ROCPROFSYS_EXE_ARGS}" "${_ROCPROFSYS_NODEID_PFX}test_presets.py::TestRunPresets::test_preset[trace-hpc]" ${_ROCPROFSYS_EXTRA_ARGS})
set_tests_properties("run-presets-preset-trace-hpc" PROPERTIES
    LABELS "presets;sys_run"
    TIMEOUT ${_TEST_TIMEOUT}
    SKIP_RETURN_CODE 77
    FIXTURES_REQUIRED "rocprofsys-global-tmp-files"
)

if(DEFINED _ROCPROFSYS_CI_TIMEOUT)
    math(EXPR _TEST_TIMEOUT "${_ROCPROFSYS_CI_TIMEOUT} + 30")
else()
    set(_TEST_TIMEOUT 90)
endif()

add_test("run-presets-preset-sys-trace" "${_ROCPROFSYS_EXE}" "${_ROCPROFSYS_EXE_ARGS}" "${_ROCPROFSYS_NODEID_PFX}test_presets.py::TestRunPresets::test_preset[sys-trace]" ${_ROCPROFSYS_EXTRA_ARGS})
set_tests_properties("run-presets-preset-sys-trace" PROPERTIES
    LABELS "presets;sys_run"
    TIMEOUT ${_TEST_TIMEOUT}
    SKIP_RETURN_CODE 77
    FIXTURES_REQUIRED "rocprofsys-global-tmp-files"
)

if(DEFINED _ROCPROFSYS_CI_TIMEOUT)
    math(EXPR _TEST_TIMEOUT "${_ROCPROFSYS_CI_TIMEOUT} + 30")
else()
    set(_TEST_TIMEOUT 90)
endif()

add_test("run-presets-preset-runtime-trace" "${_ROCPROFSYS_EXE}" "${_ROCPROFSYS_EXE_ARGS}" "${_ROCPROFSYS_NODEID_PFX}test_presets.py::TestRunPresets::test_preset[runtime-trace]" ${_ROCPROFSYS_EXTRA_ARGS})
set_tests_properties("run-presets-preset-runtime-trace" PROPERTIES
    LABELS "presets;sys_run"
    TIMEOUT ${_TEST_TIMEOUT}
    SKIP_RETURN_CODE 77
    FIXTURES_REQUIRED "rocprofsys-global-tmp-files"
)

if(DEFINED _ROCPROFSYS_CI_TIMEOUT)
    math(EXPR _TEST_TIMEOUT "${_ROCPROFSYS_CI_TIMEOUT} + 30")
else()
    set(_TEST_TIMEOUT 90)
endif()

add_test("run-presets-preset-trace-gpu" "${_ROCPROFSYS_EXE}" "${_ROCPROFSYS_EXE_ARGS}" "${_ROCPROFSYS_NODEID_PFX}test_presets.py::TestRunPresets::test_preset[trace-gpu]" ${_ROCPROFSYS_EXTRA_ARGS})
set_tests_properties("run-presets-preset-trace-gpu" PROPERTIES
    LABELS "presets;sys_run"
    TIMEOUT ${_TEST_TIMEOUT}
    SKIP_RETURN_CODE 77
    FIXTURES_REQUIRED "rocprofsys-global-tmp-files"
)

if(DEFINED _ROCPROFSYS_CI_TIMEOUT)
    math(EXPR _TEST_TIMEOUT "${_ROCPROFSYS_CI_TIMEOUT} + 30")
else()
    set(_TEST_TIMEOUT 90)
endif()

add_test("run-presets-preset-trace-openmp" "${_ROCPROFSYS_EXE}" "${_ROCPROFSYS_EXE_ARGS}" "${_ROCPROFSYS_NODEID_PFX}test_presets.py::TestRunPresets::test_preset[trace-openmp]" ${_ROCPROFSYS_EXTRA_ARGS})
set_tests_properties("run-presets-preset-trace-openmp" PROPERTIES
    LABELS "presets;sys_run"
    TIMEOUT ${_TEST_TIMEOUT}
    SKIP_RETURN_CODE 77
    FIXTURES_REQUIRED "rocprofsys-global-tmp-files"
)

if(DEFINED _ROCPROFSYS_CI_TIMEOUT)
    math(EXPR _TEST_TIMEOUT "${_ROCPROFSYS_CI_TIMEOUT} + 30")
else()
    set(_TEST_TIMEOUT 90)
endif()

add_test("run-presets-preset-profile-mpi" "${_ROCPROFSYS_EXE}" "${_ROCPROFSYS_EXE_ARGS}" "${_ROCPROFSYS_NODEID_PFX}test_presets.py::TestRunPresets::test_preset[profile-mpi]" ${_ROCPROFSYS_EXTRA_ARGS})
set_tests_properties("run-presets-preset-profile-mpi" PROPERTIES
    LABELS "presets;sys_run"
    TIMEOUT ${_TEST_TIMEOUT}
    SKIP_RETURN_CODE 77
    FIXTURES_REQUIRED "rocprofsys-global-tmp-files"
)

if(DEFINED _ROCPROFSYS_CI_TIMEOUT)
    math(EXPR _TEST_TIMEOUT "${_ROCPROFSYS_CI_TIMEOUT} + 30")
else()
    set(_TEST_TIMEOUT 90)
endif()

add_test("run-presets-preset-trace-hw-counters" "${_ROCPROFSYS_EXE}" "${_ROCPROFSYS_EXE_ARGS}" "${_ROCPROFSYS_NODEID_PFX}test_presets.py::TestRunPresets::test_preset[trace-hw-counters]" ${_ROCPROFSYS_EXTRA_ARGS})
set_tests_properties("run-presets-preset-trace-hw-counters" PROPERTIES
    LABELS "presets;sys_run"
    TIMEOUT ${_TEST_TIMEOUT}
    SKIP_RETURN_CODE 77
    FIXTURES_REQUIRED "rocprofsys-global-tmp-files"
)

if(DEFINED _ROCPROFSYS_CI_TIMEOUT)
    math(EXPR _TEST_TIMEOUT "${_ROCPROFSYS_CI_TIMEOUT} + 30")
else()
    set(_TEST_TIMEOUT 90)
endif()

add_test("run-presets-preset-rocpd-workload-trace" "${_ROCPROFSYS_EXE}" "${_ROCPROFSYS_EXE_ARGS}" "${_ROCPROFSYS_NODEID_PFX}test_presets.py::TestRunPresets::test_preset_rocpd[workload-trace]" ${_ROCPROFSYS_EXTRA_ARGS})
set_tests_properties("run-presets-preset-rocpd-workload-trace" PROPERTIES
    LABELS "gpu;presets;rocpd;sys_run"
    TIMEOUT ${_TEST_TIMEOUT}
    SKIP_RETURN_CODE 77
    FIXTURES_REQUIRED "rocprofsys-global-tmp-files"
)

if(DEFINED _ROCPROFSYS_CI_TIMEOUT)
    math(EXPR _TEST_TIMEOUT "${_ROCPROFSYS_CI_TIMEOUT} + 30")
else()
    set(_TEST_TIMEOUT 90)
endif()

add_test("sample-domain-flags-gpu" "${_ROCPROFSYS_EXE}" "${_ROCPROFSYS_EXE_ARGS}" "${_ROCPROFSYS_NODEID_PFX}test_presets.py::TestSampleDomainFlags::test_gpu" ${_ROCPROFSYS_EXTRA_ARGS})
set_tests_properties("sample-domain-flags-gpu" PROPERTIES
    LABELS "presets;sampling"
    TIMEOUT ${_TEST_TIMEOUT}
    SKIP_RETURN_CODE 77
    FIXTURES_REQUIRED "rocprofsys-global-tmp-files"
)

if(DEFINED _ROCPROFSYS_CI_TIMEOUT)
    math(EXPR _TEST_TIMEOUT "${_ROCPROFSYS_CI_TIMEOUT} + 30")
else()
    set(_TEST_TIMEOUT 90)
endif()

add_test("sample-domain-flags-gpu-metrics" "${_ROCPROFSYS_EXE}" "${_ROCPROFSYS_EXE_ARGS}" "${_ROCPROFSYS_NODEID_PFX}test_presets.py::TestSampleDomainFlags::test_gpu_metrics" ${_ROCPROFSYS_EXTRA_ARGS})
set_tests_properties("sample-domain-flags-gpu-metrics" PROPERTIES
    LABELS "presets;sampling"
    TIMEOUT ${_TEST_TIMEOUT}
    SKIP_RETURN_CODE 77
    FIXTURES_REQUIRED "rocprofsys-global-tmp-files"
)

if(DEFINED _ROCPROFSYS_CI_TIMEOUT)
    math(EXPR _TEST_TIMEOUT "${_ROCPROFSYS_CI_TIMEOUT} + 30")
else()
    set(_TEST_TIMEOUT 90)
endif()

add_test("sample-domain-flags-rocm" "${_ROCPROFSYS_EXE}" "${_ROCPROFSYS_EXE_ARGS}" "${_ROCPROFSYS_NODEID_PFX}test_presets.py::TestSampleDomainFlags::test_rocm" ${_ROCPROFSYS_EXTRA_ARGS})
set_tests_properties("sample-domain-flags-rocm" PROPERTIES
    LABELS "presets;sampling"
    TIMEOUT ${_TEST_TIMEOUT}
    SKIP_RETURN_CODE 77
    FIXTURES_REQUIRED "rocprofsys-global-tmp-files"
)

if(DEFINED _ROCPROFSYS_CI_TIMEOUT)
    math(EXPR _TEST_TIMEOUT "${_ROCPROFSYS_CI_TIMEOUT} + 30")
else()
    set(_TEST_TIMEOUT 90)
endif()

add_test("sample-domain-flags-cpu" "${_ROCPROFSYS_EXE}" "${_ROCPROFSYS_EXE_ARGS}" "${_ROCPROFSYS_NODEID_PFX}test_presets.py::TestSampleDomainFlags::test_cpu" ${_ROCPROFSYS_EXTRA_ARGS})
set_tests_properties("sample-domain-flags-cpu" PROPERTIES
    LABELS "presets;sampling"
    TIMEOUT ${_TEST_TIMEOUT}
    SKIP_RETURN_CODE 77
    FIXTURES_REQUIRED "rocprofsys-global-tmp-files"
)

if(DEFINED _ROCPROFSYS_CI_TIMEOUT)
    math(EXPR _TEST_TIMEOUT "${_ROCPROFSYS_CI_TIMEOUT} + 30")
else()
    set(_TEST_TIMEOUT 90)
endif()

add_test("sample-domain-flags-parallel" "${_ROCPROFSYS_EXE}" "${_ROCPROFSYS_EXE_ARGS}" "${_ROCPROFSYS_NODEID_PFX}test_presets.py::TestSampleDomainFlags::test_parallel" ${_ROCPROFSYS_EXTRA_ARGS})
set_tests_properties("sample-domain-flags-parallel" PROPERTIES
    LABELS "presets;sampling"
    TIMEOUT ${_TEST_TIMEOUT}
    SKIP_RETURN_CODE 77
    FIXTURES_REQUIRED "rocprofsys-global-tmp-files"
)

if(DEFINED _ROCPROFSYS_CI_TIMEOUT)
    math(EXPR _TEST_TIMEOUT "${_ROCPROFSYS_CI_TIMEOUT} + 30")
else()
    set(_TEST_TIMEOUT 90)
endif()

add_test("sample-domain-flags-preset-plus-domain" "${_ROCPROFSYS_EXE}" "${_ROCPROFSYS_EXE_ARGS}" "${_ROCPROFSYS_NODEID_PFX}test_presets.py::TestSampleDomainFlags::test_preset_plus_domain" ${_ROCPROFSYS_EXTRA_ARGS})
set_tests_properties("sample-domain-flags-preset-plus-domain" PROPERTIES
    LABELS "presets;sampling"
    TIMEOUT ${_TEST_TIMEOUT}
    SKIP_RETURN_CODE 77
    FIXTURES_REQUIRED "rocprofsys-global-tmp-files"
)

if(DEFINED _ROCPROFSYS_CI_TIMEOUT)
    math(EXPR _TEST_TIMEOUT "${_ROCPROFSYS_CI_TIMEOUT} + 30")
else()
    set(_TEST_TIMEOUT 90)
endif()

add_test("run-domain-flags-gpu" "${_ROCPROFSYS_EXE}" "${_ROCPROFSYS_EXE_ARGS}" "${_ROCPROFSYS_NODEID_PFX}test_presets.py::TestRunDomainFlags::test_gpu" ${_ROCPROFSYS_EXTRA_ARGS})
set_tests_properties("run-domain-flags-gpu" PROPERTIES
    LABELS "presets;sys_run"
    TIMEOUT ${_TEST_TIMEOUT}
    SKIP_RETURN_CODE 77
    FIXTURES_REQUIRED "rocprofsys-global-tmp-files"
)

if(DEFINED _ROCPROFSYS_CI_TIMEOUT)
    math(EXPR _TEST_TIMEOUT "${_ROCPROFSYS_CI_TIMEOUT} + 30")
else()
    set(_TEST_TIMEOUT 90)
endif()

add_test("run-domain-flags-gpu-metrics" "${_ROCPROFSYS_EXE}" "${_ROCPROFSYS_EXE_ARGS}" "${_ROCPROFSYS_NODEID_PFX}test_presets.py::TestRunDomainFlags::test_gpu_metrics" ${_ROCPROFSYS_EXTRA_ARGS})
set_tests_properties("run-domain-flags-gpu-metrics" PROPERTIES
    LABELS "presets;sys_run"
    TIMEOUT ${_TEST_TIMEOUT}
    SKIP_RETURN_CODE 77
    FIXTURES_REQUIRED "rocprofsys-global-tmp-files"
)

if(DEFINED _ROCPROFSYS_CI_TIMEOUT)
    math(EXPR _TEST_TIMEOUT "${_ROCPROFSYS_CI_TIMEOUT} + 30")
else()
    set(_TEST_TIMEOUT 90)
endif()

add_test("run-domain-flags-rocm" "${_ROCPROFSYS_EXE}" "${_ROCPROFSYS_EXE_ARGS}" "${_ROCPROFSYS_NODEID_PFX}test_presets.py::TestRunDomainFlags::test_rocm" ${_ROCPROFSYS_EXTRA_ARGS})
set_tests_properties("run-domain-flags-rocm" PROPERTIES
    LABELS "presets;sys_run"
    TIMEOUT ${_TEST_TIMEOUT}
    SKIP_RETURN_CODE 77
    FIXTURES_REQUIRED "rocprofsys-global-tmp-files"
)

if(DEFINED _ROCPROFSYS_CI_TIMEOUT)
    math(EXPR _TEST_TIMEOUT "${_ROCPROFSYS_CI_TIMEOUT} + 30")
else()
    set(_TEST_TIMEOUT 90)
endif()

add_test("run-domain-flags-cpu" "${_ROCPROFSYS_EXE}" "${_ROCPROFSYS_EXE_ARGS}" "${_ROCPROFSYS_NODEID_PFX}test_presets.py::TestRunDomainFlags::test_cpu" ${_ROCPROFSYS_EXTRA_ARGS})
set_tests_properties("run-domain-flags-cpu" PROPERTIES
    LABELS "presets;sys_run"
    TIMEOUT ${_TEST_TIMEOUT}
    SKIP_RETURN_CODE 77
    FIXTURES_REQUIRED "rocprofsys-global-tmp-files"
)

if(DEFINED _ROCPROFSYS_CI_TIMEOUT)
    math(EXPR _TEST_TIMEOUT "${_ROCPROFSYS_CI_TIMEOUT} + 30")
else()
    set(_TEST_TIMEOUT 90)
endif()

add_test("run-domain-flags-parallel" "${_ROCPROFSYS_EXE}" "${_ROCPROFSYS_EXE_ARGS}" "${_ROCPROFSYS_NODEID_PFX}test_presets.py::TestRunDomainFlags::test_parallel" ${_ROCPROFSYS_EXTRA_ARGS})
set_tests_properties("run-domain-flags-parallel" PROPERTIES
    LABELS "presets;sys_run"
    TIMEOUT ${_TEST_TIMEOUT}
    SKIP_RETURN_CODE 77
    FIXTURES_REQUIRED "rocprofsys-global-tmp-files"
)

if(DEFINED _ROCPROFSYS_CI_TIMEOUT)
    math(EXPR _TEST_TIMEOUT "${_ROCPROFSYS_CI_TIMEOUT} + 30")
else()
    set(_TEST_TIMEOUT 90)
endif()

add_test("run-domain-flags-preset-plus-domain" "${_ROCPROFSYS_EXE}" "${_ROCPROFSYS_EXE_ARGS}" "${_ROCPROFSYS_NODEID_PFX}test_presets.py::TestRunDomainFlags::test_preset_plus_domain" ${_ROCPROFSYS_EXTRA_ARGS})
set_tests_properties("run-domain-flags-preset-plus-domain" PROPERTIES
    LABELS "presets;sys_run"
    TIMEOUT ${_TEST_TIMEOUT}
    SKIP_RETURN_CODE 77
    FIXTURES_REQUIRED "rocprofsys-global-tmp-files"
)

if(DEFINED _ROCPROFSYS_CI_TIMEOUT)
    math(EXPR _TEST_TIMEOUT "${_ROCPROFSYS_CI_TIMEOUT} + 30")
else()
    set(_TEST_TIMEOUT 90)
endif()

add_test("run-sampling-target-flags-gpus-without-device" "${_ROCPROFSYS_EXE}" "${_ROCPROFSYS_EXE_ARGS}" "${_ROCPROFSYS_NODEID_PFX}test_presets.py::TestRunSamplingTargetFlags::test_gpus_without_device" ${_ROCPROFSYS_EXTRA_ARGS})
set_tests_properties("run-sampling-target-flags-gpus-without-device" PROPERTIES
    LABELS "presets;sys_run"
    TIMEOUT ${_TEST_TIMEOUT}
    SKIP_RETURN_CODE 77
    FIXTURES_REQUIRED "rocprofsys-global-tmp-files"
)

if(DEFINED _ROCPROFSYS_CI_TIMEOUT)
    math(EXPR _TEST_TIMEOUT "${_ROCPROFSYS_CI_TIMEOUT} + 30")
else()
    set(_TEST_TIMEOUT 90)
endif()

add_test("run-sampling-target-flags-cpus-without-host" "${_ROCPROFSYS_EXE}" "${_ROCPROFSYS_EXE_ARGS}" "${_ROCPROFSYS_NODEID_PFX}test_presets.py::TestRunSamplingTargetFlags::test_cpus_without_host" ${_ROCPROFSYS_EXTRA_ARGS})
set_tests_properties("run-sampling-target-flags-cpus-without-host" PROPERTIES
    LABELS "presets;sys_run"
    TIMEOUT ${_TEST_TIMEOUT}
    SKIP_RETURN_CODE 77
    FIXTURES_REQUIRED "rocprofsys-global-tmp-files"
)

if(DEFINED _ROCPROFSYS_CI_TIMEOUT)
    math(EXPR _TEST_TIMEOUT "${_ROCPROFSYS_CI_TIMEOUT} + 30")
else()
    set(_TEST_TIMEOUT 90)
endif()

add_test("run-sampling-target-flags-ai-nics-without-device" "${_ROCPROFSYS_EXE}" "${_ROCPROFSYS_EXE_ARGS}" "${_ROCPROFSYS_NODEID_PFX}test_presets.py::TestRunSamplingTargetFlags::test_ai_nics_without_device" ${_ROCPROFSYS_EXTRA_ARGS})
set_tests_properties("run-sampling-target-flags-ai-nics-without-device" PROPERTIES
    LABELS "presets;sys_run"
    TIMEOUT ${_TEST_TIMEOUT}
    SKIP_RETURN_CODE 77
    FIXTURES_REQUIRED "rocprofsys-global-tmp-files"
)

if(DEFINED _ROCPROFSYS_CI_TIMEOUT)
    math(EXPR _TEST_TIMEOUT "${_ROCPROFSYS_CI_TIMEOUT} + 30")
else()
    set(_TEST_TIMEOUT 90)
endif()

add_test("run-sampling-target-flags-preset-plus-gpus-trace-hpc" "${_ROCPROFSYS_EXE}" "${_ROCPROFSYS_EXE_ARGS}" "${_ROCPROFSYS_NODEID_PFX}test_presets.py::TestRunSamplingTargetFlags::test_preset_plus_gpus[trace-hpc]" ${_ROCPROFSYS_EXTRA_ARGS})
set_tests_properties("run-sampling-target-flags-preset-plus-gpus-trace-hpc" PROPERTIES
    LABELS "presets;sys_run"
    TIMEOUT ${_TEST_TIMEOUT}
    SKIP_RETURN_CODE 77
    FIXTURES_REQUIRED "rocprofsys-global-tmp-files"
)

if(DEFINED _ROCPROFSYS_CI_TIMEOUT)
    math(EXPR _TEST_TIMEOUT "${_ROCPROFSYS_CI_TIMEOUT} + 30")
else()
    set(_TEST_TIMEOUT 90)
endif()

add_test("run-sampling-target-flags-preset-plus-gpus-trace-gpu" "${_ROCPROFSYS_EXE}" "${_ROCPROFSYS_EXE_ARGS}" "${_ROCPROFSYS_NODEID_PFX}test_presets.py::TestRunSamplingTargetFlags::test_preset_plus_gpus[trace-gpu]" ${_ROCPROFSYS_EXTRA_ARGS})
set_tests_properties("run-sampling-target-flags-preset-plus-gpus-trace-gpu" PROPERTIES
    LABELS "presets;sys_run"
    TIMEOUT ${_TEST_TIMEOUT}
    SKIP_RETURN_CODE 77
    FIXTURES_REQUIRED "rocprofsys-global-tmp-files"
)

if(DEFINED _ROCPROFSYS_CI_TIMEOUT)
    math(EXPR _TEST_TIMEOUT "${_ROCPROFSYS_CI_TIMEOUT} + 30")
else()
    set(_TEST_TIMEOUT 90)
endif()

add_test("sample-sampling-target-flags-gpus-without-device" "${_ROCPROFSYS_EXE}" "${_ROCPROFSYS_EXE_ARGS}" "${_ROCPROFSYS_NODEID_PFX}test_presets.py::TestSampleSamplingTargetFlags::test_gpus_without_device" ${_ROCPROFSYS_EXTRA_ARGS})
set_tests_properties("sample-sampling-target-flags-gpus-without-device" PROPERTIES
    LABELS "presets;sampling"
    TIMEOUT ${_TEST_TIMEOUT}
    SKIP_RETURN_CODE 77
    FIXTURES_REQUIRED "rocprofsys-global-tmp-files"
)

if(DEFINED _ROCPROFSYS_CI_TIMEOUT)
    math(EXPR _TEST_TIMEOUT "${_ROCPROFSYS_CI_TIMEOUT} + 30")
else()
    set(_TEST_TIMEOUT 90)
endif()

add_test("sample-sampling-target-flags-cpus-without-host" "${_ROCPROFSYS_EXE}" "${_ROCPROFSYS_EXE_ARGS}" "${_ROCPROFSYS_NODEID_PFX}test_presets.py::TestSampleSamplingTargetFlags::test_cpus_without_host" ${_ROCPROFSYS_EXTRA_ARGS})
set_tests_properties("sample-sampling-target-flags-cpus-without-host" PROPERTIES
    LABELS "presets;sampling"
    TIMEOUT ${_TEST_TIMEOUT}
    SKIP_RETURN_CODE 77
    FIXTURES_REQUIRED "rocprofsys-global-tmp-files"
)

if(DEFINED _ROCPROFSYS_CI_TIMEOUT)
    math(EXPR _TEST_TIMEOUT "${_ROCPROFSYS_CI_TIMEOUT} + 30")
else()
    set(_TEST_TIMEOUT 90)
endif()

add_test("sample-sampling-target-flags-ai-nics-without-device" "${_ROCPROFSYS_EXE}" "${_ROCPROFSYS_EXE_ARGS}" "${_ROCPROFSYS_NODEID_PFX}test_presets.py::TestSampleSamplingTargetFlags::test_ai_nics_without_device" ${_ROCPROFSYS_EXTRA_ARGS})
set_tests_properties("sample-sampling-target-flags-ai-nics-without-device" PROPERTIES
    LABELS "presets;sampling"
    TIMEOUT ${_TEST_TIMEOUT}
    SKIP_RETURN_CODE 77
    FIXTURES_REQUIRED "rocprofsys-global-tmp-files"
)

if(DEFINED _ROCPROFSYS_CI_TIMEOUT)
    math(EXPR _TEST_TIMEOUT "${_ROCPROFSYS_CI_TIMEOUT} + 30")
else()
    set(_TEST_TIMEOUT 90)
endif()

add_test("sample-sampling-target-flags-preset-plus-gpus-trace-hpc" "${_ROCPROFSYS_EXE}" "${_ROCPROFSYS_EXE_ARGS}" "${_ROCPROFSYS_NODEID_PFX}test_presets.py::TestSampleSamplingTargetFlags::test_preset_plus_gpus[trace-hpc]" ${_ROCPROFSYS_EXTRA_ARGS})
set_tests_properties("sample-sampling-target-flags-preset-plus-gpus-trace-hpc" PROPERTIES
    LABELS "presets;sampling"
    TIMEOUT ${_TEST_TIMEOUT}
    SKIP_RETURN_CODE 77
    FIXTURES_REQUIRED "rocprofsys-global-tmp-files"
)

if(DEFINED _ROCPROFSYS_CI_TIMEOUT)
    math(EXPR _TEST_TIMEOUT "${_ROCPROFSYS_CI_TIMEOUT} + 30")
else()
    set(_TEST_TIMEOUT 90)
endif()

add_test("sample-sampling-target-flags-preset-plus-gpus-trace-gpu" "${_ROCPROFSYS_EXE}" "${_ROCPROFSYS_EXE_ARGS}" "${_ROCPROFSYS_NODEID_PFX}test_presets.py::TestSampleSamplingTargetFlags::test_preset_plus_gpus[trace-gpu]" ${_ROCPROFSYS_EXTRA_ARGS})
set_tests_properties("sample-sampling-target-flags-preset-plus-gpus-trace-gpu" PROPERTIES
    LABELS "presets;sampling"
    TIMEOUT ${_TEST_TIMEOUT}
    SKIP_RETURN_CODE 77
    FIXTURES_REQUIRED "rocprofsys-global-tmp-files"
)

if(DEFINED _ROCPROFSYS_CI_TIMEOUT)
    math(EXPR _TEST_TIMEOUT "${_ROCPROFSYS_CI_TIMEOUT} + 30")
else()
    set(_TEST_TIMEOUT 60)
endif()

add_test("export-config-export-run" "${_ROCPROFSYS_EXE}" "${_ROCPROFSYS_EXE_ARGS}" "${_ROCPROFSYS_NODEID_PFX}test_presets.py::TestExportConfig::test_export_run" ${_ROCPROFSYS_EXTRA_ARGS})
set_tests_properties("export-config-export-run" PROPERTIES
    LABELS "presets;sys_run"
    TIMEOUT ${_TEST_TIMEOUT}
    SKIP_RETURN_CODE 77
    FIXTURES_REQUIRED "rocprofsys-global-tmp-files"
)

if(DEFINED _ROCPROFSYS_CI_TIMEOUT)
    math(EXPR _TEST_TIMEOUT "${_ROCPROFSYS_CI_TIMEOUT} + 30")
else()
    set(_TEST_TIMEOUT 60)
endif()

add_test("export-config-export-sample" "${_ROCPROFSYS_EXE}" "${_ROCPROFSYS_EXE_ARGS}" "${_ROCPROFSYS_NODEID_PFX}test_presets.py::TestExportConfig::test_export_sample" ${_ROCPROFSYS_EXTRA_ARGS})
set_tests_properties("export-config-export-sample" PROPERTIES
    LABELS "presets;sampling"
    TIMEOUT ${_TEST_TIMEOUT}
    SKIP_RETURN_CODE 77
    FIXTURES_REQUIRED "rocprofsys-global-tmp-files"
)

if(DEFINED _ROCPROFSYS_CI_TIMEOUT)
    math(EXPR _TEST_TIMEOUT "${_ROCPROFSYS_CI_TIMEOUT} + 30")
else()
    set(_TEST_TIMEOUT 60)
endif()

add_test("preset-discovery-list-presets-run" "${_ROCPROFSYS_EXE}" "${_ROCPROFSYS_EXE_ARGS}" "${_ROCPROFSYS_NODEID_PFX}test_presets.py::TestPresetDiscovery::test_list_presets_run" ${_ROCPROFSYS_EXTRA_ARGS})
set_tests_properties("preset-discovery-list-presets-run" PROPERTIES
    LABELS "presets;sys_run"
    TIMEOUT ${_TEST_TIMEOUT}
    SKIP_RETURN_CODE 77
    FIXTURES_REQUIRED "rocprofsys-global-tmp-files"
)

if(DEFINED _ROCPROFSYS_CI_TIMEOUT)
    math(EXPR _TEST_TIMEOUT "${_ROCPROFSYS_CI_TIMEOUT} + 30")
else()
    set(_TEST_TIMEOUT 60)
endif()

add_test("preset-discovery-list-presets-sample" "${_ROCPROFSYS_EXE}" "${_ROCPROFSYS_EXE_ARGS}" "${_ROCPROFSYS_NODEID_PFX}test_presets.py::TestPresetDiscovery::test_list_presets_sample" ${_ROCPROFSYS_EXTRA_ARGS})
set_tests_properties("preset-discovery-list-presets-sample" PROPERTIES
    LABELS "presets;sampling"
    TIMEOUT ${_TEST_TIMEOUT}
    SKIP_RETURN_CODE 77
    FIXTURES_REQUIRED "rocprofsys-global-tmp-files"
)

if(DEFINED _ROCPROFSYS_CI_TIMEOUT)
    math(EXPR _TEST_TIMEOUT "${_ROCPROFSYS_CI_TIMEOUT} + 30")
else()
    set(_TEST_TIMEOUT 60)
endif()

add_test("preset-discovery-explain-preset-run" "${_ROCPROFSYS_EXE}" "${_ROCPROFSYS_EXE_ARGS}" "${_ROCPROFSYS_NODEID_PFX}test_presets.py::TestPresetDiscovery::test_explain_preset_run" ${_ROCPROFSYS_EXTRA_ARGS})
set_tests_properties("preset-discovery-explain-preset-run" PROPERTIES
    LABELS "presets;sys_run"
    TIMEOUT ${_TEST_TIMEOUT}
    SKIP_RETURN_CODE 77
    FIXTURES_REQUIRED "rocprofsys-global-tmp-files"
)

if(DEFINED _ROCPROFSYS_CI_TIMEOUT)
    math(EXPR _TEST_TIMEOUT "${_ROCPROFSYS_CI_TIMEOUT} + 30")
else()
    set(_TEST_TIMEOUT 60)
endif()

add_test("preset-discovery-explain-preset-sample" "${_ROCPROFSYS_EXE}" "${_ROCPROFSYS_EXE_ARGS}" "${_ROCPROFSYS_NODEID_PFX}test_presets.py::TestPresetDiscovery::test_explain_preset_sample" ${_ROCPROFSYS_EXTRA_ARGS})
set_tests_properties("preset-discovery-explain-preset-sample" PROPERTIES
    LABELS "presets;sampling"
    TIMEOUT ${_TEST_TIMEOUT}
    SKIP_RETURN_CODE 77
    FIXTURES_REQUIRED "rocprofsys-global-tmp-files"
)

if(DEFINED _ROCPROFSYS_CI_TIMEOUT)
    math(EXPR _TEST_TIMEOUT "${_ROCPROFSYS_CI_TIMEOUT} + 30")
else()
    set(_TEST_TIMEOUT 60)
endif()

add_test("help-discoverability-tracing-lists-selected-regions-run" "${_ROCPROFSYS_EXE}" "${_ROCPROFSYS_EXE_ARGS}" "${_ROCPROFSYS_NODEID_PFX}test_presets.py::TestHelpDiscoverability::test_tracing_lists_selected_regions[run]" ${_ROCPROFSYS_EXTRA_ARGS})
set_tests_properties("help-discoverability-tracing-lists-selected-regions-run" PROPERTIES
    LABELS "presets;sys_run"
    TIMEOUT ${_TEST_TIMEOUT}
    SKIP_RETURN_CODE 77
    FIXTURES_REQUIRED "rocprofsys-global-tmp-files"
)

if(DEFINED _ROCPROFSYS_CI_TIMEOUT)
    math(EXPR _TEST_TIMEOUT "${_ROCPROFSYS_CI_TIMEOUT} + 30")
else()
    set(_TEST_TIMEOUT 60)
endif()

add_test("help-discoverability-tracing-lists-selected-regions-sample" "${_ROCPROFSYS_EXE}" "${_ROCPROFSYS_EXE_ARGS}" "${_ROCPROFSYS_NODEID_PFX}test_presets.py::TestHelpDiscoverability::test_tracing_lists_selected_regions[sample]" ${_ROCPROFSYS_EXTRA_ARGS})
set_tests_properties("help-discoverability-tracing-lists-selected-regions-sample" PROPERTIES
    LABELS "presets;sampling"
    TIMEOUT ${_TEST_TIMEOUT}
    SKIP_RETURN_CODE 77
    FIXTURES_REQUIRED "rocprofsys-global-tmp-files"
)

if(DEFINED _ROCPROFSYS_CI_TIMEOUT)
    math(EXPR _TEST_TIMEOUT "${_ROCPROFSYS_CI_TIMEOUT} + 30")
else()
    set(_TEST_TIMEOUT 60)
endif()

add_test("help-discoverability-domain-lists-use-amd-smi-gpu-run" "${_ROCPROFSYS_EXE}" "${_ROCPROFSYS_EXE_ARGS}" "${_ROCPROFSYS_NODEID_PFX}test_presets.py::TestHelpDiscoverability::test_domain_lists_use_amd_smi[gpu-run]" ${_ROCPROFSYS_EXTRA_ARGS})
set_tests_properties("help-discoverability-domain-lists-use-amd-smi-gpu-run" PROPERTIES
    LABELS "presets;sys_run"
    TIMEOUT ${_TEST_TIMEOUT}
    SKIP_RETURN_CODE 77
    FIXTURES_REQUIRED "rocprofsys-global-tmp-files"
)

if(DEFINED _ROCPROFSYS_CI_TIMEOUT)
    math(EXPR _TEST_TIMEOUT "${_ROCPROFSYS_CI_TIMEOUT} + 30")
else()
    set(_TEST_TIMEOUT 60)
endif()

add_test("help-discoverability-domain-lists-use-amd-smi-gpu-sample" "${_ROCPROFSYS_EXE}" "${_ROCPROFSYS_EXE_ARGS}" "${_ROCPROFSYS_NODEID_PFX}test_presets.py::TestHelpDiscoverability::test_domain_lists_use_amd_smi[gpu-sample]" ${_ROCPROFSYS_EXTRA_ARGS})
set_tests_properties("help-discoverability-domain-lists-use-amd-smi-gpu-sample" PROPERTIES
    LABELS "presets;sampling"
    TIMEOUT ${_TEST_TIMEOUT}
    SKIP_RETURN_CODE 77
    FIXTURES_REQUIRED "rocprofsys-global-tmp-files"
)

if(DEFINED _ROCPROFSYS_CI_TIMEOUT)
    math(EXPR _TEST_TIMEOUT "${_ROCPROFSYS_CI_TIMEOUT} + 30")
else()
    set(_TEST_TIMEOUT 60)
endif()

add_test("help-discoverability-domain-lists-use-amd-smi-rocm-run" "${_ROCPROFSYS_EXE}" "${_ROCPROFSYS_EXE_ARGS}" "${_ROCPROFSYS_NODEID_PFX}test_presets.py::TestHelpDiscoverability::test_domain_lists_use_amd_smi[rocm-run]" ${_ROCPROFSYS_EXTRA_ARGS})
set_tests_properties("help-discoverability-domain-lists-use-amd-smi-rocm-run" PROPERTIES
    LABELS "presets;sys_run"
    TIMEOUT ${_TEST_TIMEOUT}
    SKIP_RETURN_CODE 77
    FIXTURES_REQUIRED "rocprofsys-global-tmp-files"
)

if(DEFINED _ROCPROFSYS_CI_TIMEOUT)
    math(EXPR _TEST_TIMEOUT "${_ROCPROFSYS_CI_TIMEOUT} + 30")
else()
    set(_TEST_TIMEOUT 60)
endif()

add_test("help-discoverability-domain-lists-use-amd-smi-rocm-sample" "${_ROCPROFSYS_EXE}" "${_ROCPROFSYS_EXE_ARGS}" "${_ROCPROFSYS_NODEID_PFX}test_presets.py::TestHelpDiscoverability::test_domain_lists_use_amd_smi[rocm-sample]" ${_ROCPROFSYS_EXTRA_ARGS})
set_tests_properties("help-discoverability-domain-lists-use-amd-smi-rocm-sample" PROPERTIES
    LABELS "presets;sampling"
    TIMEOUT ${_TEST_TIMEOUT}
    SKIP_RETURN_CODE 77
    FIXTURES_REQUIRED "rocprofsys-global-tmp-files"
)

if(DEFINED _ROCPROFSYS_CI_TIMEOUT)
    math(EXPR _TEST_TIMEOUT "${_ROCPROFSYS_CI_TIMEOUT} + 30")
else()
    set(_TEST_TIMEOUT 60)
endif()

add_test("help-discoverability-rocm-lists-kfd-events-run" "${_ROCPROFSYS_EXE}" "${_ROCPROFSYS_EXE_ARGS}" "${_ROCPROFSYS_NODEID_PFX}test_presets.py::TestHelpDiscoverability::test_rocm_lists_kfd_events[run]" ${_ROCPROFSYS_EXTRA_ARGS})
set_tests_properties("help-discoverability-rocm-lists-kfd-events-run" PROPERTIES
    LABELS "presets;sys_run"
    TIMEOUT ${_TEST_TIMEOUT}
    SKIP_RETURN_CODE 77
    FIXTURES_REQUIRED "rocprofsys-global-tmp-files"
)

if(DEFINED _ROCPROFSYS_CI_TIMEOUT)
    math(EXPR _TEST_TIMEOUT "${_ROCPROFSYS_CI_TIMEOUT} + 30")
else()
    set(_TEST_TIMEOUT 60)
endif()

add_test("help-discoverability-rocm-lists-kfd-events-sample" "${_ROCPROFSYS_EXE}" "${_ROCPROFSYS_EXE_ARGS}" "${_ROCPROFSYS_NODEID_PFX}test_presets.py::TestHelpDiscoverability::test_rocm_lists_kfd_events[sample]" ${_ROCPROFSYS_EXTRA_ARGS})
set_tests_properties("help-discoverability-rocm-lists-kfd-events-sample" PROPERTIES
    LABELS "presets;sampling"
    TIMEOUT ${_TEST_TIMEOUT}
    SKIP_RETURN_CODE 77
    FIXTURES_REQUIRED "rocprofsys-global-tmp-files"
)

if(DEFINED _ROCPROFSYS_CI_TIMEOUT)
    math(EXPR _TEST_TIMEOUT "${_ROCPROFSYS_CI_TIMEOUT} + 30")
else()
    set(_TEST_TIMEOUT 330)
endif()

add_test("pthreads-parallel-overhead-locks-baseline" "${_ROCPROFSYS_EXE}" "${_ROCPROFSYS_EXE_ARGS}" "${_ROCPROFSYS_NODEID_PFX}test_pthread.py::TestPthreads::test_parallel_overhead_locks[baseline]" ${_ROCPROFSYS_EXTRA_ARGS})
set_tests_properties("pthreads-parallel-overhead-locks-baseline" PROPERTIES
    LABELS "baseline;pthreads"
    TIMEOUT ${_TEST_TIMEOUT}
    SKIP_RETURN_CODE 77
    FIXTURES_REQUIRED "rocprofsys-global-tmp-files"
)

if(DEFINED _ROCPROFSYS_CI_TIMEOUT)
    math(EXPR _TEST_TIMEOUT "${_ROCPROFSYS_CI_TIMEOUT} + 30")
else()
    set(_TEST_TIMEOUT 330)
endif()

add_test("pthreads-parallel-overhead-locks-sampling" "${_ROCPROFSYS_EXE}" "${_ROCPROFSYS_EXE_ARGS}" "${_ROCPROFSYS_NODEID_PFX}test_pthread.py::TestPthreads::test_parallel_overhead_locks[sampling]" ${_ROCPROFSYS_EXTRA_ARGS})
set_tests_properties("pthreads-parallel-overhead-locks-sampling" PROPERTIES
    LABELS "pthreads;sampling"
    TIMEOUT ${_TEST_TIMEOUT}
    SKIP_RETURN_CODE 77
    FIXTURES_REQUIRED "rocprofsys-global-tmp-files"
)

if(DEFINED _ROCPROFSYS_CI_TIMEOUT)
    math(EXPR _TEST_TIMEOUT "${_ROCPROFSYS_CI_TIMEOUT} + 30")
else()
    set(_TEST_TIMEOUT 330)
endif()

add_test("pthreads-parallel-overhead-locks-binary-rewrite" "${_ROCPROFSYS_EXE}" "${_ROCPROFSYS_EXE_ARGS}" "${_ROCPROFSYS_NODEID_PFX}test_pthread.py::TestPthreads::test_parallel_overhead_locks[binary_rewrite]" ${_ROCPROFSYS_EXTRA_ARGS})
set_tests_properties("pthreads-parallel-overhead-locks-binary-rewrite" PROPERTIES
    LABELS "binary_rewrite;pthreads"
    TIMEOUT ${_TEST_TIMEOUT}
    SKIP_RETURN_CODE 77
    FIXTURES_REQUIRED "rocprofsys-global-tmp-files"
)

if(DEFINED _ROCPROFSYS_CI_TIMEOUT)
    math(EXPR _TEST_TIMEOUT "${_ROCPROFSYS_CI_TIMEOUT} + 30")
else()
    set(_TEST_TIMEOUT 330)
endif()

add_test("pthreads-parallel-overhead-locks-runtime-instrument" "${_ROCPROFSYS_EXE}" "${_ROCPROFSYS_EXE_ARGS}" "${_ROCPROFSYS_NODEID_PFX}test_pthread.py::TestPthreads::test_parallel_overhead_locks[runtime_instrument]" ${_ROCPROFSYS_EXTRA_ARGS})
set_tests_properties("pthreads-parallel-overhead-locks-runtime-instrument" PROPERTIES
    LABELS "pthreads;runtime_instrument"
    TIMEOUT ${_TEST_TIMEOUT}
    SKIP_RETURN_CODE 77
    FIXTURES_REQUIRED "rocprofsys-global-tmp-files"
)

if(DEFINED _ROCPROFSYS_CI_TIMEOUT)
    math(EXPR _TEST_TIMEOUT "${_ROCPROFSYS_CI_TIMEOUT} + 30")
else()
    set(_TEST_TIMEOUT 330)
endif()

add_test("pthreads-parallel-overhead-locks-sys-run" "${_ROCPROFSYS_EXE}" "${_ROCPROFSYS_EXE_ARGS}" "${_ROCPROFSYS_NODEID_PFX}test_pthread.py::TestPthreads::test_parallel_overhead_locks[sys_run]" ${_ROCPROFSYS_EXTRA_ARGS})
set_tests_properties("pthreads-parallel-overhead-locks-sys-run" PROPERTIES
    LABELS "pthreads;sys_run"
    TIMEOUT ${_TEST_TIMEOUT}
    SKIP_RETURN_CODE 77
    FIXTURES_REQUIRED "rocprofsys-global-tmp-files"
)

if(DEFINED _ROCPROFSYS_CI_TIMEOUT)
    math(EXPR _TEST_TIMEOUT "${_ROCPROFSYS_CI_TIMEOUT} + 30")
else()
    set(_TEST_TIMEOUT 330)
endif()

add_test("pthreads-parallel-overhead-locks-timemory-baseline" "${_ROCPROFSYS_EXE}" "${_ROCPROFSYS_EXE_ARGS}" "${_ROCPROFSYS_NODEID_PFX}test_pthread.py::TestPthreads::test_parallel_overhead_locks_timemory[baseline]" ${_ROCPROFSYS_EXTRA_ARGS})
set_tests_properties("pthreads-parallel-overhead-locks-timemory-baseline" PROPERTIES
    LABELS "baseline;pthreads"
    TIMEOUT ${_TEST_TIMEOUT}
    SKIP_RETURN_CODE 77
    FIXTURES_REQUIRED "rocprofsys-global-tmp-files"
)

if(DEFINED _ROCPROFSYS_CI_TIMEOUT)
    math(EXPR _TEST_TIMEOUT "${_ROCPROFSYS_CI_TIMEOUT} + 30")
else()
    set(_TEST_TIMEOUT 330)
endif()

add_test("pthreads-parallel-overhead-locks-timemory-sampling" "${_ROCPROFSYS_EXE}" "${_ROCPROFSYS_EXE_ARGS}" "${_ROCPROFSYS_NODEID_PFX}test_pthread.py::TestPthreads::test_parallel_overhead_locks_timemory[sampling]" ${_ROCPROFSYS_EXTRA_ARGS})
set_tests_properties("pthreads-parallel-overhead-locks-timemory-sampling" PROPERTIES
    LABELS "pthreads;sampling"
    TIMEOUT ${_TEST_TIMEOUT}
    SKIP_RETURN_CODE 77
    FIXTURES_REQUIRED "rocprofsys-global-tmp-files"
)

if(DEFINED _ROCPROFSYS_CI_TIMEOUT)
    math(EXPR _TEST_TIMEOUT "${_ROCPROFSYS_CI_TIMEOUT} + 30")
else()
    set(_TEST_TIMEOUT 330)
endif()

add_test("pthreads-parallel-overhead-locks-timemory-binary-rewrite" "${_ROCPROFSYS_EXE}" "${_ROCPROFSYS_EXE_ARGS}" "${_ROCPROFSYS_NODEID_PFX}test_pthread.py::TestPthreads::test_parallel_overhead_locks_timemory[binary_rewrite]" ${_ROCPROFSYS_EXTRA_ARGS})
set_tests_properties("pthreads-parallel-overhead-locks-timemory-binary-rewrite" PROPERTIES
    LABELS "binary_rewrite;pthreads"
    TIMEOUT ${_TEST_TIMEOUT}
    SKIP_RETURN_CODE 77
    FIXTURES_REQUIRED "rocprofsys-global-tmp-files"
)

if(DEFINED _ROCPROFSYS_CI_TIMEOUT)
    math(EXPR _TEST_TIMEOUT "${_ROCPROFSYS_CI_TIMEOUT} + 30")
else()
    set(_TEST_TIMEOUT 330)
endif()

add_test("pthreads-parallel-overhead-locks-timemory-sys-run" "${_ROCPROFSYS_EXE}" "${_ROCPROFSYS_EXE_ARGS}" "${_ROCPROFSYS_NODEID_PFX}test_pthread.py::TestPthreads::test_parallel_overhead_locks_timemory[sys_run]" ${_ROCPROFSYS_EXTRA_ARGS})
set_tests_properties("pthreads-parallel-overhead-locks-timemory-sys-run" PROPERTIES
    LABELS "pthreads;sys_run"
    TIMEOUT ${_TEST_TIMEOUT}
    SKIP_RETURN_CODE 77
    FIXTURES_REQUIRED "rocprofsys-global-tmp-files"
)

if(DEFINED _ROCPROFSYS_CI_TIMEOUT)
    math(EXPR _TEST_TIMEOUT "${_ROCPROFSYS_CI_TIMEOUT} + 30")
else()
    set(_TEST_TIMEOUT 150)
endif()

add_test("python-external-3.10-base" "${_ROCPROFSYS_EXE}" "${_ROCPROFSYS_EXE_ARGS}" "${_ROCPROFSYS_NODEID_PFX}test_python.py::TestPython::test_external[3.10-base]" "--python-versions=3.10" ${_ROCPROFSYS_EXTRA_ARGS})
set_tests_properties("python-external-3.10-base" PROPERTIES
    LABELS "python"
    TIMEOUT ${_TEST_TIMEOUT}
    SKIP_RETURN_CODE 77
    FIXTURES_REQUIRED "rocprofsys-global-tmp-files"
)

if(DEFINED _ROCPROFSYS_CI_TIMEOUT)
    math(EXPR _TEST_TIMEOUT "${_ROCPROFSYS_CI_TIMEOUT} + 30")
else()
    set(_TEST_TIMEOUT 150)
endif()

add_test("python-external-3.10-annotated" "${_ROCPROFSYS_EXE}" "${_ROCPROFSYS_EXE_ARGS}" "${_ROCPROFSYS_NODEID_PFX}test_python.py::TestPython::test_external[3.10-annotated]" "--python-versions=3.10" ${_ROCPROFSYS_EXTRA_ARGS})
set_tests_properties("python-external-3.10-annotated" PROPERTIES
    LABELS "python"
    TIMEOUT ${_TEST_TIMEOUT}
    SKIP_RETURN_CODE 77
    FIXTURES_REQUIRED "rocprofsys-global-tmp-files"
)

if(DEFINED _ROCPROFSYS_CI_TIMEOUT)
    math(EXPR _TEST_TIMEOUT "${_ROCPROFSYS_CI_TIMEOUT} + 30")
else()
    set(_TEST_TIMEOUT 150)
endif()

add_test("python-external-3.10-inefficient" "${_ROCPROFSYS_EXE}" "${_ROCPROFSYS_EXE_ARGS}" "${_ROCPROFSYS_NODEID_PFX}test_python.py::TestPython::test_external[3.10-inefficient]" "--python-versions=3.10" ${_ROCPROFSYS_EXTRA_ARGS})
set_tests_properties("python-external-3.10-inefficient" PROPERTIES
    LABELS "python"
    TIMEOUT ${_TEST_TIMEOUT}
    SKIP_RETURN_CODE 77
    FIXTURES_REQUIRED "rocprofsys-global-tmp-files"
)

if(DEFINED _ROCPROFSYS_CI_TIMEOUT)
    math(EXPR _TEST_TIMEOUT "${_ROCPROFSYS_CI_TIMEOUT} + 30")
else()
    set(_TEST_TIMEOUT 150)
endif()

add_test("python-external-3.10-inefficient-annotated" "${_ROCPROFSYS_EXE}" "${_ROCPROFSYS_EXE_ARGS}" "${_ROCPROFSYS_NODEID_PFX}test_python.py::TestPython::test_external[3.10-inefficient-annotated]" "--python-versions=3.10" ${_ROCPROFSYS_EXTRA_ARGS})
set_tests_properties("python-external-3.10-inefficient-annotated" PROPERTIES
    LABELS "python"
    TIMEOUT ${_TEST_TIMEOUT}
    SKIP_RETURN_CODE 77
    FIXTURES_REQUIRED "rocprofsys-global-tmp-files"
)

if(DEFINED _ROCPROFSYS_CI_TIMEOUT)
    math(EXPR _TEST_TIMEOUT "${_ROCPROFSYS_CI_TIMEOUT} + 30")
else()
    set(_TEST_TIMEOUT 150)
endif()

add_test("python-external-3.11-base" "${_ROCPROFSYS_EXE}" "${_ROCPROFSYS_EXE_ARGS}" "${_ROCPROFSYS_NODEID_PFX}test_python.py::TestPython::test_external[3.11-base]" "--python-versions=3.11" ${_ROCPROFSYS_EXTRA_ARGS})
set_tests_properties("python-external-3.11-base" PROPERTIES
    LABELS "python"
    TIMEOUT ${_TEST_TIMEOUT}
    SKIP_RETURN_CODE 77
    FIXTURES_REQUIRED "rocprofsys-global-tmp-files"
)

if(DEFINED _ROCPROFSYS_CI_TIMEOUT)
    math(EXPR _TEST_TIMEOUT "${_ROCPROFSYS_CI_TIMEOUT} + 30")
else()
    set(_TEST_TIMEOUT 150)
endif()

add_test("python-external-3.11-annotated" "${_ROCPROFSYS_EXE}" "${_ROCPROFSYS_EXE_ARGS}" "${_ROCPROFSYS_NODEID_PFX}test_python.py::TestPython::test_external[3.11-annotated]" "--python-versions=3.11" ${_ROCPROFSYS_EXTRA_ARGS})
set_tests_properties("python-external-3.11-annotated" PROPERTIES
    LABELS "python"
    TIMEOUT ${_TEST_TIMEOUT}
    SKIP_RETURN_CODE 77
    FIXTURES_REQUIRED "rocprofsys-global-tmp-files"
)

if(DEFINED _ROCPROFSYS_CI_TIMEOUT)
    math(EXPR _TEST_TIMEOUT "${_ROCPROFSYS_CI_TIMEOUT} + 30")
else()
    set(_TEST_TIMEOUT 150)
endif()

add_test("python-external-3.11-inefficient" "${_ROCPROFSYS_EXE}" "${_ROCPROFSYS_EXE_ARGS}" "${_ROCPROFSYS_NODEID_PFX}test_python.py::TestPython::test_external[3.11-inefficient]" "--python-versions=3.11" ${_ROCPROFSYS_EXTRA_ARGS})
set_tests_properties("python-external-3.11-inefficient" PROPERTIES
    LABELS "python"
    TIMEOUT ${_TEST_TIMEOUT}
    SKIP_RETURN_CODE 77
    FIXTURES_REQUIRED "rocprofsys-global-tmp-files"
)

if(DEFINED _ROCPROFSYS_CI_TIMEOUT)
    math(EXPR _TEST_TIMEOUT "${_ROCPROFSYS_CI_TIMEOUT} + 30")
else()
    set(_TEST_TIMEOUT 150)
endif()

add_test("python-external-3.11-inefficient-annotated" "${_ROCPROFSYS_EXE}" "${_ROCPROFSYS_EXE_ARGS}" "${_ROCPROFSYS_NODEID_PFX}test_python.py::TestPython::test_external[3.11-inefficient-annotated]" "--python-versions=3.11" ${_ROCPROFSYS_EXTRA_ARGS})
set_tests_properties("python-external-3.11-inefficient-annotated" PROPERTIES
    LABELS "python"
    TIMEOUT ${_TEST_TIMEOUT}
    SKIP_RETURN_CODE 77
    FIXTURES_REQUIRED "rocprofsys-global-tmp-files"
)

if(DEFINED _ROCPROFSYS_CI_TIMEOUT)
    math(EXPR _TEST_TIMEOUT "${_ROCPROFSYS_CI_TIMEOUT} + 30")
else()
    set(_TEST_TIMEOUT 150)
endif()

add_test("python-external-3.12-base" "${_ROCPROFSYS_EXE}" "${_ROCPROFSYS_EXE_ARGS}" "${_ROCPROFSYS_NODEID_PFX}test_python.py::TestPython::test_external[3.12-base]" "--python-versions=3.12" ${_ROCPROFSYS_EXTRA_ARGS})
set_tests_properties("python-external-3.12-base" PROPERTIES
    LABELS "python"
    TIMEOUT ${_TEST_TIMEOUT}
    SKIP_RETURN_CODE 77
    FIXTURES_REQUIRED "rocprofsys-global-tmp-files"
)

if(DEFINED _ROCPROFSYS_CI_TIMEOUT)
    math(EXPR _TEST_TIMEOUT "${_ROCPROFSYS_CI_TIMEOUT} + 30")
else()
    set(_TEST_TIMEOUT 150)
endif()

add_test("python-external-3.12-annotated" "${_ROCPROFSYS_EXE}" "${_ROCPROFSYS_EXE_ARGS}" "${_ROCPROFSYS_NODEID_PFX}test_python.py::TestPython::test_external[3.12-annotated]" "--python-versions=3.12" ${_ROCPROFSYS_EXTRA_ARGS})
set_tests_properties("python-external-3.12-annotated" PROPERTIES
    LABELS "python"
    TIMEOUT ${_TEST_TIMEOUT}
    SKIP_RETURN_CODE 77
    FIXTURES_REQUIRED "rocprofsys-global-tmp-files"
)

if(DEFINED _ROCPROFSYS_CI_TIMEOUT)
    math(EXPR _TEST_TIMEOUT "${_ROCPROFSYS_CI_TIMEOUT} + 30")
else()
    set(_TEST_TIMEOUT 150)
endif()

add_test("python-external-3.12-inefficient" "${_ROCPROFSYS_EXE}" "${_ROCPROFSYS_EXE_ARGS}" "${_ROCPROFSYS_NODEID_PFX}test_python.py::TestPython::test_external[3.12-inefficient]" "--python-versions=3.12" ${_ROCPROFSYS_EXTRA_ARGS})
set_tests_properties("python-external-3.12-inefficient" PROPERTIES
    LABELS "python"
    TIMEOUT ${_TEST_TIMEOUT}
    SKIP_RETURN_CODE 77
    FIXTURES_REQUIRED "rocprofsys-global-tmp-files"
)

if(DEFINED _ROCPROFSYS_CI_TIMEOUT)
    math(EXPR _TEST_TIMEOUT "${_ROCPROFSYS_CI_TIMEOUT} + 30")
else()
    set(_TEST_TIMEOUT 150)
endif()

add_test("python-external-3.12-inefficient-annotated" "${_ROCPROFSYS_EXE}" "${_ROCPROFSYS_EXE_ARGS}" "${_ROCPROFSYS_NODEID_PFX}test_python.py::TestPython::test_external[3.12-inefficient-annotated]" "--python-versions=3.12" ${_ROCPROFSYS_EXTRA_ARGS})
set_tests_properties("python-external-3.12-inefficient-annotated" PROPERTIES
    LABELS "python"
    TIMEOUT ${_TEST_TIMEOUT}
    SKIP_RETURN_CODE 77
    FIXTURES_REQUIRED "rocprofsys-global-tmp-files"
)

if(DEFINED _ROCPROFSYS_CI_TIMEOUT)
    math(EXPR _TEST_TIMEOUT "${_ROCPROFSYS_CI_TIMEOUT} + 30")
else()
    set(_TEST_TIMEOUT 150)
endif()

add_test("python-external-3.13-base" "${_ROCPROFSYS_EXE}" "${_ROCPROFSYS_EXE_ARGS}" "${_ROCPROFSYS_NODEID_PFX}test_python.py::TestPython::test_external[3.13-base]" "--python-versions=3.13" ${_ROCPROFSYS_EXTRA_ARGS})
set_tests_properties("python-external-3.13-base" PROPERTIES
    LABELS "python"
    TIMEOUT ${_TEST_TIMEOUT}
    SKIP_RETURN_CODE 77
    FIXTURES_REQUIRED "rocprofsys-global-tmp-files"
)

if(DEFINED _ROCPROFSYS_CI_TIMEOUT)
    math(EXPR _TEST_TIMEOUT "${_ROCPROFSYS_CI_TIMEOUT} + 30")
else()
    set(_TEST_TIMEOUT 150)
endif()

add_test("python-external-3.13-annotated" "${_ROCPROFSYS_EXE}" "${_ROCPROFSYS_EXE_ARGS}" "${_ROCPROFSYS_NODEID_PFX}test_python.py::TestPython::test_external[3.13-annotated]" "--python-versions=3.13" ${_ROCPROFSYS_EXTRA_ARGS})
set_tests_properties("python-external-3.13-annotated" PROPERTIES
    LABELS "python"
    TIMEOUT ${_TEST_TIMEOUT}
    SKIP_RETURN_CODE 77
    FIXTURES_REQUIRED "rocprofsys-global-tmp-files"
)

if(DEFINED _ROCPROFSYS_CI_TIMEOUT)
    math(EXPR _TEST_TIMEOUT "${_ROCPROFSYS_CI_TIMEOUT} + 30")
else()
    set(_TEST_TIMEOUT 150)
endif()

add_test("python-external-3.13-inefficient" "${_ROCPROFSYS_EXE}" "${_ROCPROFSYS_EXE_ARGS}" "${_ROCPROFSYS_NODEID_PFX}test_python.py::TestPython::test_external[3.13-inefficient]" "--python-versions=3.13" ${_ROCPROFSYS_EXTRA_ARGS})
set_tests_properties("python-external-3.13-inefficient" PROPERTIES
    LABELS "python"
    TIMEOUT ${_TEST_TIMEOUT}
    SKIP_RETURN_CODE 77
    FIXTURES_REQUIRED "rocprofsys-global-tmp-files"
)

if(DEFINED _ROCPROFSYS_CI_TIMEOUT)
    math(EXPR _TEST_TIMEOUT "${_ROCPROFSYS_CI_TIMEOUT} + 30")
else()
    set(_TEST_TIMEOUT 150)
endif()

add_test("python-external-3.13-inefficient-annotated" "${_ROCPROFSYS_EXE}" "${_ROCPROFSYS_EXE_ARGS}" "${_ROCPROFSYS_NODEID_PFX}test_python.py::TestPython::test_external[3.13-inefficient-annotated]" "--python-versions=3.13" ${_ROCPROFSYS_EXTRA_ARGS})
set_tests_properties("python-external-3.13-inefficient-annotated" PROPERTIES
    LABELS "python"
    TIMEOUT ${_TEST_TIMEOUT}
    SKIP_RETURN_CODE 77
    FIXTURES_REQUIRED "rocprofsys-global-tmp-files"
)

if(DEFINED _ROCPROFSYS_CI_TIMEOUT)
    math(EXPR _TEST_TIMEOUT "${_ROCPROFSYS_CI_TIMEOUT} + 30")
else()
    set(_TEST_TIMEOUT 150)
endif()

add_test("python-builtin-3.10-false" "${_ROCPROFSYS_EXE}" "${_ROCPROFSYS_EXE_ARGS}" "${_ROCPROFSYS_NODEID_PFX}test_python.py::TestPython::test_builtin[3.10-False]" "--python-versions=3.10" ${_ROCPROFSYS_EXTRA_ARGS})
set_tests_properties("python-builtin-3.10-false" PROPERTIES
    LABELS "python;rocpd"
    TIMEOUT ${_TEST_TIMEOUT}
    SKIP_RETURN_CODE 77
    FIXTURES_REQUIRED "rocprofsys-global-tmp-files"
)

if(DEFINED _ROCPROFSYS_CI_TIMEOUT)
    math(EXPR _TEST_TIMEOUT "${_ROCPROFSYS_CI_TIMEOUT} + 30")
else()
    set(_TEST_TIMEOUT 150)
endif()

add_test("python-builtin-3.10-annotated" "${_ROCPROFSYS_EXE}" "${_ROCPROFSYS_EXE_ARGS}" "${_ROCPROFSYS_NODEID_PFX}test_python.py::TestPython::test_builtin[3.10-annotated]" "--python-versions=3.10" ${_ROCPROFSYS_EXTRA_ARGS})
set_tests_properties("python-builtin-3.10-annotated" PROPERTIES
    LABELS "python"
    TIMEOUT ${_TEST_TIMEOUT}
    SKIP_RETURN_CODE 77
    FIXTURES_REQUIRED "rocprofsys-global-tmp-files"
)

if(DEFINED _ROCPROFSYS_CI_TIMEOUT)
    math(EXPR _TEST_TIMEOUT "${_ROCPROFSYS_CI_TIMEOUT} + 30")
else()
    set(_TEST_TIMEOUT 150)
endif()

add_test("python-builtin-3.11-false" "${_ROCPROFSYS_EXE}" "${_ROCPROFSYS_EXE_ARGS}" "${_ROCPROFSYS_NODEID_PFX}test_python.py::TestPython::test_builtin[3.11-False]" "--python-versions=3.11" ${_ROCPROFSYS_EXTRA_ARGS})
set_tests_properties("python-builtin-3.11-false" PROPERTIES
    LABELS "python;rocpd"
    TIMEOUT ${_TEST_TIMEOUT}
    SKIP_RETURN_CODE 77
    FIXTURES_REQUIRED "rocprofsys-global-tmp-files"
)

if(DEFINED _ROCPROFSYS_CI_TIMEOUT)
    math(EXPR _TEST_TIMEOUT "${_ROCPROFSYS_CI_TIMEOUT} + 30")
else()
    set(_TEST_TIMEOUT 150)
endif()

add_test("python-builtin-3.11-annotated" "${_ROCPROFSYS_EXE}" "${_ROCPROFSYS_EXE_ARGS}" "${_ROCPROFSYS_NODEID_PFX}test_python.py::TestPython::test_builtin[3.11-annotated]" "--python-versions=3.11" ${_ROCPROFSYS_EXTRA_ARGS})
set_tests_properties("python-builtin-3.11-annotated" PROPERTIES
    LABELS "python"
    TIMEOUT ${_TEST_TIMEOUT}
    SKIP_RETURN_CODE 77
    FIXTURES_REQUIRED "rocprofsys-global-tmp-files"
)

if(DEFINED _ROCPROFSYS_CI_TIMEOUT)
    math(EXPR _TEST_TIMEOUT "${_ROCPROFSYS_CI_TIMEOUT} + 30")
else()
    set(_TEST_TIMEOUT 150)
endif()

add_test("python-builtin-3.12-false" "${_ROCPROFSYS_EXE}" "${_ROCPROFSYS_EXE_ARGS}" "${_ROCPROFSYS_NODEID_PFX}test_python.py::TestPython::test_builtin[3.12-False]" "--python-versions=3.12" ${_ROCPROFSYS_EXTRA_ARGS})
set_tests_properties("python-builtin-3.12-false" PROPERTIES
    LABELS "python;rocpd"
    TIMEOUT ${_TEST_TIMEOUT}
    SKIP_RETURN_CODE 77
    FIXTURES_REQUIRED "rocprofsys-global-tmp-files"
)

if(DEFINED _ROCPROFSYS_CI_TIMEOUT)
    math(EXPR _TEST_TIMEOUT "${_ROCPROFSYS_CI_TIMEOUT} + 30")
else()
    set(_TEST_TIMEOUT 150)
endif()

add_test("python-builtin-3.12-annotated" "${_ROCPROFSYS_EXE}" "${_ROCPROFSYS_EXE_ARGS}" "${_ROCPROFSYS_NODEID_PFX}test_python.py::TestPython::test_builtin[3.12-annotated]" "--python-versions=3.12" ${_ROCPROFSYS_EXTRA_ARGS})
set_tests_properties("python-builtin-3.12-annotated" PROPERTIES
    LABELS "python"
    TIMEOUT ${_TEST_TIMEOUT}
    SKIP_RETURN_CODE 77
    FIXTURES_REQUIRED "rocprofsys-global-tmp-files"
)

if(DEFINED _ROCPROFSYS_CI_TIMEOUT)
    math(EXPR _TEST_TIMEOUT "${_ROCPROFSYS_CI_TIMEOUT} + 30")
else()
    set(_TEST_TIMEOUT 150)
endif()

add_test("python-builtin-3.13-false" "${_ROCPROFSYS_EXE}" "${_ROCPROFSYS_EXE_ARGS}" "${_ROCPROFSYS_NODEID_PFX}test_python.py::TestPython::test_builtin[3.13-False]" "--python-versions=3.13" ${_ROCPROFSYS_EXTRA_ARGS})
set_tests_properties("python-builtin-3.13-false" PROPERTIES
    LABELS "python;rocpd"
    TIMEOUT ${_TEST_TIMEOUT}
    SKIP_RETURN_CODE 77
    FIXTURES_REQUIRED "rocprofsys-global-tmp-files"
)

if(DEFINED _ROCPROFSYS_CI_TIMEOUT)
    math(EXPR _TEST_TIMEOUT "${_ROCPROFSYS_CI_TIMEOUT} + 30")
else()
    set(_TEST_TIMEOUT 150)
endif()

add_test("python-builtin-3.13-annotated" "${_ROCPROFSYS_EXE}" "${_ROCPROFSYS_EXE_ARGS}" "${_ROCPROFSYS_NODEID_PFX}test_python.py::TestPython::test_builtin[3.13-annotated]" "--python-versions=3.13" ${_ROCPROFSYS_EXTRA_ARGS})
set_tests_properties("python-builtin-3.13-annotated" PROPERTIES
    LABELS "python"
    TIMEOUT ${_TEST_TIMEOUT}
    SKIP_RETURN_CODE 77
    FIXTURES_REQUIRED "rocprofsys-global-tmp-files"
)

if(DEFINED _ROCPROFSYS_CI_TIMEOUT)
    math(EXPR _TEST_TIMEOUT "${_ROCPROFSYS_CI_TIMEOUT} + 30")
else()
    set(_TEST_TIMEOUT 150)
endif()

add_test("python-builtin-noprofile-3.10-false" "${_ROCPROFSYS_EXE}" "${_ROCPROFSYS_EXE_ARGS}" "${_ROCPROFSYS_NODEID_PFX}test_python.py::TestPython::test_builtin_noprofile[3.10-False]" "--python-versions=3.10" ${_ROCPROFSYS_EXTRA_ARGS})
set_tests_properties("python-builtin-noprofile-3.10-false" PROPERTIES
    LABELS "python"
    TIMEOUT ${_TEST_TIMEOUT}
    SKIP_RETURN_CODE 77
    FIXTURES_REQUIRED "rocprofsys-global-tmp-files"
)

if(DEFINED _ROCPROFSYS_CI_TIMEOUT)
    math(EXPR _TEST_TIMEOUT "${_ROCPROFSYS_CI_TIMEOUT} + 30")
else()
    set(_TEST_TIMEOUT 150)
endif()

add_test("python-builtin-noprofile-3.10-annotated" "${_ROCPROFSYS_EXE}" "${_ROCPROFSYS_EXE_ARGS}" "${_ROCPROFSYS_NODEID_PFX}test_python.py::TestPython::test_builtin_noprofile[3.10-annotated]" "--python-versions=3.10" ${_ROCPROFSYS_EXTRA_ARGS})
set_tests_properties("python-builtin-noprofile-3.10-annotated" PROPERTIES
    LABELS "python"
    TIMEOUT ${_TEST_TIMEOUT}
    SKIP_RETURN_CODE 77
    FIXTURES_REQUIRED "rocprofsys-global-tmp-files"
)

if(DEFINED _ROCPROFSYS_CI_TIMEOUT)
    math(EXPR _TEST_TIMEOUT "${_ROCPROFSYS_CI_TIMEOUT} + 30")
else()
    set(_TEST_TIMEOUT 150)
endif()

add_test("python-builtin-noprofile-3.11-false" "${_ROCPROFSYS_EXE}" "${_ROCPROFSYS_EXE_ARGS}" "${_ROCPROFSYS_NODEID_PFX}test_python.py::TestPython::test_builtin_noprofile[3.11-False]" "--python-versions=3.11" ${_ROCPROFSYS_EXTRA_ARGS})
set_tests_properties("python-builtin-noprofile-3.11-false" PROPERTIES
    LABELS "python"
    TIMEOUT ${_TEST_TIMEOUT}
    SKIP_RETURN_CODE 77
    FIXTURES_REQUIRED "rocprofsys-global-tmp-files"
)

if(DEFINED _ROCPROFSYS_CI_TIMEOUT)
    math(EXPR _TEST_TIMEOUT "${_ROCPROFSYS_CI_TIMEOUT} + 30")
else()
    set(_TEST_TIMEOUT 150)
endif()

add_test("python-builtin-noprofile-3.11-annotated" "${_ROCPROFSYS_EXE}" "${_ROCPROFSYS_EXE_ARGS}" "${_ROCPROFSYS_NODEID_PFX}test_python.py::TestPython::test_builtin_noprofile[3.11-annotated]" "--python-versions=3.11" ${_ROCPROFSYS_EXTRA_ARGS})
set_tests_properties("python-builtin-noprofile-3.11-annotated" PROPERTIES
    LABELS "python"
    TIMEOUT ${_TEST_TIMEOUT}
    SKIP_RETURN_CODE 77
    FIXTURES_REQUIRED "rocprofsys-global-tmp-files"
)

if(DEFINED _ROCPROFSYS_CI_TIMEOUT)
    math(EXPR _TEST_TIMEOUT "${_ROCPROFSYS_CI_TIMEOUT} + 30")
else()
    set(_TEST_TIMEOUT 150)
endif()

add_test("python-builtin-noprofile-3.12-false" "${_ROCPROFSYS_EXE}" "${_ROCPROFSYS_EXE_ARGS}" "${_ROCPROFSYS_NODEID_PFX}test_python.py::TestPython::test_builtin_noprofile[3.12-False]" "--python-versions=3.12" ${_ROCPROFSYS_EXTRA_ARGS})
set_tests_properties("python-builtin-noprofile-3.12-false" PROPERTIES
    LABELS "python"
    TIMEOUT ${_TEST_TIMEOUT}
    SKIP_RETURN_CODE 77
    FIXTURES_REQUIRED "rocprofsys-global-tmp-files"
)

if(DEFINED _ROCPROFSYS_CI_TIMEOUT)
    math(EXPR _TEST_TIMEOUT "${_ROCPROFSYS_CI_TIMEOUT} + 30")
else()
    set(_TEST_TIMEOUT 150)
endif()

add_test("python-builtin-noprofile-3.12-annotated" "${_ROCPROFSYS_EXE}" "${_ROCPROFSYS_EXE_ARGS}" "${_ROCPROFSYS_NODEID_PFX}test_python.py::TestPython::test_builtin_noprofile[3.12-annotated]" "--python-versions=3.12" ${_ROCPROFSYS_EXTRA_ARGS})
set_tests_properties("python-builtin-noprofile-3.12-annotated" PROPERTIES
    LABELS "python"
    TIMEOUT ${_TEST_TIMEOUT}
    SKIP_RETURN_CODE 77
    FIXTURES_REQUIRED "rocprofsys-global-tmp-files"
)

if(DEFINED _ROCPROFSYS_CI_TIMEOUT)
    math(EXPR _TEST_TIMEOUT "${_ROCPROFSYS_CI_TIMEOUT} + 30")
else()
    set(_TEST_TIMEOUT 150)
endif()

add_test("python-builtin-noprofile-3.13-false" "${_ROCPROFSYS_EXE}" "${_ROCPROFSYS_EXE_ARGS}" "${_ROCPROFSYS_NODEID_PFX}test_python.py::TestPython::test_builtin_noprofile[3.13-False]" "--python-versions=3.13" ${_ROCPROFSYS_EXTRA_ARGS})
set_tests_properties("python-builtin-noprofile-3.13-false" PROPERTIES
    LABELS "python"
    TIMEOUT ${_TEST_TIMEOUT}
    SKIP_RETURN_CODE 77
    FIXTURES_REQUIRED "rocprofsys-global-tmp-files"
)

if(DEFINED _ROCPROFSYS_CI_TIMEOUT)
    math(EXPR _TEST_TIMEOUT "${_ROCPROFSYS_CI_TIMEOUT} + 30")
else()
    set(_TEST_TIMEOUT 150)
endif()

add_test("python-builtin-noprofile-3.13-annotated" "${_ROCPROFSYS_EXE}" "${_ROCPROFSYS_EXE_ARGS}" "${_ROCPROFSYS_NODEID_PFX}test_python.py::TestPython::test_builtin_noprofile[3.13-annotated]" "--python-versions=3.13" ${_ROCPROFSYS_EXTRA_ARGS})
set_tests_properties("python-builtin-noprofile-3.13-annotated" PROPERTIES
    LABELS "python"
    TIMEOUT ${_TEST_TIMEOUT}
    SKIP_RETURN_CODE 77
    FIXTURES_REQUIRED "rocprofsys-global-tmp-files"
)

if(DEFINED _ROCPROFSYS_CI_TIMEOUT)
    math(EXPR _TEST_TIMEOUT "${_ROCPROFSYS_CI_TIMEOUT} + 30")
else()
    set(_TEST_TIMEOUT 330)
endif()

add_test("python-source-3.10" "${_ROCPROFSYS_EXE}" "${_ROCPROFSYS_EXE_ARGS}" "${_ROCPROFSYS_NODEID_PFX}test_python.py::TestPython::test_source[3.10]" "--python-versions=3.10" ${_ROCPROFSYS_EXTRA_ARGS})
set_tests_properties("python-source-3.10" PROPERTIES
    LABELS "python;rocpd"
    TIMEOUT ${_TEST_TIMEOUT}
    SKIP_RETURN_CODE 77
    FIXTURES_REQUIRED "rocprofsys-global-tmp-files"
)

if(DEFINED _ROCPROFSYS_CI_TIMEOUT)
    math(EXPR _TEST_TIMEOUT "${_ROCPROFSYS_CI_TIMEOUT} + 30")
else()
    set(_TEST_TIMEOUT 330)
endif()

add_test("python-source-3.11" "${_ROCPROFSYS_EXE}" "${_ROCPROFSYS_EXE_ARGS}" "${_ROCPROFSYS_NODEID_PFX}test_python.py::TestPython::test_source[3.11]" "--python-versions=3.11" ${_ROCPROFSYS_EXTRA_ARGS})
set_tests_properties("python-source-3.11" PROPERTIES
    LABELS "python;rocpd"
    TIMEOUT ${_TEST_TIMEOUT}
    SKIP_RETURN_CODE 77
    FIXTURES_REQUIRED "rocprofsys-global-tmp-files"
)

if(DEFINED _ROCPROFSYS_CI_TIMEOUT)
    math(EXPR _TEST_TIMEOUT "${_ROCPROFSYS_CI_TIMEOUT} + 30")
else()
    set(_TEST_TIMEOUT 330)
endif()

add_test("python-source-3.12" "${_ROCPROFSYS_EXE}" "${_ROCPROFSYS_EXE_ARGS}" "${_ROCPROFSYS_NODEID_PFX}test_python.py::TestPython::test_source[3.12]" "--python-versions=3.12" ${_ROCPROFSYS_EXTRA_ARGS})
set_tests_properties("python-source-3.12" PROPERTIES
    LABELS "python;rocpd"
    TIMEOUT ${_TEST_TIMEOUT}
    SKIP_RETURN_CODE 77
    FIXTURES_REQUIRED "rocprofsys-global-tmp-files"
)

if(DEFINED _ROCPROFSYS_CI_TIMEOUT)
    math(EXPR _TEST_TIMEOUT "${_ROCPROFSYS_CI_TIMEOUT} + 30")
else()
    set(_TEST_TIMEOUT 330)
endif()

add_test("python-source-3.13" "${_ROCPROFSYS_EXE}" "${_ROCPROFSYS_EXE_ARGS}" "${_ROCPROFSYS_NODEID_PFX}test_python.py::TestPython::test_source[3.13]" "--python-versions=3.13" ${_ROCPROFSYS_EXTRA_ARGS})
set_tests_properties("python-source-3.13" PROPERTIES
    LABELS "python;rocpd"
    TIMEOUT ${_TEST_TIMEOUT}
    SKIP_RETURN_CODE 77
    FIXTURES_REQUIRED "rocprofsys-global-tmp-files"
)

if(DEFINED _ROCPROFSYS_CI_TIMEOUT)
    math(EXPR _TEST_TIMEOUT "${_ROCPROFSYS_CI_TIMEOUT} + 30")
else()
    set(_TEST_TIMEOUT 330)
endif()

add_test("rank-filter-no-filter" "${_ROCPROFSYS_EXE}" "${_ROCPROFSYS_EXE_ARGS}" "${_ROCPROFSYS_NODEID_PFX}test_rank_filter.py::TestRankFilter::test_no_filter[]" ${_ROCPROFSYS_EXTRA_ARGS})
set_tests_properties("rank-filter-no-filter" PROPERTIES
    LABELS "mpi;rank_filter;rocpd;sys_run"
    TIMEOUT ${_TEST_TIMEOUT}
    SKIP_RETURN_CODE 77
    FIXTURES_REQUIRED "rocprofsys-global-tmp-files"
)

if(DEFINED _ROCPROFSYS_CI_TIMEOUT)
    math(EXPR _TEST_TIMEOUT "${_ROCPROFSYS_CI_TIMEOUT} + 30")
else()
    set(_TEST_TIMEOUT 330)
endif()

add_test("rank-filter-no-filter-via-cli" "${_ROCPROFSYS_EXE}" "${_ROCPROFSYS_EXE_ARGS}" "${_ROCPROFSYS_NODEID_PFX}test_rank_filter.py::TestRankFilter::test_no_filter[via_cli]" ${_ROCPROFSYS_EXTRA_ARGS})
set_tests_properties("rank-filter-no-filter-via-cli" PROPERTIES
    LABELS "mpi;rank_filter;rocpd;sys_run"
    TIMEOUT ${_TEST_TIMEOUT}
    SKIP_RETURN_CODE 77
    FIXTURES_REQUIRED "rocprofsys-global-tmp-files"
)

if(DEFINED _ROCPROFSYS_CI_TIMEOUT)
    math(EXPR _TEST_TIMEOUT "${_ROCPROFSYS_CI_TIMEOUT} + 30")
else()
    set(_TEST_TIMEOUT 330)
endif()

add_test("rank-filter-no-filter-via-env" "${_ROCPROFSYS_EXE}" "${_ROCPROFSYS_EXE_ARGS}" "${_ROCPROFSYS_NODEID_PFX}test_rank_filter.py::TestRankFilter::test_no_filter[via_env]" ${_ROCPROFSYS_EXTRA_ARGS})
set_tests_properties("rank-filter-no-filter-via-env" PROPERTIES
    LABELS "mpi;rank_filter;rocpd;sys_run"
    TIMEOUT ${_TEST_TIMEOUT}
    SKIP_RETURN_CODE 77
    FIXTURES_REQUIRED "rocprofsys-global-tmp-files"
)

if(DEFINED _ROCPROFSYS_CI_TIMEOUT)
    math(EXPR _TEST_TIMEOUT "${_ROCPROFSYS_CI_TIMEOUT} + 30")
else()
    set(_TEST_TIMEOUT 330)
endif()

add_test("rank-filter-mixed-env-output-cli-logs" "${_ROCPROFSYS_EXE}" "${_ROCPROFSYS_EXE_ARGS}" "${_ROCPROFSYS_NODEID_PFX}test_rank_filter.py::TestRankFilter::test_mixed_env_output_cli_logs" ${_ROCPROFSYS_EXTRA_ARGS})
set_tests_properties("rank-filter-mixed-env-output-cli-logs" PROPERTIES
    LABELS "mpi;rank_filter;rocpd;sys_run"
    TIMEOUT ${_TEST_TIMEOUT}
    SKIP_RETURN_CODE 77
    FIXTURES_REQUIRED "rocprofsys-global-tmp-files"
)

if(DEFINED _ROCPROFSYS_CI_TIMEOUT)
    math(EXPR _TEST_TIMEOUT "${_ROCPROFSYS_CI_TIMEOUT} + 30")
else()
    set(_TEST_TIMEOUT 330)
endif()

add_test("rank-filter-overlapping-ranges-cli-output-env-logs" "${_ROCPROFSYS_EXE}" "${_ROCPROFSYS_EXE_ARGS}" "${_ROCPROFSYS_NODEID_PFX}test_rank_filter.py::TestRankFilter::test_overlapping_ranges_cli_output_env_logs" ${_ROCPROFSYS_EXTRA_ARGS})
set_tests_properties("rank-filter-overlapping-ranges-cli-output-env-logs" PROPERTIES
    LABELS "mpi;rank_filter;rocpd;sys_run"
    TIMEOUT ${_TEST_TIMEOUT}
    SKIP_RETURN_CODE 77
    FIXTURES_REQUIRED "rocprofsys-global-tmp-files"
)

if(DEFINED _ROCPROFSYS_CI_TIMEOUT)
    math(EXPR _TEST_TIMEOUT "${_ROCPROFSYS_CI_TIMEOUT} + 30")
else()
    set(_TEST_TIMEOUT 330)
endif()

add_test("rank-filter-custom-id-excludes-all" "${_ROCPROFSYS_EXE}" "${_ROCPROFSYS_EXE_ARGS}" "${_ROCPROFSYS_NODEID_PFX}test_rank_filter.py::TestRankFilter::test_custom_id_excludes_all" ${_ROCPROFSYS_EXTRA_ARGS})
set_tests_properties("rank-filter-custom-id-excludes-all" PROPERTIES
    LABELS "mpi;rank_filter;rocpd;sys_run"
    TIMEOUT ${_TEST_TIMEOUT}
    SKIP_RETURN_CODE 77
    FIXTURES_REQUIRED "rocprofsys-global-tmp-files"
)

if(DEFINED _ROCPROFSYS_CI_TIMEOUT)
    math(EXPR _TEST_TIMEOUT "${_ROCPROFSYS_CI_TIMEOUT} + 30")
else()
    set(_TEST_TIMEOUT 330)
endif()

add_test("rank-filter-custom-id-requires-output-or-logs" "${_ROCPROFSYS_EXE}" "${_ROCPROFSYS_EXE_ARGS}" "${_ROCPROFSYS_NODEID_PFX}test_rank_filter.py::TestRankFilter::test_custom_id_requires_output_or_logs" ${_ROCPROFSYS_EXTRA_ARGS})
set_tests_properties("rank-filter-custom-id-requires-output-or-logs" PROPERTIES
    LABELS "mpi;rank_filter;rocpd;sys_run"
    TIMEOUT ${_TEST_TIMEOUT}
    SKIP_RETURN_CODE 77
    FIXTURES_REQUIRED "rocprofsys-global-tmp-files"
)

if(DEFINED _ROCPROFSYS_CI_TIMEOUT)
    math(EXPR _TEST_TIMEOUT "${_ROCPROFSYS_CI_TIMEOUT} + 30")
else()
    set(_TEST_TIMEOUT 330)
endif()

add_test("rccl-all-reduce-perf-sampling" "${_ROCPROFSYS_EXE}" "${_ROCPROFSYS_EXE_ARGS}" "${_ROCPROFSYS_NODEID_PFX}test_rccl.py::TestRCCL::test[all-reduce-perf-sampling]" ${_ROCPROFSYS_EXTRA_ARGS})
set_tests_properties("rccl-all-reduce-perf-sampling" PROPERTIES
    LABELS "gpu;mpi;rccl;sampling"
    TIMEOUT ${_TEST_TIMEOUT}
    SKIP_RETURN_CODE 77
    FIXTURES_REQUIRED "rocprofsys-global-tmp-files"
)

if(DEFINED _ROCPROFSYS_CI_TIMEOUT)
    math(EXPR _TEST_TIMEOUT "${_ROCPROFSYS_CI_TIMEOUT} + 30")
else()
    set(_TEST_TIMEOUT 330)
endif()

add_test("rccl-all-reduce-perf-binary-rewrite" "${_ROCPROFSYS_EXE}" "${_ROCPROFSYS_EXE_ARGS}" "${_ROCPROFSYS_NODEID_PFX}test_rccl.py::TestRCCL::test[all-reduce-perf-binary_rewrite]" ${_ROCPROFSYS_EXTRA_ARGS})
set_tests_properties("rccl-all-reduce-perf-binary-rewrite" PROPERTIES
    LABELS "binary_rewrite;gpu;mpi;rccl"
    TIMEOUT ${_TEST_TIMEOUT}
    SKIP_RETURN_CODE 77
    FIXTURES_REQUIRED "rocprofsys-global-tmp-files"
)

if(DEFINED _ROCPROFSYS_CI_TIMEOUT)
    math(EXPR _TEST_TIMEOUT "${_ROCPROFSYS_CI_TIMEOUT} + 30")
else()
    set(_TEST_TIMEOUT 330)
endif()

add_test("rccl-all-reduce-perf-sys-run" "${_ROCPROFSYS_EXE}" "${_ROCPROFSYS_EXE_ARGS}" "${_ROCPROFSYS_NODEID_PFX}test_rccl.py::TestRCCL::test[all-reduce-perf-sys_run]" ${_ROCPROFSYS_EXTRA_ARGS})
set_tests_properties("rccl-all-reduce-perf-sys-run" PROPERTIES
    LABELS "gpu;mpi;rccl;rocpd;sys_run"
    TIMEOUT ${_TEST_TIMEOUT}
    SKIP_RETURN_CODE 77
    FIXTURES_REQUIRED "rocprofsys-global-tmp-files"
)

if(DEFINED _ROCPROFSYS_CI_TIMEOUT)
    math(EXPR _TEST_TIMEOUT "${_ROCPROFSYS_CI_TIMEOUT} + 30")
else()
    set(_TEST_TIMEOUT 330)
endif()

add_test("rccl-all-reduce-perf-runtime-instrument" "${_ROCPROFSYS_EXE}" "${_ROCPROFSYS_EXE_ARGS}" "${_ROCPROFSYS_NODEID_PFX}test_rccl.py::TestRCCL::test[all-reduce-perf-runtime_instrument]" ${_ROCPROFSYS_EXTRA_ARGS})
set_tests_properties("rccl-all-reduce-perf-runtime-instrument" PROPERTIES
    LABELS "gpu;mpi;rccl;runtime_instrument;slow"
    TIMEOUT ${_TEST_TIMEOUT}
    SKIP_RETURN_CODE 77
    FIXTURES_REQUIRED "rocprofsys-global-tmp-files"
)

if(DEFINED _ROCPROFSYS_CI_TIMEOUT)
    math(EXPR _TEST_TIMEOUT "${_ROCPROFSYS_CI_TIMEOUT} + 30")
else()
    set(_TEST_TIMEOUT 330)
endif()

add_test("rccl-all-gather-perf-sampling" "${_ROCPROFSYS_EXE}" "${_ROCPROFSYS_EXE_ARGS}" "${_ROCPROFSYS_NODEID_PFX}test_rccl.py::TestRCCL::test[all-gather-perf-sampling]" ${_ROCPROFSYS_EXTRA_ARGS})
set_tests_properties("rccl-all-gather-perf-sampling" PROPERTIES
    LABELS "gpu;mpi;rccl;sampling"
    TIMEOUT ${_TEST_TIMEOUT}
    SKIP_RETURN_CODE 77
    FIXTURES_REQUIRED "rocprofsys-global-tmp-files"
)

if(DEFINED _ROCPROFSYS_CI_TIMEOUT)
    math(EXPR _TEST_TIMEOUT "${_ROCPROFSYS_CI_TIMEOUT} + 30")
else()
    set(_TEST_TIMEOUT 330)
endif()

add_test("rccl-all-gather-perf-binary-rewrite" "${_ROCPROFSYS_EXE}" "${_ROCPROFSYS_EXE_ARGS}" "${_ROCPROFSYS_NODEID_PFX}test_rccl.py::TestRCCL::test[all-gather-perf-binary_rewrite]" ${_ROCPROFSYS_EXTRA_ARGS})
set_tests_properties("rccl-all-gather-perf-binary-rewrite" PROPERTIES
    LABELS "binary_rewrite;gpu;mpi;rccl"
    TIMEOUT ${_TEST_TIMEOUT}
    SKIP_RETURN_CODE 77
    FIXTURES_REQUIRED "rocprofsys-global-tmp-files"
)

if(DEFINED _ROCPROFSYS_CI_TIMEOUT)
    math(EXPR _TEST_TIMEOUT "${_ROCPROFSYS_CI_TIMEOUT} + 30")
else()
    set(_TEST_TIMEOUT 330)
endif()

add_test("rccl-all-gather-perf-sys-run" "${_ROCPROFSYS_EXE}" "${_ROCPROFSYS_EXE_ARGS}" "${_ROCPROFSYS_NODEID_PFX}test_rccl.py::TestRCCL::test[all-gather-perf-sys_run]" ${_ROCPROFSYS_EXTRA_ARGS})
set_tests_properties("rccl-all-gather-perf-sys-run" PROPERTIES
    LABELS "gpu;mpi;rccl;rocpd;sys_run"
    TIMEOUT ${_TEST_TIMEOUT}
    SKIP_RETURN_CODE 77
    FIXTURES_REQUIRED "rocprofsys-global-tmp-files"
)

if(DEFINED _ROCPROFSYS_CI_TIMEOUT)
    math(EXPR _TEST_TIMEOUT "${_ROCPROFSYS_CI_TIMEOUT} + 30")
else()
    set(_TEST_TIMEOUT 330)
endif()

add_test("rccl-all-gather-perf-runtime-instrument" "${_ROCPROFSYS_EXE}" "${_ROCPROFSYS_EXE_ARGS}" "${_ROCPROFSYS_NODEID_PFX}test_rccl.py::TestRCCL::test[all-gather-perf-runtime_instrument]" ${_ROCPROFSYS_EXTRA_ARGS})
set_tests_properties("rccl-all-gather-perf-runtime-instrument" PROPERTIES
    LABELS "gpu;mpi;rccl;runtime_instrument;slow"
    TIMEOUT ${_TEST_TIMEOUT}
    SKIP_RETURN_CODE 77
    FIXTURES_REQUIRED "rocprofsys-global-tmp-files"
)

if(DEFINED _ROCPROFSYS_CI_TIMEOUT)
    math(EXPR _TEST_TIMEOUT "${_ROCPROFSYS_CI_TIMEOUT} + 30")
else()
    set(_TEST_TIMEOUT 330)
endif()

add_test("rccl-broadcast-perf-sampling" "${_ROCPROFSYS_EXE}" "${_ROCPROFSYS_EXE_ARGS}" "${_ROCPROFSYS_NODEID_PFX}test_rccl.py::TestRCCL::test[broadcast-perf-sampling]" ${_ROCPROFSYS_EXTRA_ARGS})
set_tests_properties("rccl-broadcast-perf-sampling" PROPERTIES
    LABELS "gpu;mpi;rccl;sampling"
    TIMEOUT ${_TEST_TIMEOUT}
    SKIP_RETURN_CODE 77
    FIXTURES_REQUIRED "rocprofsys-global-tmp-files"
)

if(DEFINED _ROCPROFSYS_CI_TIMEOUT)
    math(EXPR _TEST_TIMEOUT "${_ROCPROFSYS_CI_TIMEOUT} + 30")
else()
    set(_TEST_TIMEOUT 330)
endif()

add_test("rccl-broadcast-perf-binary-rewrite" "${_ROCPROFSYS_EXE}" "${_ROCPROFSYS_EXE_ARGS}" "${_ROCPROFSYS_NODEID_PFX}test_rccl.py::TestRCCL::test[broadcast-perf-binary_rewrite]" ${_ROCPROFSYS_EXTRA_ARGS})
set_tests_properties("rccl-broadcast-perf-binary-rewrite" PROPERTIES
    LABELS "binary_rewrite;gpu;mpi;rccl"
    TIMEOUT ${_TEST_TIMEOUT}
    SKIP_RETURN_CODE 77
    FIXTURES_REQUIRED "rocprofsys-global-tmp-files"
)

if(DEFINED _ROCPROFSYS_CI_TIMEOUT)
    math(EXPR _TEST_TIMEOUT "${_ROCPROFSYS_CI_TIMEOUT} + 30")
else()
    set(_TEST_TIMEOUT 330)
endif()

add_test("rccl-broadcast-perf-sys-run" "${_ROCPROFSYS_EXE}" "${_ROCPROFSYS_EXE_ARGS}" "${_ROCPROFSYS_NODEID_PFX}test_rccl.py::TestRCCL::test[broadcast-perf-sys_run]" ${_ROCPROFSYS_EXTRA_ARGS})
set_tests_properties("rccl-broadcast-perf-sys-run" PROPERTIES
    LABELS "gpu;mpi;rccl;rocpd;sys_run"
    TIMEOUT ${_TEST_TIMEOUT}
    SKIP_RETURN_CODE 77
    FIXTURES_REQUIRED "rocprofsys-global-tmp-files"
)

if(DEFINED _ROCPROFSYS_CI_TIMEOUT)
    math(EXPR _TEST_TIMEOUT "${_ROCPROFSYS_CI_TIMEOUT} + 30")
else()
    set(_TEST_TIMEOUT 330)
endif()

add_test("rccl-broadcast-perf-runtime-instrument" "${_ROCPROFSYS_EXE}" "${_ROCPROFSYS_EXE_ARGS}" "${_ROCPROFSYS_NODEID_PFX}test_rccl.py::TestRCCL::test[broadcast-perf-runtime_instrument]" ${_ROCPROFSYS_EXTRA_ARGS})
set_tests_properties("rccl-broadcast-perf-runtime-instrument" PROPERTIES
    LABELS "gpu;mpi;rccl;runtime_instrument;slow"
    TIMEOUT ${_TEST_TIMEOUT}
    SKIP_RETURN_CODE 77
    FIXTURES_REQUIRED "rocprofsys-global-tmp-files"
)

if(DEFINED _ROCPROFSYS_CI_TIMEOUT)
    math(EXPR _TEST_TIMEOUT "${_ROCPROFSYS_CI_TIMEOUT} + 30")
else()
    set(_TEST_TIMEOUT 330)
endif()

add_test("rccl-reduce-scatter-perf-sampling" "${_ROCPROFSYS_EXE}" "${_ROCPROFSYS_EXE_ARGS}" "${_ROCPROFSYS_NODEID_PFX}test_rccl.py::TestRCCL::test[reduce-scatter-perf-sampling]" ${_ROCPROFSYS_EXTRA_ARGS})
set_tests_properties("rccl-reduce-scatter-perf-sampling" PROPERTIES
    LABELS "gpu;mpi;rccl;sampling"
    TIMEOUT ${_TEST_TIMEOUT}
    SKIP_RETURN_CODE 77
    FIXTURES_REQUIRED "rocprofsys-global-tmp-files"
)

if(DEFINED _ROCPROFSYS_CI_TIMEOUT)
    math(EXPR _TEST_TIMEOUT "${_ROCPROFSYS_CI_TIMEOUT} + 30")
else()
    set(_TEST_TIMEOUT 330)
endif()

add_test("rccl-reduce-scatter-perf-binary-rewrite" "${_ROCPROFSYS_EXE}" "${_ROCPROFSYS_EXE_ARGS}" "${_ROCPROFSYS_NODEID_PFX}test_rccl.py::TestRCCL::test[reduce-scatter-perf-binary_rewrite]" ${_ROCPROFSYS_EXTRA_ARGS})
set_tests_properties("rccl-reduce-scatter-perf-binary-rewrite" PROPERTIES
    LABELS "binary_rewrite;gpu;mpi;rccl"
    TIMEOUT ${_TEST_TIMEOUT}
    SKIP_RETURN_CODE 77
    FIXTURES_REQUIRED "rocprofsys-global-tmp-files"
)

if(DEFINED _ROCPROFSYS_CI_TIMEOUT)
    math(EXPR _TEST_TIMEOUT "${_ROCPROFSYS_CI_TIMEOUT} + 30")
else()
    set(_TEST_TIMEOUT 330)
endif()

add_test("rccl-reduce-scatter-perf-sys-run" "${_ROCPROFSYS_EXE}" "${_ROCPROFSYS_EXE_ARGS}" "${_ROCPROFSYS_NODEID_PFX}test_rccl.py::TestRCCL::test[reduce-scatter-perf-sys_run]" ${_ROCPROFSYS_EXTRA_ARGS})
set_tests_properties("rccl-reduce-scatter-perf-sys-run" PROPERTIES
    LABELS "gpu;mpi;rccl;rocpd;sys_run"
    TIMEOUT ${_TEST_TIMEOUT}
    SKIP_RETURN_CODE 77
    FIXTURES_REQUIRED "rocprofsys-global-tmp-files"
)

if(DEFINED _ROCPROFSYS_CI_TIMEOUT)
    math(EXPR _TEST_TIMEOUT "${_ROCPROFSYS_CI_TIMEOUT} + 30")
else()
    set(_TEST_TIMEOUT 330)
endif()

add_test("rccl-reduce-scatter-perf-runtime-instrument" "${_ROCPROFSYS_EXE}" "${_ROCPROFSYS_EXE_ARGS}" "${_ROCPROFSYS_NODEID_PFX}test_rccl.py::TestRCCL::test[reduce-scatter-perf-runtime_instrument]" ${_ROCPROFSYS_EXTRA_ARGS})
set_tests_properties("rccl-reduce-scatter-perf-runtime-instrument" PROPERTIES
    LABELS "gpu;mpi;rccl;runtime_instrument;slow"
    TIMEOUT ${_TEST_TIMEOUT}
    SKIP_RETURN_CODE 77
    FIXTURES_REQUIRED "rocprofsys-global-tmp-files"
)

if(DEFINED _ROCPROFSYS_CI_TIMEOUT)
    math(EXPR _TEST_TIMEOUT "${_ROCPROFSYS_CI_TIMEOUT} + 30")
else()
    set(_TEST_TIMEOUT 330)
endif()

add_test("rccl-reduce-perf-sampling" "${_ROCPROFSYS_EXE}" "${_ROCPROFSYS_EXE_ARGS}" "${_ROCPROFSYS_NODEID_PFX}test_rccl.py::TestRCCL::test[reduce-perf-sampling]" ${_ROCPROFSYS_EXTRA_ARGS})
set_tests_properties("rccl-reduce-perf-sampling" PROPERTIES
    LABELS "gpu;mpi;rccl;sampling"
    TIMEOUT ${_TEST_TIMEOUT}
    SKIP_RETURN_CODE 77
    FIXTURES_REQUIRED "rocprofsys-global-tmp-files"
)

if(DEFINED _ROCPROFSYS_CI_TIMEOUT)
    math(EXPR _TEST_TIMEOUT "${_ROCPROFSYS_CI_TIMEOUT} + 30")
else()
    set(_TEST_TIMEOUT 330)
endif()

add_test("rccl-reduce-perf-binary-rewrite" "${_ROCPROFSYS_EXE}" "${_ROCPROFSYS_EXE_ARGS}" "${_ROCPROFSYS_NODEID_PFX}test_rccl.py::TestRCCL::test[reduce-perf-binary_rewrite]" ${_ROCPROFSYS_EXTRA_ARGS})
set_tests_properties("rccl-reduce-perf-binary-rewrite" PROPERTIES
    LABELS "binary_rewrite;gpu;mpi;rccl"
    TIMEOUT ${_TEST_TIMEOUT}
    SKIP_RETURN_CODE 77
    FIXTURES_REQUIRED "rocprofsys-global-tmp-files"
)

if(DEFINED _ROCPROFSYS_CI_TIMEOUT)
    math(EXPR _TEST_TIMEOUT "${_ROCPROFSYS_CI_TIMEOUT} + 30")
else()
    set(_TEST_TIMEOUT 330)
endif()

add_test("rccl-reduce-perf-sys-run" "${_ROCPROFSYS_EXE}" "${_ROCPROFSYS_EXE_ARGS}" "${_ROCPROFSYS_NODEID_PFX}test_rccl.py::TestRCCL::test[reduce-perf-sys_run]" ${_ROCPROFSYS_EXTRA_ARGS})
set_tests_properties("rccl-reduce-perf-sys-run" PROPERTIES
    LABELS "gpu;mpi;rccl;rocpd;sys_run"
    TIMEOUT ${_TEST_TIMEOUT}
    SKIP_RETURN_CODE 77
    FIXTURES_REQUIRED "rocprofsys-global-tmp-files"
)

if(DEFINED _ROCPROFSYS_CI_TIMEOUT)
    math(EXPR _TEST_TIMEOUT "${_ROCPROFSYS_CI_TIMEOUT} + 30")
else()
    set(_TEST_TIMEOUT 330)
endif()

add_test("rccl-reduce-perf-runtime-instrument" "${_ROCPROFSYS_EXE}" "${_ROCPROFSYS_EXE_ARGS}" "${_ROCPROFSYS_NODEID_PFX}test_rccl.py::TestRCCL::test[reduce-perf-runtime_instrument]" ${_ROCPROFSYS_EXTRA_ARGS})
set_tests_properties("rccl-reduce-perf-runtime-instrument" PROPERTIES
    LABELS "gpu;mpi;rccl;runtime_instrument;slow"
    TIMEOUT ${_TEST_TIMEOUT}
    SKIP_RETURN_CODE 77
    FIXTURES_REQUIRED "rocprofsys-global-tmp-files"
)

if(DEFINED _ROCPROFSYS_CI_TIMEOUT)
    math(EXPR _TEST_TIMEOUT "${_ROCPROFSYS_CI_TIMEOUT} + 30")
else()
    set(_TEST_TIMEOUT 330)
endif()

add_test("rccl-alltoall-perf-sampling" "${_ROCPROFSYS_EXE}" "${_ROCPROFSYS_EXE_ARGS}" "${_ROCPROFSYS_NODEID_PFX}test_rccl.py::TestRCCL::test[alltoall-perf-sampling]" ${_ROCPROFSYS_EXTRA_ARGS})
set_tests_properties("rccl-alltoall-perf-sampling" PROPERTIES
    LABELS "gpu;mpi;rccl;sampling"
    TIMEOUT ${_TEST_TIMEOUT}
    SKIP_RETURN_CODE 77
    FIXTURES_REQUIRED "rocprofsys-global-tmp-files"
)

if(DEFINED _ROCPROFSYS_CI_TIMEOUT)
    math(EXPR _TEST_TIMEOUT "${_ROCPROFSYS_CI_TIMEOUT} + 30")
else()
    set(_TEST_TIMEOUT 330)
endif()

add_test("rccl-alltoall-perf-binary-rewrite" "${_ROCPROFSYS_EXE}" "${_ROCPROFSYS_EXE_ARGS}" "${_ROCPROFSYS_NODEID_PFX}test_rccl.py::TestRCCL::test[alltoall-perf-binary_rewrite]" ${_ROCPROFSYS_EXTRA_ARGS})
set_tests_properties("rccl-alltoall-perf-binary-rewrite" PROPERTIES
    LABELS "binary_rewrite;gpu;mpi;rccl"
    TIMEOUT ${_TEST_TIMEOUT}
    SKIP_RETURN_CODE 77
    FIXTURES_REQUIRED "rocprofsys-global-tmp-files"
)

if(DEFINED _ROCPROFSYS_CI_TIMEOUT)
    math(EXPR _TEST_TIMEOUT "${_ROCPROFSYS_CI_TIMEOUT} + 30")
else()
    set(_TEST_TIMEOUT 330)
endif()

add_test("rccl-alltoall-perf-sys-run" "${_ROCPROFSYS_EXE}" "${_ROCPROFSYS_EXE_ARGS}" "${_ROCPROFSYS_NODEID_PFX}test_rccl.py::TestRCCL::test[alltoall-perf-sys_run]" ${_ROCPROFSYS_EXTRA_ARGS})
set_tests_properties("rccl-alltoall-perf-sys-run" PROPERTIES
    LABELS "gpu;mpi;rccl;rocpd;sys_run"
    TIMEOUT ${_TEST_TIMEOUT}
    SKIP_RETURN_CODE 77
    FIXTURES_REQUIRED "rocprofsys-global-tmp-files"
)

if(DEFINED _ROCPROFSYS_CI_TIMEOUT)
    math(EXPR _TEST_TIMEOUT "${_ROCPROFSYS_CI_TIMEOUT} + 30")
else()
    set(_TEST_TIMEOUT 330)
endif()

add_test("rccl-alltoall-perf-runtime-instrument" "${_ROCPROFSYS_EXE}" "${_ROCPROFSYS_EXE_ARGS}" "${_ROCPROFSYS_NODEID_PFX}test_rccl.py::TestRCCL::test[alltoall-perf-runtime_instrument]" ${_ROCPROFSYS_EXTRA_ARGS})
set_tests_properties("rccl-alltoall-perf-runtime-instrument" PROPERTIES
    LABELS "gpu;mpi;rccl;runtime_instrument;slow"
    TIMEOUT ${_TEST_TIMEOUT}
    SKIP_RETURN_CODE 77
    FIXTURES_REQUIRED "rocprofsys-global-tmp-files"
)

if(DEFINED _ROCPROFSYS_CI_TIMEOUT)
    math(EXPR _TEST_TIMEOUT "${_ROCPROFSYS_CI_TIMEOUT} + 30")
else()
    set(_TEST_TIMEOUT 330)
endif()

add_test("rccl-scatter-perf-sampling" "${_ROCPROFSYS_EXE}" "${_ROCPROFSYS_EXE_ARGS}" "${_ROCPROFSYS_NODEID_PFX}test_rccl.py::TestRCCL::test[scatter-perf-sampling]" ${_ROCPROFSYS_EXTRA_ARGS})
set_tests_properties("rccl-scatter-perf-sampling" PROPERTIES
    LABELS "gpu;mpi;rccl;sampling"
    TIMEOUT ${_TEST_TIMEOUT}
    SKIP_RETURN_CODE 77
    FIXTURES_REQUIRED "rocprofsys-global-tmp-files"
)

if(DEFINED _ROCPROFSYS_CI_TIMEOUT)
    math(EXPR _TEST_TIMEOUT "${_ROCPROFSYS_CI_TIMEOUT} + 30")
else()
    set(_TEST_TIMEOUT 330)
endif()

add_test("rccl-scatter-perf-binary-rewrite" "${_ROCPROFSYS_EXE}" "${_ROCPROFSYS_EXE_ARGS}" "${_ROCPROFSYS_NODEID_PFX}test_rccl.py::TestRCCL::test[scatter-perf-binary_rewrite]" ${_ROCPROFSYS_EXTRA_ARGS})
set_tests_properties("rccl-scatter-perf-binary-rewrite" PROPERTIES
    LABELS "binary_rewrite;gpu;mpi;rccl"
    TIMEOUT ${_TEST_TIMEOUT}
    SKIP_RETURN_CODE 77
    FIXTURES_REQUIRED "rocprofsys-global-tmp-files"
)

if(DEFINED _ROCPROFSYS_CI_TIMEOUT)
    math(EXPR _TEST_TIMEOUT "${_ROCPROFSYS_CI_TIMEOUT} + 30")
else()
    set(_TEST_TIMEOUT 330)
endif()

add_test("rccl-scatter-perf-sys-run" "${_ROCPROFSYS_EXE}" "${_ROCPROFSYS_EXE_ARGS}" "${_ROCPROFSYS_NODEID_PFX}test_rccl.py::TestRCCL::test[scatter-perf-sys_run]" ${_ROCPROFSYS_EXTRA_ARGS})
set_tests_properties("rccl-scatter-perf-sys-run" PROPERTIES
    LABELS "gpu;mpi;rccl;rocpd;sys_run"
    TIMEOUT ${_TEST_TIMEOUT}
    SKIP_RETURN_CODE 77
    FIXTURES_REQUIRED "rocprofsys-global-tmp-files"
)

if(DEFINED _ROCPROFSYS_CI_TIMEOUT)
    math(EXPR _TEST_TIMEOUT "${_ROCPROFSYS_CI_TIMEOUT} + 30")
else()
    set(_TEST_TIMEOUT 330)
endif()

add_test("rccl-scatter-perf-runtime-instrument" "${_ROCPROFSYS_EXE}" "${_ROCPROFSYS_EXE_ARGS}" "${_ROCPROFSYS_NODEID_PFX}test_rccl.py::TestRCCL::test[scatter-perf-runtime_instrument]" ${_ROCPROFSYS_EXTRA_ARGS})
set_tests_properties("rccl-scatter-perf-runtime-instrument" PROPERTIES
    LABELS "gpu;mpi;rccl;runtime_instrument;slow"
    TIMEOUT ${_TEST_TIMEOUT}
    SKIP_RETURN_CODE 77
    FIXTURES_REQUIRED "rocprofsys-global-tmp-files"
)

if(DEFINED _ROCPROFSYS_CI_TIMEOUT)
    math(EXPR _TEST_TIMEOUT "${_ROCPROFSYS_CI_TIMEOUT} + 30")
else()
    set(_TEST_TIMEOUT 330)
endif()

add_test("rccl-gather-perf-sampling" "${_ROCPROFSYS_EXE}" "${_ROCPROFSYS_EXE_ARGS}" "${_ROCPROFSYS_NODEID_PFX}test_rccl.py::TestRCCL::test[gather-perf-sampling]" ${_ROCPROFSYS_EXTRA_ARGS})
set_tests_properties("rccl-gather-perf-sampling" PROPERTIES
    LABELS "gpu;mpi;rccl;sampling"
    TIMEOUT ${_TEST_TIMEOUT}
    SKIP_RETURN_CODE 77
    FIXTURES_REQUIRED "rocprofsys-global-tmp-files"
)

if(DEFINED _ROCPROFSYS_CI_TIMEOUT)
    math(EXPR _TEST_TIMEOUT "${_ROCPROFSYS_CI_TIMEOUT} + 30")
else()
    set(_TEST_TIMEOUT 330)
endif()

add_test("rccl-gather-perf-binary-rewrite" "${_ROCPROFSYS_EXE}" "${_ROCPROFSYS_EXE_ARGS}" "${_ROCPROFSYS_NODEID_PFX}test_rccl.py::TestRCCL::test[gather-perf-binary_rewrite]" ${_ROCPROFSYS_EXTRA_ARGS})
set_tests_properties("rccl-gather-perf-binary-rewrite" PROPERTIES
    LABELS "binary_rewrite;gpu;mpi;rccl"
    TIMEOUT ${_TEST_TIMEOUT}
    SKIP_RETURN_CODE 77
    FIXTURES_REQUIRED "rocprofsys-global-tmp-files"
)

if(DEFINED _ROCPROFSYS_CI_TIMEOUT)
    math(EXPR _TEST_TIMEOUT "${_ROCPROFSYS_CI_TIMEOUT} + 30")
else()
    set(_TEST_TIMEOUT 330)
endif()

add_test("rccl-gather-perf-sys-run" "${_ROCPROFSYS_EXE}" "${_ROCPROFSYS_EXE_ARGS}" "${_ROCPROFSYS_NODEID_PFX}test_rccl.py::TestRCCL::test[gather-perf-sys_run]" ${_ROCPROFSYS_EXTRA_ARGS})
set_tests_properties("rccl-gather-perf-sys-run" PROPERTIES
    LABELS "gpu;mpi;rccl;rocpd;sys_run"
    TIMEOUT ${_TEST_TIMEOUT}
    SKIP_RETURN_CODE 77
    FIXTURES_REQUIRED "rocprofsys-global-tmp-files"
)

if(DEFINED _ROCPROFSYS_CI_TIMEOUT)
    math(EXPR _TEST_TIMEOUT "${_ROCPROFSYS_CI_TIMEOUT} + 30")
else()
    set(_TEST_TIMEOUT 330)
endif()

add_test("rccl-gather-perf-runtime-instrument" "${_ROCPROFSYS_EXE}" "${_ROCPROFSYS_EXE_ARGS}" "${_ROCPROFSYS_NODEID_PFX}test_rccl.py::TestRCCL::test[gather-perf-runtime_instrument]" ${_ROCPROFSYS_EXTRA_ARGS})
set_tests_properties("rccl-gather-perf-runtime-instrument" PROPERTIES
    LABELS "gpu;mpi;rccl;runtime_instrument;slow"
    TIMEOUT ${_TEST_TIMEOUT}
    SKIP_RETURN_CODE 77
    FIXTURES_REQUIRED "rocprofsys-global-tmp-files"
)

if(DEFINED _ROCPROFSYS_CI_TIMEOUT)
    math(EXPR _TEST_TIMEOUT "${_ROCPROFSYS_CI_TIMEOUT} + 30")
else()
    set(_TEST_TIMEOUT 330)
endif()

add_test("rccl-sendrecv-perf-sampling" "${_ROCPROFSYS_EXE}" "${_ROCPROFSYS_EXE_ARGS}" "${_ROCPROFSYS_NODEID_PFX}test_rccl.py::TestRCCL::test[sendrecv-perf-sampling]" ${_ROCPROFSYS_EXTRA_ARGS})
set_tests_properties("rccl-sendrecv-perf-sampling" PROPERTIES
    LABELS "gpu;mpi;rccl;sampling"
    TIMEOUT ${_TEST_TIMEOUT}
    SKIP_RETURN_CODE 77
    FIXTURES_REQUIRED "rocprofsys-global-tmp-files"
)

if(DEFINED _ROCPROFSYS_CI_TIMEOUT)
    math(EXPR _TEST_TIMEOUT "${_ROCPROFSYS_CI_TIMEOUT} + 30")
else()
    set(_TEST_TIMEOUT 330)
endif()

add_test("rccl-sendrecv-perf-binary-rewrite" "${_ROCPROFSYS_EXE}" "${_ROCPROFSYS_EXE_ARGS}" "${_ROCPROFSYS_NODEID_PFX}test_rccl.py::TestRCCL::test[sendrecv-perf-binary_rewrite]" ${_ROCPROFSYS_EXTRA_ARGS})
set_tests_properties("rccl-sendrecv-perf-binary-rewrite" PROPERTIES
    LABELS "binary_rewrite;gpu;mpi;rccl"
    TIMEOUT ${_TEST_TIMEOUT}
    SKIP_RETURN_CODE 77
    FIXTURES_REQUIRED "rocprofsys-global-tmp-files"
)

if(DEFINED _ROCPROFSYS_CI_TIMEOUT)
    math(EXPR _TEST_TIMEOUT "${_ROCPROFSYS_CI_TIMEOUT} + 30")
else()
    set(_TEST_TIMEOUT 330)
endif()

add_test("rccl-sendrecv-perf-sys-run" "${_ROCPROFSYS_EXE}" "${_ROCPROFSYS_EXE_ARGS}" "${_ROCPROFSYS_NODEID_PFX}test_rccl.py::TestRCCL::test[sendrecv-perf-sys_run]" ${_ROCPROFSYS_EXTRA_ARGS})
set_tests_properties("rccl-sendrecv-perf-sys-run" PROPERTIES
    LABELS "gpu;mpi;rccl;rocpd;sys_run"
    TIMEOUT ${_TEST_TIMEOUT}
    SKIP_RETURN_CODE 77
    FIXTURES_REQUIRED "rocprofsys-global-tmp-files"
)

if(DEFINED _ROCPROFSYS_CI_TIMEOUT)
    math(EXPR _TEST_TIMEOUT "${_ROCPROFSYS_CI_TIMEOUT} + 30")
else()
    set(_TEST_TIMEOUT 330)
endif()

add_test("rccl-sendrecv-perf-runtime-instrument" "${_ROCPROFSYS_EXE}" "${_ROCPROFSYS_EXE_ARGS}" "${_ROCPROFSYS_NODEID_PFX}test_rccl.py::TestRCCL::test[sendrecv-perf-runtime_instrument]" ${_ROCPROFSYS_EXTRA_ARGS})
set_tests_properties("rccl-sendrecv-perf-runtime-instrument" PROPERTIES
    LABELS "gpu;mpi;rccl;runtime_instrument;slow"
    TIMEOUT ${_TEST_TIMEOUT}
    SKIP_RETURN_CODE 77
    FIXTURES_REQUIRED "rocprofsys-global-tmp-files"
)

if(DEFINED _ROCPROFSYS_CI_TIMEOUT)
    math(EXPR _TEST_TIMEOUT "${_ROCPROFSYS_CI_TIMEOUT} + 30")
else()
    set(_TEST_TIMEOUT 330)
endif()

add_test("rccl-alltoallv-perf-sampling" "${_ROCPROFSYS_EXE}" "${_ROCPROFSYS_EXE_ARGS}" "${_ROCPROFSYS_NODEID_PFX}test_rccl.py::TestRCCL::test[alltoallv-perf-sampling]" ${_ROCPROFSYS_EXTRA_ARGS})
set_tests_properties("rccl-alltoallv-perf-sampling" PROPERTIES
    LABELS "gpu;mpi;rccl;sampling"
    TIMEOUT ${_TEST_TIMEOUT}
    SKIP_RETURN_CODE 77
    FIXTURES_REQUIRED "rocprofsys-global-tmp-files"
)

if(DEFINED _ROCPROFSYS_CI_TIMEOUT)
    math(EXPR _TEST_TIMEOUT "${_ROCPROFSYS_CI_TIMEOUT} + 30")
else()
    set(_TEST_TIMEOUT 330)
endif()

add_test("rccl-alltoallv-perf-binary-rewrite" "${_ROCPROFSYS_EXE}" "${_ROCPROFSYS_EXE_ARGS}" "${_ROCPROFSYS_NODEID_PFX}test_rccl.py::TestRCCL::test[alltoallv-perf-binary_rewrite]" ${_ROCPROFSYS_EXTRA_ARGS})
set_tests_properties("rccl-alltoallv-perf-binary-rewrite" PROPERTIES
    LABELS "binary_rewrite;gpu;mpi;rccl"
    TIMEOUT ${_TEST_TIMEOUT}
    SKIP_RETURN_CODE 77
    FIXTURES_REQUIRED "rocprofsys-global-tmp-files"
)

if(DEFINED _ROCPROFSYS_CI_TIMEOUT)
    math(EXPR _TEST_TIMEOUT "${_ROCPROFSYS_CI_TIMEOUT} + 30")
else()
    set(_TEST_TIMEOUT 330)
endif()

add_test("rccl-alltoallv-perf-sys-run" "${_ROCPROFSYS_EXE}" "${_ROCPROFSYS_EXE_ARGS}" "${_ROCPROFSYS_NODEID_PFX}test_rccl.py::TestRCCL::test[alltoallv-perf-sys_run]" ${_ROCPROFSYS_EXTRA_ARGS})
set_tests_properties("rccl-alltoallv-perf-sys-run" PROPERTIES
    LABELS "gpu;mpi;rccl;rocpd;sys_run"
    TIMEOUT ${_TEST_TIMEOUT}
    SKIP_RETURN_CODE 77
    FIXTURES_REQUIRED "rocprofsys-global-tmp-files"
)

if(DEFINED _ROCPROFSYS_CI_TIMEOUT)
    math(EXPR _TEST_TIMEOUT "${_ROCPROFSYS_CI_TIMEOUT} + 30")
else()
    set(_TEST_TIMEOUT 330)
endif()

add_test("rccl-alltoallv-perf-runtime-instrument" "${_ROCPROFSYS_EXE}" "${_ROCPROFSYS_EXE_ARGS}" "${_ROCPROFSYS_NODEID_PFX}test_rccl.py::TestRCCL::test[alltoallv-perf-runtime_instrument]" ${_ROCPROFSYS_EXTRA_ARGS})
set_tests_properties("rccl-alltoallv-perf-runtime-instrument" PROPERTIES
    LABELS "gpu;mpi;rccl;runtime_instrument;slow"
    TIMEOUT ${_TEST_TIMEOUT}
    SKIP_RETURN_CODE 77
    FIXTURES_REQUIRED "rocprofsys-global-tmp-files"
)

if(DEFINED _ROCPROFSYS_CI_TIMEOUT)
    math(EXPR _TEST_TIMEOUT "${_ROCPROFSYS_CI_TIMEOUT} + 30")
else()
    set(_TEST_TIMEOUT 330)
endif()

add_test("rewrite-caller-baseline" "${_ROCPROFSYS_EXE}" "${_ROCPROFSYS_EXE_ARGS}" "${_ROCPROFSYS_NODEID_PFX}test_rewrite_caller.py::TestRewriteCaller::test[baseline]" ${_ROCPROFSYS_EXTRA_ARGS})
set_tests_properties("rewrite-caller-baseline" PROPERTIES
    LABELS "baseline;caller_include;rewrite_caller"
    TIMEOUT ${_TEST_TIMEOUT}
    SKIP_RETURN_CODE 77
    FIXTURES_REQUIRED "rocprofsys-global-tmp-files"
)

if(DEFINED _ROCPROFSYS_CI_TIMEOUT)
    math(EXPR _TEST_TIMEOUT "${_ROCPROFSYS_CI_TIMEOUT} + 30")
else()
    set(_TEST_TIMEOUT 330)
endif()

add_test("rewrite-caller-binary-rewrite" "${_ROCPROFSYS_EXE}" "${_ROCPROFSYS_EXE_ARGS}" "${_ROCPROFSYS_NODEID_PFX}test_rewrite_caller.py::TestRewriteCaller::test[binary_rewrite]" ${_ROCPROFSYS_EXTRA_ARGS})
set_tests_properties("rewrite-caller-binary-rewrite" PROPERTIES
    LABELS "binary_rewrite;caller_include;rewrite_caller"
    TIMEOUT ${_TEST_TIMEOUT}
    SKIP_RETURN_CODE 77
    FIXTURES_REQUIRED "rocprofsys-global-tmp-files"
)

if(DEFINED _ROCPROFSYS_CI_TIMEOUT)
    math(EXPR _TEST_TIMEOUT "${_ROCPROFSYS_CI_TIMEOUT} + 30")
else()
    set(_TEST_TIMEOUT 330)
endif()

add_test("rewrite-caller-sys-run" "${_ROCPROFSYS_EXE}" "${_ROCPROFSYS_EXE_ARGS}" "${_ROCPROFSYS_NODEID_PFX}test_rewrite_caller.py::TestRewriteCaller::test[sys_run]" ${_ROCPROFSYS_EXTRA_ARGS})
set_tests_properties("rewrite-caller-sys-run" PROPERTIES
    LABELS "caller_include;rewrite_caller;sys_run"
    TIMEOUT ${_TEST_TIMEOUT}
    SKIP_RETURN_CODE 77
    FIXTURES_REQUIRED "rocprofsys-global-tmp-files"
)

if(DEFINED _ROCPROFSYS_CI_TIMEOUT)
    math(EXPR _TEST_TIMEOUT "${_ROCPROFSYS_CI_TIMEOUT} + 30")
else()
    set(_TEST_TIMEOUT 150)
endif()

add_test("roctx-baseline" "${_ROCPROFSYS_EXE}" "${_ROCPROFSYS_EXE_ARGS}" "${_ROCPROFSYS_NODEID_PFX}test_roctx.py::TestROCTx::test[baseline]" ${_ROCPROFSYS_EXTRA_ARGS})
set_tests_properties("roctx-baseline" PROPERTIES
    LABELS "baseline;gpu;rocm;roctx"
    TIMEOUT ${_TEST_TIMEOUT}
    SKIP_RETURN_CODE 77
    FIXTURES_REQUIRED "rocprofsys-global-tmp-files"
)

if(DEFINED _ROCPROFSYS_CI_TIMEOUT)
    math(EXPR _TEST_TIMEOUT "${_ROCPROFSYS_CI_TIMEOUT} + 30")
else()
    set(_TEST_TIMEOUT 150)
endif()

add_test("roctx-binary-rewrite" "${_ROCPROFSYS_EXE}" "${_ROCPROFSYS_EXE_ARGS}" "${_ROCPROFSYS_NODEID_PFX}test_roctx.py::TestROCTx::test[binary_rewrite]" ${_ROCPROFSYS_EXTRA_ARGS})
set_tests_properties("roctx-binary-rewrite" PROPERTIES
    LABELS "binary_rewrite;gpu;rocm;roctx"
    TIMEOUT ${_TEST_TIMEOUT}
    SKIP_RETURN_CODE 77
    FIXTURES_REQUIRED "rocprofsys-global-tmp-files"
)

if(DEFINED _ROCPROFSYS_CI_TIMEOUT)
    math(EXPR _TEST_TIMEOUT "${_ROCPROFSYS_CI_TIMEOUT} + 30")
else()
    set(_TEST_TIMEOUT 150)
endif()

add_test("roctx-sys-run" "${_ROCPROFSYS_EXE}" "${_ROCPROFSYS_EXE_ARGS}" "${_ROCPROFSYS_NODEID_PFX}test_roctx.py::TestROCTx::test[sys_run]" ${_ROCPROFSYS_EXTRA_ARGS})
set_tests_properties("roctx-sys-run" PROPERTIES
    LABELS "gpu;rocm;roctx;sys_run"
    TIMEOUT ${_TEST_TIMEOUT}
    SKIP_RETURN_CODE 77
    FIXTURES_REQUIRED "rocprofsys-global-tmp-files"
)

if(DEFINED _ROCPROFSYS_CI_TIMEOUT)
    math(EXPR _TEST_TIMEOUT "${_ROCPROFSYS_CI_TIMEOUT} + 30")
else()
    set(_TEST_TIMEOUT 150)
endif()

add_test("roctx-runtime-instrument" "${_ROCPROFSYS_EXE}" "${_ROCPROFSYS_EXE_ARGS}" "${_ROCPROFSYS_NODEID_PFX}test_roctx.py::TestROCTx::test[runtime_instrument]" ${_ROCPROFSYS_EXTRA_ARGS})
set_tests_properties("roctx-runtime-instrument" PROPERTIES
    LABELS "gpu;rocm;roctx;runtime_instrument"
    TIMEOUT ${_TEST_TIMEOUT}
    SKIP_RETURN_CODE 77
    FIXTURES_REQUIRED "rocprofsys-global-tmp-files"
)

if(DEFINED _ROCPROFSYS_CI_TIMEOUT)
    math(EXPR _TEST_TIMEOUT "${_ROCPROFSYS_CI_TIMEOUT} + 30")
else()
    set(_TEST_TIMEOUT 150)
endif()

add_test("roctx-sampling" "${_ROCPROFSYS_EXE}" "${_ROCPROFSYS_EXE_ARGS}" "${_ROCPROFSYS_NODEID_PFX}test_roctx.py::TestROCTx::test_sampling" ${_ROCPROFSYS_EXTRA_ARGS})
set_tests_properties("roctx-sampling" PROPERTIES
    LABELS "gpu;rocm;rocpd;roctx"
    TIMEOUT ${_TEST_TIMEOUT}
    SKIP_RETURN_CODE 77
    FIXTURES_REQUIRED "rocprofsys-global-tmp-files"
)

if(DEFINED _ROCPROFSYS_CI_TIMEOUT)
    math(EXPR _TEST_TIMEOUT "${_ROCPROFSYS_CI_TIMEOUT} + 30")
else()
    set(_TEST_TIMEOUT 330)
endif()

add_test("scratch-memory-baseline" "${_ROCPROFSYS_EXE}" "${_ROCPROFSYS_EXE_ARGS}" "${_ROCPROFSYS_NODEID_PFX}test_scratch_memory.py::TestScratchMemory::test[baseline]" ${_ROCPROFSYS_EXTRA_ARGS})
set_tests_properties("scratch-memory-baseline" PROPERTIES
    LABELS "baseline;gpu;rocm;rocpd;scratch_memory"
    TIMEOUT ${_TEST_TIMEOUT}
    SKIP_RETURN_CODE 77
    FIXTURES_REQUIRED "rocprofsys-global-tmp-files"
)

if(DEFINED _ROCPROFSYS_CI_TIMEOUT)
    math(EXPR _TEST_TIMEOUT "${_ROCPROFSYS_CI_TIMEOUT} + 30")
else()
    set(_TEST_TIMEOUT 330)
endif()

add_test("scratch-memory-sampling" "${_ROCPROFSYS_EXE}" "${_ROCPROFSYS_EXE_ARGS}" "${_ROCPROFSYS_NODEID_PFX}test_scratch_memory.py::TestScratchMemory::test[sampling]" ${_ROCPROFSYS_EXTRA_ARGS})
set_tests_properties("scratch-memory-sampling" PROPERTIES
    LABELS "gpu;rocm;rocpd;sampling;scratch_memory"
    TIMEOUT ${_TEST_TIMEOUT}
    SKIP_RETURN_CODE 77
    FIXTURES_REQUIRED "rocprofsys-global-tmp-files"
)

if(DEFINED _ROCPROFSYS_CI_TIMEOUT)
    math(EXPR _TEST_TIMEOUT "${_ROCPROFSYS_CI_TIMEOUT} + 30")
else()
    set(_TEST_TIMEOUT 330)
endif()

add_test("scratch-memory-binary-rewrite" "${_ROCPROFSYS_EXE}" "${_ROCPROFSYS_EXE_ARGS}" "${_ROCPROFSYS_NODEID_PFX}test_scratch_memory.py::TestScratchMemory::test[binary_rewrite]" ${_ROCPROFSYS_EXTRA_ARGS})
set_tests_properties("scratch-memory-binary-rewrite" PROPERTIES
    LABELS "binary_rewrite;gpu;rocm;rocpd;scratch_memory"
    TIMEOUT ${_TEST_TIMEOUT}
    SKIP_RETURN_CODE 77
    FIXTURES_REQUIRED "rocprofsys-global-tmp-files"
)

if(DEFINED _ROCPROFSYS_CI_TIMEOUT)
    math(EXPR _TEST_TIMEOUT "${_ROCPROFSYS_CI_TIMEOUT} + 30")
else()
    set(_TEST_TIMEOUT 330)
endif()

add_test("scratch-memory-sys-run" "${_ROCPROFSYS_EXE}" "${_ROCPROFSYS_EXE_ARGS}" "${_ROCPROFSYS_NODEID_PFX}test_scratch_memory.py::TestScratchMemory::test[sys_run]" ${_ROCPROFSYS_EXTRA_ARGS})
set_tests_properties("scratch-memory-sys-run" PROPERTIES
    LABELS "gpu;rocm;rocpd;scratch_memory;sys_run"
    TIMEOUT ${_TEST_TIMEOUT}
    SKIP_RETURN_CODE 77
    FIXTURES_REQUIRED "rocprofsys-global-tmp-files"
)

if(DEFINED _ROCPROFSYS_CI_TIMEOUT)
    math(EXPR _TEST_TIMEOUT "${_ROCPROFSYS_CI_TIMEOUT} + 30")
else()
    set(_TEST_TIMEOUT 150)
endif()

add_test("pause-resume-enabled-sys-run" "${_ROCPROFSYS_EXE}" "${_ROCPROFSYS_EXE_ARGS}" "${_ROCPROFSYS_NODEID_PFX}test_selective_regions.py::TestPauseResume::test[enabled-sys_run]" ${_ROCPROFSYS_EXTRA_ARGS})
set_tests_properties("pause-resume-enabled-sys-run" PROPERTIES
    LABELS "gpu;rocm;selective_regions;sys_run"
    TIMEOUT ${_TEST_TIMEOUT}
    SKIP_RETURN_CODE 77
    FIXTURES_REQUIRED "rocprofsys-global-tmp-files"
)

if(DEFINED _ROCPROFSYS_CI_TIMEOUT)
    math(EXPR _TEST_TIMEOUT "${_ROCPROFSYS_CI_TIMEOUT} + 30")
else()
    set(_TEST_TIMEOUT 150)
endif()

add_test("pause-resume-enabled-sampling" "${_ROCPROFSYS_EXE}" "${_ROCPROFSYS_EXE_ARGS}" "${_ROCPROFSYS_NODEID_PFX}test_selective_regions.py::TestPauseResume::test[enabled-sampling]" ${_ROCPROFSYS_EXTRA_ARGS})
set_tests_properties("pause-resume-enabled-sampling" PROPERTIES
    LABELS "gpu;rocm;sampling;selective_regions"
    TIMEOUT ${_TEST_TIMEOUT}
    SKIP_RETURN_CODE 77
    FIXTURES_REQUIRED "rocprofsys-global-tmp-files"
)

if(DEFINED _ROCPROFSYS_CI_TIMEOUT)
    math(EXPR _TEST_TIMEOUT "${_ROCPROFSYS_CI_TIMEOUT} + 30")
else()
    set(_TEST_TIMEOUT 150)
endif()

add_test("pause-resume-disabled-sys-run" "${_ROCPROFSYS_EXE}" "${_ROCPROFSYS_EXE_ARGS}" "${_ROCPROFSYS_NODEID_PFX}test_selective_regions.py::TestPauseResume::test[disabled-sys_run]" ${_ROCPROFSYS_EXTRA_ARGS})
set_tests_properties("pause-resume-disabled-sys-run" PROPERTIES
    LABELS "gpu;rocm;selective_regions;sys_run"
    TIMEOUT ${_TEST_TIMEOUT}
    SKIP_RETURN_CODE 77
    FIXTURES_REQUIRED "rocprofsys-global-tmp-files"
)

if(DEFINED _ROCPROFSYS_CI_TIMEOUT)
    math(EXPR _TEST_TIMEOUT "${_ROCPROFSYS_CI_TIMEOUT} + 30")
else()
    set(_TEST_TIMEOUT 150)
endif()

add_test("pause-resume-disabled-sampling" "${_ROCPROFSYS_EXE}" "${_ROCPROFSYS_EXE_ARGS}" "${_ROCPROFSYS_NODEID_PFX}test_selective_regions.py::TestPauseResume::test[disabled-sampling]" ${_ROCPROFSYS_EXTRA_ARGS})
set_tests_properties("pause-resume-disabled-sampling" PROPERTIES
    LABELS "gpu;rocm;sampling;selective_regions"
    TIMEOUT ${_TEST_TIMEOUT}
    SKIP_RETURN_CODE 77
    FIXTURES_REQUIRED "rocprofsys-global-tmp-files"
)

if(DEFINED _ROCPROFSYS_CI_TIMEOUT)
    math(EXPR _TEST_TIMEOUT "${_ROCPROFSYS_CI_TIMEOUT} + 30")
else()
    set(_TEST_TIMEOUT 150)
endif()

add_test("selective-region-no-filter-start-stop-sys-run" "${_ROCPROFSYS_EXE}" "${_ROCPROFSYS_EXE_ARGS}" "${_ROCPROFSYS_NODEID_PFX}test_selective_regions.py::TestSelectiveRegion::test_no_filter[start_stop-sys_run]" ${_ROCPROFSYS_EXTRA_ARGS})
set_tests_properties("selective-region-no-filter-start-stop-sys-run" PROPERTIES
    LABELS "gpu;rocm;selective_regions;sys_run"
    TIMEOUT ${_TEST_TIMEOUT}
    SKIP_RETURN_CODE 77
    FIXTURES_REQUIRED "rocprofsys-global-tmp-files"
)

if(DEFINED _ROCPROFSYS_CI_TIMEOUT)
    math(EXPR _TEST_TIMEOUT "${_ROCPROFSYS_CI_TIMEOUT} + 30")
else()
    set(_TEST_TIMEOUT 150)
endif()

add_test("selective-region-no-filter-start-stop-sampling" "${_ROCPROFSYS_EXE}" "${_ROCPROFSYS_EXE_ARGS}" "${_ROCPROFSYS_NODEID_PFX}test_selective_regions.py::TestSelectiveRegion::test_no_filter[start_stop-sampling]" ${_ROCPROFSYS_EXTRA_ARGS})
set_tests_properties("selective-region-no-filter-start-stop-sampling" PROPERTIES
    LABELS "gpu;rocm;sampling;selective_regions"
    TIMEOUT ${_TEST_TIMEOUT}
    SKIP_RETURN_CODE 77
    FIXTURES_REQUIRED "rocprofsys-global-tmp-files"
)

if(DEFINED _ROCPROFSYS_CI_TIMEOUT)
    math(EXPR _TEST_TIMEOUT "${_ROCPROFSYS_CI_TIMEOUT} + 30")
else()
    set(_TEST_TIMEOUT 150)
endif()

add_test("selective-region-no-filter-push-pop-sys-run" "${_ROCPROFSYS_EXE}" "${_ROCPROFSYS_EXE_ARGS}" "${_ROCPROFSYS_NODEID_PFX}test_selective_regions.py::TestSelectiveRegion::test_no_filter[push_pop-sys_run]" ${_ROCPROFSYS_EXTRA_ARGS})
set_tests_properties("selective-region-no-filter-push-pop-sys-run" PROPERTIES
    LABELS "gpu;rocm;selective_regions;sys_run"
    TIMEOUT ${_TEST_TIMEOUT}
    SKIP_RETURN_CODE 77
    FIXTURES_REQUIRED "rocprofsys-global-tmp-files"
)

if(DEFINED _ROCPROFSYS_CI_TIMEOUT)
    math(EXPR _TEST_TIMEOUT "${_ROCPROFSYS_CI_TIMEOUT} + 30")
else()
    set(_TEST_TIMEOUT 150)
endif()

add_test("selective-region-no-filter-push-pop-sampling" "${_ROCPROFSYS_EXE}" "${_ROCPROFSYS_EXE_ARGS}" "${_ROCPROFSYS_NODEID_PFX}test_selective_regions.py::TestSelectiveRegion::test_no_filter[push_pop-sampling]" ${_ROCPROFSYS_EXTRA_ARGS})
set_tests_properties("selective-region-no-filter-push-pop-sampling" PROPERTIES
    LABELS "gpu;rocm;sampling;selective_regions"
    TIMEOUT ${_TEST_TIMEOUT}
    SKIP_RETURN_CODE 77
    FIXTURES_REQUIRED "rocprofsys-global-tmp-files"
)

if(DEFINED _ROCPROFSYS_CI_TIMEOUT)
    math(EXPR _TEST_TIMEOUT "${_ROCPROFSYS_CI_TIMEOUT} + 30")
else()
    set(_TEST_TIMEOUT 150)
endif()

add_test("selective-region-region-1-filter-start-stop-sys-run" "${_ROCPROFSYS_EXE}" "${_ROCPROFSYS_EXE_ARGS}" "${_ROCPROFSYS_NODEID_PFX}test_selective_regions.py::TestSelectiveRegion::test_region_1_filter[start_stop-sys_run]" ${_ROCPROFSYS_EXTRA_ARGS})
set_tests_properties("selective-region-region-1-filter-start-stop-sys-run" PROPERTIES
    LABELS "gpu;rocm;selective_regions;sys_run"
    TIMEOUT ${_TEST_TIMEOUT}
    SKIP_RETURN_CODE 77
    FIXTURES_REQUIRED "rocprofsys-global-tmp-files"
)

if(DEFINED _ROCPROFSYS_CI_TIMEOUT)
    math(EXPR _TEST_TIMEOUT "${_ROCPROFSYS_CI_TIMEOUT} + 30")
else()
    set(_TEST_TIMEOUT 150)
endif()

add_test("selective-region-region-1-filter-start-stop-sampling" "${_ROCPROFSYS_EXE}" "${_ROCPROFSYS_EXE_ARGS}" "${_ROCPROFSYS_NODEID_PFX}test_selective_regions.py::TestSelectiveRegion::test_region_1_filter[start_stop-sampling]" ${_ROCPROFSYS_EXTRA_ARGS})
set_tests_properties("selective-region-region-1-filter-start-stop-sampling" PROPERTIES
    LABELS "gpu;rocm;sampling;selective_regions"
    TIMEOUT ${_TEST_TIMEOUT}
    SKIP_RETURN_CODE 77
    FIXTURES_REQUIRED "rocprofsys-global-tmp-files"
)

if(DEFINED _ROCPROFSYS_CI_TIMEOUT)
    math(EXPR _TEST_TIMEOUT "${_ROCPROFSYS_CI_TIMEOUT} + 30")
else()
    set(_TEST_TIMEOUT 150)
endif()

add_test("selective-region-region-1-filter-push-pop-sys-run" "${_ROCPROFSYS_EXE}" "${_ROCPROFSYS_EXE_ARGS}" "${_ROCPROFSYS_NODEID_PFX}test_selective_regions.py::TestSelectiveRegion::test_region_1_filter[push_pop-sys_run]" ${_ROCPROFSYS_EXTRA_ARGS})
set_tests_properties("selective-region-region-1-filter-push-pop-sys-run" PROPERTIES
    LABELS "gpu;rocm;selective_regions;sys_run"
    TIMEOUT ${_TEST_TIMEOUT}
    SKIP_RETURN_CODE 77
    FIXTURES_REQUIRED "rocprofsys-global-tmp-files"
)

if(DEFINED _ROCPROFSYS_CI_TIMEOUT)
    math(EXPR _TEST_TIMEOUT "${_ROCPROFSYS_CI_TIMEOUT} + 30")
else()
    set(_TEST_TIMEOUT 150)
endif()

add_test("selective-region-region-1-filter-push-pop-sampling" "${_ROCPROFSYS_EXE}" "${_ROCPROFSYS_EXE_ARGS}" "${_ROCPROFSYS_NODEID_PFX}test_selective_regions.py::TestSelectiveRegion::test_region_1_filter[push_pop-sampling]" ${_ROCPROFSYS_EXTRA_ARGS})
set_tests_properties("selective-region-region-1-filter-push-pop-sampling" PROPERTIES
    LABELS "gpu;rocm;sampling;selective_regions"
    TIMEOUT ${_TEST_TIMEOUT}
    SKIP_RETURN_CODE 77
    FIXTURES_REQUIRED "rocprofsys-global-tmp-files"
)

if(DEFINED _ROCPROFSYS_CI_TIMEOUT)
    math(EXPR _TEST_TIMEOUT "${_ROCPROFSYS_CI_TIMEOUT} + 30")
else()
    set(_TEST_TIMEOUT 150)
endif()

add_test("selective-region-region-2-and-3-filter-start-stop-sys-run" "${_ROCPROFSYS_EXE}" "${_ROCPROFSYS_EXE_ARGS}" "${_ROCPROFSYS_NODEID_PFX}test_selective_regions.py::TestSelectiveRegion::test_region_2_and_3_filter[start_stop-sys_run]" ${_ROCPROFSYS_EXTRA_ARGS})
set_tests_properties("selective-region-region-2-and-3-filter-start-stop-sys-run" PROPERTIES
    LABELS "gpu;rocm;selective_regions;sys_run"
    TIMEOUT ${_TEST_TIMEOUT}
    SKIP_RETURN_CODE 77
    FIXTURES_REQUIRED "rocprofsys-global-tmp-files"
)

if(DEFINED _ROCPROFSYS_CI_TIMEOUT)
    math(EXPR _TEST_TIMEOUT "${_ROCPROFSYS_CI_TIMEOUT} + 30")
else()
    set(_TEST_TIMEOUT 150)
endif()

add_test("selective-region-region-2-and-3-filter-start-stop-sampling" "${_ROCPROFSYS_EXE}" "${_ROCPROFSYS_EXE_ARGS}" "${_ROCPROFSYS_NODEID_PFX}test_selective_regions.py::TestSelectiveRegion::test_region_2_and_3_filter[start_stop-sampling]" ${_ROCPROFSYS_EXTRA_ARGS})
set_tests_properties("selective-region-region-2-and-3-filter-start-stop-sampling" PROPERTIES
    LABELS "gpu;rocm;sampling;selective_regions"
    TIMEOUT ${_TEST_TIMEOUT}
    SKIP_RETURN_CODE 77
    FIXTURES_REQUIRED "rocprofsys-global-tmp-files"
)

if(DEFINED _ROCPROFSYS_CI_TIMEOUT)
    math(EXPR _TEST_TIMEOUT "${_ROCPROFSYS_CI_TIMEOUT} + 30")
else()
    set(_TEST_TIMEOUT 150)
endif()

add_test("selective-region-region-2-and-3-filter-push-pop-sys-run" "${_ROCPROFSYS_EXE}" "${_ROCPROFSYS_EXE_ARGS}" "${_ROCPROFSYS_NODEID_PFX}test_selective_regions.py::TestSelectiveRegion::test_region_2_and_3_filter[push_pop-sys_run]" ${_ROCPROFSYS_EXTRA_ARGS})
set_tests_properties("selective-region-region-2-and-3-filter-push-pop-sys-run" PROPERTIES
    LABELS "gpu;rocm;selective_regions;sys_run"
    TIMEOUT ${_TEST_TIMEOUT}
    SKIP_RETURN_CODE 77
    FIXTURES_REQUIRED "rocprofsys-global-tmp-files"
)

if(DEFINED _ROCPROFSYS_CI_TIMEOUT)
    math(EXPR _TEST_TIMEOUT "${_ROCPROFSYS_CI_TIMEOUT} + 30")
else()
    set(_TEST_TIMEOUT 150)
endif()

add_test("selective-region-region-2-and-3-filter-push-pop-sampling" "${_ROCPROFSYS_EXE}" "${_ROCPROFSYS_EXE_ARGS}" "${_ROCPROFSYS_NODEID_PFX}test_selective_regions.py::TestSelectiveRegion::test_region_2_and_3_filter[push_pop-sampling]" ${_ROCPROFSYS_EXTRA_ARGS})
set_tests_properties("selective-region-region-2-and-3-filter-push-pop-sampling" PROPERTIES
    LABELS "gpu;rocm;sampling;selective_regions"
    TIMEOUT ${_TEST_TIMEOUT}
    SKIP_RETURN_CODE 77
    FIXTURES_REQUIRED "rocprofsys-global-tmp-files"
)

if(DEFINED _ROCPROFSYS_CI_TIMEOUT)
    math(EXPR _TEST_TIMEOUT "${_ROCPROFSYS_CI_TIMEOUT} + 30")
else()
    set(_TEST_TIMEOUT 150)
endif()

add_test("selective-region-pause-no-filter-inside-start-stop-sys-run" "${_ROCPROFSYS_EXE}" "${_ROCPROFSYS_EXE_ARGS}" "${_ROCPROFSYS_NODEID_PFX}test_selective_regions.py::TestSelectiveRegionPause::test_no_filter[inside-start_stop-sys_run]" ${_ROCPROFSYS_EXTRA_ARGS})
set_tests_properties("selective-region-pause-no-filter-inside-start-stop-sys-run" PROPERTIES
    LABELS "gpu;rocm;selective_regions;sys_run"
    TIMEOUT ${_TEST_TIMEOUT}
    SKIP_RETURN_CODE 77
    FIXTURES_REQUIRED "rocprofsys-global-tmp-files"
)

if(DEFINED _ROCPROFSYS_CI_TIMEOUT)
    math(EXPR _TEST_TIMEOUT "${_ROCPROFSYS_CI_TIMEOUT} + 30")
else()
    set(_TEST_TIMEOUT 150)
endif()

add_test("selective-region-pause-no-filter-inside-start-stop-sampling" "${_ROCPROFSYS_EXE}" "${_ROCPROFSYS_EXE_ARGS}" "${_ROCPROFSYS_NODEID_PFX}test_selective_regions.py::TestSelectiveRegionPause::test_no_filter[inside-start_stop-sampling]" ${_ROCPROFSYS_EXTRA_ARGS})
set_tests_properties("selective-region-pause-no-filter-inside-start-stop-sampling" PROPERTIES
    LABELS "gpu;rocm;sampling;selective_regions"
    TIMEOUT ${_TEST_TIMEOUT}
    SKIP_RETURN_CODE 77
    FIXTURES_REQUIRED "rocprofsys-global-tmp-files"
)

if(DEFINED _ROCPROFSYS_CI_TIMEOUT)
    math(EXPR _TEST_TIMEOUT "${_ROCPROFSYS_CI_TIMEOUT} + 30")
else()
    set(_TEST_TIMEOUT 150)
endif()

add_test("selective-region-pause-no-filter-inside-push-pop-sys-run" "${_ROCPROFSYS_EXE}" "${_ROCPROFSYS_EXE_ARGS}" "${_ROCPROFSYS_NODEID_PFX}test_selective_regions.py::TestSelectiveRegionPause::test_no_filter[inside-push_pop-sys_run]" ${_ROCPROFSYS_EXTRA_ARGS})
set_tests_properties("selective-region-pause-no-filter-inside-push-pop-sys-run" PROPERTIES
    LABELS "gpu;rocm;selective_regions;sys_run"
    TIMEOUT ${_TEST_TIMEOUT}
    SKIP_RETURN_CODE 77
    FIXTURES_REQUIRED "rocprofsys-global-tmp-files"
)

if(DEFINED _ROCPROFSYS_CI_TIMEOUT)
    math(EXPR _TEST_TIMEOUT "${_ROCPROFSYS_CI_TIMEOUT} + 30")
else()
    set(_TEST_TIMEOUT 150)
endif()

add_test("selective-region-pause-no-filter-inside-push-pop-sampling" "${_ROCPROFSYS_EXE}" "${_ROCPROFSYS_EXE_ARGS}" "${_ROCPROFSYS_NODEID_PFX}test_selective_regions.py::TestSelectiveRegionPause::test_no_filter[inside-push_pop-sampling]" ${_ROCPROFSYS_EXTRA_ARGS})
set_tests_properties("selective-region-pause-no-filter-inside-push-pop-sampling" PROPERTIES
    LABELS "gpu;rocm;sampling;selective_regions"
    TIMEOUT ${_TEST_TIMEOUT}
    SKIP_RETURN_CODE 77
    FIXTURES_REQUIRED "rocprofsys-global-tmp-files"
)

if(DEFINED _ROCPROFSYS_CI_TIMEOUT)
    math(EXPR _TEST_TIMEOUT "${_ROCPROFSYS_CI_TIMEOUT} + 30")
else()
    set(_TEST_TIMEOUT 150)
endif()

add_test("selective-region-pause-no-filter-before-start-stop-sys-run" "${_ROCPROFSYS_EXE}" "${_ROCPROFSYS_EXE_ARGS}" "${_ROCPROFSYS_NODEID_PFX}test_selective_regions.py::TestSelectiveRegionPause::test_no_filter[before-start_stop-sys_run]" ${_ROCPROFSYS_EXTRA_ARGS})
set_tests_properties("selective-region-pause-no-filter-before-start-stop-sys-run" PROPERTIES
    LABELS "gpu;rocm;selective_regions;sys_run"
    TIMEOUT ${_TEST_TIMEOUT}
    SKIP_RETURN_CODE 77
    FIXTURES_REQUIRED "rocprofsys-global-tmp-files"
)

if(DEFINED _ROCPROFSYS_CI_TIMEOUT)
    math(EXPR _TEST_TIMEOUT "${_ROCPROFSYS_CI_TIMEOUT} + 30")
else()
    set(_TEST_TIMEOUT 150)
endif()

add_test("selective-region-pause-no-filter-before-start-stop-sampling" "${_ROCPROFSYS_EXE}" "${_ROCPROFSYS_EXE_ARGS}" "${_ROCPROFSYS_NODEID_PFX}test_selective_regions.py::TestSelectiveRegionPause::test_no_filter[before-start_stop-sampling]" ${_ROCPROFSYS_EXTRA_ARGS})
set_tests_properties("selective-region-pause-no-filter-before-start-stop-sampling" PROPERTIES
    LABELS "gpu;rocm;sampling;selective_regions"
    TIMEOUT ${_TEST_TIMEOUT}
    SKIP_RETURN_CODE 77
    FIXTURES_REQUIRED "rocprofsys-global-tmp-files"
)

if(DEFINED _ROCPROFSYS_CI_TIMEOUT)
    math(EXPR _TEST_TIMEOUT "${_ROCPROFSYS_CI_TIMEOUT} + 30")
else()
    set(_TEST_TIMEOUT 150)
endif()

add_test("selective-region-pause-no-filter-before-push-pop-sys-run" "${_ROCPROFSYS_EXE}" "${_ROCPROFSYS_EXE_ARGS}" "${_ROCPROFSYS_NODEID_PFX}test_selective_regions.py::TestSelectiveRegionPause::test_no_filter[before-push_pop-sys_run]" ${_ROCPROFSYS_EXTRA_ARGS})
set_tests_properties("selective-region-pause-no-filter-before-push-pop-sys-run" PROPERTIES
    LABELS "gpu;rocm;selective_regions;sys_run"
    TIMEOUT ${_TEST_TIMEOUT}
    SKIP_RETURN_CODE 77
    FIXTURES_REQUIRED "rocprofsys-global-tmp-files"
)

if(DEFINED _ROCPROFSYS_CI_TIMEOUT)
    math(EXPR _TEST_TIMEOUT "${_ROCPROFSYS_CI_TIMEOUT} + 30")
else()
    set(_TEST_TIMEOUT 150)
endif()

add_test("selective-region-pause-no-filter-before-push-pop-sampling" "${_ROCPROFSYS_EXE}" "${_ROCPROFSYS_EXE_ARGS}" "${_ROCPROFSYS_NODEID_PFX}test_selective_regions.py::TestSelectiveRegionPause::test_no_filter[before-push_pop-sampling]" ${_ROCPROFSYS_EXTRA_ARGS})
set_tests_properties("selective-region-pause-no-filter-before-push-pop-sampling" PROPERTIES
    LABELS "gpu;rocm;sampling;selective_regions"
    TIMEOUT ${_TEST_TIMEOUT}
    SKIP_RETURN_CODE 77
    FIXTURES_REQUIRED "rocprofsys-global-tmp-files"
)

if(DEFINED _ROCPROFSYS_CI_TIMEOUT)
    math(EXPR _TEST_TIMEOUT "${_ROCPROFSYS_CI_TIMEOUT} + 30")
else()
    set(_TEST_TIMEOUT 150)
endif()

add_test("selective-region-pause-no-filter-outside-start-stop-sys-run" "${_ROCPROFSYS_EXE}" "${_ROCPROFSYS_EXE_ARGS}" "${_ROCPROFSYS_NODEID_PFX}test_selective_regions.py::TestSelectiveRegionPause::test_no_filter[outside-start_stop-sys_run]" ${_ROCPROFSYS_EXTRA_ARGS})
set_tests_properties("selective-region-pause-no-filter-outside-start-stop-sys-run" PROPERTIES
    LABELS "gpu;rocm;selective_regions;sys_run"
    TIMEOUT ${_TEST_TIMEOUT}
    SKIP_RETURN_CODE 77
    FIXTURES_REQUIRED "rocprofsys-global-tmp-files"
)

if(DEFINED _ROCPROFSYS_CI_TIMEOUT)
    math(EXPR _TEST_TIMEOUT "${_ROCPROFSYS_CI_TIMEOUT} + 30")
else()
    set(_TEST_TIMEOUT 150)
endif()

add_test("selective-region-pause-no-filter-outside-start-stop-sampling" "${_ROCPROFSYS_EXE}" "${_ROCPROFSYS_EXE_ARGS}" "${_ROCPROFSYS_NODEID_PFX}test_selective_regions.py::TestSelectiveRegionPause::test_no_filter[outside-start_stop-sampling]" ${_ROCPROFSYS_EXTRA_ARGS})
set_tests_properties("selective-region-pause-no-filter-outside-start-stop-sampling" PROPERTIES
    LABELS "gpu;rocm;sampling;selective_regions"
    TIMEOUT ${_TEST_TIMEOUT}
    SKIP_RETURN_CODE 77
    FIXTURES_REQUIRED "rocprofsys-global-tmp-files"
)

if(DEFINED _ROCPROFSYS_CI_TIMEOUT)
    math(EXPR _TEST_TIMEOUT "${_ROCPROFSYS_CI_TIMEOUT} + 30")
else()
    set(_TEST_TIMEOUT 150)
endif()

add_test("selective-region-pause-no-filter-outside-push-pop-sys-run" "${_ROCPROFSYS_EXE}" "${_ROCPROFSYS_EXE_ARGS}" "${_ROCPROFSYS_NODEID_PFX}test_selective_regions.py::TestSelectiveRegionPause::test_no_filter[outside-push_pop-sys_run]" ${_ROCPROFSYS_EXTRA_ARGS})
set_tests_properties("selective-region-pause-no-filter-outside-push-pop-sys-run" PROPERTIES
    LABELS "gpu;rocm;selective_regions;sys_run"
    TIMEOUT ${_TEST_TIMEOUT}
    SKIP_RETURN_CODE 77
    FIXTURES_REQUIRED "rocprofsys-global-tmp-files"
)

if(DEFINED _ROCPROFSYS_CI_TIMEOUT)
    math(EXPR _TEST_TIMEOUT "${_ROCPROFSYS_CI_TIMEOUT} + 30")
else()
    set(_TEST_TIMEOUT 150)
endif()

add_test("selective-region-pause-no-filter-outside-push-pop-sampling" "${_ROCPROFSYS_EXE}" "${_ROCPROFSYS_EXE_ARGS}" "${_ROCPROFSYS_NODEID_PFX}test_selective_regions.py::TestSelectiveRegionPause::test_no_filter[outside-push_pop-sampling]" ${_ROCPROFSYS_EXTRA_ARGS})
set_tests_properties("selective-region-pause-no-filter-outside-push-pop-sampling" PROPERTIES
    LABELS "gpu;rocm;sampling;selective_regions"
    TIMEOUT ${_TEST_TIMEOUT}
    SKIP_RETURN_CODE 77
    FIXTURES_REQUIRED "rocprofsys-global-tmp-files"
)

if(DEFINED _ROCPROFSYS_CI_TIMEOUT)
    math(EXPR _TEST_TIMEOUT "${_ROCPROFSYS_CI_TIMEOUT} + 30")
else()
    set(_TEST_TIMEOUT 150)
endif()

add_test("selective-region-pause-filtered-inside-start-stop-sys-run" "${_ROCPROFSYS_EXE}" "${_ROCPROFSYS_EXE_ARGS}" "${_ROCPROFSYS_NODEID_PFX}test_selective_regions.py::TestSelectiveRegionPause::test_filtered[inside-start_stop-sys_run]" ${_ROCPROFSYS_EXTRA_ARGS})
set_tests_properties("selective-region-pause-filtered-inside-start-stop-sys-run" PROPERTIES
    LABELS "gpu;rocm;selective_regions;sys_run"
    TIMEOUT ${_TEST_TIMEOUT}
    SKIP_RETURN_CODE 77
    FIXTURES_REQUIRED "rocprofsys-global-tmp-files"
)

if(DEFINED _ROCPROFSYS_CI_TIMEOUT)
    math(EXPR _TEST_TIMEOUT "${_ROCPROFSYS_CI_TIMEOUT} + 30")
else()
    set(_TEST_TIMEOUT 150)
endif()

add_test("selective-region-pause-filtered-inside-start-stop-sampling" "${_ROCPROFSYS_EXE}" "${_ROCPROFSYS_EXE_ARGS}" "${_ROCPROFSYS_NODEID_PFX}test_selective_regions.py::TestSelectiveRegionPause::test_filtered[inside-start_stop-sampling]" ${_ROCPROFSYS_EXTRA_ARGS})
set_tests_properties("selective-region-pause-filtered-inside-start-stop-sampling" PROPERTIES
    LABELS "gpu;rocm;sampling;selective_regions"
    TIMEOUT ${_TEST_TIMEOUT}
    SKIP_RETURN_CODE 77
    FIXTURES_REQUIRED "rocprofsys-global-tmp-files"
)

if(DEFINED _ROCPROFSYS_CI_TIMEOUT)
    math(EXPR _TEST_TIMEOUT "${_ROCPROFSYS_CI_TIMEOUT} + 30")
else()
    set(_TEST_TIMEOUT 150)
endif()

add_test("selective-region-pause-filtered-inside-push-pop-sys-run" "${_ROCPROFSYS_EXE}" "${_ROCPROFSYS_EXE_ARGS}" "${_ROCPROFSYS_NODEID_PFX}test_selective_regions.py::TestSelectiveRegionPause::test_filtered[inside-push_pop-sys_run]" ${_ROCPROFSYS_EXTRA_ARGS})
set_tests_properties("selective-region-pause-filtered-inside-push-pop-sys-run" PROPERTIES
    LABELS "gpu;rocm;selective_regions;sys_run"
    TIMEOUT ${_TEST_TIMEOUT}
    SKIP_RETURN_CODE 77
    FIXTURES_REQUIRED "rocprofsys-global-tmp-files"
)

if(DEFINED _ROCPROFSYS_CI_TIMEOUT)
    math(EXPR _TEST_TIMEOUT "${_ROCPROFSYS_CI_TIMEOUT} + 30")
else()
    set(_TEST_TIMEOUT 150)
endif()

add_test("selective-region-pause-filtered-inside-push-pop-sampling" "${_ROCPROFSYS_EXE}" "${_ROCPROFSYS_EXE_ARGS}" "${_ROCPROFSYS_NODEID_PFX}test_selective_regions.py::TestSelectiveRegionPause::test_filtered[inside-push_pop-sampling]" ${_ROCPROFSYS_EXTRA_ARGS})
set_tests_properties("selective-region-pause-filtered-inside-push-pop-sampling" PROPERTIES
    LABELS "gpu;rocm;sampling;selective_regions"
    TIMEOUT ${_TEST_TIMEOUT}
    SKIP_RETURN_CODE 77
    FIXTURES_REQUIRED "rocprofsys-global-tmp-files"
)

if(DEFINED _ROCPROFSYS_CI_TIMEOUT)
    math(EXPR _TEST_TIMEOUT "${_ROCPROFSYS_CI_TIMEOUT} + 30")
else()
    set(_TEST_TIMEOUT 150)
endif()

add_test("selective-region-pause-filtered-before-start-stop-sys-run" "${_ROCPROFSYS_EXE}" "${_ROCPROFSYS_EXE_ARGS}" "${_ROCPROFSYS_NODEID_PFX}test_selective_regions.py::TestSelectiveRegionPause::test_filtered[before-start_stop-sys_run]" ${_ROCPROFSYS_EXTRA_ARGS})
set_tests_properties("selective-region-pause-filtered-before-start-stop-sys-run" PROPERTIES
    LABELS "gpu;rocm;selective_regions;sys_run"
    TIMEOUT ${_TEST_TIMEOUT}
    SKIP_RETURN_CODE 77
    FIXTURES_REQUIRED "rocprofsys-global-tmp-files"
)

if(DEFINED _ROCPROFSYS_CI_TIMEOUT)
    math(EXPR _TEST_TIMEOUT "${_ROCPROFSYS_CI_TIMEOUT} + 30")
else()
    set(_TEST_TIMEOUT 150)
endif()

add_test("selective-region-pause-filtered-before-start-stop-sampling" "${_ROCPROFSYS_EXE}" "${_ROCPROFSYS_EXE_ARGS}" "${_ROCPROFSYS_NODEID_PFX}test_selective_regions.py::TestSelectiveRegionPause::test_filtered[before-start_stop-sampling]" ${_ROCPROFSYS_EXTRA_ARGS})
set_tests_properties("selective-region-pause-filtered-before-start-stop-sampling" PROPERTIES
    LABELS "gpu;rocm;sampling;selective_regions"
    TIMEOUT ${_TEST_TIMEOUT}
    SKIP_RETURN_CODE 77
    FIXTURES_REQUIRED "rocprofsys-global-tmp-files"
)

if(DEFINED _ROCPROFSYS_CI_TIMEOUT)
    math(EXPR _TEST_TIMEOUT "${_ROCPROFSYS_CI_TIMEOUT} + 30")
else()
    set(_TEST_TIMEOUT 150)
endif()

add_test("selective-region-pause-filtered-before-push-pop-sys-run" "${_ROCPROFSYS_EXE}" "${_ROCPROFSYS_EXE_ARGS}" "${_ROCPROFSYS_NODEID_PFX}test_selective_regions.py::TestSelectiveRegionPause::test_filtered[before-push_pop-sys_run]" ${_ROCPROFSYS_EXTRA_ARGS})
set_tests_properties("selective-region-pause-filtered-before-push-pop-sys-run" PROPERTIES
    LABELS "gpu;rocm;selective_regions;sys_run"
    TIMEOUT ${_TEST_TIMEOUT}
    SKIP_RETURN_CODE 77
    FIXTURES_REQUIRED "rocprofsys-global-tmp-files"
)

if(DEFINED _ROCPROFSYS_CI_TIMEOUT)
    math(EXPR _TEST_TIMEOUT "${_ROCPROFSYS_CI_TIMEOUT} + 30")
else()
    set(_TEST_TIMEOUT 150)
endif()

add_test("selective-region-pause-filtered-before-push-pop-sampling" "${_ROCPROFSYS_EXE}" "${_ROCPROFSYS_EXE_ARGS}" "${_ROCPROFSYS_NODEID_PFX}test_selective_regions.py::TestSelectiveRegionPause::test_filtered[before-push_pop-sampling]" ${_ROCPROFSYS_EXTRA_ARGS})
set_tests_properties("selective-region-pause-filtered-before-push-pop-sampling" PROPERTIES
    LABELS "gpu;rocm;sampling;selective_regions"
    TIMEOUT ${_TEST_TIMEOUT}
    SKIP_RETURN_CODE 77
    FIXTURES_REQUIRED "rocprofsys-global-tmp-files"
)

if(DEFINED _ROCPROFSYS_CI_TIMEOUT)
    math(EXPR _TEST_TIMEOUT "${_ROCPROFSYS_CI_TIMEOUT} + 30")
else()
    set(_TEST_TIMEOUT 150)
endif()

add_test("selective-region-pause-filtered-outside-start-stop-sys-run" "${_ROCPROFSYS_EXE}" "${_ROCPROFSYS_EXE_ARGS}" "${_ROCPROFSYS_NODEID_PFX}test_selective_regions.py::TestSelectiveRegionPause::test_filtered[outside-start_stop-sys_run]" ${_ROCPROFSYS_EXTRA_ARGS})
set_tests_properties("selective-region-pause-filtered-outside-start-stop-sys-run" PROPERTIES
    LABELS "gpu;rocm;selective_regions;sys_run"
    TIMEOUT ${_TEST_TIMEOUT}
    SKIP_RETURN_CODE 77
    FIXTURES_REQUIRED "rocprofsys-global-tmp-files"
)

if(DEFINED _ROCPROFSYS_CI_TIMEOUT)
    math(EXPR _TEST_TIMEOUT "${_ROCPROFSYS_CI_TIMEOUT} + 30")
else()
    set(_TEST_TIMEOUT 150)
endif()

add_test("selective-region-pause-filtered-outside-start-stop-sampling" "${_ROCPROFSYS_EXE}" "${_ROCPROFSYS_EXE_ARGS}" "${_ROCPROFSYS_NODEID_PFX}test_selective_regions.py::TestSelectiveRegionPause::test_filtered[outside-start_stop-sampling]" ${_ROCPROFSYS_EXTRA_ARGS})
set_tests_properties("selective-region-pause-filtered-outside-start-stop-sampling" PROPERTIES
    LABELS "gpu;rocm;sampling;selective_regions"
    TIMEOUT ${_TEST_TIMEOUT}
    SKIP_RETURN_CODE 77
    FIXTURES_REQUIRED "rocprofsys-global-tmp-files"
)

if(DEFINED _ROCPROFSYS_CI_TIMEOUT)
    math(EXPR _TEST_TIMEOUT "${_ROCPROFSYS_CI_TIMEOUT} + 30")
else()
    set(_TEST_TIMEOUT 150)
endif()

add_test("selective-region-pause-filtered-outside-push-pop-sys-run" "${_ROCPROFSYS_EXE}" "${_ROCPROFSYS_EXE_ARGS}" "${_ROCPROFSYS_NODEID_PFX}test_selective_regions.py::TestSelectiveRegionPause::test_filtered[outside-push_pop-sys_run]" ${_ROCPROFSYS_EXTRA_ARGS})
set_tests_properties("selective-region-pause-filtered-outside-push-pop-sys-run" PROPERTIES
    LABELS "gpu;rocm;selective_regions;sys_run"
    TIMEOUT ${_TEST_TIMEOUT}
    SKIP_RETURN_CODE 77
    FIXTURES_REQUIRED "rocprofsys-global-tmp-files"
)

if(DEFINED _ROCPROFSYS_CI_TIMEOUT)
    math(EXPR _TEST_TIMEOUT "${_ROCPROFSYS_CI_TIMEOUT} + 30")
else()
    set(_TEST_TIMEOUT 150)
endif()

add_test("selective-region-pause-filtered-outside-push-pop-sampling" "${_ROCPROFSYS_EXE}" "${_ROCPROFSYS_EXE_ARGS}" "${_ROCPROFSYS_NODEID_PFX}test_selective_regions.py::TestSelectiveRegionPause::test_filtered[outside-push_pop-sampling]" ${_ROCPROFSYS_EXTRA_ARGS})
set_tests_properties("selective-region-pause-filtered-outside-push-pop-sampling" PROPERTIES
    LABELS "gpu;rocm;sampling;selective_regions"
    TIMEOUT ${_TEST_TIMEOUT}
    SKIP_RETURN_CODE 77
    FIXTURES_REQUIRED "rocprofsys-global-tmp-files"
)

if(DEFINED _ROCPROFSYS_CI_TIMEOUT)
    math(EXPR _TEST_TIMEOUT "${_ROCPROFSYS_CI_TIMEOUT} + 30")
else()
    set(_TEST_TIMEOUT 150)
endif()

add_test("selective-region-pause-no-marker-inside-start-stop-sys-run" "${_ROCPROFSYS_EXE}" "${_ROCPROFSYS_EXE_ARGS}" "${_ROCPROFSYS_NODEID_PFX}test_selective_regions.py::TestSelectiveRegionPause::test_no_marker[inside-start_stop-sys_run]" ${_ROCPROFSYS_EXTRA_ARGS})
set_tests_properties("selective-region-pause-no-marker-inside-start-stop-sys-run" PROPERTIES
    LABELS "gpu;rocm;selective_regions;sys_run"
    TIMEOUT ${_TEST_TIMEOUT}
    SKIP_RETURN_CODE 77
    FIXTURES_REQUIRED "rocprofsys-global-tmp-files"
)

if(DEFINED _ROCPROFSYS_CI_TIMEOUT)
    math(EXPR _TEST_TIMEOUT "${_ROCPROFSYS_CI_TIMEOUT} + 30")
else()
    set(_TEST_TIMEOUT 150)
endif()

add_test("selective-region-pause-no-marker-inside-start-stop-sampling" "${_ROCPROFSYS_EXE}" "${_ROCPROFSYS_EXE_ARGS}" "${_ROCPROFSYS_NODEID_PFX}test_selective_regions.py::TestSelectiveRegionPause::test_no_marker[inside-start_stop-sampling]" ${_ROCPROFSYS_EXTRA_ARGS})
set_tests_properties("selective-region-pause-no-marker-inside-start-stop-sampling" PROPERTIES
    LABELS "gpu;rocm;sampling;selective_regions"
    TIMEOUT ${_TEST_TIMEOUT}
    SKIP_RETURN_CODE 77
    FIXTURES_REQUIRED "rocprofsys-global-tmp-files"
)

if(DEFINED _ROCPROFSYS_CI_TIMEOUT)
    math(EXPR _TEST_TIMEOUT "${_ROCPROFSYS_CI_TIMEOUT} + 30")
else()
    set(_TEST_TIMEOUT 150)
endif()

add_test("selective-region-pause-no-marker-inside-push-pop-sys-run" "${_ROCPROFSYS_EXE}" "${_ROCPROFSYS_EXE_ARGS}" "${_ROCPROFSYS_NODEID_PFX}test_selective_regions.py::TestSelectiveRegionPause::test_no_marker[inside-push_pop-sys_run]" ${_ROCPROFSYS_EXTRA_ARGS})
set_tests_properties("selective-region-pause-no-marker-inside-push-pop-sys-run" PROPERTIES
    LABELS "gpu;rocm;selective_regions;sys_run"
    TIMEOUT ${_TEST_TIMEOUT}
    SKIP_RETURN_CODE 77
    FIXTURES_REQUIRED "rocprofsys-global-tmp-files"
)

if(DEFINED _ROCPROFSYS_CI_TIMEOUT)
    math(EXPR _TEST_TIMEOUT "${_ROCPROFSYS_CI_TIMEOUT} + 30")
else()
    set(_TEST_TIMEOUT 150)
endif()

add_test("selective-region-pause-no-marker-inside-push-pop-sampling" "${_ROCPROFSYS_EXE}" "${_ROCPROFSYS_EXE_ARGS}" "${_ROCPROFSYS_NODEID_PFX}test_selective_regions.py::TestSelectiveRegionPause::test_no_marker[inside-push_pop-sampling]" ${_ROCPROFSYS_EXTRA_ARGS})
set_tests_properties("selective-region-pause-no-marker-inside-push-pop-sampling" PROPERTIES
    LABELS "gpu;rocm;sampling;selective_regions"
    TIMEOUT ${_TEST_TIMEOUT}
    SKIP_RETURN_CODE 77
    FIXTURES_REQUIRED "rocprofsys-global-tmp-files"
)

if(DEFINED _ROCPROFSYS_CI_TIMEOUT)
    math(EXPR _TEST_TIMEOUT "${_ROCPROFSYS_CI_TIMEOUT} + 30")
else()
    set(_TEST_TIMEOUT 150)
endif()

add_test("selective-region-pause-no-marker-before-start-stop-sys-run" "${_ROCPROFSYS_EXE}" "${_ROCPROFSYS_EXE_ARGS}" "${_ROCPROFSYS_NODEID_PFX}test_selective_regions.py::TestSelectiveRegionPause::test_no_marker[before-start_stop-sys_run]" ${_ROCPROFSYS_EXTRA_ARGS})
set_tests_properties("selective-region-pause-no-marker-before-start-stop-sys-run" PROPERTIES
    LABELS "gpu;rocm;selective_regions;sys_run"
    TIMEOUT ${_TEST_TIMEOUT}
    SKIP_RETURN_CODE 77
    FIXTURES_REQUIRED "rocprofsys-global-tmp-files"
)

if(DEFINED _ROCPROFSYS_CI_TIMEOUT)
    math(EXPR _TEST_TIMEOUT "${_ROCPROFSYS_CI_TIMEOUT} + 30")
else()
    set(_TEST_TIMEOUT 150)
endif()

add_test("selective-region-pause-no-marker-before-start-stop-sampling" "${_ROCPROFSYS_EXE}" "${_ROCPROFSYS_EXE_ARGS}" "${_ROCPROFSYS_NODEID_PFX}test_selective_regions.py::TestSelectiveRegionPause::test_no_marker[before-start_stop-sampling]" ${_ROCPROFSYS_EXTRA_ARGS})
set_tests_properties("selective-region-pause-no-marker-before-start-stop-sampling" PROPERTIES
    LABELS "gpu;rocm;sampling;selective_regions"
    TIMEOUT ${_TEST_TIMEOUT}
    SKIP_RETURN_CODE 77
    FIXTURES_REQUIRED "rocprofsys-global-tmp-files"
)

if(DEFINED _ROCPROFSYS_CI_TIMEOUT)
    math(EXPR _TEST_TIMEOUT "${_ROCPROFSYS_CI_TIMEOUT} + 30")
else()
    set(_TEST_TIMEOUT 150)
endif()

add_test("selective-region-pause-no-marker-before-push-pop-sys-run" "${_ROCPROFSYS_EXE}" "${_ROCPROFSYS_EXE_ARGS}" "${_ROCPROFSYS_NODEID_PFX}test_selective_regions.py::TestSelectiveRegionPause::test_no_marker[before-push_pop-sys_run]" ${_ROCPROFSYS_EXTRA_ARGS})
set_tests_properties("selective-region-pause-no-marker-before-push-pop-sys-run" PROPERTIES
    LABELS "gpu;rocm;selective_regions;sys_run"
    TIMEOUT ${_TEST_TIMEOUT}
    SKIP_RETURN_CODE 77
    FIXTURES_REQUIRED "rocprofsys-global-tmp-files"
)

if(DEFINED _ROCPROFSYS_CI_TIMEOUT)
    math(EXPR _TEST_TIMEOUT "${_ROCPROFSYS_CI_TIMEOUT} + 30")
else()
    set(_TEST_TIMEOUT 150)
endif()

add_test("selective-region-pause-no-marker-before-push-pop-sampling" "${_ROCPROFSYS_EXE}" "${_ROCPROFSYS_EXE_ARGS}" "${_ROCPROFSYS_NODEID_PFX}test_selective_regions.py::TestSelectiveRegionPause::test_no_marker[before-push_pop-sampling]" ${_ROCPROFSYS_EXTRA_ARGS})
set_tests_properties("selective-region-pause-no-marker-before-push-pop-sampling" PROPERTIES
    LABELS "gpu;rocm;sampling;selective_regions"
    TIMEOUT ${_TEST_TIMEOUT}
    SKIP_RETURN_CODE 77
    FIXTURES_REQUIRED "rocprofsys-global-tmp-files"
)

if(DEFINED _ROCPROFSYS_CI_TIMEOUT)
    math(EXPR _TEST_TIMEOUT "${_ROCPROFSYS_CI_TIMEOUT} + 30")
else()
    set(_TEST_TIMEOUT 150)
endif()

add_test("selective-region-pause-no-marker-outside-start-stop-sys-run" "${_ROCPROFSYS_EXE}" "${_ROCPROFSYS_EXE_ARGS}" "${_ROCPROFSYS_NODEID_PFX}test_selective_regions.py::TestSelectiveRegionPause::test_no_marker[outside-start_stop-sys_run]" ${_ROCPROFSYS_EXTRA_ARGS})
set_tests_properties("selective-region-pause-no-marker-outside-start-stop-sys-run" PROPERTIES
    LABELS "gpu;rocm;selective_regions;sys_run"
    TIMEOUT ${_TEST_TIMEOUT}
    SKIP_RETURN_CODE 77
    FIXTURES_REQUIRED "rocprofsys-global-tmp-files"
)

if(DEFINED _ROCPROFSYS_CI_TIMEOUT)
    math(EXPR _TEST_TIMEOUT "${_ROCPROFSYS_CI_TIMEOUT} + 30")
else()
    set(_TEST_TIMEOUT 150)
endif()

add_test("selective-region-pause-no-marker-outside-start-stop-sampling" "${_ROCPROFSYS_EXE}" "${_ROCPROFSYS_EXE_ARGS}" "${_ROCPROFSYS_NODEID_PFX}test_selective_regions.py::TestSelectiveRegionPause::test_no_marker[outside-start_stop-sampling]" ${_ROCPROFSYS_EXTRA_ARGS})
set_tests_properties("selective-region-pause-no-marker-outside-start-stop-sampling" PROPERTIES
    LABELS "gpu;rocm;sampling;selective_regions"
    TIMEOUT ${_TEST_TIMEOUT}
    SKIP_RETURN_CODE 77
    FIXTURES_REQUIRED "rocprofsys-global-tmp-files"
)

if(DEFINED _ROCPROFSYS_CI_TIMEOUT)
    math(EXPR _TEST_TIMEOUT "${_ROCPROFSYS_CI_TIMEOUT} + 30")
else()
    set(_TEST_TIMEOUT 150)
endif()

add_test("selective-region-pause-no-marker-outside-push-pop-sys-run" "${_ROCPROFSYS_EXE}" "${_ROCPROFSYS_EXE_ARGS}" "${_ROCPROFSYS_NODEID_PFX}test_selective_regions.py::TestSelectiveRegionPause::test_no_marker[outside-push_pop-sys_run]" ${_ROCPROFSYS_EXTRA_ARGS})
set_tests_properties("selective-region-pause-no-marker-outside-push-pop-sys-run" PROPERTIES
    LABELS "gpu;rocm;selective_regions;sys_run"
    TIMEOUT ${_TEST_TIMEOUT}
    SKIP_RETURN_CODE 77
    FIXTURES_REQUIRED "rocprofsys-global-tmp-files"
)

if(DEFINED _ROCPROFSYS_CI_TIMEOUT)
    math(EXPR _TEST_TIMEOUT "${_ROCPROFSYS_CI_TIMEOUT} + 30")
else()
    set(_TEST_TIMEOUT 150)
endif()

add_test("selective-region-pause-no-marker-outside-push-pop-sampling" "${_ROCPROFSYS_EXE}" "${_ROCPROFSYS_EXE_ARGS}" "${_ROCPROFSYS_NODEID_PFX}test_selective_regions.py::TestSelectiveRegionPause::test_no_marker[outside-push_pop-sampling]" ${_ROCPROFSYS_EXTRA_ARGS})
set_tests_properties("selective-region-pause-no-marker-outside-push-pop-sampling" PROPERTIES
    LABELS "gpu;rocm;sampling;selective_regions"
    TIMEOUT ${_TEST_TIMEOUT}
    SKIP_RETURN_CODE 77
    FIXTURES_REQUIRED "rocprofsys-global-tmp-files"
)

if(DEFINED _ROCPROFSYS_CI_TIMEOUT)
    math(EXPR _TEST_TIMEOUT "${_ROCPROFSYS_CI_TIMEOUT} + 30")
else()
    set(_TEST_TIMEOUT 150)
endif()

add_test("selective-region-no-marker-region-1-filter-start-stop-sys-run" "${_ROCPROFSYS_EXE}" "${_ROCPROFSYS_EXE_ARGS}" "${_ROCPROFSYS_NODEID_PFX}test_selective_regions.py::TestSelectiveRegionNoMarker::test_region_1_filter[start_stop-sys_run]" ${_ROCPROFSYS_EXTRA_ARGS})
set_tests_properties("selective-region-no-marker-region-1-filter-start-stop-sys-run" PROPERTIES
    LABELS "gpu;rocm;selective_regions;sys_run"
    TIMEOUT ${_TEST_TIMEOUT}
    SKIP_RETURN_CODE 77
    FIXTURES_REQUIRED "rocprofsys-global-tmp-files"
)

if(DEFINED _ROCPROFSYS_CI_TIMEOUT)
    math(EXPR _TEST_TIMEOUT "${_ROCPROFSYS_CI_TIMEOUT} + 30")
else()
    set(_TEST_TIMEOUT 150)
endif()

add_test("selective-region-no-marker-region-1-filter-start-stop-sampling" "${_ROCPROFSYS_EXE}" "${_ROCPROFSYS_EXE_ARGS}" "${_ROCPROFSYS_NODEID_PFX}test_selective_regions.py::TestSelectiveRegionNoMarker::test_region_1_filter[start_stop-sampling]" ${_ROCPROFSYS_EXTRA_ARGS})
set_tests_properties("selective-region-no-marker-region-1-filter-start-stop-sampling" PROPERTIES
    LABELS "gpu;rocm;sampling;selective_regions"
    TIMEOUT ${_TEST_TIMEOUT}
    SKIP_RETURN_CODE 77
    FIXTURES_REQUIRED "rocprofsys-global-tmp-files"
)

if(DEFINED _ROCPROFSYS_CI_TIMEOUT)
    math(EXPR _TEST_TIMEOUT "${_ROCPROFSYS_CI_TIMEOUT} + 30")
else()
    set(_TEST_TIMEOUT 150)
endif()

add_test("selective-region-no-marker-region-1-filter-push-pop-sys-run" "${_ROCPROFSYS_EXE}" "${_ROCPROFSYS_EXE_ARGS}" "${_ROCPROFSYS_NODEID_PFX}test_selective_regions.py::TestSelectiveRegionNoMarker::test_region_1_filter[push_pop-sys_run]" ${_ROCPROFSYS_EXTRA_ARGS})
set_tests_properties("selective-region-no-marker-region-1-filter-push-pop-sys-run" PROPERTIES
    LABELS "gpu;rocm;selective_regions;sys_run"
    TIMEOUT ${_TEST_TIMEOUT}
    SKIP_RETURN_CODE 77
    FIXTURES_REQUIRED "rocprofsys-global-tmp-files"
)

if(DEFINED _ROCPROFSYS_CI_TIMEOUT)
    math(EXPR _TEST_TIMEOUT "${_ROCPROFSYS_CI_TIMEOUT} + 30")
else()
    set(_TEST_TIMEOUT 150)
endif()

add_test("selective-region-no-marker-region-1-filter-push-pop-sampling" "${_ROCPROFSYS_EXE}" "${_ROCPROFSYS_EXE_ARGS}" "${_ROCPROFSYS_NODEID_PFX}test_selective_regions.py::TestSelectiveRegionNoMarker::test_region_1_filter[push_pop-sampling]" ${_ROCPROFSYS_EXTRA_ARGS})
set_tests_properties("selective-region-no-marker-region-1-filter-push-pop-sampling" PROPERTIES
    LABELS "gpu;rocm;sampling;selective_regions"
    TIMEOUT ${_TEST_TIMEOUT}
    SKIP_RETURN_CODE 77
    FIXTURES_REQUIRED "rocprofsys-global-tmp-files"
)

if(DEFINED _ROCPROFSYS_CI_TIMEOUT)
    math(EXPR _TEST_TIMEOUT "${_ROCPROFSYS_CI_TIMEOUT} + 30")
else()
    set(_TEST_TIMEOUT 330)
endif()

add_test("shmem-pingpong-baseline" "${_ROCPROFSYS_EXE}" "${_ROCPROFSYS_EXE_ARGS}" "${_ROCPROFSYS_NODEID_PFX}test_shmem.py::TestShmem::test_pingpong[baseline]" ${_ROCPROFSYS_EXTRA_ARGS})
set_tests_properties("shmem-pingpong-baseline" PROPERTIES
    LABELS "baseline;shmem"
    TIMEOUT ${_TEST_TIMEOUT}
    SKIP_RETURN_CODE 77
    FIXTURES_REQUIRED "rocprofsys-global-tmp-files"
    RUN_SERIAL TRUE
)

if(DEFINED _ROCPROFSYS_CI_TIMEOUT)
    math(EXPR _TEST_TIMEOUT "${_ROCPROFSYS_CI_TIMEOUT} + 30")
else()
    set(_TEST_TIMEOUT 330)
endif()

add_test("shmem-pingpong-sampling" "${_ROCPROFSYS_EXE}" "${_ROCPROFSYS_EXE_ARGS}" "${_ROCPROFSYS_NODEID_PFX}test_shmem.py::TestShmem::test_pingpong[sampling]" ${_ROCPROFSYS_EXTRA_ARGS})
set_tests_properties("shmem-pingpong-sampling" PROPERTIES
    LABELS "sampling;shmem"
    TIMEOUT ${_TEST_TIMEOUT}
    SKIP_RETURN_CODE 77
    FIXTURES_REQUIRED "rocprofsys-global-tmp-files"
    RUN_SERIAL TRUE
)

if(DEFINED _ROCPROFSYS_CI_TIMEOUT)
    math(EXPR _TEST_TIMEOUT "${_ROCPROFSYS_CI_TIMEOUT} + 30")
else()
    set(_TEST_TIMEOUT 330)
endif()

add_test("shmem-pingpong-sys-run" "${_ROCPROFSYS_EXE}" "${_ROCPROFSYS_EXE_ARGS}" "${_ROCPROFSYS_NODEID_PFX}test_shmem.py::TestShmem::test_pingpong[sys_run]" ${_ROCPROFSYS_EXTRA_ARGS})
set_tests_properties("shmem-pingpong-sys-run" PROPERTIES
    LABELS "rocpd;shmem;sys_run"
    TIMEOUT ${_TEST_TIMEOUT}
    SKIP_RETURN_CODE 77
    FIXTURES_REQUIRED "rocprofsys-global-tmp-files"
    RUN_SERIAL TRUE
)

if(DEFINED _ROCPROFSYS_CI_TIMEOUT)
    math(EXPR _TEST_TIMEOUT "${_ROCPROFSYS_CI_TIMEOUT} + 30")
else()
    set(_TEST_TIMEOUT 510)
endif()

add_test("thread-limit-below-sampling" "${_ROCPROFSYS_EXE}" "${_ROCPROFSYS_EXE_ARGS}" "${_ROCPROFSYS_NODEID_PFX}test_thread_limit.py::TestThreadLimit::test[below-sampling]" ${_ROCPROFSYS_EXTRA_ARGS})
set_tests_properties("thread-limit-below-sampling" PROPERTIES
    LABELS "sampling;thread_limit"
    TIMEOUT ${_TEST_TIMEOUT}
    SKIP_RETURN_CODE 77
    FIXTURES_REQUIRED "rocprofsys-global-tmp-files"
)

if(DEFINED _ROCPROFSYS_CI_TIMEOUT)
    math(EXPR _TEST_TIMEOUT "${_ROCPROFSYS_CI_TIMEOUT} + 30")
else()
    set(_TEST_TIMEOUT 510)
endif()

add_test("thread-limit-below-binary-rewrite" "${_ROCPROFSYS_EXE}" "${_ROCPROFSYS_EXE_ARGS}" "${_ROCPROFSYS_NODEID_PFX}test_thread_limit.py::TestThreadLimit::test[below-binary_rewrite]" ${_ROCPROFSYS_EXTRA_ARGS})
set_tests_properties("thread-limit-below-binary-rewrite" PROPERTIES
    LABELS "binary_rewrite;thread_limit"
    TIMEOUT ${_TEST_TIMEOUT}
    SKIP_RETURN_CODE 77
    FIXTURES_REQUIRED "rocprofsys-global-tmp-files"
)

if(DEFINED _ROCPROFSYS_CI_TIMEOUT)
    math(EXPR _TEST_TIMEOUT "${_ROCPROFSYS_CI_TIMEOUT} + 30")
else()
    set(_TEST_TIMEOUT 510)
endif()

add_test("thread-limit-below-runtime-instrument" "${_ROCPROFSYS_EXE}" "${_ROCPROFSYS_EXE_ARGS}" "${_ROCPROFSYS_NODEID_PFX}test_thread_limit.py::TestThreadLimit::test[below-runtime_instrument]" ${_ROCPROFSYS_EXTRA_ARGS})
set_tests_properties("thread-limit-below-runtime-instrument" PROPERTIES
    LABELS "runtime_instrument;thread_limit"
    TIMEOUT ${_TEST_TIMEOUT}
    SKIP_RETURN_CODE 77
    FIXTURES_REQUIRED "rocprofsys-global-tmp-files"
)

if(DEFINED _ROCPROFSYS_CI_TIMEOUT)
    math(EXPR _TEST_TIMEOUT "${_ROCPROFSYS_CI_TIMEOUT} + 30")
else()
    set(_TEST_TIMEOUT 510)
endif()

add_test("thread-limit-below-sys-run" "${_ROCPROFSYS_EXE}" "${_ROCPROFSYS_EXE_ARGS}" "${_ROCPROFSYS_NODEID_PFX}test_thread_limit.py::TestThreadLimit::test[below-sys_run]" ${_ROCPROFSYS_EXTRA_ARGS})
set_tests_properties("thread-limit-below-sys-run" PROPERTIES
    LABELS "sys_run;thread_limit"
    TIMEOUT ${_TEST_TIMEOUT}
    SKIP_RETURN_CODE 77
    FIXTURES_REQUIRED "rocprofsys-global-tmp-files"
)

if(DEFINED _ROCPROFSYS_CI_TIMEOUT)
    math(EXPR _TEST_TIMEOUT "${_ROCPROFSYS_CI_TIMEOUT} + 30")
else()
    set(_TEST_TIMEOUT 510)
endif()

add_test("thread-limit-above-sampling" "${_ROCPROFSYS_EXE}" "${_ROCPROFSYS_EXE_ARGS}" "${_ROCPROFSYS_NODEID_PFX}test_thread_limit.py::TestThreadLimit::test[above-sampling]" ${_ROCPROFSYS_EXTRA_ARGS})
set_tests_properties("thread-limit-above-sampling" PROPERTIES
    LABELS "sampling;thread_limit"
    TIMEOUT ${_TEST_TIMEOUT}
    SKIP_RETURN_CODE 77
    FIXTURES_REQUIRED "rocprofsys-global-tmp-files"
)

if(DEFINED _ROCPROFSYS_CI_TIMEOUT)
    math(EXPR _TEST_TIMEOUT "${_ROCPROFSYS_CI_TIMEOUT} + 30")
else()
    set(_TEST_TIMEOUT 510)
endif()

add_test("thread-limit-above-binary-rewrite" "${_ROCPROFSYS_EXE}" "${_ROCPROFSYS_EXE_ARGS}" "${_ROCPROFSYS_NODEID_PFX}test_thread_limit.py::TestThreadLimit::test[above-binary_rewrite]" ${_ROCPROFSYS_EXTRA_ARGS})
set_tests_properties("thread-limit-above-binary-rewrite" PROPERTIES
    LABELS "binary_rewrite;thread_limit"
    TIMEOUT ${_TEST_TIMEOUT}
    SKIP_RETURN_CODE 77
    FIXTURES_REQUIRED "rocprofsys-global-tmp-files"
)

if(DEFINED _ROCPROFSYS_CI_TIMEOUT)
    math(EXPR _TEST_TIMEOUT "${_ROCPROFSYS_CI_TIMEOUT} + 30")
else()
    set(_TEST_TIMEOUT 510)
endif()

add_test("thread-limit-above-runtime-instrument" "${_ROCPROFSYS_EXE}" "${_ROCPROFSYS_EXE_ARGS}" "${_ROCPROFSYS_NODEID_PFX}test_thread_limit.py::TestThreadLimit::test[above-runtime_instrument]" ${_ROCPROFSYS_EXTRA_ARGS})
set_tests_properties("thread-limit-above-runtime-instrument" PROPERTIES
    LABELS "runtime_instrument;thread_limit"
    TIMEOUT ${_TEST_TIMEOUT}
    SKIP_RETURN_CODE 77
    FIXTURES_REQUIRED "rocprofsys-global-tmp-files"
)

if(DEFINED _ROCPROFSYS_CI_TIMEOUT)
    math(EXPR _TEST_TIMEOUT "${_ROCPROFSYS_CI_TIMEOUT} + 30")
else()
    set(_TEST_TIMEOUT 510)
endif()

add_test("thread-limit-above-sys-run" "${_ROCPROFSYS_EXE}" "${_ROCPROFSYS_EXE_ARGS}" "${_ROCPROFSYS_NODEID_PFX}test_thread_limit.py::TestThreadLimit::test[above-sys_run]" ${_ROCPROFSYS_EXTRA_ARGS})
set_tests_properties("thread-limit-above-sys-run" PROPERTIES
    LABELS "sys_run;thread_limit"
    TIMEOUT ${_TEST_TIMEOUT}
    SKIP_RETURN_CODE 77
    FIXTURES_REQUIRED "rocprofsys-global-tmp-files"
)

if(DEFINED _ROCPROFSYS_CI_TIMEOUT)
    math(EXPR _TEST_TIMEOUT "${_ROCPROFSYS_CI_TIMEOUT} + 30")
else()
    set(_TEST_TIMEOUT 510)
endif()

add_test("thread-limit-at-sampling" "${_ROCPROFSYS_EXE}" "${_ROCPROFSYS_EXE_ARGS}" "${_ROCPROFSYS_NODEID_PFX}test_thread_limit.py::TestThreadLimit::test[at-sampling]" ${_ROCPROFSYS_EXTRA_ARGS})
set_tests_properties("thread-limit-at-sampling" PROPERTIES
    LABELS "sampling;thread_limit"
    TIMEOUT ${_TEST_TIMEOUT}
    SKIP_RETURN_CODE 77
    FIXTURES_REQUIRED "rocprofsys-global-tmp-files"
)

if(DEFINED _ROCPROFSYS_CI_TIMEOUT)
    math(EXPR _TEST_TIMEOUT "${_ROCPROFSYS_CI_TIMEOUT} + 30")
else()
    set(_TEST_TIMEOUT 510)
endif()

add_test("thread-limit-at-binary-rewrite" "${_ROCPROFSYS_EXE}" "${_ROCPROFSYS_EXE_ARGS}" "${_ROCPROFSYS_NODEID_PFX}test_thread_limit.py::TestThreadLimit::test[at-binary_rewrite]" ${_ROCPROFSYS_EXTRA_ARGS})
set_tests_properties("thread-limit-at-binary-rewrite" PROPERTIES
    LABELS "binary_rewrite;thread_limit"
    TIMEOUT ${_TEST_TIMEOUT}
    SKIP_RETURN_CODE 77
    FIXTURES_REQUIRED "rocprofsys-global-tmp-files"
)

if(DEFINED _ROCPROFSYS_CI_TIMEOUT)
    math(EXPR _TEST_TIMEOUT "${_ROCPROFSYS_CI_TIMEOUT} + 30")
else()
    set(_TEST_TIMEOUT 510)
endif()

add_test("thread-limit-at-runtime-instrument" "${_ROCPROFSYS_EXE}" "${_ROCPROFSYS_EXE_ARGS}" "${_ROCPROFSYS_NODEID_PFX}test_thread_limit.py::TestThreadLimit::test[at-runtime_instrument]" ${_ROCPROFSYS_EXTRA_ARGS})
set_tests_properties("thread-limit-at-runtime-instrument" PROPERTIES
    LABELS "runtime_instrument;thread_limit"
    TIMEOUT ${_TEST_TIMEOUT}
    SKIP_RETURN_CODE 77
    FIXTURES_REQUIRED "rocprofsys-global-tmp-files"
)

if(DEFINED _ROCPROFSYS_CI_TIMEOUT)
    math(EXPR _TEST_TIMEOUT "${_ROCPROFSYS_CI_TIMEOUT} + 30")
else()
    set(_TEST_TIMEOUT 510)
endif()

add_test("thread-limit-at-sys-run" "${_ROCPROFSYS_EXE}" "${_ROCPROFSYS_EXE_ARGS}" "${_ROCPROFSYS_NODEID_PFX}test_thread_limit.py::TestThreadLimit::test[at-sys_run]" ${_ROCPROFSYS_EXTRA_ARGS})
set_tests_properties("thread-limit-at-sys-run" PROPERTIES
    LABELS "sys_run;thread_limit"
    TIMEOUT ${_TEST_TIMEOUT}
    SKIP_RETURN_CODE 77
    FIXTURES_REQUIRED "rocprofsys-global-tmp-files"
)

if(DEFINED _ROCPROFSYS_CI_TIMEOUT)
    math(EXPR _TEST_TIMEOUT "${_ROCPROFSYS_CI_TIMEOUT} + 30")
else()
    set(_TEST_TIMEOUT 150)
endif()

add_test("trace-time-window-binary-rewrite" "${_ROCPROFSYS_EXE}" "${_ROCPROFSYS_EXE_ARGS}" "${_ROCPROFSYS_NODEID_PFX}test_time_window.py::TestTraceTimeWindow::test[binary_rewrite]" ${_ROCPROFSYS_EXTRA_ARGS})
set_tests_properties("trace-time-window-binary-rewrite" PROPERTIES
    LABELS "binary_rewrite;time_window"
    TIMEOUT ${_TEST_TIMEOUT}
    SKIP_RETURN_CODE 77
    FIXTURES_REQUIRED "rocprofsys-global-tmp-files"
)

if(DEFINED _ROCPROFSYS_CI_TIMEOUT)
    math(EXPR _TEST_TIMEOUT "${_ROCPROFSYS_CI_TIMEOUT} + 30")
else()
    set(_TEST_TIMEOUT 330)
endif()

add_test("trace-time-window-runtime-instrument" "${_ROCPROFSYS_EXE}" "${_ROCPROFSYS_EXE_ARGS}" "${_ROCPROFSYS_NODEID_PFX}test_time_window.py::TestTraceTimeWindow::test[runtime_instrument]" ${_ROCPROFSYS_EXTRA_ARGS})
set_tests_properties("trace-time-window-runtime-instrument" PROPERTIES
    LABELS "runtime_instrument;time_window"
    TIMEOUT ${_TEST_TIMEOUT}
    SKIP_RETURN_CODE 77
    FIXTURES_REQUIRED "rocprofsys-global-tmp-files"
)

if(DEFINED _ROCPROFSYS_CI_TIMEOUT)
    math(EXPR _TEST_TIMEOUT "${_ROCPROFSYS_CI_TIMEOUT} + 30")
else()
    set(_TEST_TIMEOUT 150)
endif()

add_test("trace-time-window-delay-binary-rewrite" "${_ROCPROFSYS_EXE}" "${_ROCPROFSYS_EXE_ARGS}" "${_ROCPROFSYS_NODEID_PFX}test_time_window.py::TestTraceTimeWindow::test_delay[binary_rewrite]" ${_ROCPROFSYS_EXTRA_ARGS})
set_tests_properties("trace-time-window-delay-binary-rewrite" PROPERTIES
    LABELS "binary_rewrite;time_window"
    TIMEOUT ${_TEST_TIMEOUT}
    SKIP_RETURN_CODE 77
    FIXTURES_REQUIRED "rocprofsys-global-tmp-files"
)

if(DEFINED _ROCPROFSYS_CI_TIMEOUT)
    math(EXPR _TEST_TIMEOUT "${_ROCPROFSYS_CI_TIMEOUT} + 30")
else()
    set(_TEST_TIMEOUT 330)
endif()

add_test("trace-time-window-delay-runtime-instrument" "${_ROCPROFSYS_EXE}" "${_ROCPROFSYS_EXE_ARGS}" "${_ROCPROFSYS_NODEID_PFX}test_time_window.py::TestTraceTimeWindow::test_delay[runtime_instrument]" ${_ROCPROFSYS_EXTRA_ARGS})
set_tests_properties("trace-time-window-delay-runtime-instrument" PROPERTIES
    LABELS "runtime_instrument;time_window"
    TIMEOUT ${_TEST_TIMEOUT}
    SKIP_RETURN_CODE 77
    FIXTURES_REQUIRED "rocprofsys-global-tmp-files"
)

if(DEFINED _ROCPROFSYS_CI_TIMEOUT)
    math(EXPR _TEST_TIMEOUT "${_ROCPROFSYS_CI_TIMEOUT} + 30")
else()
    set(_TEST_TIMEOUT 60)
endif()

add_test("tool-runner-replace-env-preset-replaces-shell-env-run" "${_ROCPROFSYS_EXE}" "${_ROCPROFSYS_EXE_ARGS}" "${_ROCPROFSYS_NODEID_PFX}test_tool_runner.py::TestReplaceEnvNoDuplicates::test_preset_replaces_shell_env[run]" ${_ROCPROFSYS_EXTRA_ARGS})
set_tests_properties("tool-runner-replace-env-preset-replaces-shell-env-run" PROPERTIES
    LABELS "presets;sys_run"
    TIMEOUT ${_TEST_TIMEOUT}
    SKIP_RETURN_CODE 77
    FIXTURES_REQUIRED "rocprofsys-global-tmp-files"
)

if(DEFINED _ROCPROFSYS_CI_TIMEOUT)
    math(EXPR _TEST_TIMEOUT "${_ROCPROFSYS_CI_TIMEOUT} + 30")
else()
    set(_TEST_TIMEOUT 60)
endif()

add_test("tool-runner-replace-env-preset-replaces-shell-env-sample" "${_ROCPROFSYS_EXE}" "${_ROCPROFSYS_EXE_ARGS}" "${_ROCPROFSYS_NODEID_PFX}test_tool_runner.py::TestReplaceEnvNoDuplicates::test_preset_replaces_shell_env[sample]" ${_ROCPROFSYS_EXTRA_ARGS})
set_tests_properties("tool-runner-replace-env-preset-replaces-shell-env-sample" PROPERTIES
    LABELS "presets;sampling"
    TIMEOUT ${_TEST_TIMEOUT}
    SKIP_RETURN_CODE 77
    FIXTURES_REQUIRED "rocprofsys-global-tmp-files"
)

if(DEFINED _ROCPROFSYS_CI_TIMEOUT)
    math(EXPR _TEST_TIMEOUT "${_ROCPROFSYS_CI_TIMEOUT} + 30")
else()
    set(_TEST_TIMEOUT 60)
endif()

add_test("tool-runner-profile-conflict-profile-and-flat-profile-rejected-run" "${_ROCPROFSYS_EXE}" "${_ROCPROFSYS_EXE_ARGS}" "${_ROCPROFSYS_NODEID_PFX}test_tool_runner.py::TestProfileFlatProfileConflict::test_profile_and_flat_profile_rejected[run]" ${_ROCPROFSYS_EXTRA_ARGS})
set_tests_properties("tool-runner-profile-conflict-profile-and-flat-profile-rejected-run" PROPERTIES
    LABELS "presets;sys_run"
    TIMEOUT ${_TEST_TIMEOUT}
    SKIP_RETURN_CODE 77
    FIXTURES_REQUIRED "rocprofsys-global-tmp-files"
)

if(DEFINED _ROCPROFSYS_CI_TIMEOUT)
    math(EXPR _TEST_TIMEOUT "${_ROCPROFSYS_CI_TIMEOUT} + 30")
else()
    set(_TEST_TIMEOUT 60)
endif()

add_test("tool-runner-profile-conflict-profile-and-flat-profile-rejected-sample" "${_ROCPROFSYS_EXE}" "${_ROCPROFSYS_EXE_ARGS}" "${_ROCPROFSYS_NODEID_PFX}test_tool_runner.py::TestProfileFlatProfileConflict::test_profile_and_flat_profile_rejected[sample]" ${_ROCPROFSYS_EXTRA_ARGS})
set_tests_properties("tool-runner-profile-conflict-profile-and-flat-profile-rejected-sample" PROPERTIES
    LABELS "presets;sampling"
    TIMEOUT ${_TEST_TIMEOUT}
    SKIP_RETURN_CODE 77
    FIXTURES_REQUIRED "rocprofsys-global-tmp-files"
)

if(DEFINED _ROCPROFSYS_CI_TIMEOUT)
    math(EXPR _TEST_TIMEOUT "${_ROCPROFSYS_CI_TIMEOUT} + 30")
else()
    set(_TEST_TIMEOUT 330)
endif()

add_test("transpose-baseline" "${_ROCPROFSYS_EXE}" "${_ROCPROFSYS_EXE_ARGS}" "${_ROCPROFSYS_NODEID_PFX}test_transpose.py::TestTranspose::test[baseline]" ${_ROCPROFSYS_EXTRA_ARGS})
set_tests_properties("transpose-baseline" PROPERTIES
    LABELS "baseline;gpu;rocm;transpose"
    TIMEOUT ${_TEST_TIMEOUT}
    SKIP_RETURN_CODE 77
    FIXTURES_REQUIRED "rocprofsys-global-tmp-files"
)

if(DEFINED _ROCPROFSYS_CI_TIMEOUT)
    math(EXPR _TEST_TIMEOUT "${_ROCPROFSYS_CI_TIMEOUT} + 30")
else()
    set(_TEST_TIMEOUT 330)
endif()

add_test("transpose-binary-rewrite" "${_ROCPROFSYS_EXE}" "${_ROCPROFSYS_EXE_ARGS}" "${_ROCPROFSYS_NODEID_PFX}test_transpose.py::TestTranspose::test[binary_rewrite]" ${_ROCPROFSYS_EXTRA_ARGS})
set_tests_properties("transpose-binary-rewrite" PROPERTIES
    LABELS "binary_rewrite;gpu;rocm;transpose"
    TIMEOUT ${_TEST_TIMEOUT}
    SKIP_RETURN_CODE 77
    FIXTURES_REQUIRED "rocprofsys-global-tmp-files"
)

if(DEFINED _ROCPROFSYS_CI_TIMEOUT)
    math(EXPR _TEST_TIMEOUT "${_ROCPROFSYS_CI_TIMEOUT} + 30")
else()
    set(_TEST_TIMEOUT 330)
endif()

add_test("transpose-runtime-instrument" "${_ROCPROFSYS_EXE}" "${_ROCPROFSYS_EXE_ARGS}" "${_ROCPROFSYS_NODEID_PFX}test_transpose.py::TestTranspose::test[runtime_instrument]" ${_ROCPROFSYS_EXTRA_ARGS})
set_tests_properties("transpose-runtime-instrument" PROPERTIES
    LABELS "gpu;rocm;runtime_instrument;transpose"
    TIMEOUT ${_TEST_TIMEOUT}
    SKIP_RETURN_CODE 77
    FIXTURES_REQUIRED "rocprofsys-global-tmp-files"
)

if(DEFINED _ROCPROFSYS_CI_TIMEOUT)
    math(EXPR _TEST_TIMEOUT "${_ROCPROFSYS_CI_TIMEOUT} + 30")
else()
    set(_TEST_TIMEOUT 330)
endif()

add_test("transpose-sys-run" "${_ROCPROFSYS_EXE}" "${_ROCPROFSYS_EXE_ARGS}" "${_ROCPROFSYS_NODEID_PFX}test_transpose.py::TestTranspose::test[sys_run]" ${_ROCPROFSYS_EXTRA_ARGS})
set_tests_properties("transpose-sys-run" PROPERTIES
    LABELS "gpu;rocm;sys_run;transpose"
    TIMEOUT ${_TEST_TIMEOUT}
    SKIP_RETURN_CODE 77
    FIXTURES_REQUIRED "rocprofsys-global-tmp-files"
)

if(DEFINED _ROCPROFSYS_CI_TIMEOUT)
    math(EXPR _TEST_TIMEOUT "${_ROCPROFSYS_CI_TIMEOUT} + 30")
else()
    set(_TEST_TIMEOUT 150)
endif()

add_test("transpose-sampling" "${_ROCPROFSYS_EXE}" "${_ROCPROFSYS_EXE_ARGS}" "${_ROCPROFSYS_NODEID_PFX}test_transpose.py::TestTranspose::test_sampling" ${_ROCPROFSYS_EXTRA_ARGS})
set_tests_properties("transpose-sampling" PROPERTIES
    LABELS "gpu;rocm;rocpd;transpose"
    TIMEOUT ${_TEST_TIMEOUT}
    SKIP_RETURN_CODE 77
    FIXTURES_REQUIRED "rocprofsys-global-tmp-files"
)

if(DEFINED _ROCPROFSYS_CI_TIMEOUT)
    math(EXPR _TEST_TIMEOUT "${_ROCPROFSYS_CI_TIMEOUT} + 30")
else()
    set(_TEST_TIMEOUT 150)
endif()

add_test("transpose-two-kernels-sampling" "${_ROCPROFSYS_EXE}" "${_ROCPROFSYS_EXE_ARGS}" "${_ROCPROFSYS_NODEID_PFX}test_transpose.py::TestTranspose::test_two_kernels[sampling]" ${_ROCPROFSYS_EXTRA_ARGS})
set_tests_properties("transpose-two-kernels-sampling" PROPERTIES
    LABELS "gpu;rocm;sampling;transpose"
    TIMEOUT ${_TEST_TIMEOUT}
    SKIP_RETURN_CODE 77
    FIXTURES_REQUIRED "rocprofsys-global-tmp-files"
)

if(DEFINED _ROCPROFSYS_CI_TIMEOUT)
    math(EXPR _TEST_TIMEOUT "${_ROCPROFSYS_CI_TIMEOUT} + 30")
else()
    set(_TEST_TIMEOUT 330)
endif()

add_test("transpose-two-kernels-sys-run" "${_ROCPROFSYS_EXE}" "${_ROCPROFSYS_EXE_ARGS}" "${_ROCPROFSYS_NODEID_PFX}test_transpose.py::TestTranspose::test_two_kernels[sys_run]" ${_ROCPROFSYS_EXTRA_ARGS})
set_tests_properties("transpose-two-kernels-sys-run" PROPERTIES
    LABELS "gpu;rocm;sys_run;transpose"
    TIMEOUT ${_TEST_TIMEOUT}
    SKIP_RETURN_CODE 77
    FIXTURES_REQUIRED "rocprofsys-global-tmp-files"
)

if(DEFINED _ROCPROFSYS_CI_TIMEOUT)
    math(EXPR _TEST_TIMEOUT "${_ROCPROFSYS_CI_TIMEOUT} + 30")
else()
    set(_TEST_TIMEOUT 150)
endif()

add_test("transpose-loops-sampling" "${_ROCPROFSYS_EXE}" "${_ROCPROFSYS_EXE_ARGS}" "${_ROCPROFSYS_NODEID_PFX}test_transpose.py::TestTranspose::test_loops[sampling]" ${_ROCPROFSYS_EXTRA_ARGS})
set_tests_properties("transpose-loops-sampling" PROPERTIES
    LABELS "gpu;loops;rocm;sampling;transpose"
    TIMEOUT ${_TEST_TIMEOUT}
    SKIP_RETURN_CODE 77
    FIXTURES_REQUIRED "rocprofsys-global-tmp-files"
)

if(DEFINED _ROCPROFSYS_CI_TIMEOUT)
    math(EXPR _TEST_TIMEOUT "${_ROCPROFSYS_CI_TIMEOUT} + 30")
else()
    set(_TEST_TIMEOUT 150)
endif()

add_test("transpose-loops-binary-rewrite" "${_ROCPROFSYS_EXE}" "${_ROCPROFSYS_EXE_ARGS}" "${_ROCPROFSYS_NODEID_PFX}test_transpose.py::TestTranspose::test_loops[binary_rewrite]" ${_ROCPROFSYS_EXTRA_ARGS})
set_tests_properties("transpose-loops-binary-rewrite" PROPERTIES
    LABELS "binary_rewrite;gpu;loops;rocm;transpose"
    TIMEOUT ${_TEST_TIMEOUT}
    SKIP_RETURN_CODE 77
    FIXTURES_REQUIRED "rocprofsys-global-tmp-files"
)

if(DEFINED _ROCPROFSYS_CI_TIMEOUT)
    math(EXPR _TEST_TIMEOUT "${_ROCPROFSYS_CI_TIMEOUT} + 30")
else()
    set(_TEST_TIMEOUT 150)
endif()

add_test("transpose-parametrized-1-16-16-sampling" "${_ROCPROFSYS_EXE}" "${_ROCPROFSYS_EXE_ARGS}" "${_ROCPROFSYS_NODEID_PFX}test_transpose.py::TestTranspose::test_parametrized[1-16-16-sampling]" ${_ROCPROFSYS_EXTRA_ARGS})
set_tests_properties("transpose-parametrized-1-16-16-sampling" PROPERTIES
    LABELS "gpu;rocm;sampling;transpose"
    TIMEOUT ${_TEST_TIMEOUT}
    SKIP_RETURN_CODE 77
    FIXTURES_REQUIRED "rocprofsys-global-tmp-files"
)

if(DEFINED _ROCPROFSYS_CI_TIMEOUT)
    math(EXPR _TEST_TIMEOUT "${_ROCPROFSYS_CI_TIMEOUT} + 30")
else()
    set(_TEST_TIMEOUT 150)
endif()

add_test("transpose-parametrized-1-16-16-sys-run" "${_ROCPROFSYS_EXE}" "${_ROCPROFSYS_EXE_ARGS}" "${_ROCPROFSYS_NODEID_PFX}test_transpose.py::TestTranspose::test_parametrized[1-16-16-sys_run]" ${_ROCPROFSYS_EXTRA_ARGS})
set_tests_properties("transpose-parametrized-1-16-16-sys-run" PROPERTIES
    LABELS "gpu;rocm;sys_run;transpose"
    TIMEOUT ${_TEST_TIMEOUT}
    SKIP_RETURN_CODE 77
    FIXTURES_REQUIRED "rocprofsys-global-tmp-files"
)

if(DEFINED _ROCPROFSYS_CI_TIMEOUT)
    math(EXPR _TEST_TIMEOUT "${_ROCPROFSYS_CI_TIMEOUT} + 30")
else()
    set(_TEST_TIMEOUT 150)
endif()

add_test("transpose-parametrized-2-32-32-sampling" "${_ROCPROFSYS_EXE}" "${_ROCPROFSYS_EXE_ARGS}" "${_ROCPROFSYS_NODEID_PFX}test_transpose.py::TestTranspose::test_parametrized[2-32-32-sampling]" ${_ROCPROFSYS_EXTRA_ARGS})
set_tests_properties("transpose-parametrized-2-32-32-sampling" PROPERTIES
    LABELS "gpu;rocm;sampling;transpose"
    TIMEOUT ${_TEST_TIMEOUT}
    SKIP_RETURN_CODE 77
    FIXTURES_REQUIRED "rocprofsys-global-tmp-files"
)

if(DEFINED _ROCPROFSYS_CI_TIMEOUT)
    math(EXPR _TEST_TIMEOUT "${_ROCPROFSYS_CI_TIMEOUT} + 30")
else()
    set(_TEST_TIMEOUT 150)
endif()

add_test("transpose-parametrized-2-32-32-sys-run" "${_ROCPROFSYS_EXE}" "${_ROCPROFSYS_EXE_ARGS}" "${_ROCPROFSYS_NODEID_PFX}test_transpose.py::TestTranspose::test_parametrized[2-32-32-sys_run]" ${_ROCPROFSYS_EXTRA_ARGS})
set_tests_properties("transpose-parametrized-2-32-32-sys-run" PROPERTIES
    LABELS "gpu;rocm;sys_run;transpose"
    TIMEOUT ${_TEST_TIMEOUT}
    SKIP_RETURN_CODE 77
    FIXTURES_REQUIRED "rocprofsys-global-tmp-files"
)

if(DEFINED _ROCPROFSYS_CI_TIMEOUT)
    math(EXPR _TEST_TIMEOUT "${_ROCPROFSYS_CI_TIMEOUT} + 30")
else()
    set(_TEST_TIMEOUT 150)
endif()

add_test("transpose-parametrized-5-64-64-sampling" "${_ROCPROFSYS_EXE}" "${_ROCPROFSYS_EXE_ARGS}" "${_ROCPROFSYS_NODEID_PFX}test_transpose.py::TestTranspose::test_parametrized[5-64-64-sampling]" ${_ROCPROFSYS_EXTRA_ARGS})
set_tests_properties("transpose-parametrized-5-64-64-sampling" PROPERTIES
    LABELS "gpu;rocm;sampling;transpose"
    TIMEOUT ${_TEST_TIMEOUT}
    SKIP_RETURN_CODE 77
    FIXTURES_REQUIRED "rocprofsys-global-tmp-files"
)

if(DEFINED _ROCPROFSYS_CI_TIMEOUT)
    math(EXPR _TEST_TIMEOUT "${_ROCPROFSYS_CI_TIMEOUT} + 30")
else()
    set(_TEST_TIMEOUT 150)
endif()

add_test("transpose-parametrized-5-64-64-sys-run" "${_ROCPROFSYS_EXE}" "${_ROCPROFSYS_EXE_ARGS}" "${_ROCPROFSYS_NODEID_PFX}test_transpose.py::TestTranspose::test_parametrized[5-64-64-sys_run]" ${_ROCPROFSYS_EXTRA_ARGS})
set_tests_properties("transpose-parametrized-5-64-64-sys-run" PROPERTIES
    LABELS "gpu;rocm;sys_run;transpose"
    TIMEOUT ${_TEST_TIMEOUT}
    SKIP_RETURN_CODE 77
    FIXTURES_REQUIRED "rocprofsys-global-tmp-files"
)

if(DEFINED _ROCPROFSYS_CI_TIMEOUT)
    math(EXPR _TEST_TIMEOUT "${_ROCPROFSYS_CI_TIMEOUT} + 30")
else()
    set(_TEST_TIMEOUT 150)
endif()

add_test("transpose-hip-stream-group-by-queue-sampling" "${_ROCPROFSYS_EXE}" "${_ROCPROFSYS_EXE_ARGS}" "${_ROCPROFSYS_NODEID_PFX}test_transpose.py::TestTranspose::test_hip_stream[group-by-queue-sampling]" ${_ROCPROFSYS_EXTRA_ARGS})
set_tests_properties("transpose-hip-stream-group-by-queue-sampling" PROPERTIES
    LABELS "gpu;group_by_queue;hip_stream;rocm;sampling;transpose"
    TIMEOUT ${_TEST_TIMEOUT}
    SKIP_RETURN_CODE 77
    FIXTURES_REQUIRED "rocprofsys-global-tmp-files"
)

if(DEFINED _ROCPROFSYS_CI_TIMEOUT)
    math(EXPR _TEST_TIMEOUT "${_ROCPROFSYS_CI_TIMEOUT} + 30")
else()
    set(_TEST_TIMEOUT 150)
endif()

add_test("transpose-hip-stream-group-by-queue-sys-run" "${_ROCPROFSYS_EXE}" "${_ROCPROFSYS_EXE_ARGS}" "${_ROCPROFSYS_NODEID_PFX}test_transpose.py::TestTranspose::test_hip_stream[group-by-queue-sys_run]" ${_ROCPROFSYS_EXTRA_ARGS})
set_tests_properties("transpose-hip-stream-group-by-queue-sys-run" PROPERTIES
    LABELS "gpu;group_by_queue;hip_stream;rocm;sys_run;transpose"
    TIMEOUT ${_TEST_TIMEOUT}
    SKIP_RETURN_CODE 77
    FIXTURES_REQUIRED "rocprofsys-global-tmp-files"
)

if(DEFINED _ROCPROFSYS_CI_TIMEOUT)
    math(EXPR _TEST_TIMEOUT "${_ROCPROFSYS_CI_TIMEOUT} + 30")
else()
    set(_TEST_TIMEOUT 150)
endif()

add_test("transpose-hip-stream-group-by-stream-sampling" "${_ROCPROFSYS_EXE}" "${_ROCPROFSYS_EXE_ARGS}" "${_ROCPROFSYS_NODEID_PFX}test_transpose.py::TestTranspose::test_hip_stream[group-by-stream-sampling]" ${_ROCPROFSYS_EXTRA_ARGS})
set_tests_properties("transpose-hip-stream-group-by-stream-sampling" PROPERTIES
    LABELS "gpu;group_by_stream;hip_stream;rocm;sampling;transpose"
    TIMEOUT ${_TEST_TIMEOUT}
    SKIP_RETURN_CODE 77
    FIXTURES_REQUIRED "rocprofsys-global-tmp-files"
)

if(DEFINED _ROCPROFSYS_CI_TIMEOUT)
    math(EXPR _TEST_TIMEOUT "${_ROCPROFSYS_CI_TIMEOUT} + 30")
else()
    set(_TEST_TIMEOUT 150)
endif()

add_test("transpose-hip-stream-group-by-stream-sys-run" "${_ROCPROFSYS_EXE}" "${_ROCPROFSYS_EXE_ARGS}" "${_ROCPROFSYS_NODEID_PFX}test_transpose.py::TestTranspose::test_hip_stream[group-by-stream-sys_run]" ${_ROCPROFSYS_EXTRA_ARGS})
set_tests_properties("transpose-hip-stream-group-by-stream-sys-run" PROPERTIES
    LABELS "gpu;group_by_stream;hip_stream;rocm;sys_run;transpose"
    TIMEOUT ${_TEST_TIMEOUT}
    SKIP_RETURN_CODE 77
    FIXTURES_REQUIRED "rocprofsys-global-tmp-files"
)

if(DEFINED _ROCPROFSYS_CI_TIMEOUT)
    math(EXPR _TEST_TIMEOUT "${_ROCPROFSYS_CI_TIMEOUT} + 30")
else()
    set(_TEST_TIMEOUT 150)
endif()

add_test("transpose-rocprofiler-sampling" "${_ROCPROFSYS_EXE}" "${_ROCPROFSYS_EXE_ARGS}" "${_ROCPROFSYS_NODEID_PFX}test_transpose.py::TestTransposeROCProfiler::test[sampling]" ${_ROCPROFSYS_EXTRA_ARGS})
set_tests_properties("transpose-rocprofiler-sampling" PROPERTIES
    LABELS "gpu;rocm;rocpd;rocprofiler;sampling;transpose"
    TIMEOUT ${_TEST_TIMEOUT}
    SKIP_RETURN_CODE 77
    FIXTURES_REQUIRED "rocprofsys-global-tmp-files"
)

if(DEFINED _ROCPROFSYS_CI_TIMEOUT)
    math(EXPR _TEST_TIMEOUT "${_ROCPROFSYS_CI_TIMEOUT} + 30")
else()
    set(_TEST_TIMEOUT 150)
endif()

add_test("transpose-rocprofiler-binary-rewrite" "${_ROCPROFSYS_EXE}" "${_ROCPROFSYS_EXE_ARGS}" "${_ROCPROFSYS_NODEID_PFX}test_transpose.py::TestTransposeROCProfiler::test[binary_rewrite]" ${_ROCPROFSYS_EXTRA_ARGS})
set_tests_properties("transpose-rocprofiler-binary-rewrite" PROPERTIES
    LABELS "binary_rewrite;gpu;rocm;rocpd;rocprofiler;transpose"
    TIMEOUT ${_TEST_TIMEOUT}
    SKIP_RETURN_CODE 77
    FIXTURES_REQUIRED "rocprofsys-global-tmp-files"
)

if(DEFINED _ROCPROFSYS_CI_TIMEOUT)
    math(EXPR _TEST_TIMEOUT "${_ROCPROFSYS_CI_TIMEOUT} + 30")
else()
    set(_TEST_TIMEOUT 330)
endif()

add_test("transpose-gpu-perf-counters" "${_ROCPROFSYS_EXE}" "${_ROCPROFSYS_EXE_ARGS}" "${_ROCPROFSYS_NODEID_PFX}test_transpose.py::TestTransposeGPUPerfCounters::test" ${_ROCPROFSYS_EXTRA_ARGS})
set_tests_properties("transpose-gpu-perf-counters" PROPERTIES
    LABELS "gpu;rocm;rocpd;rocprofiler;transpose"
    TIMEOUT ${_TEST_TIMEOUT}
    SKIP_RETURN_CODE 77
    FIXTURES_REQUIRED "rocprofsys-global-tmp-files"
)

if(DEFINED _ROCPROFSYS_CI_TIMEOUT)
    math(EXPR _TEST_TIMEOUT "${_ROCPROFSYS_CI_TIMEOUT} + 30")
else()
    set(_TEST_TIMEOUT 330)
endif()

add_test("ucx-mpi-all2all-binary-rewrite" "${_ROCPROFSYS_EXE}" "${_ROCPROFSYS_EXE_ARGS}" "${_ROCPROFSYS_NODEID_PFX}test_ucx.py::TestUCX::test[mpi-all2all-binary_rewrite]" ${_ROCPROFSYS_EXTRA_ARGS})
set_tests_properties("ucx-mpi-all2all-binary-rewrite" PROPERTIES
    LABELS "binary_rewrite;mpi;openmpi;ucx"
    TIMEOUT ${_TEST_TIMEOUT}
    SKIP_RETURN_CODE 77
    FIXTURES_REQUIRED "rocprofsys-global-tmp-files"
)

if(DEFINED _ROCPROFSYS_CI_TIMEOUT)
    math(EXPR _TEST_TIMEOUT "${_ROCPROFSYS_CI_TIMEOUT} + 30")
else()
    set(_TEST_TIMEOUT 330)
endif()

add_test("ucx-mpi-all2all-sys-run" "${_ROCPROFSYS_EXE}" "${_ROCPROFSYS_EXE_ARGS}" "${_ROCPROFSYS_NODEID_PFX}test_ucx.py::TestUCX::test[mpi-all2all-sys_run]" ${_ROCPROFSYS_EXTRA_ARGS})
set_tests_properties("ucx-mpi-all2all-sys-run" PROPERTIES
    LABELS "mpi;openmpi;sys_run;ucx"
    TIMEOUT ${_TEST_TIMEOUT}
    SKIP_RETURN_CODE 77
    FIXTURES_REQUIRED "rocprofsys-global-tmp-files"
)

if(DEFINED _ROCPROFSYS_CI_TIMEOUT)
    math(EXPR _TEST_TIMEOUT "${_ROCPROFSYS_CI_TIMEOUT} + 30")
else()
    set(_TEST_TIMEOUT 330)
endif()

add_test("ucx-mpi-allgather-binary-rewrite" "${_ROCPROFSYS_EXE}" "${_ROCPROFSYS_EXE_ARGS}" "${_ROCPROFSYS_NODEID_PFX}test_ucx.py::TestUCX::test[mpi-allgather-binary_rewrite]" ${_ROCPROFSYS_EXTRA_ARGS})
set_tests_properties("ucx-mpi-allgather-binary-rewrite" PROPERTIES
    LABELS "binary_rewrite;mpi;openmpi;ucx"
    TIMEOUT ${_TEST_TIMEOUT}
    SKIP_RETURN_CODE 77
    FIXTURES_REQUIRED "rocprofsys-global-tmp-files"
)

if(DEFINED _ROCPROFSYS_CI_TIMEOUT)
    math(EXPR _TEST_TIMEOUT "${_ROCPROFSYS_CI_TIMEOUT} + 30")
else()
    set(_TEST_TIMEOUT 330)
endif()

add_test("ucx-mpi-allgather-sys-run" "${_ROCPROFSYS_EXE}" "${_ROCPROFSYS_EXE_ARGS}" "${_ROCPROFSYS_NODEID_PFX}test_ucx.py::TestUCX::test[mpi-allgather-sys_run]" ${_ROCPROFSYS_EXTRA_ARGS})
set_tests_properties("ucx-mpi-allgather-sys-run" PROPERTIES
    LABELS "mpi;openmpi;sys_run;ucx"
    TIMEOUT ${_TEST_TIMEOUT}
    SKIP_RETURN_CODE 77
    FIXTURES_REQUIRED "rocprofsys-global-tmp-files"
)

if(DEFINED _ROCPROFSYS_CI_TIMEOUT)
    math(EXPR _TEST_TIMEOUT "${_ROCPROFSYS_CI_TIMEOUT} + 30")
else()
    set(_TEST_TIMEOUT 330)
endif()

add_test("ucx-mpi-allreduce-binary-rewrite" "${_ROCPROFSYS_EXE}" "${_ROCPROFSYS_EXE_ARGS}" "${_ROCPROFSYS_NODEID_PFX}test_ucx.py::TestUCX::test[mpi-allreduce-binary_rewrite]" ${_ROCPROFSYS_EXTRA_ARGS})
set_tests_properties("ucx-mpi-allreduce-binary-rewrite" PROPERTIES
    LABELS "binary_rewrite;mpi;openmpi;ucx"
    TIMEOUT ${_TEST_TIMEOUT}
    SKIP_RETURN_CODE 77
    FIXTURES_REQUIRED "rocprofsys-global-tmp-files"
)

if(DEFINED _ROCPROFSYS_CI_TIMEOUT)
    math(EXPR _TEST_TIMEOUT "${_ROCPROFSYS_CI_TIMEOUT} + 30")
else()
    set(_TEST_TIMEOUT 330)
endif()

add_test("ucx-mpi-allreduce-sys-run" "${_ROCPROFSYS_EXE}" "${_ROCPROFSYS_EXE_ARGS}" "${_ROCPROFSYS_NODEID_PFX}test_ucx.py::TestUCX::test[mpi-allreduce-sys_run]" ${_ROCPROFSYS_EXTRA_ARGS})
set_tests_properties("ucx-mpi-allreduce-sys-run" PROPERTIES
    LABELS "mpi;openmpi;sys_run;ucx"
    TIMEOUT ${_TEST_TIMEOUT}
    SKIP_RETURN_CODE 77
    FIXTURES_REQUIRED "rocprofsys-global-tmp-files"
)

if(DEFINED _ROCPROFSYS_CI_TIMEOUT)
    math(EXPR _TEST_TIMEOUT "${_ROCPROFSYS_CI_TIMEOUT} + 30")
else()
    set(_TEST_TIMEOUT 330)
endif()

add_test("ucx-mpi-scatter-gather-binary-rewrite" "${_ROCPROFSYS_EXE}" "${_ROCPROFSYS_EXE_ARGS}" "${_ROCPROFSYS_NODEID_PFX}test_ucx.py::TestUCX::test[mpi-scatter-gather-binary_rewrite]" ${_ROCPROFSYS_EXTRA_ARGS})
set_tests_properties("ucx-mpi-scatter-gather-binary-rewrite" PROPERTIES
    LABELS "binary_rewrite;mpi;openmpi;ucx"
    TIMEOUT ${_TEST_TIMEOUT}
    SKIP_RETURN_CODE 77
    FIXTURES_REQUIRED "rocprofsys-global-tmp-files"
)

if(DEFINED _ROCPROFSYS_CI_TIMEOUT)
    math(EXPR _TEST_TIMEOUT "${_ROCPROFSYS_CI_TIMEOUT} + 30")
else()
    set(_TEST_TIMEOUT 330)
endif()

add_test("ucx-mpi-scatter-gather-sys-run" "${_ROCPROFSYS_EXE}" "${_ROCPROFSYS_EXE_ARGS}" "${_ROCPROFSYS_NODEID_PFX}test_ucx.py::TestUCX::test[mpi-scatter-gather-sys_run]" ${_ROCPROFSYS_EXTRA_ARGS})
set_tests_properties("ucx-mpi-scatter-gather-sys-run" PROPERTIES
    LABELS "mpi;openmpi;sys_run;ucx"
    TIMEOUT ${_TEST_TIMEOUT}
    SKIP_RETURN_CODE 77
    FIXTURES_REQUIRED "rocprofsys-global-tmp-files"
)

if(DEFINED _ROCPROFSYS_CI_TIMEOUT)
    math(EXPR _TEST_TIMEOUT "${_ROCPROFSYS_CI_TIMEOUT} + 30")
else()
    set(_TEST_TIMEOUT 330)
endif()

add_test("ucx-mpi-send-recv-binary-rewrite" "${_ROCPROFSYS_EXE}" "${_ROCPROFSYS_EXE_ARGS}" "${_ROCPROFSYS_NODEID_PFX}test_ucx.py::TestUCX::test[mpi-send-recv-binary_rewrite]" ${_ROCPROFSYS_EXTRA_ARGS})
set_tests_properties("ucx-mpi-send-recv-binary-rewrite" PROPERTIES
    LABELS "binary_rewrite;mpi;openmpi;ucx"
    TIMEOUT ${_TEST_TIMEOUT}
    SKIP_RETURN_CODE 77
    FIXTURES_REQUIRED "rocprofsys-global-tmp-files"
)

if(DEFINED _ROCPROFSYS_CI_TIMEOUT)
    math(EXPR _TEST_TIMEOUT "${_ROCPROFSYS_CI_TIMEOUT} + 30")
else()
    set(_TEST_TIMEOUT 330)
endif()

add_test("ucx-mpi-send-recv-sys-run" "${_ROCPROFSYS_EXE}" "${_ROCPROFSYS_EXE_ARGS}" "${_ROCPROFSYS_NODEID_PFX}test_ucx.py::TestUCX::test[mpi-send-recv-sys_run]" ${_ROCPROFSYS_EXTRA_ARGS})
set_tests_properties("ucx-mpi-send-recv-sys-run" PROPERTIES
    LABELS "mpi;openmpi;sys_run;ucx"
    TIMEOUT ${_TEST_TIMEOUT}
    SKIP_RETURN_CODE 77
    FIXTURES_REQUIRED "rocprofsys-global-tmp-files"
)

if(DEFINED _ROCPROFSYS_CI_TIMEOUT)
    math(EXPR _TEST_TIMEOUT "${_ROCPROFSYS_CI_TIMEOUT} + 30")
else()
    set(_TEST_TIMEOUT 330)
endif()

add_test("ucx-perfetto-binary-rewrite" "${_ROCPROFSYS_EXE}" "${_ROCPROFSYS_EXE_ARGS}" "${_ROCPROFSYS_NODEID_PFX}test_ucx.py::TestUCX::test_perfetto[binary_rewrite]" ${_ROCPROFSYS_EXTRA_ARGS})
set_tests_properties("ucx-perfetto-binary-rewrite" PROPERTIES
    LABELS "binary_rewrite;mpi;openmpi;ucx"
    TIMEOUT ${_TEST_TIMEOUT}
    SKIP_RETURN_CODE 77
    FIXTURES_REQUIRED "rocprofsys-global-tmp-files"
)

if(DEFINED _ROCPROFSYS_CI_TIMEOUT)
    math(EXPR _TEST_TIMEOUT "${_ROCPROFSYS_CI_TIMEOUT} + 30")
else()
    set(_TEST_TIMEOUT 330)
endif()

add_test("ucx-perfetto-sys-run" "${_ROCPROFSYS_EXE}" "${_ROCPROFSYS_EXE_ARGS}" "${_ROCPROFSYS_NODEID_PFX}test_ucx.py::TestUCX::test_perfetto[sys_run]" ${_ROCPROFSYS_EXTRA_ARGS})
set_tests_properties("ucx-perfetto-sys-run" PROPERTIES
    LABELS "mpi;openmpi;sys_run;ucx"
    TIMEOUT ${_TEST_TIMEOUT}
    SKIP_RETURN_CODE 77
    FIXTURES_REQUIRED "rocprofsys-global-tmp-files"
)

if(DEFINED _ROCPROFSYS_CI_TIMEOUT)
    math(EXPR _TEST_TIMEOUT "${_ROCPROFSYS_CI_TIMEOUT} + 30")
else()
    set(_TEST_TIMEOUT 330)
endif()

add_test("ucx-mpip-binary-rewrite" "${_ROCPROFSYS_EXE}" "${_ROCPROFSYS_EXE_ARGS}" "${_ROCPROFSYS_NODEID_PFX}test_ucx.py::TestUCX::test_mpip[binary_rewrite]" ${_ROCPROFSYS_EXTRA_ARGS})
set_tests_properties("ucx-mpip-binary-rewrite" PROPERTIES
    LABELS "binary_rewrite;mpi;openmpi;ucx"
    TIMEOUT ${_TEST_TIMEOUT}
    SKIP_RETURN_CODE 77
    FIXTURES_REQUIRED "rocprofsys-global-tmp-files"
)

if(DEFINED _ROCPROFSYS_CI_TIMEOUT)
    math(EXPR _TEST_TIMEOUT "${_ROCPROFSYS_CI_TIMEOUT} + 30")
else()
    set(_TEST_TIMEOUT 330)
endif()

add_test("ucx-mpip-sys-run" "${_ROCPROFSYS_EXE}" "${_ROCPROFSYS_EXE_ARGS}" "${_ROCPROFSYS_NODEID_PFX}test_ucx.py::TestUCX::test_mpip[sys_run]" ${_ROCPROFSYS_EXTRA_ARGS})
set_tests_properties("ucx-mpip-sys-run" PROPERTIES
    LABELS "mpi;openmpi;sys_run;ucx"
    TIMEOUT ${_TEST_TIMEOUT}
    SKIP_RETURN_CODE 77
    FIXTURES_REQUIRED "rocprofsys-global-tmp-files"
)

if(DEFINED _ROCPROFSYS_CI_TIMEOUT)
    math(EXPR _TEST_TIMEOUT "${_ROCPROFSYS_CI_TIMEOUT} + 30")
else()
    set(_TEST_TIMEOUT 330)
endif()

add_test("ucx-bcast-1024-binary-rewrite" "${_ROCPROFSYS_EXE}" "${_ROCPROFSYS_EXE_ARGS}" "${_ROCPROFSYS_NODEID_PFX}test_ucx.py::TestUCX::test_bcast[1024-binary_rewrite]" ${_ROCPROFSYS_EXTRA_ARGS})
set_tests_properties("ucx-bcast-1024-binary-rewrite" PROPERTIES
    LABELS "binary_rewrite;mpi;openmpi;ucx"
    TIMEOUT ${_TEST_TIMEOUT}
    SKIP_RETURN_CODE 77
    FIXTURES_REQUIRED "rocprofsys-global-tmp-files"
)

if(DEFINED _ROCPROFSYS_CI_TIMEOUT)
    math(EXPR _TEST_TIMEOUT "${_ROCPROFSYS_CI_TIMEOUT} + 30")
else()
    set(_TEST_TIMEOUT 330)
endif()

add_test("ucx-bcast-1024-sys-run" "${_ROCPROFSYS_EXE}" "${_ROCPROFSYS_EXE_ARGS}" "${_ROCPROFSYS_NODEID_PFX}test_ucx.py::TestUCX::test_bcast[1024-sys_run]" ${_ROCPROFSYS_EXTRA_ARGS})
set_tests_properties("ucx-bcast-1024-sys-run" PROPERTIES
    LABELS "mpi;openmpi;sys_run;ucx"
    TIMEOUT ${_TEST_TIMEOUT}
    SKIP_RETURN_CODE 77
    FIXTURES_REQUIRED "rocprofsys-global-tmp-files"
)

if(DEFINED _ROCPROFSYS_CI_TIMEOUT)
    math(EXPR _TEST_TIMEOUT "${_ROCPROFSYS_CI_TIMEOUT} + 30")
else()
    set(_TEST_TIMEOUT 330)
endif()

add_test("ucx-bcast-4096-binary-rewrite" "${_ROCPROFSYS_EXE}" "${_ROCPROFSYS_EXE_ARGS}" "${_ROCPROFSYS_NODEID_PFX}test_ucx.py::TestUCX::test_bcast[4096-binary_rewrite]" ${_ROCPROFSYS_EXTRA_ARGS})
set_tests_properties("ucx-bcast-4096-binary-rewrite" PROPERTIES
    LABELS "binary_rewrite;mpi;openmpi;ucx"
    TIMEOUT ${_TEST_TIMEOUT}
    SKIP_RETURN_CODE 77
    FIXTURES_REQUIRED "rocprofsys-global-tmp-files"
)

if(DEFINED _ROCPROFSYS_CI_TIMEOUT)
    math(EXPR _TEST_TIMEOUT "${_ROCPROFSYS_CI_TIMEOUT} + 30")
else()
    set(_TEST_TIMEOUT 330)
endif()

add_test("ucx-bcast-4096-sys-run" "${_ROCPROFSYS_EXE}" "${_ROCPROFSYS_EXE_ARGS}" "${_ROCPROFSYS_NODEID_PFX}test_ucx.py::TestUCX::test_bcast[4096-sys_run]" ${_ROCPROFSYS_EXTRA_ARGS})
set_tests_properties("ucx-bcast-4096-sys-run" PROPERTIES
    LABELS "mpi;openmpi;sys_run;ucx"
    TIMEOUT ${_TEST_TIMEOUT}
    SKIP_RETURN_CODE 77
    FIXTURES_REQUIRED "rocprofsys-global-tmp-files"
)

if(DEFINED _ROCPROFSYS_CI_TIMEOUT)
    math(EXPR _TEST_TIMEOUT "${_ROCPROFSYS_CI_TIMEOUT} + 30")
else()
    set(_TEST_TIMEOUT 330)
endif()

add_test("ucx-bcast-16384-binary-rewrite" "${_ROCPROFSYS_EXE}" "${_ROCPROFSYS_EXE_ARGS}" "${_ROCPROFSYS_NODEID_PFX}test_ucx.py::TestUCX::test_bcast[16384-binary_rewrite]" ${_ROCPROFSYS_EXTRA_ARGS})
set_tests_properties("ucx-bcast-16384-binary-rewrite" PROPERTIES
    LABELS "binary_rewrite;mpi;openmpi;ucx"
    TIMEOUT ${_TEST_TIMEOUT}
    SKIP_RETURN_CODE 77
    FIXTURES_REQUIRED "rocprofsys-global-tmp-files"
)

if(DEFINED _ROCPROFSYS_CI_TIMEOUT)
    math(EXPR _TEST_TIMEOUT "${_ROCPROFSYS_CI_TIMEOUT} + 30")
else()
    set(_TEST_TIMEOUT 330)
endif()

add_test("ucx-bcast-16384-sys-run" "${_ROCPROFSYS_EXE}" "${_ROCPROFSYS_EXE_ARGS}" "${_ROCPROFSYS_NODEID_PFX}test_ucx.py::TestUCX::test_bcast[16384-sys_run]" ${_ROCPROFSYS_EXTRA_ARGS})
set_tests_properties("ucx-bcast-16384-sys-run" PROPERTIES
    LABELS "mpi;openmpi;sys_run;ucx"
    TIMEOUT ${_TEST_TIMEOUT}
    SKIP_RETURN_CODE 77
    FIXTURES_REQUIRED "rocprofsys-global-tmp-files"
)

if(DEFINED _ROCPROFSYS_CI_TIMEOUT)
    math(EXPR _TEST_TIMEOUT "${_ROCPROFSYS_CI_TIMEOUT} + 30")
else()
    set(_TEST_TIMEOUT 330)
endif()

add_test("ucx-active-message-binary-rewrite" "${_ROCPROFSYS_EXE}" "${_ROCPROFSYS_EXE_ARGS}" "${_ROCPROFSYS_NODEID_PFX}test_ucx.py::TestUCX::test_active_message[binary_rewrite]" ${_ROCPROFSYS_EXTRA_ARGS})
set_tests_properties("ucx-active-message-binary-rewrite" PROPERTIES
    LABELS "binary_rewrite;mpi;openmpi;ucx"
    TIMEOUT ${_TEST_TIMEOUT}
    SKIP_RETURN_CODE 77
    FIXTURES_REQUIRED "rocprofsys-global-tmp-files"
)

if(DEFINED _ROCPROFSYS_CI_TIMEOUT)
    math(EXPR _TEST_TIMEOUT "${_ROCPROFSYS_CI_TIMEOUT} + 30")
else()
    set(_TEST_TIMEOUT 330)
endif()

add_test("ucx-active-message-sys-run" "${_ROCPROFSYS_EXE}" "${_ROCPROFSYS_EXE_ARGS}" "${_ROCPROFSYS_NODEID_PFX}test_ucx.py::TestUCX::test_active_message[sys_run]" ${_ROCPROFSYS_EXTRA_ARGS})
set_tests_properties("ucx-active-message-sys-run" PROPERTIES
    LABELS "mpi;openmpi;sys_run;ucx"
    TIMEOUT ${_TEST_TIMEOUT}
    SKIP_RETURN_CODE 77
    FIXTURES_REQUIRED "rocprofsys-global-tmp-files"
)

if(DEFINED _ROCPROFSYS_CI_TIMEOUT)
    math(EXPR _TEST_TIMEOUT "${_ROCPROFSYS_CI_TIMEOUT} + 30")
else()
    set(_TEST_TIMEOUT 150)
endif()

add_test("unified-memory-output-sys-run" "${_ROCPROFSYS_EXE}" "${_ROCPROFSYS_EXE_ARGS}" "${_ROCPROFSYS_NODEID_PFX}test_unified_memory.py::TestUnifiedMemory::test_output[sys_run]" ${_ROCPROFSYS_EXTRA_ARGS})
set_tests_properties("unified-memory-output-sys-run" PROPERTIES
    LABELS "gpu;hip;sys_run;unified_memory;xnack"
    TIMEOUT ${_TEST_TIMEOUT}
    SKIP_RETURN_CODE 77
    FIXTURES_REQUIRED "rocprofsys-global-tmp-files"
)

if(DEFINED _ROCPROFSYS_CI_TIMEOUT)
    math(EXPR _TEST_TIMEOUT "${_ROCPROFSYS_CI_TIMEOUT} + 30")
else()
    set(_TEST_TIMEOUT 330)
endif()

add_test("unit-tests" "${_ROCPROFSYS_EXE}" "${_ROCPROFSYS_EXE_ARGS}" "${_ROCPROFSYS_NODEID_PFX}test_units.py::TestUnitTests::test" ${_ROCPROFSYS_EXTRA_ARGS})
set_tests_properties("unit-tests" PROPERTIES
    LABELS "unit_tests"
    TIMEOUT ${_TEST_TIMEOUT}
    SKIP_RETURN_CODE 77
    FIXTURES_REQUIRED "rocprofsys-global-tmp-files"
)

if(DEFINED _ROCPROFSYS_CI_TIMEOUT)
    math(EXPR _TEST_TIMEOUT "${_ROCPROFSYS_CI_TIMEOUT} + 30")
else()
    set(_TEST_TIMEOUT 330)
endif()

add_test("user-api-baseline" "${_ROCPROFSYS_EXE}" "${_ROCPROFSYS_EXE_ARGS}" "${_ROCPROFSYS_NODEID_PFX}test_user_api.py::TestUserAPI::test[baseline]" ${_ROCPROFSYS_EXTRA_ARGS})
set_tests_properties("user-api-baseline" PROPERTIES
    LABELS "baseline;user_api"
    TIMEOUT ${_TEST_TIMEOUT}
    SKIP_RETURN_CODE 77
    FIXTURES_REQUIRED "rocprofsys-global-tmp-files"
)

if(DEFINED _ROCPROFSYS_CI_TIMEOUT)
    math(EXPR _TEST_TIMEOUT "${_ROCPROFSYS_CI_TIMEOUT} + 30")
else()
    set(_TEST_TIMEOUT 330)
endif()

add_test("user-api-sampling" "${_ROCPROFSYS_EXE}" "${_ROCPROFSYS_EXE_ARGS}" "${_ROCPROFSYS_NODEID_PFX}test_user_api.py::TestUserAPI::test[sampling]" ${_ROCPROFSYS_EXTRA_ARGS})
set_tests_properties("user-api-sampling" PROPERTIES
    LABELS "sampling;user_api"
    TIMEOUT ${_TEST_TIMEOUT}
    SKIP_RETURN_CODE 77
    FIXTURES_REQUIRED "rocprofsys-global-tmp-files"
)

if(DEFINED _ROCPROFSYS_CI_TIMEOUT)
    math(EXPR _TEST_TIMEOUT "${_ROCPROFSYS_CI_TIMEOUT} + 30")
else()
    set(_TEST_TIMEOUT 330)
endif()

add_test("user-api-binary-rewrite" "${_ROCPROFSYS_EXE}" "${_ROCPROFSYS_EXE_ARGS}" "${_ROCPROFSYS_NODEID_PFX}test_user_api.py::TestUserAPI::test[binary_rewrite]" ${_ROCPROFSYS_EXTRA_ARGS})
set_tests_properties("user-api-binary-rewrite" PROPERTIES
    LABELS "binary_rewrite;user_api"
    TIMEOUT ${_TEST_TIMEOUT}
    SKIP_RETURN_CODE 77
    FIXTURES_REQUIRED "rocprofsys-global-tmp-files"
)

if(DEFINED _ROCPROFSYS_CI_TIMEOUT)
    math(EXPR _TEST_TIMEOUT "${_ROCPROFSYS_CI_TIMEOUT} + 30")
else()
    set(_TEST_TIMEOUT 330)
endif()

add_test("user-api-runtime-instrument" "${_ROCPROFSYS_EXE}" "${_ROCPROFSYS_EXE_ARGS}" "${_ROCPROFSYS_NODEID_PFX}test_user_api.py::TestUserAPI::test[runtime_instrument]" ${_ROCPROFSYS_EXTRA_ARGS})
set_tests_properties("user-api-runtime-instrument" PROPERTIES
    LABELS "runtime_instrument;user_api"
    TIMEOUT ${_TEST_TIMEOUT}
    SKIP_RETURN_CODE 77
    FIXTURES_REQUIRED "rocprofsys-global-tmp-files"
)

if(DEFINED _ROCPROFSYS_CI_TIMEOUT)
    math(EXPR _TEST_TIMEOUT "${_ROCPROFSYS_CI_TIMEOUT} + 30")
else()
    set(_TEST_TIMEOUT 330)
endif()

add_test("user-api-sys-run" "${_ROCPROFSYS_EXE}" "${_ROCPROFSYS_EXE_ARGS}" "${_ROCPROFSYS_NODEID_PFX}test_user_api.py::TestUserAPI::test[sys_run]" ${_ROCPROFSYS_EXTRA_ARGS})
set_tests_properties("user-api-sys-run" PROPERTIES
    LABELS "sys_run;user_api"
    TIMEOUT ${_TEST_TIMEOUT}
    SKIP_RETURN_CODE 77
    FIXTURES_REQUIRED "rocprofsys-global-tmp-files"
)

if(DEFINED _ROCPROFSYS_CI_TIMEOUT)
    math(EXPR _TEST_TIMEOUT "${_ROCPROFSYS_CI_TIMEOUT} + 30")
else()
    set(_TEST_TIMEOUT 330)
endif()

add_test("validate-json-data-rejects-top-level-type-mismatches-summary-value0-summary-must-be-an-object" "${_ROCPROFSYS_EXE}" "${_ROCPROFSYS_EXE_ARGS}" "${_ROCPROFSYS_NODEID_PFX}test_validate_unified_memory.py::test_validate_json_data_rejects_top_level_type_mismatches[summary-value0-'summary' must be an object]" ${_ROCPROFSYS_EXTRA_ARGS})
set_tests_properties("validate-json-data-rejects-top-level-type-mismatches-summary-value0-summary-must-be-an-object" PROPERTIES
    LABELS "validation_usm"
    TIMEOUT ${_TEST_TIMEOUT}
    SKIP_RETURN_CODE 77
    FIXTURES_REQUIRED "rocprofsys-global-tmp-files"
)

if(DEFINED _ROCPROFSYS_CI_TIMEOUT)
    math(EXPR _TEST_TIMEOUT "${_ROCPROFSYS_CI_TIMEOUT} + 30")
else()
    set(_TEST_TIMEOUT 330)
endif()

add_test("validate-json-data-rejects-top-level-type-mismatches-devices-value1-devices-must-be-an-array" "${_ROCPROFSYS_EXE}" "${_ROCPROFSYS_EXE_ARGS}" "${_ROCPROFSYS_NODEID_PFX}test_validate_unified_memory.py::test_validate_json_data_rejects_top_level_type_mismatches[devices-value1-'devices' must be an array]" ${_ROCPROFSYS_EXTRA_ARGS})
set_tests_properties("validate-json-data-rejects-top-level-type-mismatches-devices-value1-devices-must-be-an-array" PROPERTIES
    LABELS "validation_usm"
    TIMEOUT ${_TEST_TIMEOUT}
    SKIP_RETURN_CODE 77
    FIXTURES_REQUIRED "rocprofsys-global-tmp-files"
)

if(DEFINED _ROCPROFSYS_CI_TIMEOUT)
    math(EXPR _TEST_TIMEOUT "${_ROCPROFSYS_CI_TIMEOUT} + 30")
else()
    set(_TEST_TIMEOUT 330)
endif()

add_test("validate-json-data-rejects-nested-type-mismatches-migration-triggers-not-object" "${_ROCPROFSYS_EXE}" "${_ROCPROFSYS_EXE_ARGS}" "${_ROCPROFSYS_NODEID_PFX}test_validate_unified_memory.py::test_validate_json_data_rejects_nested_type_mismatches[migration-triggers-not-object]" ${_ROCPROFSYS_EXTRA_ARGS})
set_tests_properties("validate-json-data-rejects-nested-type-mismatches-migration-triggers-not-object" PROPERTIES
    LABELS "validation_usm"
    TIMEOUT ${_TEST_TIMEOUT}
    SKIP_RETURN_CODE 77
    FIXTURES_REQUIRED "rocprofsys-global-tmp-files"
)

if(DEFINED _ROCPROFSYS_CI_TIMEOUT)
    math(EXPR _TEST_TIMEOUT "${_ROCPROFSYS_CI_TIMEOUT} + 30")
else()
    set(_TEST_TIMEOUT 330)
endif()

add_test("validate-json-data-rejects-nested-type-mismatches-device-entry-not-object" "${_ROCPROFSYS_EXE}" "${_ROCPROFSYS_EXE_ARGS}" "${_ROCPROFSYS_NODEID_PFX}test_validate_unified_memory.py::test_validate_json_data_rejects_nested_type_mismatches[device-entry-not-object]" ${_ROCPROFSYS_EXTRA_ARGS})
set_tests_properties("validate-json-data-rejects-nested-type-mismatches-device-entry-not-object" PROPERTIES
    LABELS "validation_usm"
    TIMEOUT ${_TEST_TIMEOUT}
    SKIP_RETURN_CODE 77
    FIXTURES_REQUIRED "rocprofsys-global-tmp-files"
)

if(DEFINED _ROCPROFSYS_CI_TIMEOUT)
    math(EXPR _TEST_TIMEOUT "${_ROCPROFSYS_CI_TIMEOUT} + 30")
else()
    set(_TEST_TIMEOUT 330)
endif()

add_test("validate-json-data-rejects-nested-type-mismatches-migrations-not-object" "${_ROCPROFSYS_EXE}" "${_ROCPROFSYS_EXE_ARGS}" "${_ROCPROFSYS_NODEID_PFX}test_validate_unified_memory.py::test_validate_json_data_rejects_nested_type_mismatches[migrations-not-object]" ${_ROCPROFSYS_EXTRA_ARGS})
set_tests_properties("validate-json-data-rejects-nested-type-mismatches-migrations-not-object" PROPERTIES
    LABELS "validation_usm"
    TIMEOUT ${_TEST_TIMEOUT}
    SKIP_RETURN_CODE 77
    FIXTURES_REQUIRED "rocprofsys-global-tmp-files"
)

if(DEFINED _ROCPROFSYS_CI_TIMEOUT)
    math(EXPR _TEST_TIMEOUT "${_ROCPROFSYS_CI_TIMEOUT} + 30")
else()
    set(_TEST_TIMEOUT 330)
endif()

add_test("validate-json-data-rejects-nested-type-mismatches-direction-stats-not-object" "${_ROCPROFSYS_EXE}" "${_ROCPROFSYS_EXE_ARGS}" "${_ROCPROFSYS_NODEID_PFX}test_validate_unified_memory.py::test_validate_json_data_rejects_nested_type_mismatches[direction-stats-not-object]" ${_ROCPROFSYS_EXTRA_ARGS})
set_tests_properties("validate-json-data-rejects-nested-type-mismatches-direction-stats-not-object" PROPERTIES
    LABELS "validation_usm"
    TIMEOUT ${_TEST_TIMEOUT}
    SKIP_RETURN_CODE 77
    FIXTURES_REQUIRED "rocprofsys-global-tmp-files"
)

if(DEFINED _ROCPROFSYS_CI_TIMEOUT)
    math(EXPR _TEST_TIMEOUT "${_ROCPROFSYS_CI_TIMEOUT} + 30")
else()
    set(_TEST_TIMEOUT 330)
endif()

add_test("validate-json-data-accepts-valid-fault-only-data" "${_ROCPROFSYS_EXE}" "${_ROCPROFSYS_EXE_ARGS}" "${_ROCPROFSYS_NODEID_PFX}test_validate_unified_memory.py::test_validate_json_data_accepts_valid_fault_only_data" ${_ROCPROFSYS_EXTRA_ARGS})
set_tests_properties("validate-json-data-accepts-valid-fault-only-data" PROPERTIES
    LABELS "validation_usm"
    TIMEOUT ${_TEST_TIMEOUT}
    SKIP_RETURN_CODE 77
    FIXTURES_REQUIRED "rocprofsys-global-tmp-files"
)

if(DEFINED _ROCPROFSYS_CI_TIMEOUT)
    math(EXPR _TEST_TIMEOUT "${_ROCPROFSYS_CI_TIMEOUT} + 30")
else()
    set(_TEST_TIMEOUT 330)
endif()

add_test("load-json-output-reports-read-failures-directory-path" "${_ROCPROFSYS_EXE}" "${_ROCPROFSYS_EXE_ARGS}" "${_ROCPROFSYS_NODEID_PFX}test_validate_unified_memory.py::test_load_json_output_reports_read_failures[directory-path]" ${_ROCPROFSYS_EXTRA_ARGS})
set_tests_properties("load-json-output-reports-read-failures-directory-path" PROPERTIES
    LABELS "validation_usm"
    TIMEOUT ${_TEST_TIMEOUT}
    SKIP_RETURN_CODE 77
    FIXTURES_REQUIRED "rocprofsys-global-tmp-files"
)

if(DEFINED _ROCPROFSYS_CI_TIMEOUT)
    math(EXPR _TEST_TIMEOUT "${_ROCPROFSYS_CI_TIMEOUT} + 30")
else()
    set(_TEST_TIMEOUT 330)
endif()

add_test("load-json-output-reports-read-failures-invalid-encoding" "${_ROCPROFSYS_EXE}" "${_ROCPROFSYS_EXE_ARGS}" "${_ROCPROFSYS_NODEID_PFX}test_validate_unified_memory.py::test_load_json_output_reports_read_failures[invalid-encoding]" ${_ROCPROFSYS_EXTRA_ARGS})
set_tests_properties("load-json-output-reports-read-failures-invalid-encoding" PROPERTIES
    LABELS "validation_usm"
    TIMEOUT ${_TEST_TIMEOUT}
    SKIP_RETURN_CODE 77
    FIXTURES_REQUIRED "rocprofsys-global-tmp-files"
)

if(DEFINED _ROCPROFSYS_CI_TIMEOUT)
    math(EXPR _TEST_TIMEOUT "${_ROCPROFSYS_CI_TIMEOUT} + 30")
else()
    set(_TEST_TIMEOUT 330)
endif()

add_test("load-json-output-reports-read-failures-invalid-json" "${_ROCPROFSYS_EXE}" "${_ROCPROFSYS_EXE_ARGS}" "${_ROCPROFSYS_NODEID_PFX}test_validate_unified_memory.py::test_load_json_output_reports_read_failures[invalid-json]" ${_ROCPROFSYS_EXTRA_ARGS})
set_tests_properties("load-json-output-reports-read-failures-invalid-json" PROPERTIES
    LABELS "validation_usm"
    TIMEOUT ${_TEST_TIMEOUT}
    SKIP_RETURN_CODE 77
    FIXTURES_REQUIRED "rocprofsys-global-tmp-files"
)

if(DEFINED _ROCPROFSYS_CI_TIMEOUT)
    math(EXPR _TEST_TIMEOUT "${_ROCPROFSYS_CI_TIMEOUT} + 30")
else()
    set(_TEST_TIMEOUT 330)
endif()

add_test("is-fault-only-output-depends-on-positive-integer-migrations-0-false-contains-unified-memory-migration-throughput-track" "${_ROCPROFSYS_EXE}" "${_ROCPROFSYS_EXE_ARGS}" "${_ROCPROFSYS_NODEID_PFX}test_validate_unified_memory.py::test_is_fault_only_output_depends_on_positive_integer_migrations[0-False-contains unified-memory migration throughput track]" ${_ROCPROFSYS_EXTRA_ARGS})
set_tests_properties("is-fault-only-output-depends-on-positive-integer-migrations-0-false-contains-unified-memory-migration-throughput-track" PROPERTIES
    LABELS "validation_usm"
    TIMEOUT ${_TEST_TIMEOUT}
    SKIP_RETURN_CODE 77
    FIXTURES_REQUIRED "rocprofsys-global-tmp-files"
)

if(DEFINED _ROCPROFSYS_CI_TIMEOUT)
    math(EXPR _TEST_TIMEOUT "${_ROCPROFSYS_CI_TIMEOUT} + 30")
else()
    set(_TEST_TIMEOUT 330)
endif()

add_test("is-fault-only-output-depends-on-positive-integer-migrations-1-true-perfetto-fault-only-validation-skipped" "${_ROCPROFSYS_EXE}" "${_ROCPROFSYS_EXE_ARGS}" "${_ROCPROFSYS_NODEID_PFX}test_validate_unified_memory.py::test_is_fault_only_output_depends_on_positive_integer_migrations[1-True-Perfetto fault-only validation skipped]" ${_ROCPROFSYS_EXTRA_ARGS})
set_tests_properties("is-fault-only-output-depends-on-positive-integer-migrations-1-true-perfetto-fault-only-validation-skipped" PROPERTIES
    LABELS "validation_usm"
    TIMEOUT ${_TEST_TIMEOUT}
    SKIP_RETURN_CODE 77
    FIXTURES_REQUIRED "rocprofsys-global-tmp-files"
)

if(DEFINED _ROCPROFSYS_CI_TIMEOUT)
    math(EXPR _TEST_TIMEOUT "${_ROCPROFSYS_CI_TIMEOUT} + 30")
else()
    set(_TEST_TIMEOUT 330)
endif()

add_test("is-fault-only-output-depends-on-positive-integer-migrations-true-false-contains-unified-memory-migration-throughput-track" "${_ROCPROFSYS_EXE}" "${_ROCPROFSYS_EXE_ARGS}" "${_ROCPROFSYS_NODEID_PFX}test_validate_unified_memory.py::test_is_fault_only_output_depends_on_positive_integer_migrations[True-False-contains unified-memory migration throughput track]" ${_ROCPROFSYS_EXTRA_ARGS})
set_tests_properties("is-fault-only-output-depends-on-positive-integer-migrations-true-false-contains-unified-memory-migration-throughput-track" PROPERTIES
    LABELS "validation_usm"
    TIMEOUT ${_TEST_TIMEOUT}
    SKIP_RETURN_CODE 77
    FIXTURES_REQUIRED "rocprofsys-global-tmp-files"
)

if(DEFINED _ROCPROFSYS_CI_TIMEOUT)
    math(EXPR _TEST_TIMEOUT "${_ROCPROFSYS_CI_TIMEOUT} + 30")
else()
    set(_TEST_TIMEOUT 330)
endif()

add_test("validate-perfetto-fault-only-trace-checks-track-names-prefix-unified-memory-page-faults-suffix-true-all-validation-checks-passed" "${_ROCPROFSYS_EXE}" "${_ROCPROFSYS_EXE_ARGS}" "${_ROCPROFSYS_NODEID_PFX}test_validate_unified_memory.py::test_validate_perfetto_fault_only_trace_checks_track_names[prefix Unified Memory Page Faults suffix-True-All validation checks passed]" ${_ROCPROFSYS_EXTRA_ARGS})
set_tests_properties("validate-perfetto-fault-only-trace-checks-track-names-prefix-unified-memory-page-faults-suffix-true-all-validation-checks-passed" PROPERTIES
    LABELS "validation_usm"
    TIMEOUT ${_TEST_TIMEOUT}
    SKIP_RETURN_CODE 77
    FIXTURES_REQUIRED "rocprofsys-global-tmp-files"
)

if(DEFINED _ROCPROFSYS_CI_TIMEOUT)
    math(EXPR _TEST_TIMEOUT "${_ROCPROFSYS_CI_TIMEOUT} + 30")
else()
    set(_TEST_TIMEOUT 330)
endif()

add_test("validate-perfetto-fault-only-trace-checks-track-names-unified-memory-page-faults-unified-memory-migration-throughput-false-contains-unified-memory-migration-throughput-track" "${_ROCPROFSYS_EXE}" "${_ROCPROFSYS_EXE_ARGS}" "${_ROCPROFSYS_NODEID_PFX}test_validate_unified_memory.py::test_validate_perfetto_fault_only_trace_checks_track_names[Unified Memory Page Faults Unified Memory Migration Throughput-False-contains unified-memory migration throughput track]" ${_ROCPROFSYS_EXTRA_ARGS})
set_tests_properties("validate-perfetto-fault-only-trace-checks-track-names-unified-memory-page-faults-unified-memory-migration-throughput-false-contains-unified-memory-migration-throughput-track" PROPERTIES
    LABELS "validation_usm"
    TIMEOUT ${_TEST_TIMEOUT}
    SKIP_RETURN_CODE 77
    FIXTURES_REQUIRED "rocprofsys-global-tmp-files"
)

if(DEFINED _ROCPROFSYS_CI_TIMEOUT)
    math(EXPR _TEST_TIMEOUT "${_ROCPROFSYS_CI_TIMEOUT} + 30")
else()
    set(_TEST_TIMEOUT 330)
endif()

add_test("validate-perfetto-fault-only-trace-checks-track-names-false-perfetto-trace-is-empty" "${_ROCPROFSYS_EXE}" "${_ROCPROFSYS_EXE_ARGS}" "${_ROCPROFSYS_NODEID_PFX}test_validate_unified_memory.py::test_validate_perfetto_fault_only_trace_checks_track_names[-False-Perfetto trace is empty]" ${_ROCPROFSYS_EXTRA_ARGS})
set_tests_properties("validate-perfetto-fault-only-trace-checks-track-names-false-perfetto-trace-is-empty" PROPERTIES
    LABELS "validation_usm"
    TIMEOUT ${_TEST_TIMEOUT}
    SKIP_RETURN_CODE 77
    FIXTURES_REQUIRED "rocprofsys-global-tmp-files"
)

if(DEFINED _ROCPROFSYS_CI_TIMEOUT)
    math(EXPR _TEST_TIMEOUT "${_ROCPROFSYS_CI_TIMEOUT} + 30")
else()
    set(_TEST_TIMEOUT 150)
endif()

add_test("video-decode-sampling" "${_ROCPROFSYS_EXE}" "${_ROCPROFSYS_EXE_ARGS}" "${_ROCPROFSYS_NODEID_PFX}test_videodecode.py::TestVideoDecode::test[sampling]" ${_ROCPROFSYS_EXTRA_ARGS})
set_tests_properties("video-decode-sampling" PROPERTIES
    LABELS "decode;gpu;rocm;rocpd;sampling;videodecode"
    TIMEOUT ${_TEST_TIMEOUT}
    SKIP_RETURN_CODE 77
    FIXTURES_REQUIRED "rocprofsys-global-tmp-files"
)

if(DEFINED _ROCPROFSYS_CI_TIMEOUT)
    math(EXPR _TEST_TIMEOUT "${_ROCPROFSYS_CI_TIMEOUT} + 30")
else()
    set(_TEST_TIMEOUT 150)
endif()

add_test("video-decode-sys-run" "${_ROCPROFSYS_EXE}" "${_ROCPROFSYS_EXE_ARGS}" "${_ROCPROFSYS_NODEID_PFX}test_videodecode.py::TestVideoDecode::test[sys_run]" ${_ROCPROFSYS_EXTRA_ARGS})
set_tests_properties("video-decode-sys-run" PROPERTIES
    LABELS "decode;gpu;rocm;sys_run;videodecode"
    TIMEOUT ${_TEST_TIMEOUT}
    SKIP_RETURN_CODE 77
    FIXTURES_REQUIRED "rocprofsys-global-tmp-files"
)

add_test("rocprofiler-systems-test-cleanup" "${_ROCPROFSYS_EXE}" "${_ROCPROFSYS_EXE_ARGS}" "${_ROCPROFSYS_NODEID_PFX}" "--ctest-mode" "cleanup")
set_tests_properties("rocprofiler-systems-test-cleanup" PROPERTIES
    FIXTURES_CLEANUP "rocprofsys-global-tmp-files"
    LABELS "cleanup;global"
    TIMEOUT 30
)
