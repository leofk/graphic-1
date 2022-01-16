varying vec3 vNormal;

void main() {

 	// HINT: Q1b, Set final rendered color surface normals

	//vec3 adjNormal = normalize(vNormal) * 0.5 + 0.5; // normalize normal

  	gl_FragColor = vec4(vNormal, 1.0); // REPLACE ME

}
