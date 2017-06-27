PROJECT(dynet:parser)
CMAKE_MINIMUM_REQUIRED(VERSION 2.8)


ADD_EXECUTABLE(lstm-parse lstm-parse.cc)
if (WITH_CUDA_BACKEND)
    target_link_libraries(lstm-parse gdynet ${LIBS})
    CUDA_ADD_CUBLAS_TO_TARGET(lstm-parse)
else()
    target_link_libraries(lstm-parse dynet ${LIBS})
endif (WITH_CUDA_BACKEND)


#CMAKE_MINIMUM_REQUIRED(VERSION 2.8)
#
#foreach(FOLDER lstm-parse )
#    set(TARGET ${FOLDER})
#    ADD_EXECUTABLE(${TARGET} cpp/${FOLDER}/${TARGET}.cc)
#    if (WITH_CUDA_BACKEND)
#        target_link_libraries(${TARGET} gdynet ${LIBS})
#        CUDA_ADD_CUBLAS_TO_TARGET(${TARGET})
#    else()
#        target_link_libraries(${TARGET} dynet ${LIBS})
#    endif (WITH_CUDA_BACKEND)
#    if(UNIX AND NOT APPLE)
#        target_link_libraries(${TARGET} rt)
#    endif()
#endforeach()