# Compiler
CXX = clang++

# Compiler flags
CXXFLAGS = -std=c++11 -Wall -Wextra

# Executable name
TARGET = main

# Directories
SRCDIR = .
BUILDDIR = build
BINDIR = .

# Source files
SOURCES = $(wildcard $(SRCDIR)/*.cpp)
OBJECTS = $(SOURCES:$(SRCDIR)/%.cpp=$(BUILDDIR)/%.o)
DEPENDENCIES = $(OBJECTS:.o=.d)

# GLFW and OpenGL libraries and paths (adjust as needed)
GLFW_INCLUDE = $(shell brew --prefix)/include
GLFW_LIB = $(shell brew --prefix)/lib

# Linker flags
LDFLAGS = -L$(GLFW_LIB) -lglfw -framework OpenGL

# Default rule
all: directories $(BINDIR)/$(TARGET)

# Create necessary directories
directories:
	@mkdir -p $(BUILDDIR)

# Linking
$(BINDIR)/$(TARGET): $(OBJECTS)
	$(CXX) $(OBJECTS) -o $@ $(LDFLAGS)

# Compilation
$(BUILDDIR)/%.o: $(SRCDIR)/%.cpp
	$(CXX) $(CXXFLAGS) -MMD -MP -c $< -o $@ -I$(GLFW_INCLUDE)

# Include dependencies
-include $(DEPENDENCIES)

# Clean
clean:
	@rm -rf $(BUILDDIR)
	@rm -f $(BINDIR)/$(TARGET)

.PHONY: all clean
