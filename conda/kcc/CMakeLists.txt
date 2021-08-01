cmake_minimum_required(VERSION 3.5)
project(bullet-kitsunetsuki)

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

set(KCC_SOURCES
  ${CMAKE_CURRENT_SOURCE_DIR}/bullet/kcc.cxx
  ${CMAKE_CURRENT_SOURCE_DIR}/panda/config.cxx
  ${CMAKE_CURRENT_SOURCE_DIR}/panda/kcc.cxx
  ${CMAKE_CURRENT_SOURCE_DIR}/panda/hitbox.cxx
)

set(KCC_HEADERS
  ${CMAKE_CURRENT_SOURCE_DIR}/bullet/kcc.h
  ${CMAKE_CURRENT_SOURCE_DIR}/panda/config.h
  ${CMAKE_CURRENT_SOURCE_DIR}/panda/kcc.h
  ${CMAKE_CURRENT_SOURCE_DIR}/panda/hitbox.h
)

include_directories(${CMAKE_SOURCE_DIR})

add_custom_command(
  OUTPUT ${CMAKE_CURRENT_BINARY_DIR}/kcc_igate.cpp ${CMAKE_CURRENT_BINARY_DIR}/kcc.in
  COMMAND interrogate -DCPPPARSER -D__STDC__=1 -D__cplusplus=201103L
  -I${PANDA_INCLUDE_DIR}/panda3d
  -S${PANDA_INCLUDE_DIR}/panda3d/parser-inc
  -oc ${CMAKE_CURRENT_BINARY_DIR}/kcc_igate.cpp
  -od ${CMAKE_CURRENT_BINARY_DIR}/kcc.in
  -fnames -string -refcount -assert -python-native -nomangle
  -module kcc -library kcc
  ${KCC_HEADERS}
  DEPENDS ${KCC_SOURCES} ${KCC_HEADERS})

add_custom_command(
  OUTPUT ${CMAKE_CURRENT_BINARY_DIR}/kcc_module.cpp
  COMMAND interrogate_module
  -oc ${CMAKE_CURRENT_BINARY_DIR}/kcc_module.cpp
  -module kcc -library kcc
  -python-native
  -import panda3d.core
  -import panda3d.bullet
  ${CMAKE_CURRENT_BINARY_DIR}/kcc.in
  DEPENDS ${CMAKE_CURRENT_BINARY_DIR}/kcc.in ${CMAKE_CURRENT_BINARY_DIR}/kcc_igate.cpp)

add_library(kcc SHARED
  ${KCC_SOURCES}
  ${CMAKE_CURRENT_BINARY_DIR}/kcc_igate.cpp
  ${CMAKE_CURRENT_BINARY_DIR}/kcc_module.cpp)

set_target_properties(kcc PROPERTIES PREFIX "")
if(WIN32)
  set_target_properties(kcc PROPERTIES SUFFIX ".pyd")
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

target_link_libraries(kcc
  ${PANDA_LIBS}
  # PYTHON
  ${PYTHON_LIBRARY}
  # BULLET
  ${BULLET_COLLISION_LIBRARY}
  ${BULLET_DYNAMICS_LIBRARY}
  ${BULLET_MATH_LIBRARY}
  ${BULLET_SOFTBODY_LIBRARY}
  )

install(TARGETS kcc DESTINATION ${CMAKE_INSTALL_PREFIX})
