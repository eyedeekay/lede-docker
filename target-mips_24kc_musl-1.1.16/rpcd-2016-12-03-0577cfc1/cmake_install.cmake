# Install script for directory: /home/lede-build/source/build_dir/target-mips_24kc_musl-1.1.16/rpcd-2016-12-03-0577cfc1

# Set the install prefix
if(NOT DEFINED CMAKE_INSTALL_PREFIX)
  set(CMAKE_INSTALL_PREFIX "/usr")
endif()
string(REGEX REPLACE "/$" "" CMAKE_INSTALL_PREFIX "${CMAKE_INSTALL_PREFIX}")

# Set the install configuration name.
if(NOT DEFINED CMAKE_INSTALL_CONFIG_NAME)
  if(BUILD_TYPE)
    string(REGEX REPLACE "^[^A-Za-z0-9_]+" ""
           CMAKE_INSTALL_CONFIG_NAME "${BUILD_TYPE}")
  else()
    set(CMAKE_INSTALL_CONFIG_NAME "Release")
  endif()
  message(STATUS "Install configuration: \"${CMAKE_INSTALL_CONFIG_NAME}\"")
endif()

# Set the component getting installed.
if(NOT CMAKE_INSTALL_COMPONENT)
  if(COMPONENT)
    message(STATUS "Install component: \"${COMPONENT}\"")
    set(CMAKE_INSTALL_COMPONENT "${COMPONENT}")
  else()
    set(CMAKE_INSTALL_COMPONENT)
  endif()
endif()

# Install shared libraries without execute permission?
if(NOT DEFINED CMAKE_INSTALL_SO_NO_EXE)
  set(CMAKE_INSTALL_SO_NO_EXE "1")
endif()

if("${CMAKE_INSTALL_COMPONENT}" STREQUAL "Unspecified" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/sbin" TYPE EXECUTABLE FILES "/home/lede-build/source/build_dir/target-mips_24kc_musl-1.1.16/rpcd-2016-12-03-0577cfc1/rpcd")
  if(EXISTS "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/sbin/rpcd" AND
     NOT IS_SYMLINK "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/sbin/rpcd")
    if(CMAKE_INSTALL_DO_STRIP)
      execute_process(COMMAND "/home/lede-build/source/build_dir/target-mips_24kc_musl-1.1.16/rpcd-2016-12-03-0577cfc1/:" "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/sbin/rpcd")
    endif()
  endif()
endif()

if("${CMAKE_INSTALL_COMPONENT}" STREQUAL "Unspecified" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/lib" TYPE MODULE FILES "/home/lede-build/source/build_dir/target-mips_24kc_musl-1.1.16/rpcd-2016-12-03-0577cfc1/file.so")
  if(EXISTS "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/lib/file.so" AND
     NOT IS_SYMLINK "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/lib/file.so")
    if(CMAKE_INSTALL_DO_STRIP)
      execute_process(COMMAND "/home/lede-build/source/build_dir/target-mips_24kc_musl-1.1.16/rpcd-2016-12-03-0577cfc1/:" "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/lib/file.so")
    endif()
  endif()
endif()

if("${CMAKE_INSTALL_COMPONENT}" STREQUAL "Unspecified" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/lib" TYPE MODULE FILES "/home/lede-build/source/build_dir/target-mips_24kc_musl-1.1.16/rpcd-2016-12-03-0577cfc1/rpcsys.so")
  if(EXISTS "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/lib/rpcsys.so" AND
     NOT IS_SYMLINK "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/lib/rpcsys.so")
    if(CMAKE_INSTALL_DO_STRIP)
      execute_process(COMMAND "/home/lede-build/source/build_dir/target-mips_24kc_musl-1.1.16/rpcd-2016-12-03-0577cfc1/:" "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/lib/rpcsys.so")
    endif()
  endif()
endif()

if("${CMAKE_INSTALL_COMPONENT}" STREQUAL "Unspecified" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/lib" TYPE MODULE FILES "/home/lede-build/source/build_dir/target-mips_24kc_musl-1.1.16/rpcd-2016-12-03-0577cfc1/iwinfo.so")
  if(EXISTS "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/lib/iwinfo.so" AND
     NOT IS_SYMLINK "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/lib/iwinfo.so")
    if(CMAKE_INSTALL_DO_STRIP)
      execute_process(COMMAND "/home/lede-build/source/build_dir/target-mips_24kc_musl-1.1.16/rpcd-2016-12-03-0577cfc1/:" "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/lib/iwinfo.so")
    endif()
  endif()
endif()

if(CMAKE_INSTALL_COMPONENT)
  set(CMAKE_INSTALL_MANIFEST "install_manifest_${CMAKE_INSTALL_COMPONENT}.txt")
else()
  set(CMAKE_INSTALL_MANIFEST "install_manifest.txt")
endif()

string(REPLACE ";" "\n" CMAKE_INSTALL_MANIFEST_CONTENT
       "${CMAKE_INSTALL_MANIFEST_FILES}")
file(WRITE "/home/lede-build/source/build_dir/target-mips_24kc_musl-1.1.16/rpcd-2016-12-03-0577cfc1/${CMAKE_INSTALL_MANIFEST}"
     "${CMAKE_INSTALL_MANIFEST_CONTENT}")
