# Install script for directory: /cygdrive/d/DongKyuKim/Magnetic Resonance/REMMI Test/niftyreg_source/reg-lib

# Set the install prefix
if(NOT DEFINED CMAKE_INSTALL_PREFIX)
  set(CMAKE_INSTALL_PREFIX "/usr/local")
endif()
string(REGEX REPLACE "/$" "" CMAKE_INSTALL_PREFIX "${CMAKE_INSTALL_PREFIX}")

# Set the install configuration name.
if(NOT DEFINED CMAKE_INSTALL_CONFIG_NAME)
  if(BUILD_TYPE)
    string(REGEX REPLACE "^[^A-Za-z0-9_]+" ""
           CMAKE_INSTALL_CONFIG_NAME "${BUILD_TYPE}")
  else()
    set(CMAKE_INSTALL_CONFIG_NAME "")
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

if(NOT CMAKE_INSTALL_COMPONENT OR "${CMAKE_INSTALL_COMPONENT}" STREQUAL "Development")
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/lib" TYPE STATIC_LIBRARY FILES "/cygdrive/d/DongKyuKim/Magnetic Resonance/REMMI Test/niftyreg_build/reg-lib/lib_reg_resampling.a")
endif()

if(NOT CMAKE_INSTALL_COMPONENT OR "${CMAKE_INSTALL_COMPONENT}" STREQUAL "Development")
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/include" TYPE FILE FILES "/cygdrive/d/DongKyuKim/Magnetic Resonance/REMMI Test/niftyreg_source/reg-lib/_reg_resampling.h")
endif()

if(NOT CMAKE_INSTALL_COMPONENT OR "${CMAKE_INSTALL_COMPONENT}" STREQUAL "Development")
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/lib" TYPE STATIC_LIBRARY FILES "/cygdrive/d/DongKyuKim/Magnetic Resonance/REMMI Test/niftyreg_build/reg-lib/lib_reg_maths.a")
endif()

if(NOT CMAKE_INSTALL_COMPONENT OR "${CMAKE_INSTALL_COMPONENT}" STREQUAL "Development")
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/include" TYPE FILE FILES "/cygdrive/d/DongKyuKim/Magnetic Resonance/REMMI Test/niftyreg_source/reg-lib/_reg_maths.h")
endif()

if(NOT CMAKE_INSTALL_COMPONENT OR "${CMAKE_INSTALL_COMPONENT}" STREQUAL "Development")
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/lib" TYPE STATIC_LIBRARY FILES "/cygdrive/d/DongKyuKim/Magnetic Resonance/REMMI Test/niftyreg_build/reg-lib/lib_reg_globalTransformation.a")
endif()

if(NOT CMAKE_INSTALL_COMPONENT OR "${CMAKE_INSTALL_COMPONENT}" STREQUAL "Development")
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/include" TYPE FILE FILES "/cygdrive/d/DongKyuKim/Magnetic Resonance/REMMI Test/niftyreg_source/reg-lib/_reg_globalTransformation.h")
endif()

if(NOT CMAKE_INSTALL_COMPONENT OR "${CMAKE_INSTALL_COMPONENT}" STREQUAL "Development")
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/lib" TYPE STATIC_LIBRARY FILES "/cygdrive/d/DongKyuKim/Magnetic Resonance/REMMI Test/niftyreg_build/reg-lib/lib_reg_mutualinformation.a")
endif()

if(NOT CMAKE_INSTALL_COMPONENT OR "${CMAKE_INSTALL_COMPONENT}" STREQUAL "Development")
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/include" TYPE FILE FILES "/cygdrive/d/DongKyuKim/Magnetic Resonance/REMMI Test/niftyreg_source/reg-lib/_reg_mutualinformation.h")
endif()

if(NOT CMAKE_INSTALL_COMPONENT OR "${CMAKE_INSTALL_COMPONENT}" STREQUAL "Development")
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/lib" TYPE STATIC_LIBRARY FILES "/cygdrive/d/DongKyuKim/Magnetic Resonance/REMMI Test/niftyreg_build/reg-lib/lib_reg_ssd.a")
endif()

if(NOT CMAKE_INSTALL_COMPONENT OR "${CMAKE_INSTALL_COMPONENT}" STREQUAL "Development")
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/include" TYPE FILE FILES "/cygdrive/d/DongKyuKim/Magnetic Resonance/REMMI Test/niftyreg_source/reg-lib/_reg_ssd.h")
endif()

if(NOT CMAKE_INSTALL_COMPONENT OR "${CMAKE_INSTALL_COMPONENT}" STREQUAL "Development")
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/lib" TYPE STATIC_LIBRARY FILES "/cygdrive/d/DongKyuKim/Magnetic Resonance/REMMI Test/niftyreg_build/reg-lib/lib_reg_KLdivergence.a")
endif()

