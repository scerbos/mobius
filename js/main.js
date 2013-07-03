var container, stats;

var camera, scene, renderer;

init();
animate();

var mobiusStrip;

function init() {

  container = document.createElement( 'div' );
  $('#p1').prepend(container);

  camera = new THREE.PerspectiveCamera( 45, 1.6, 500, 2000 );
  camera.position.y = 750;

  // controls
  controls = new THREE.OrbitControls( camera );

  scene = new THREE.Scene();

  var light, object, materials;

  scene.add( new THREE.AmbientLight( 0x404040 ) );

  light = new THREE.PointLight( 0xffffff );
  light.position.set( 30, 600, 0 );
  scene.add( light );

  var map = THREE.ImageUtils.loadTexture( 'textures/text.jpg' );
  map.wrapS = map.wrapT = THREE.RepeatWrapping;
  map.anisotropy = 16;

  var map2 = THREE.ImageUtils.loadTexture( 'textures/text-back.jpg' );
  map2.wrapS = map2.wrapT = THREE.RepeatWrapping;
  map2.anisotropy = 16;

  materials = [
    new THREE.MeshLambertMaterial( { ambient: 0xbbbbbb, map: map2, side: THREE.BackSide } ),
    new THREE.MeshLambertMaterial( { ambient: 0xbbbbbb, map: map, side: THREE.FrontSide} )
    // , new THREE.MeshBasicMaterial( { color: 0xffffff, wireframe: false, transparent: true, opacity: 0.1, side: THREE.DoubleSide } )
  ];

  var heightScale = 1;
  var p = 2;
  var q = 3;
  var radius = 150, tube = 10, segmentsR = 50, segmentsT = 20;

  console.log(THREE.ParametricGeometries);
  var geo;

  // Mobius Strip

  geo = new THREE.ParametricGeometry( THREE.ParametricGeometries.mobius, 40, 40 );
  mobiusStrip = THREE.SceneUtils.createMultiMaterialObject( geo, materials );
  mobiusStrip.position.set( 10, 0, 0 );
  mobiusStrip.rotation.x = -100;
  mobiusStrip.scale.multiplyScalar( 100 );
  scene.add( mobiusStrip );

  renderer = new THREE.WebGLRenderer( { antialias: true } );
  renderer.setSize( window.innerWidth, window.innerHeight );

  container.appendChild( renderer.domElement );

  stats = new Stats();
  stats.domElement.style.position = 'absolute';
  stats.domElement.style.top = '0px';
  container.appendChild( stats.domElement );

  window.addEventListener( 'resize', onWindowResize, false );

}

function onWindowResize() {

  camera.aspect = window.innerWidth / window.innerHeight;
  camera.updateProjectionMatrix();

  renderer.setSize( window.innerWidth, window.innerHeight );

}

function animate() {

  requestAnimationFrame( animate );

  controls.update();

  render();
  stats.update();

}

function render() {
  mobiusStrip.rotation.z = mobiusStrip.rotation.z + .004;
  mobiusStrip.rotation.y = Math.sin($.now()/1000)/10;
  renderer.render( scene, camera );

}

function updateText(text) {

}

var canvas = $("canvas");

var xOff=0, yOff=0;

for(var obj = canvas; obj != null; obj = obj.offsetParent) {
    xOff += obj.scrollLeft - obj.offsetLeft;
    yOff += obj.scrollTop - obj.offsetTop;
}