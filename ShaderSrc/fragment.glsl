#version 330 core

uniform sampler2D texture1;
uniform sampler2D texture2;
uniform vec3 objectColor;
uniform vec3 lightColor;
uniform vec3 lightPos;
uniform vec3 viewPos;

in vec2 TexCoord;
in vec3 Normal;
in vec3 FragPos;

out vec4 FragColor;


void main()
{

	float ambientStrength = 0.1f;
	vec3 ambient = ambientStrength * lightColor;

	vec3 norm = normalize(Normal);
	vec3 lightDir = normalize(lightPos - FragPos);
	float diff = max(dot(norm, lightDir), 0.0f);
	vec3 diffuse = diff * lightColor;

	float specularStrength = 0.5f;
	vec3 viewDir = normalize(viewPos - FragPos);
	vec3 reflectDir = reflect(-lightDir, norm);
	float spec = pow(max(dot(viewDir, reflectDir), 0.0f), 32);
	vec3 specular = specularStrength * spec * lightColor;

	vec4 result = mix(texture(texture1, TexCoord), texture(texture2, TexCoord), 0.2f) * vec4(diffuse + ambient + specular, 1.0f);

	FragColor = result;
	//FragColor = vec4(objectColor * lightColor, 1.0f);
};