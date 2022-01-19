in vec3 vnormal;

void main() {

 	// HINT: Q1b, Set final rendered color surface normals
  	gl_FragColor = vec4(vnormal, 1.0);

}
