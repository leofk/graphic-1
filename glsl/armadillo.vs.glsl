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
    vec4 armModelPos = modelMatrix * vec4(position, 1.0);
    vec3 lightDir = normalize(orbPosition - armModelPos.xyz);
    vec3 vnormal = normalize((modelMatrix * vec4(normal, 0.0)).xyz);

    vcolor = max(dot(vnormal, lightDir), 0.0);

    // Q1D:
    // HINT: Compute distance in World coordinate to make the magnitude easier to interpret
    // HINT: GLSL has a build-in distance() function

    orbDistance = distance(armModelPos.xyz, orbPosition); // REPLACE ME

    gl_Position = projectionMatrix * viewMatrix * modelMatrix * vec4(position, 1.0);
}
