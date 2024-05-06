#include <string>
#include <fstream>
#include <sstream>
#include <iostream>
#include "include/glad/glad.h"
#include <GLFW/glfw3.h>
#include "shader_load.h"

std::string loadContent(const char* path) {
    std::ifstream inputFile(path);
    std::stringstream sstream; 
    sstream << inputFile.rdbuf();
    return sstream.str();
}

Shader::Shader(const char* vertexPath, const char* fragmentPath) {
    std::string vertex = loadContent(vertexPath);
    const char* vertexShaderSource = vertex.c_str();
    std::string fragment = loadContent(fragmentPath);
    const char* fragmentShaderSource = fragment.c_str();


    unsigned int vertexShader = glCreateShader(GL_VERTEX_SHADER);
    glShaderSource(vertexShader, 1, &vertexShaderSource, NULL);
    glCompileShader(vertexShader);
    // check for shader compile errors
    // fragment shader
    unsigned int fragmentShader = glCreateShader(GL_FRAGMENT_SHADER);
    glShaderSource(fragmentShader, 1, &fragmentShaderSource, NULL);
    glCompileShader(fragmentShader);
    // check for shader compile errors
    // link shaders
    ID = glCreateProgram();
    glAttachShader(ID, vertexShader);
    glAttachShader(ID, fragmentShader);
    glLinkProgram(ID);
    glDeleteShader(vertexShader);
    glDeleteShader(fragmentShader);
}
