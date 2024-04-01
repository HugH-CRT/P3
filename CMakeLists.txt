cmake_minimum_required(VERSION 3.14)

# Set CXX 20 
set(CMAKE_CXX_STANDARD 20)

# Setup name
set(PROJECT_NAME p3)
set(PROJECT_DIR src)
set(APP_NAME App)
set(EXTERN_DIR extern)

# Add extern include directories for all subdirectories
include_directories(${EXTERN_DIR}/glew/include)
include_directories(${EXTERN_DIR}/glfw/include)
include_directories(${EXTERN_DIR}/optick/src)
include_directories(${EXTERN_DIR}/imgui)
include_directories(${EXTERN_DIR}/glm/include)

if(CMAKE_BUILD_TYPE STREQUAL "Debug")
    link_directories(${CMAKE_SOURCE_DIR}/libs/debug)
else()
    link_directories(${CMAKE_SOURCE_DIR}/libs/release)
endif()

# Add extern libraries
set(EXTERN_LIBS
    glew32
    glfw3
    optickcore
    opengl32
)
# Add static library
set(EXTERN_LIBS_STATIC
    imgui
)

project(${PROJECT_NAME})

set(CMAKE_CXX_STANDARD 20)

add_subdirectory(${PROJECT_DIR})

set_property(DIRECTORY ${CMAKE_SOURCE_DIR} PROPERTY VS_STARTUP_PROJECT ${APP_NAME})