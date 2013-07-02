var container, stats;

var camera, scene, renderer;

init();
animate();

var mobiusStrip;

function init() {

  container = document.createElement( 'div' );
  document.body.appendChild( container );

  camera = new THREE.PerspectiveCamera( 45, window.innerWidth / window.innerHeight, 1, 2000 );
  camera.position.y = 400;

  // controls
  controls = new THREE.OrbitControls( camera );

  scene = new THREE.Scene();

  var light, object, materials;

  scene.add( new THREE.AmbientLight( 0x404040 ) );

  light = new THREE.DirectionalLight( 0xffffff );
  light.position.set( 0, 0, 1 );
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

  renderer.render( scene, camera );

}

function updateText(text) {

}