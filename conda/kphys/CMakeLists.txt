cmake_minimum_required(VERSION 3.5)
project(kitsunetsuki-phys)

if(WIN32)
  set(CMAKE_C_FLAGS "${CMAKE_C_FLAGS}")
  set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS}")
  add_definitions("/wd4996 /wd4275 /wd4267 /wd4101 /wd4273")
else()
  set(CMAKE_C_FLAGS "${CMAKE_CXX_FLAGS} -fPIC -std=c++11")
  set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -fPIC -std=c++11")
endif()

find_package(PythonInterp 3.2 REQUIRED)
find_package(PythonLibs 3.2 REQUIRED)
include_directories(${PYTHON_INCLUDE_DIR})

find_package(Bullet REQUIRED)
include_directories(${BULLET_INCLUDE_DIR})

find_path(PANDA_INCLUDE_DIR NAMES panda3d/pandatoolbase.h)
include_directories(${PANDA_INCLUDE_DIR}/panda3d)
find_library(PANDAFRAMEWORK_LIBRARY_PATH NAMES libp3framework.so libp3framework.lib)
get_filename_component(PANDA_LIBRARY_DIR ${PANDAFRAMEWORK_LIBRARY_PATH} DIRECTORY)
link_directories(${PANDA_LIBRARY_DIR})

set(KPHYS_SOURCES
  ${CMAKE_SOURCE_DIR}/kphys/bullet/controller.cxx
  ${CMAKE_SOURCE_DIR}/kphys/bullet/world.cxx
  ${CMAKE_SOURCE_DIR}/kphys/panda/config.cxx
  ${CMAKE_SOURCE_DIR}/kphys/panda/controller.cxx
  ${CMAKE_SOURCE_DIR}/kphys/panda/hitbox.cxx
  ${CMAKE_SOURCE_DIR}/kphys/panda/world.cxx
)

set(KPHYS_HEADERS
  ${CMAKE_SOURCE_DIR}/kphys/bullet/controller.h
  ${CMAKE_SOURCE_DIR}/kphys/bullet/world.h
  ${CMAKE_SOURCE_DIR}/kphys/panda/config.h
  ${CMAKE_SOURCE_DIR}/kphys/panda/controller.h
  ${CMAKE_SOURCE_DIR}/kphys/panda/hitbox.h
  ${CMAKE_SOURCE_DIR}/kphys/panda/world.h
)

include_directories(${CMAKE_SOURCE_DIR})

add_custom_command(
  OUTPUT ${CMAKE_CURRENT_BINARY_DIR}/kphys_igate.cpp ${CMAKE_CURRENT_BINARY_DIR}/kphys.in
  COMMAND interrogate -DCPPPARSER -D__STDC__=1 -D__cplusplus=201103L
  -I${CMAKE_SOURCE_DIR}
  -I${PANDA_INCLUDE_DIR}/panda3d
  -S${CMAKE_SOURCE_DIR}
  -S${PANDA_INCLUDE_DIR}/panda3d/parser-inc
  -oc ${CMAKE_CURRENT_BINARY_DIR}/kphys_igate.cpp
  -od ${CMAKE_CURRENT_BINARY_DIR}/kphys.in
  -fnames -string -refcount -assert -python-native -nomangle
  -module kphys -library kphys
  ${KPHYS_HEADERS}
  DEPENDS ${KPHYS_SOURCES} ${KPHYS_HEADERS} ${CMAKE_SOURCE_DIR}/kphys/interrogate.h)

add_custom_command(
  OUTPUT ${CMAKE_CURRENT_BINARY_DIR}/kphys_module.cpp
  COMMAND interrogate_module
  -oc ${CMAKE_CURRENT_BINARY_DIR}/kphys_module.cpp
  -module kphys -library kphys
  -python-native
  -import panda3d.core
  -import panda3d.bullet
  ${CMAKE_CURRENT_BINARY_DIR}/kphys.in
  DEPENDS ${CMAKE_CURRENT_BINARY_DIR}/kphys.in ${CMAKE_CURRENT_BINARY_DIR}/kphys_igate.cpp)

add_library(kphys SHARED
  ${KPHYS_SOURCES}
  ${CMAKE_CURRENT_BINARY_DIR}/kphys_igate.cpp
  ${CMAKE_CURRENT_BINARY_DIR}/kphys_module.cpp)

set_target_properties(kphys PROPERTIES PREFIX "")
if(WIN32)
  set_target_properties(kphys PROPERTIES SUFFIX ".pyd")
endif()

if(WIN32)
  set(PANDA_LIBS
    # PRIMARY
    libp3framework
    # COMMON_PANDA_LIBS
    libpanda
    libpandaexpress
    # COMMON_DTOOL_LIBS
    libp3dtool
    libp3dtoolconfig
    # EXTRA
    libp3direct
    libp3interrogatedb
    # PANDABULLET
    libpandabullet
    )
else()
  set(PANDA_LIBS
    # PRIMARY
    p3framework
    # COMMON_PANDA_LIBS
    panda
    pandaexpress
    # COMMON_DTOOL_LIBS
    p3dtool
    p3dtoolconfig
    # EXTRA
    p3direct
    p3interrogatedb
    # PANDABULLET
    pandabullet
    )
endif()

target_link_libraries(kphys
  ${PANDA_LIBS}
  # PYTHON
  ${PYTHON_LIBRARY}
  # BULLET
  ${BULLET_COLLISION_LIBRARY}
  ${BULLET_DYNAMICS_LIBRARY}
  ${BULLET_MATH_LIBRARY}
  ${BULLET_SOFTBODY_LIBRARY}
  )

install(TARGETS kphys DESTINATION ${CMAKE_INSTALL_PREFIX})
