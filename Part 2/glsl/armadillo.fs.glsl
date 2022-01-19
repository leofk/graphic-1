// The value of the "varying" variable is interpolated between values computed in the vertex shader
// The varying variable we passed from the vertex shader is identified by the 'in' classifier
in float vcolor;
in float orbDistance;

// This is defined as a constant radius
float minDistance = 2.0;

void main() {

	gl_FragColor = vec4(vcolor, vcolor, vcolor, 1.0);

	if (orbDistance <= minDistance)
		gl_FragColor.g += 10.0;

}