
//import peasy.*;


PeasyCam cam;
int total = 1000;
Particle [] part = new Particle[total];

void setup () {
  size(1024, 768, P3D);
  smooth();
//  hint(DISABLE_DEPTH_TEST);

  //cam = new PeasyCam(this, 0, 0, 0, 250);
  perspective(radians(60), float(width)/float(height), .1, 3000);

  for (int i = 0; i<total; i++) {
    float sRot = random(360);
    float zRot = random(-360, 360);
    float speed = random(-1, 1)*.03;
    part[i] = new Particle(sRot, zRot, speed); //
  }
}





void draw() {
  background(0);
  lights();
  for (int i = 0; i<total; i++) {
    part[i].display();
  }


  fill(200, 0, 0, 50);
  //emissive(200,0,0);
  noStroke();
  sphereDetail(24);
  sphere(99.5);

  PVector origin = new PVector(0,0,0);

  if (keyPressed == true) {
      println("YES");
      stroke(255);
      strokeWeight(2);
      rectMode(CORNER);
      rect(100, 100, -1000, -1000, 0, 0, 120, 0);
      rect(-100, -100, 600, 600, 120, 0, 0, 0);
    } else {
  }

  println(mouseX);
}

class Particle {

  PVector p = new PVector(100, 0, 0);
  float startRot = 0;
  float zSpin = 0;
  float ySpin = 0;
  float speed = 0;
  float x;
  float y;
  float z;
  float orbits;


  Particle(float _startRot, float _zSpin, float _speed) {
    startRot = _startRot;
    zSpin = _zSpin;
    speed = _speed;
  }



  void display() {

    pushMatrix(); //entire orb system rotation
    rotateY(radians(orbits));
    pushMatrix(); //offset strating point rotation
    strokeWeight(1);
    stroke(230);
    rotateZ(radians(startRot));
    rotateY(radians(startRot));
    rotateX(radians(startRot));

    pushMatrix(); //movement of the points across the sphere
    rotateY(radians(ySpin));
    rotateZ(radians(zSpin));
    rotateX(radians(ySpin));
    point(p.x, p.y, p.z);

    x = modelX(p.x, p.y, p.z);
    y = modelY(p.x, p.y, p.z);
    z = modelZ(p.x, p.y, p.z);

    popMatrix();
    popMatrix();
    popMatrix();

    for (int i = 0; i < total; i++) {
      float d = dist(part[i].x, part[i].y, part[i].z, x, y, z);
      if (d<20) {
        strokeWeight(.50);
        stroke(180, 50);
        line(part[i].x, part[i].y, part[i].z, x, y, z);
      }
    }

    ySpin+=speed;
    zSpin+=speed;
    orbits+=.05;
  }
}


