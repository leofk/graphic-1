/*
 * UBC CPSC 314, Vjan2022
 * Assignment 1 Template
 */

// Setup and return the scene and related objects.
// You should look into js/setup.js to see what exactly is done here.
const {
  renderer,
  scene,
  camera,
  worldFrame,
} = setup();

/////////////////////////////////
//   YOUR WORK STARTS BELOW    //
/////////////////////////////////
const time = {type: 'float', value: 0}
const armadilloFrame = new THREE.Object3D();
armadilloFrame.position.set(0, 0, 0);
scene.add(armadilloFrame);

// Initialize uniform
const orbPosition = { type: 'v3', value: new THREE.Vector3(0.0, 8.0, 0.0) };

// Materials: specifying uniforms and shaders
const armadilloMaterial = new THREE.ShaderMaterial({
  uniforms: {
    orbPosition: orbPosition
  }
});
const sphereMaterial = new THREE.ShaderMaterial({
  uniforms: {
    orbPosition: orbPosition
  }
});

// Load shaders.
const shaderFiles = [
  'glsl/armadillo.vs.glsl',
  'glsl/armadillo.fs.glsl',
  'glsl/sphere.vs.glsl',
  'glsl/sphere.fs.glsl'
];

new THREE.SourceLoader().load(shaderFiles, function (shaders) {
  armadilloMaterial.vertexShader = shaders['glsl/armadillo.vs.glsl'];
  armadilloMaterial.fragmentShader = shaders['glsl/armadillo.fs.glsl'];

  sphereMaterial.vertexShader = shaders['glsl/sphere.vs.glsl'];
  sphereMaterial.fragmentShader = shaders['glsl/sphere.fs.glsl'];
})

// Load and place the Armadillo geometry
// Look at the definition of loadOBJ to familiarize yourself with how each parameter
// affects the loaded object.
loadAndPlaceOBJ('obj/armadillo.obj', armadilloMaterial, armadilloFrame, function (armadillo) {
  armadillo.rotation.y = Math.PI;
  armadillo.position.y = 2.0;
  armadillo.scale.set(0.05, 0.05, 0.05);
});


// Create the main covid sphere geometry
// https://threejs.org/docs/#api/en/geometries/SphereGeometry
const sphereGeometry = new THREE.SphereGeometry(1.0, 32.0, 32.0);
const sphere = new THREE.Mesh(sphereGeometry, sphereMaterial);
sphere.position.set(0.0, 1.0, 0.0);
sphere.parent = worldFrame;
scene.add(sphere);

const sphereLight = new THREE.PointLight(0xffffff, 1, 100);
// Place the light at the location of the orb
  sphereLight.position.set(orbPosition.value.x, orbPosition.value.y, orbPosition.value.z);
scene.add(sphereLight);

// Listen to keyboard events.
const keyboard = new THREEx.KeyboardState();
function checkKeyboard() {

  let speed = 0.2

  if (keyboard.pressed("shift"))
    speed += 0.3

  if (keyboard.pressed("w")) { // move forwards
    armadilloFrame.position.z += speed * Math.cos(armadilloFrame.rotation.y)
    armadilloFrame.position.x += speed * Math.sin(armadilloFrame.rotation.y)
  }

  if (keyboard.pressed("s")) { // move backwards
    armadilloFrame.position.z -= 0.2 * Math.cos(armadilloFrame.rotation.y)
    armadilloFrame.position.x -= 0.2 * Math.sin(armadilloFrame.rotation.y)
  }

  if (keyboard.pressed("a"))  // turn counterclockwise
    armadilloFrame.rotation.y += Math.PI/60

  if (keyboard.pressed("d")) // turn clockwise
    armadilloFrame.rotation.y -= Math.PI/60

  // The following tells three.js that some uniforms might have changed
  armadilloMaterial.needsUpdate = true;
  sphereMaterial.needsUpdate = true;

}

let target = 10.0;
// Setup update callback
function update(time) {
  // checkKeyboard();
  armadilloMaterial.needsUpdate = true;
  sphereMaterial.needsUpdate = true;

  // sphere.rotation.y = time * 0.003;
  sphere.position.z = 5 * Math.cos(time * 0.0015);
  sphere.position.x = 5 * Math.sin(time * 0.0015);
  sphere.position.y = 2;

  orbPosition.value.z = sphere.position.z;
  orbPosition.value.x = sphere.position.x;
  orbPosition.value.y = sphere.position.y;

  // Requests the next update call, this creates a loop
  requestAnimationFrame(update);
  renderer.render(scene, camera);
}

// Start the animation loop.
// update();
requestAnimationFrame(update);

