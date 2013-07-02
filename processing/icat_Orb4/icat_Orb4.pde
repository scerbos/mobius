import peasy.*;
import processing.video.*;
import controlP5.*;

PGraphics pg1;
Movie [] vids;
PFont font;
PeasyCam cam;
int total = 1000;
Particle [] part = new Particle[total];
boolean spike;
//float orbScale = .1;
float alphaUp = 0;

float burst = 10;
float noff = 0;
float toff = 0;

float []  labelSizeA = new float [50];



/////////////////////////////////////////////SETUP/////////////////
void setup () {
  size(1280, 720 , P3D);  //change to size(1280, 720, P3d);
  smooth(8);
  colorMode(HSB, 360, 100, 100);

  cam = new PeasyCam(this, 0, 0, 0, 275);
  perspective(radians(60), float(width)/float(height), .1, 3000);
  gui_Setup();
  cp5.setAutoDraw(false);
  font = loadFont("ArialMT-48.vlw");
  textFont(font, 6);
  vids = new Movie[3];
  pg1 = createGraphics(width, height, P3D);

  //Load all of the 
  for (int i = 0; i<3; i++) {
    vids[i] = new Movie(this, "video" + i + ".mov");
    vids[i].stop();
  }

  for (int i = 0; i<total; i++) {
    float sRot = random(360);
    float zRot = random(-360, 360);
    float speed = random(-1, 1)*.03;
    color pColor = color(230);
    float pSize = .75;
    spike = false;
    part[i] = new Particle(sRot, zRot, speed, pSize, pColor);
  }
  
  for (int i = 0; i<50; i++) {
    labelSizeA[i] = 6;
  }
  
  //PFont pfont = createFont("Arial", 20, true);
  //ControlFont cp5_font = new ControlFont(pfont, 24);
  
}

//////////////////////////////////////////////DRAW////////////////////
void draw() {
  background(12);
  hint(DISABLE_DEPTH_TEST);

  //deactivates the peasycam is clicking on ControlP5 in the window
  if (cp5.window(this).isMouseOver()) {
    cam.setActive(false);
  } 
  else {
    cam.setActive(true);
  }

  //draw the part Class
  for (int i = 0; i<total; i++) {
    part[i].p.x = burst;
    part[i].display(burst);
//    burst = noise(toff)+noff;
//    toff+=.001;
  }
  
    if (burst < 100 ) {
      burst += noise(noff);
    }
 
  noff += .1;

  //animate the Image Studio projects list
  //on to the screen
  //  if (studioID == 2) {
  //    projectList.setPosition(100, 25);
  //  } 
  //  else {
  //    projectList.setPosition(0, -300);
  //  }

  //ICAT LOGO INTRO
  icat_Logo();
  noSelect();

  ////////////////////////////////////the Red Sphere
  //eventually will be if(studioID > 0)
  if (noStudio) {
    if (frameCount > 300 && alphaUp < 60) {
      alphaUp +=.5;
    }
    fill(340, 100, 40, alphaUp);
    noStroke();
    sphereDetail(24);
    sphere(99.5);
  }
  /////////////////////////////////////////////orb 
  orb();


  /////////////////////////////Movie Playaer Stage
  gui3D();
  gui_Draw();

}





////////////////////////////////CUSTOM FUNCTIONS//////////////
//////////////////////////////////////////////////////////////


void movieEvent(Movie m) {
  m.read();
}

//Notes from Meeting with Audrey
//Fade the labels when the lightbox becomes visible.
//Side buttons for the projects in the lightbox so that you can advance thru them one at a time.
//She is going to 
