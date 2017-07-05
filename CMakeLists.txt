project(dynet)
cmake_minimum_required(VERSION 2.8 FATAL_ERROR)

set(CMAKE_MODULE_PATH ${PROJECT_SOURCE_DIR}/cmake)
set(CMAKE_CXX_FLAGS "-Wall -std=c++11 -O3 -g -lm")

enable_testing()

include_directories(${CMAKE_CURRENT_SOURCE_DIR}/dynet)
set(WITH_CUDA_BACKEND 1)


function(find_cudnn)
  set(CUDNN_ROOT /usr/local/cuda CACHE PATH "CUDNN root path")
  find_path(CUDNN_INCLUDE_DIRS cudnn.h
          HINTS ${CUDNN_ROOT}
          ${CUDNN_ROOT}/include
          DOC "CUDNN include path")
  find_library(CUDNN_LIBRARIES NAMES libcudnn.so cudnn.lib
          PATHS ${CUDNN_ROOT}
          ${CUDNN_ROOT}/lib
          ${CUDNN_ROOT}/lib64
          ${CUDNN_ROOT}/lib/x64
          DOC "CUDNN library path")
  if(CUDNN_INCLUDE_DIRS AND CUDNN_LIBRARIES)
    set(CUDNN_FOUND TRUE PARENT_SCOPE)
    message(STATUS "Found CUDNN (include: ${CUDNN_INCLUDE_DIRS}, library: ${CUDNN_LIBRARIES})")
    mark_as_advanced(CUDNN_INCLUDE_DIRS CUDNN_LIBRARIES)
  else()
    MESSAGE(STATUS "Failed to find CUDNN in path: ${CUDNN_ROOT} (Did you set CUDNN_ROOT properly?)")
  endif()
endfunction()


if(BACKEND)
  message("-- BACKEND: ${BACKEND}")
else()
  message("-- BACKEND not specified, defaulting to eigen.")
  set(BACKEND "eigen")
endif()

if(BACKEND MATCHES "^eigen$")
  set(WITH_EIGEN_BACKEND 1)
elseif(BACKEND MATCHES "^cuda$")
  set(WITH_CUDA_BACKEND 1)
else()
  message(SEND_ERROR "BACKEND must be eigen or cuda")
endif()

if (WITH_CUDA_BACKEND)
  find_package(CUDA REQUIRED)
  set(CUDA_TOOLKIT_ROOT_DIR ${CUDA_ROOT})
  include_directories(SYSTEM ${CUDA_INCLUDE_DIRS})
  #list(APPEND CUDA_LIBRARIES /usr/lib64/libpthread.so)
  MESSAGE("CUDA_LIBRARIES: ${CUDA_LIBRARIES}")
  list(REMOVE_ITEM CUDA_LIBRARIES -lpthread)
  set(LIBS ${LIBS} ${CUDA_LIBRARIES})
  set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -DEIGEN_HAS_CUDA_FP16 -DEIGEN_USE_GPU")
  find_cudnn()
  if(CUDNN_FOUND)
    include_directories(SYSTEM ${CUDNN_INCLUDE_DIRS})
    list(APPEND CUDA_LIBRARIES ${CUDNN_LIBRARIES})
    message("-- Successfully include CUDNN flags")
  else()
    message("-- CUDNN not found, some dependent functionalities will be disabled")
  endif()
endif()

# look for Eigen
#get_filename_component(EIGEN3_INCLUDE_DIR "${EIGEN3_INCLUDE_DIR}" REALPATH BASE_DIR "${CMAKE_BINARY_DIR}")
#message("-- Eigen dir is " ${EIGEN3_INCLUDE_DIR})
#find_package(Eigen3 REQUIRED)
#include_directories(${EIGEN3_INCLUDE_DIR})
#
#FIND_PACKAGE(Threads REQUIRED)
#set(LIBS ${LIBS} ${CMAKE_THREAD_LIBS_INIT})
#
#configure_file(${CMAKE_CURRENT_SOURCE_DIR}/config.h.cmake ${CMAKE_CURRENT_BINARY_DIR}/config.h)
#include_directories(${CMAKE_CURRENT_BINARY_DIR})



# look for Boost
#if(DEFINED BOOST_ROOT OR DEFINED BOOSTROOT OR DEFINED ENV{BOOST_ROOT} OR DEFINED ENV{BOOSTROOT})
#  set(Boost_NO_SYSTEM_PATHS ON)
#  if(DEFINED ${Boost_INCLUDE_DIR})
#    get_filename_component(Boost_INCLUDE_DIR "${Boost_INCLUDE_DIR}" REALPATH BASE_DIR "${CMAKE_BINARY_DIR}")
#  endif()
#endif()
#set(Boost_REALPATH ON)
#find_package(Boost COMPONENTS program_options regex serialization REQUIRED)
#message("-- Boost dir is " ${Boost_INCLUDE_DIR})
#include_directories(${Boost_INCLUDE_DIR})
# look for Boost
if(DEFINED ENV{BOOST_ROOT})
  set(Boost_NO_SYSTEM_PATHS ON)
endif()
set(Boost_REALPATH ON)
find_package(Boost COMPONENTS program_options serialization REQUIRED)
include_directories(${Boost_INCLUDE_DIR})
set(LIBS ${LIBS} ${Boost_LIBRARIES})
link_directories( ${Boost_LIBRARY_DIRS})

# look for Eigen
find_package(Eigen3 REQUIRED)
include_directories(${EIGEN3_INCLUDE_DIR})

add_subdirectory(dynet/dynet)
add_subdirectory(parser)
