# WiredTiger 11.1.0 vcpkg

This repository contains vcpkg ports for WiredTiger, and is initially made for my own convenience.

# Notice

I've **tested on windows with VS2019/MSVC ONLY**, I'm not sure if it will work with MinGW or other platforms/toolchains.

This is **not official**, and I'm neither going to support all triplets nor planning to submit to vcpkg repo.

You should **check**:
1. whether wiredtiger is already included in vcpkg repository.
2. whether you're going to use a static-linked wiredtiger library on windows with MSVC.

before considering to use this unofficial port.

# Usage

1. Clone this repository to `<vcpkg-root>/ports`
   ```powershell
   cd <vcpkg-root>/ports
   git clone https://github.com/kabu1204/wiredtiger-vcpkg wiredtiger
   ```
2. Install
   ```powershell
   cd <vcpkg-root>
   .\vcpkg.exe install wiredtiger[*]:x64-windows-static
   ```
3. Use it in your CMake projects
   
   Add following to your CMakeLists.txt:
   ```cmake
    find_library(WIREDTIGER_LIB wiredtiger REQUIRED)
    find_path(WIREDTIGER_INCLUDE_DIR "wiredtiger.h" REQUIRED)    
    target_link_libraries(main PRIVATE ${WIREDTIGER_LIB})
    target_include_directories(main PRIVATE ${WIREDTIGER_INCLUDE_DIR})
   ```

   And remember to pass `-DCMAKE_TOOLCHAIN_FILE=C:/src/vcpkg/scripts/buildsystems/vcpkg.cmake ` and 
   `-DVCPKG_TARGET_TRIPLET=x64-windows-static` to your cmake commandline arguments.

# Optional features

```
wiredtiger[lz4]          built-in lz4 compressor in wiredtiger
wiredtiger[snappy]       built-in snappy compressor in wiredtiger
wiredtiger[zlib]         built-in zlib compressor in wiredtiger
wiredtiger[zstd]         built-in zstd compressor in wiredtiger
```

