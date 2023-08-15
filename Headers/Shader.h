#ifndef SHADER_H
#define SHADER_H

#include <glad/glad.h>
#include <glad/glad.h>
#include <glm/glm.hpp>

#include <string.h>
#include <fstream>
#include <sstream>
#include <iostream>


class Shader
{
public:
	//program ID
	unsigned int ID;

	Shader(const char* vertexPath, const char* fragmentPath);
	~Shader();
	void use();

	void setBool(const std::string& name, const bool& value) const;
	void setInt(const std::string& name, const int& value) const;
	void setFloat(const std::string& name, const float& value) const;
	void setMat4(const std::string& name, const glm::mat4& mat) const;
	void setVec3(const std::string& name, float x, float y, float z) const;
	void setVec3(const std::string& name, glm::vec3 vector) const;
	void setVec3(const std::string& name, const float* color) const;
};


#endif // !SHADER_H


