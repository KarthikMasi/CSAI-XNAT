# CMAKE generated file: DO NOT EDIT!
# Generated by "Unix Makefiles" Generator, CMake Version 3.3

# Delete rule output on recipe failure.
.DELETE_ON_ERROR:


#=============================================================================
# Special targets provided by cmake.

# Disable implicit rules so canonical targets will work.
.SUFFIXES:


# Remove some rules from gmake that .SUFFIXES does not remove.
SUFFIXES =

.SUFFIXES: .hpux_make_needs_suffix_list


# Suppress display of executed commands.
$(VERBOSE).SILENT:


# A target that is always out of date.
cmake_force:

.PHONY : cmake_force

#=============================================================================
# Set environment variables for the build.

# The shell in which to execute make rules.
SHELL = /bin/sh

# The CMake executable.
CMAKE_COMMAND = /usr/bin/cmake.exe

# The command to remove a file.
RM = /usr/bin/cmake.exe -E remove -f

# Escaping for special characters.
EQUALS = =

# The top-level source directory on which CMake was run.
CMAKE_SOURCE_DIR = "/cygdrive/d/DongKyuKim/Magnetic Resonance/REMMI Test/niftyreg_source"

# The top-level build directory on which CMake was run.
CMAKE_BINARY_DIR = "/cygdrive/d/DongKyuKim/Magnetic Resonance/REMMI Test/niftyreg_build"

# Include any dependencies generated for this target.
include reg-apps/CMakeFiles/reg_resample.dir/depend.make

# Include the progress variables for this target.
include reg-apps/CMakeFiles/reg_resample.dir/progress.make

# Include the compile flags for this target's objects.
include reg-apps/CMakeFiles/reg_resample.dir/flags.make

reg-apps/CMakeFiles/reg_resample.dir/reg_resample.cpp.o: reg-apps/CMakeFiles/reg_resample.dir/flags.make
reg-apps/CMakeFiles/reg_resample.dir/reg_resample.cpp.o: /cygdrive/d/DongKyuKim/Magnetic\ Resonance/REMMI\ Test/niftyreg_source/reg-apps/reg_resample.cpp
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --progress-dir="/cygdrive/d/DongKyuKim/Magnetic Resonance/REMMI Test/niftyreg_build/CMakeFiles" --progress-num=$(CMAKE_PROGRESS_1) "Building CXX object reg-apps/CMakeFiles/reg_resample.dir/reg_resample.cpp.o"
	cd "/cygdrive/d/DongKyuKim/Magnetic Resonance/REMMI Test/niftyreg_build/reg-apps" && /usr/bin/c++.exe   $(CXX_DEFINES) $(CXX_FLAGS) -o CMakeFiles/reg_resample.dir/reg_resample.cpp.o -c "/cygdrive/d/DongKyuKim/Magnetic Resonance/REMMI Test/niftyreg_source/reg-apps/reg_resample.cpp"

reg-apps/CMakeFiles/reg_resample.dir/reg_resample.cpp.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing CXX source to CMakeFiles/reg_resample.dir/reg_resample.cpp.i"
	cd "/cygdrive/d/DongKyuKim/Magnetic Resonance/REMMI Test/niftyreg_build/reg-apps" && /usr/bin/c++.exe  $(CXX_DEFINES) $(CXX_FLAGS) -E "/cygdrive/d/DongKyuKim/Magnetic Resonance/REMMI Test/niftyreg_source/reg-apps/reg_resample.cpp" > CMakeFiles/reg_resample.dir/reg_resample.cpp.i

reg-apps/CMakeFiles/reg_resample.dir/reg_resample.cpp.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling CXX source to assembly CMakeFiles/reg_resample.dir/reg_resample.cpp.s"
	cd "/cygdrive/d/DongKyuKim/Magnetic Resonance/REMMI Test/niftyreg_build/reg-apps" && /usr/bin/c++.exe  $(CXX_DEFINES) $(CXX_FLAGS) -S "/cygdrive/d/DongKyuKim/Magnetic Resonance/REMMI Test/niftyreg_source/reg-apps/reg_resample.cpp" -o CMakeFiles/reg_resample.dir/reg_resample.cpp.s

reg-apps/CMakeFiles/reg_resample.dir/reg_resample.cpp.o.requires:

.PHONY : reg-apps/CMakeFiles/reg_resample.dir/reg_resample.cpp.o.requires

