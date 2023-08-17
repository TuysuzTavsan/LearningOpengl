#version 330 core

struct Material {
	sampler2D diffuse;
	sampler2D specular;
	sampler2D emission;
	float shininess;
};

struct Light {
	vec3 position;

	vec3 ambient;
	vec3 diffuse;
	vec3 specular;
};


uniform vec3 lightPos;
uniform vec3 lightColor;
uniform vec3 viewPos;


uniform Light light;
uniform Material material;

in vec2 TexCoords;
in vec3 Normal;
in vec3 FragPos;

out vec4 FragColor;


void main()
{
	//ambient
	vec3 ambient = light.ambient * texture(material.diffuse, TexCoords).rgb;

	//diffuse
	vec3 norm = normalize(Normal);
	vec3 lightDir = normalize(lightPos - FragPos);
	float diff = max(dot(norm, lightDir), 0.0f);
	vec3 diffuse = light.diffuse * diff * texture(material.diffuse, TexCoords).rgb;

	//specular	
	float specularStrength = 1.0f;
	vec3 viewDir = normalize(viewPos - FragPos);
	vec3 reflectDir = reflect(-lightDir, norm);	
	float spec = pow(max(dot(viewDir, reflectDir), 0.0f), material.shininess);
	vec3 specular = light.specular * spec * texture(material.specular, TexCoords).rgb;

	vec3 emission = vec3(0.0f);

	if(texture(material.specular, TexCoords).rgb == vec3(0.0f))
	{
		emission = texture(material.emission, TexCoords).rgb;
	}
	
	FragColor = vec4((specular + ambient + diffuse) * lightColor  + emission, 1.0f);

};