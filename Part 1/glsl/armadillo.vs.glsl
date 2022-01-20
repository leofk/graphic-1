// The uniform variable is set up in the javascript code and the same for all vertices
uniform vec3 orbPosition;

// This is a "varying" variable and interpolated between vertices and across fragments.
// The shared variable is initialized in the vertex shader and passed to the fragment shader.
out float vcolor;
out float orbDistance;

void main() {

    // Q1C:
    // HINT: GLSL PROVIDES THE DOT() FUNCTION 
  	// HINT: SHADING IS CALCULATED BY TAKING THE DOT PRODUCT OF THE NORMAL AND LIGHT DIRECTION VECTORS

    // Solution 1: world space -> model space
    vec4 orbPosTrans = inverse(modelMatrix) * vec4(orbPosition, 1.0);
    vec3 lightDir = orbPosTrans.xyz - position;

    float dot = dot(normal, lightDir);
    float l1 = length(normal);
    float l2 = length(lightDir);

    vcolor = max(dot / (l1 * l2), 0.0);

    // Solution 2: transform normals
//    vec4 armModPos = modelMatrix * vec4(position, 1.0);
//    vec3 lightDir = orbPosition - armModPos.xyz;
//
//    mat4 invTrpModelMatix = transpose(inverse(modelMatrix));
//    vec3 vnormal = (invTrpModelMatix * vec4(normal, 1.0)).xyz;
//
//    float dot = dot(vnormal, lightDir);
//    float l1 = length(vnormal);
//    float l2 = length(lightDir);
//
//    vcolor = max(dot / (l1 * l2), 0.0);

    // Solution 3: scam
//    vec4 armModPos = modelMatrix * vec4(position, 1.0);
//    vec3 lightDir = orbPosition - armModPos.xyz;
//
//    vec3 vnormal = (modelMatrix * vec4(normal, 0.0)).xyz;
//
//    float dot = dot(vnormal, lightDir);
//    float l1 = length(vnormal);
//    float l2 = length(lightDir);
//
//    vcolor = max(dot / (l1 * l2), 0.0);

    // Solution 4: Use normalize?
//    vec4 armModPos = modelMatrix * vec4(position, 1.0);
//    vec3 lightDir = normalize(orbPosition - armModPos.xyz);
//    vec3 vnormal = normalize((modelMatrix * vec4(normal, 0.0)).xyz);
//    vcolor = dot(lightDir, vnormal);

    // Q1D:
    // HINT: Compute distance in World coordinate to make the magnitude easier to interpret
    // HINT: GLSL has a build-in distance() function

    vec4 armModelPos = modelMatrix * vec4(position, 1.0);
    orbDistance = distance(armModelPos.xyz, orbPosition);

    gl_Position = projectionMatrix * viewMatrix * modelMatrix * vec4(position, 1.0);
}
