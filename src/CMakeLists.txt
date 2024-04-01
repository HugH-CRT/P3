cmake_minimum_required(VERSION 3.14)

project(${APP_NAME})

set(SRC_DIR ${CMAKE_CURRENT_SOURCE_DIR})
set(INCLUDE_DIR ${CMAKE_CURRENT_SOURCE_DIR})

file(GLOB_RECURSE HEADERS
    "${INCLUDE_DIR}/*.h"
    "${INCLUDE_DIR}/*.hxx"
    "${INCLUDE_DIR}/*.hpp"
    "${INCLUDE_DIR}/*.hh"
    "${INCLUDE_DIR}/*.inl"
)

file(GLOB_RECURSE SOURCES
    "${SRC_DIR}/*.cpp"
    "${SRC_DIR}/*.cxx"
    "${SRC_DIR}/*.cc"
    "${SRC_DIR}/*.c"
)

add_executable(${APP_NAME} ${HEADERS} ${SOURCES})

set_target_properties(App
    PROPERTIES
    ARCHIVE_OUTPUT_DIRECTORY "${CMAKE_SOURCE_DIR}/output"
    LIBRARY_OUTPUT_DIRECTORY "${CMAKE_SOURCE_DIR}/output"
    RUNTIME_OUTPUT_DIRECTORY "${CMAKE_SOURCE_DIR}/output"
)

target_include_directories(${APP_NAME} PRIVATE ${INCLUDE_DIR})
target_link_libraries(${APP_NAME} PRIVATE ${EXTERN_LIBS})
target_link_libraries(${APP_NAME} PRIVATE ${EXTERN_LIBS_STATIC})

if(CMAKE_BUILD_TYPE STREQUAL "Debug")
    set(DLL_DIR "${CMAKE_SOURCE_DIR}/libs/debug")
else()
    set(DLL_DIR "${CMAKE_SOURCE_DIR}/libs/release")
endif()

# Copying DLLs to output directory
file(GLOB_RECURSE DLLS "${DLL_DIR}/*.dll")
foreach(DLL ${DLLS})
    add_custom_command(TARGET ${APP_NAME} POST_BUILD
        COMMAND ${CMAKE_COMMAND} -E copy_if_different
        ${DLL}
        $<TARGET_FILE_DIR:${APP_NAME}>
    )
endforeach()