if(NOT CMAKE_INSTALL_COMPONENT OR "${CMAKE_INSTALL_COMPONENT}" STREQUAL "Development")
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/include" TYPE FILE FILES "/cygdrive/d/DongKyuKim/Magnetic Resonance/REMMI Test/niftyreg_source/reg-lib/_reg_KLdivergence.h")
endif()

if(NOT CMAKE_INSTALL_COMPONENT OR "${CMAKE_INSTALL_COMPONENT}" STREQUAL "Development")
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/lib" TYPE STATIC_LIBRARY FILES "/cygdrive/d/DongKyuKim/Magnetic Resonance/REMMI Test/niftyreg_build/reg-lib/lib_reg_blockMatching.a")
endif()

if(NOT CMAKE_INSTALL_COMPONENT OR "${CMAKE_INSTALL_COMPONENT}" STREQUAL "Development")
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/include" TYPE FILE FILES "/cygdrive/d/DongKyuKim/Magnetic Resonance/REMMI Test/niftyreg_source/reg-lib/_reg_blockMatching.h")
endif()

if(NOT CMAKE_INSTALL_COMPONENT OR "${CMAKE_INSTALL_COMPONENT}" STREQUAL "Development")
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/lib" TYPE STATIC_LIBRARY FILES "/cygdrive/d/DongKyuKim/Magnetic Resonance/REMMI Test/niftyreg_build/reg-lib/lib_reg_femTransformation.a")
endif()

if(NOT CMAKE_INSTALL_COMPONENT OR "${CMAKE_INSTALL_COMPONENT}" STREQUAL "Development")
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/include" TYPE FILE FILES "/cygdrive/d/DongKyuKim/Magnetic Resonance/REMMI Test/niftyreg_source/reg-lib/_reg_femTransformation.h")
endif()

if(NOT CMAKE_INSTALL_COMPONENT OR "${CMAKE_INSTALL_COMPONENT}" STREQUAL "Development")
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/lib" TYPE STATIC_LIBRARY FILES "/cygdrive/d/DongKyuKim/Magnetic Resonance/REMMI Test/niftyreg_build/reg-lib/lib_reg_tools.a")
endif()

if(NOT CMAKE_INSTALL_COMPONENT OR "${CMAKE_INSTALL_COMPONENT}" STREQUAL "Development")
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/include" TYPE FILE FILES "/cygdrive/d/DongKyuKim/Magnetic Resonance/REMMI Test/niftyreg_source/reg-lib/_reg_tools.h")
endif()

if(NOT CMAKE_INSTALL_COMPONENT OR "${CMAKE_INSTALL_COMPONENT}" STREQUAL "Development")
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/lib" TYPE STATIC_LIBRARY FILES "/cygdrive/d/DongKyuKim/Magnetic Resonance/REMMI Test/niftyreg_build/reg-lib/lib_reg_localTransformation.a")
endif()

if(NOT CMAKE_INSTALL_COMPONENT OR "${CMAKE_INSTALL_COMPONENT}" STREQUAL "Development")
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/include" TYPE FILE FILES "/cygdrive/d/DongKyuKim/Magnetic Resonance/REMMI Test/niftyreg_source/reg-lib/_reg_localTransformation.h")
endif()

if(NOT CMAKE_INSTALL_COMPONENT OR "${CMAKE_INSTALL_COMPONENT}" STREQUAL "RuntimeLibraries")
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/lib" TYPE STATIC_LIBRARY OPTIONAL FILES "/cygdrive/d/DongKyuKim/Magnetic Resonance/REMMI Test/niftyreg_build/reg-lib/lib_reg_f3d.dll.a")
endif()

if(NOT CMAKE_INSTALL_COMPONENT OR "${CMAKE_INSTALL_COMPONENT}" STREQUAL "RuntimeLibraries")
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/bin" TYPE SHARED_LIBRARY FILES "/cygdrive/d/DongKyuKim/Magnetic Resonance/REMMI Test/niftyreg_build/reg-lib/cyg_reg_f3d.dll")
  if(EXISTS "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/bin/cyg_reg_f3d.dll" AND
     NOT IS_SYMLINK "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/bin/cyg_reg_f3d.dll")
    if(CMAKE_INSTALL_DO_STRIP)
      execute_process(COMMAND "/usr/bin/strip.exe" "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/bin/cyg_reg_f3d.dll")
    endif()
  endif()
endif()

if(NOT CMAKE_INSTALL_COMPONENT OR "${CMAKE_INSTALL_COMPONENT}" STREQUAL "Development")
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/include" TYPE FILE FILES
    "/cygdrive/d/DongKyuKim/Magnetic Resonance/REMMI Test/niftyreg_source/reg-lib/_reg_f3d.h"
    "/cygdrive/d/DongKyuKim/Magnetic Resonance/REMMI Test/niftyreg_source/reg-lib/_reg_f3d.cpp"
    )
