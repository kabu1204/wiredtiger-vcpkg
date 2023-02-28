vcpkg_check_linkage(ONLY_STATIC_LIBRARY ONLY_STATIC_CRT)

vcpkg_check_features(OUT_FEATURE_OPTIONS FEATURE_OPTIONS
  FEATURES
      "lz4"     HAVE_BUILTIN_EXTENSION_LZ4
      "snappy"  HAVE_BUILTIN_EXTENSION_SNAPPY
      "zlib"    HAVE_BUILTIN_EXTENSION_ZLIB
      "zstd"    HAVE_BUILTIN_EXTENSION_ZSTD
)

message(STATUS ${FEATURE_OPTIONS})

vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO wiredtiger/wiredtiger
    REF 11.1.0
    SHA512 df3e859880b8f8edf4d5c8a4b95a47656045a7d6cd4b02a72c92a31de51e7161064fde4f227a5c3b8bb7c8816b83b2a79e8df3e16b052b790c9942fea8ca4279
    HEAD_REF develop
    PATCHES
        0001-fix-detect-zlib.lib-and-implib-on-windows.patch
        0002-fix-link-debug-CRT.patch
)

vcpkg_cmake_configure(
  SOURCE_PATH "${SOURCE_PATH}"
  OPTIONS
    -DENABLE_STATIC=1
    -DENABLE_LZ4=0
    -DENABLE_SNAPPY=0
    -DENABLE_ZLIB=0
    -DENABLE_ZSTD=0
    -DENABLE_PYTHON=0
    ${FEATURE_OPTIONS}
)

vcpkg_cmake_install()

vcpkg_copy_pdbs()

file(REMOVE_RECURSE "${CURRENT_PACKAGES_DIR}/bin")
file(REMOVE_RECURSE "${CURRENT_PACKAGES_DIR}/debug/include")
if(VCPKG_LIBRARY_LINKAGE STREQUAL "static")
    file(REMOVE_RECURSE "${CURRENT_PACKAGES_DIR}/bin" "${CURRENT_PACKAGES_DIR}/debug/bin")
endif()

vcpkg_fixup_pkgconfig()

file(COPY "${CMAKE_CURRENT_LIST_DIR}/usage" DESTINATION "${CURRENT_PACKAGES_DIR}/share/${PORT}")
vcpkg_install_copyright(FILE_LIST "${SOURCE_PATH}/LICENSE")