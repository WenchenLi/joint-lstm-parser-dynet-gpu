project(dynet)
cmake_minimum_required(VERSION 2.8 FATAL_ERROR)

set(CMAKE_MODULE_PATH ${PROJECT_SOURCE_DIR}/cmake)
set(CMAKE_CXX_FLAGS "-Wall -std=c++11 -O3 -g -lm")

enable_testing()

#include_directories(${CMAKE_CURRENT_SOURCE_DIR})
include_directories(${CMAKE_CURRENT_SOURCE_DIR}/dynet)
set(WITH_CUDA_BACKEND 1)


if (WITH_CUDA_BACKEND)
  find_package(CUDA REQUIRED)
  set(CUDA_TOOLKIT_ROOT_DIR ${CUDA_ROOT})
  include_directories(SYSTEM ${CUDA_INCLUDE_DIRS})
  add_definitions(-DHAVE_CUDA)
#  list(APPEND CUDA_LIBRARIES /usr/lib64/libpthread.so)#1
  MESSAGE("CUDA_LIBRARIES: ${CUDA_LIBRARIES}")
  list(REMOVE_ITEM CUDA_LIBRARIES -lpthread)
  set(LIBS ${LIBS} ${CUDA_LIBRARIES})
#  find_cudnn()#1
#  include_directories(SYSTEM ${CUDNN_INCLUDE_DIRS})#1
endif()

# look for Boost
if(DEFINED ENV{BOOST_ROOT})
      set(Boost_NO_SYSTEM_PATHS ON)
  endif()
  set(Boost_REALPATH ON)
  find_package(Boost COMPONENTS program_options serialization REQUIRED)
  include_directories(${Boost_INCLUDE_DIR})
  set(LIBS ${LIBS} ${Boost_LIBRARIES})

  # look for Eigen
  find_package(Eigen3 REQUIRED)
  include_directories(${EIGEN3_INCLUDE_DIR})

  #configure_file(${CMAKE_CURRENT_SOURCE_DIR}/config.h.cmake ${CMAKE_CURRENT_BINARY_DIR}/config.h)

  add_subdirectory(dynet/dynet)
#  find_package(dynet)
  # add_subdirectory(dynet/examples)
  add_subdirectory(parser)