endif()

if(NOT CMAKE_INSTALL_COMPONENT OR "${CMAKE_INSTALL_COMPONENT}" STREQUAL "Development")
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/include" TYPE FILE FILES
    "/cygdrive/d/DongKyuKim/Magnetic Resonance/REMMI Test/niftyreg_source/reg-lib/_reg_f3d2.h"
    "/cygdrive/d/DongKyuKim/Magnetic Resonance/REMMI Test/niftyreg_source/reg-lib/_reg_f3d2.cpp"
    )
endif()

if(NOT CMAKE_INSTALL_COMPONENT OR "${CMAKE_INSTALL_COMPONENT}" STREQUAL "Development")
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/include" TYPE FILE FILES
    "/cygdrive/d/DongKyuKim/Magnetic Resonance/REMMI Test/niftyreg_source/reg-lib/_reg_f3d_sym.h"
    "/cygdrive/d/DongKyuKim/Magnetic Resonance/REMMI Test/niftyreg_source/reg-lib/_reg_f3d_sym.cpp"
    )
endif()

if(NOT CMAKE_INSTALL_COMPONENT OR "${CMAKE_INSTALL_COMPONENT}" STREQUAL "RuntimeLibraries")
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/lib" TYPE STATIC_LIBRARY OPTIONAL FILES "/cygdrive/d/DongKyuKim/Magnetic Resonance/REMMI Test/niftyreg_build/reg-lib/lib_reg_aladin.dll.a")
endif()

if(NOT CMAKE_INSTALL_COMPONENT OR "${CMAKE_INSTALL_COMPONENT}" STREQUAL "RuntimeLibraries")
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/bin" TYPE SHARED_LIBRARY FILES "/cygdrive/d/DongKyuKim/Magnetic Resonance/REMMI Test/niftyreg_build/reg-lib/cyg_reg_aladin.dll")
  if(EXISTS "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/bin/cyg_reg_aladin.dll" AND
     NOT IS_SYMLINK "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/bin/cyg_reg_aladin.dll")
    if(CMAKE_INSTALL_DO_STRIP)
      execute_process(COMMAND "/usr/bin/strip.exe" "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/bin/cyg_reg_aladin.dll")
    endif()
  endif()
endif()

if(NOT CMAKE_INSTALL_COMPONENT OR "${CMAKE_INSTALL_COMPONENT}" STREQUAL "Development")
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/include" TYPE FILE FILES
    "/cygdrive/d/DongKyuKim/Magnetic Resonance/REMMI Test/niftyreg_source/reg-lib/_reg_aladin.h"
    "/cygdrive/d/DongKyuKim/Magnetic Resonance/REMMI Test/niftyreg_source/reg-lib/_reg_aladin.cpp"
    "/cygdrive/d/DongKyuKim/Magnetic Resonance/REMMI Test/niftyreg_source/reg-lib/_reg_macros.h"
    )
endif()

if(NOT CMAKE_INSTALL_COMPONENT OR "${CMAKE_INSTALL_COMPONENT}" STREQUAL "RuntimeLibraries")
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/lib" TYPE STATIC_LIBRARY OPTIONAL FILES "/cygdrive/d/DongKyuKim/Magnetic Resonance/REMMI Test/niftyreg_build/reg-lib/lib_reg_thinPlateSpline.dll.a")
endif()

if(NOT CMAKE_INSTALL_COMPONENT OR "${CMAKE_INSTALL_COMPONENT}" STREQUAL "RuntimeLibraries")
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/bin" TYPE SHARED_LIBRARY FILES "/cygdrive/d/DongKyuKim/Magnetic Resonance/REMMI Test/niftyreg_build/reg-lib/cyg_reg_thinPlateSpline.dll")
  if(EXISTS "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/bin/cyg_reg_thinPlateSpline.dll" AND
     NOT IS_SYMLINK "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/bin/cyg_reg_thinPlateSpline.dll")
    if(CMAKE_INSTALL_DO_STRIP)
      execute_process(COMMAND "/usr/bin/strip.exe" "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/bin/cyg_reg_thinPlateSpline.dll")
    endif()
  endif()
endif()

if(NOT CMAKE_INSTALL_COMPONENT OR "${CMAKE_INSTALL_COMPONENT}" STREQUAL "Development")
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/include" TYPE FILE FILES
    "/cygdrive/d/DongKyuKim/Magnetic Resonance/REMMI Test/niftyreg_source/reg-lib/_reg_thinPlateSpline.h"
    "/cygdrive/d/DongKyuKim/Magnetic Resonance/REMMI Test/niftyreg_source/reg-lib/_reg_thinPlateSpline.cpp"
    )
endif()

