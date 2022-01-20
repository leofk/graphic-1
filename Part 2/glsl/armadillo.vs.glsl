// The uniform variable is set up in the javascript code and the same for all vertices
uniform vec3 orbPosition;

// This is a "varying" variable and interpolated between vertices and across fragments.
// The shared variable is initialized in the vertex shader and passed to the fragment shader.
out float vcolor;
out float orbDistance;

void main() {

    vec4 orbPosTrans = inverse(modelMatrix) * vec4(orbPosition, 1.0);
    vec3 lightDir = orbPosTrans.xyz - position;

    float dot = dot(normal, lightDir);
    float l1 = length(normal);
    float l2 = length(lightDir);

    vcolor = max(dot / (l1 * l2), 0.0);

    vec4 armModelPos = modelMatrix * vec4(position, 1.0);
    orbDistance = distance(armModelPos.xyz, orbPosition);

    gl_Position = projectionMatrix * viewMatrix * modelMatrix * vec4(position, 1.0);
}