reg-apps/CMakeFiles/reg_resample.dir/reg_resample.cpp.o.provides: reg-apps/CMakeFiles/reg_resample.dir/reg_resample.cpp.o.requires
	$(MAKE) -f reg-apps/CMakeFiles/reg_resample.dir/build.make reg-apps/CMakeFiles/reg_resample.dir/reg_resample.cpp.o.provides.build
.PHONY : reg-apps/CMakeFiles/reg_resample.dir/reg_resample.cpp.o.provides

reg-apps/CMakeFiles/reg_resample.dir/reg_resample.cpp.o.provides.build: reg-apps/CMakeFiles/reg_resample.dir/reg_resample.cpp.o


# Object files for target reg_resample
reg_resample_OBJECTS = \
"CMakeFiles/reg_resample.dir/reg_resample.cpp.o"

# External object files for target reg_resample
reg_resample_EXTERNAL_OBJECTS =

reg-apps/reg_resample.exe: reg-apps/CMakeFiles/reg_resample.dir/reg_resample.cpp.o
reg-apps/reg_resample.exe: reg-apps/CMakeFiles/reg_resample.dir/build.make
reg-apps/reg_resample.exe: reg-lib/lib_reg_resampling.a
reg-apps/reg_resample.exe: reg-lib/lib_reg_localTransformation.a
reg-apps/reg_resample.exe: reg-lib/lib_reg_tools.a
reg-apps/reg_resample.exe: reg-lib/lib_reg_globalTransformation.a
reg-apps/reg_resample.exe: reg-io/lib_reg_ReadWriteImage.a
reg-apps/reg_resample.exe: reg-io/png/libreg_png.a
reg-apps/reg_resample.exe: reg-io/png/libpng.a
reg-apps/reg_resample.exe: reg-io/nrrd/libreg_nrrd.a
reg-apps/reg_resample.exe: reg-lib/lib_reg_tools.a
reg-apps/reg_resample.exe: reg-lib/lib_reg_maths.a
reg-apps/reg_resample.exe: reg-io/nifti/libreg_nifti.a
reg-apps/reg_resample.exe: reg-io/nrrd/libreg_NrrdIO.a
reg-apps/reg_resample.exe: reg-io/zlib/libz.a
reg-apps/reg_resample.exe: reg-apps/CMakeFiles/reg_resample.dir/link.txt
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --bold --progress-dir="/cygdrive/d/DongKyuKim/Magnetic Resonance/REMMI Test/niftyreg_build/CMakeFiles" --progress-num=$(CMAKE_PROGRESS_2) "Linking CXX executable reg_resample.exe"
	cd "/cygdrive/d/DongKyuKim/Magnetic Resonance/REMMI Test/niftyreg_build/reg-apps" && $(CMAKE_COMMAND) -E cmake_link_script CMakeFiles/reg_resample.dir/link.txt --verbose=$(VERBOSE)

# Rule to build all files generated by this target.
reg-apps/CMakeFiles/reg_resample.dir/build: reg-apps/reg_resample.exe

.PHONY : reg-apps/CMakeFiles/reg_resample.dir/build

reg-apps/CMakeFiles/reg_resample.dir/requires: reg-apps/CMakeFiles/reg_resample.dir/reg_resample.cpp.o.requires

.PHONY : reg-apps/CMakeFiles/reg_resample.dir/requires

reg-apps/CMakeFiles/reg_resample.dir/clean:
	cd "/cygdrive/d/DongKyuKim/Magnetic Resonance/REMMI Test/niftyreg_build/reg-apps" && $(CMAKE_COMMAND) -P CMakeFiles/reg_resample.dir/cmake_clean.cmake
.PHONY : reg-apps/CMakeFiles/reg_resample.dir/clean

reg-apps/CMakeFiles/reg_resample.dir/depend:
	cd "/cygdrive/d/DongKyuKim/Magnetic Resonance/REMMI Test/niftyreg_build" && $(CMAKE_COMMAND) -E cmake_depends "Unix Makefiles" "/cygdrive/d/DongKyuKim/Magnetic Resonance/REMMI Test/niftyreg_source" "/cygdrive/d/DongKyuKim/Magnetic Resonance/REMMI Test/niftyreg_source/reg-apps" "/cygdrive/d/DongKyuKim/Magnetic Resonance/REMMI Test/niftyreg_build" "/cygdrive/d/DongKyuKim/Magnetic Resonance/REMMI Test/niftyreg_build/reg-apps" "/cygdrive/d/DongKyuKim/Magnetic Resonance/REMMI Test/niftyreg_build/reg-apps/CMakeFiles/reg_resample.dir/DependInfo.cmake" --color=$(COLOR)
.PHONY : reg-apps/CMakeFiles/reg_resample.dir/depend

