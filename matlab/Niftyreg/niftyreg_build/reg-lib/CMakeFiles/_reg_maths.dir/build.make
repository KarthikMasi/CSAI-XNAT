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
include reg-lib/CMakeFiles/_reg_maths.dir/depend.make

# Include the progress variables for this target.
include reg-lib/CMakeFiles/_reg_maths.dir/progress.make

# Include the compile flags for this target's objects.
include reg-lib/CMakeFiles/_reg_maths.dir/flags.make

reg-lib/CMakeFiles/_reg_maths.dir/_reg_maths.cpp.o: reg-lib/CMakeFiles/_reg_maths.dir/flags.make
reg-lib/CMakeFiles/_reg_maths.dir/_reg_maths.cpp.o: /cygdrive/d/DongKyuKim/Magnetic\ Resonance/REMMI\ Test/niftyreg_source/reg-lib/_reg_maths.cpp
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --progress-dir="/cygdrive/d/DongKyuKim/Magnetic Resonance/REMMI Test/niftyreg_build/CMakeFiles" --progress-num=$(CMAKE_PROGRESS_1) "Building CXX object reg-lib/CMakeFiles/_reg_maths.dir/_reg_maths.cpp.o"
	cd "/cygdrive/d/DongKyuKim/Magnetic Resonance/REMMI Test/niftyreg_build/reg-lib" && /usr/bin/c++.exe   $(CXX_DEFINES) $(CXX_FLAGS) -o CMakeFiles/_reg_maths.dir/_reg_maths.cpp.o -c "/cygdrive/d/DongKyuKim/Magnetic Resonance/REMMI Test/niftyreg_source/reg-lib/_reg_maths.cpp"

reg-lib/CMakeFiles/_reg_maths.dir/_reg_maths.cpp.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing CXX source to CMakeFiles/_reg_maths.dir/_reg_maths.cpp.i"
	cd "/cygdrive/d/DongKyuKim/Magnetic Resonance/REMMI Test/niftyreg_build/reg-lib" && /usr/bin/c++.exe  $(CXX_DEFINES) $(CXX_FLAGS) -E "/cygdrive/d/DongKyuKim/Magnetic Resonance/REMMI Test/niftyreg_source/reg-lib/_reg_maths.cpp" > CMakeFiles/_reg_maths.dir/_reg_maths.cpp.i

reg-lib/CMakeFiles/_reg_maths.dir/_reg_maths.cpp.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling CXX source to assembly CMakeFiles/_reg_maths.dir/_reg_maths.cpp.s"
	cd "/cygdrive/d/DongKyuKim/Magnetic Resonance/REMMI Test/niftyreg_build/reg-lib" && /usr/bin/c++.exe  $(CXX_DEFINES) $(CXX_FLAGS) -S "/cygdrive/d/DongKyuKim/Magnetic Resonance/REMMI Test/niftyreg_source/reg-lib/_reg_maths.cpp" -o CMakeFiles/_reg_maths.dir/_reg_maths.cpp.s

reg-lib/CMakeFiles/_reg_maths.dir/_reg_maths.cpp.o.requires:

.PHONY : reg-lib/CMakeFiles/_reg_maths.dir/_reg_maths.cpp.o.requires

reg-lib/CMakeFiles/_reg_maths.dir/_reg_maths.cpp.o.provides: reg-lib/CMakeFiles/_reg_maths.dir/_reg_maths.cpp.o.requires
	$(MAKE) -f reg-lib/CMakeFiles/_reg_maths.dir/build.make reg-lib/CMakeFiles/_reg_maths.dir/_reg_maths.cpp.o.provides.build
.PHONY : reg-lib/CMakeFiles/_reg_maths.dir/_reg_maths.cpp.o.provides

reg-lib/CMakeFiles/_reg_maths.dir/_reg_maths.cpp.o.provides.build: reg-lib/CMakeFiles/_reg_maths.dir/_reg_maths.cpp.o


# Object files for target _reg_maths
_reg_maths_OBJECTS = \
"CMakeFiles/_reg_maths.dir/_reg_maths.cpp.o"

# External object files for target _reg_maths
_reg_maths_EXTERNAL_OBJECTS =

reg-lib/lib_reg_maths.a: reg-lib/CMakeFiles/_reg_maths.dir/_reg_maths.cpp.o
reg-lib/lib_reg_maths.a: reg-lib/CMakeFiles/_reg_maths.dir/build.make
reg-lib/lib_reg_maths.a: reg-lib/CMakeFiles/_reg_maths.dir/link.txt
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --bold --progress-dir="/cygdrive/d/DongKyuKim/Magnetic Resonance/REMMI Test/niftyreg_build/CMakeFiles" --progress-num=$(CMAKE_PROGRESS_2) "Linking CXX static library lib_reg_maths.a"
	cd "/cygdrive/d/DongKyuKim/Magnetic Resonance/REMMI Test/niftyreg_build/reg-lib" && $(CMAKE_COMMAND) -P CMakeFiles/_reg_maths.dir/cmake_clean_target.cmake
	cd "/cygdrive/d/DongKyuKim/Magnetic Resonance/REMMI Test/niftyreg_build/reg-lib" && $(CMAKE_COMMAND) -E cmake_link_script CMakeFiles/_reg_maths.dir/link.txt --verbose=$(VERBOSE)

# Rule to build all files generated by this target.
reg-lib/CMakeFiles/_reg_maths.dir/build: reg-lib/lib_reg_maths.a

.PHONY : reg-lib/CMakeFiles/_reg_maths.dir/build

reg-lib/CMakeFiles/_reg_maths.dir/requires: reg-lib/CMakeFiles/_reg_maths.dir/_reg_maths.cpp.o.requires

.PHONY : reg-lib/CMakeFiles/_reg_maths.dir/requires

reg-lib/CMakeFiles/_reg_maths.dir/clean:
	cd "/cygdrive/d/DongKyuKim/Magnetic Resonance/REMMI Test/niftyreg_build/reg-lib" && $(CMAKE_COMMAND) -P CMakeFiles/_reg_maths.dir/cmake_clean.cmake
.PHONY : reg-lib/CMakeFiles/_reg_maths.dir/clean

reg-lib/CMakeFiles/_reg_maths.dir/depend:
	cd "/cygdrive/d/DongKyuKim/Magnetic Resonance/REMMI Test/niftyreg_build" && $(CMAKE_COMMAND) -E cmake_depends "Unix Makefiles" "/cygdrive/d/DongKyuKim/Magnetic Resonance/REMMI Test/niftyreg_source" "/cygdrive/d/DongKyuKim/Magnetic Resonance/REMMI Test/niftyreg_source/reg-lib" "/cygdrive/d/DongKyuKim/Magnetic Resonance/REMMI Test/niftyreg_build" "/cygdrive/d/DongKyuKim/Magnetic Resonance/REMMI Test/niftyreg_build/reg-lib" "/cygdrive/d/DongKyuKim/Magnetic Resonance/REMMI Test/niftyreg_build/reg-lib/CMakeFiles/_reg_maths.dir/DependInfo.cmake" --color=$(COLOR)
.PHONY : reg-lib/CMakeFiles/_reg_maths.dir/depend

