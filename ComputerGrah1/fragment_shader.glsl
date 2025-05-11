#version 410 core

in vec3 FragPos;
in vec3 NormalOut;

out vec4 FragColor;

uniform vec3 lightColor;
uniform vec3 viewPos;

struct Material {
    vec3 ambient;
    vec3 diffuse;
    vec3 specular;
    float shininess;
};

uniform Material material;

void main()
{
    // ����������� �������
    vec3 norm = normalize(NormalOut);

    // ������� ��������� �����
    vec3 lightPos = vec3(1.2f, 1.0f, 2.0f);

    // ������ �� ��������� � ��������� �����
    vec3 lightDir = normalize(lightPos - FragPos);

    // ��������� ���������
    float diff = max(dot(norm, lightDir), 0.0);

    // ������ ��������� �����
    vec3 reflectDir = reflect(-lightDir, norm);

    // ������ ����������� �������
    vec3 viewDir = normalize(viewPos - FragPos);

    // ����������� ���������
    float spec = pow(max(dot(viewDir, reflectDir), 0.0), material.shininess);

    // �������� ����
    vec3 ambient = material.ambient * lightColor;
    vec3 diffuse = material.diffuse * diff * lightColor;
    vec3 specular = material.specular * spec * lightColor;

    vec3 result = ambient + diffuse + specular;

    FragColor = vec4(result, 1.0);
}
