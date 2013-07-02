class Particle {

  PVector p = new PVector(100, 0, 0);
  PVector p2 = new PVector(120, 0, 0);
  PVector p3 = new PVector(100, 0, 0);
  PVector shrink = new PVector(-.5, 0, 0);
  float startRot = 0;
  float zSpin = 0;
  float ySpin = 0;
  float speed = 0;
  float x, x2, sX;
  float y, y2, sY;
  float z, z2;
  float orbits;
  boolean spike;

  float pSize;
  color pColor;
  float projectID;


  Particle(float _startRot, float _zSpin, float _speed, float _pSize, color _pColor) { 
    startRot = _startRot;
    zSpin = _zSpin;
    speed = _speed;
    pSize = _pSize;
    pColor = _pColor;
  }



  void display(float burst) {

    pushMatrix(); //slow spin of the entire orb system
    rotateY(radians(orbits));

    pushMatrix(); //offset starting point rotation\
    rotateZ(radians(startRot));
    rotateY(radians(startRot));
    rotateX(radians(startRot));

    pushMatrix(); //movement of the points across the sphere
    rotateY(radians(ySpin));
    rotateZ(radians(zSpin));
    rotateX(radians(ySpin));


    strokeWeight(pSize);  //draw the point
    stroke(pColor);
    point(p.x, p.y, p.z);

//get the true 3D coordinates without
//all fo the push/popMatrix() stuff
    x = modelX(p.x, p.y, p.z);
    y = modelY(p.x, p.y, p.z);
    z = modelZ(p.x, p.y, p.z);
    x2 = modelX(p2.x, p2.y, p2.z);
    y2 = modelY(p2.x, p2.y, p2.z);
    z2 = modelZ(p2.x, p2.y, p2.z);
    sX = screenX(p2.x, p2.y, p2.z);
    sY = screenY(p2.x, p2.y, p2.z);

    popMatrix();
    popMatrix();
    popMatrix();


//measure the distance between all of the points
//draw lines if the distance is below the threshold in the if() statement
    for (int i = 0; i < total; i++) {
      float d = dist(part[i].x, part[i].y, part[i].z, x, y, z);
      if (d<burst/5) {
        strokeWeight(1);
        stroke(pColor, 50);
        line(part[i].x, part[i].y, part[i].z, x, y, z);
      }
    }

    //    if(p.x > 20) {
    //    p.add(shrink);
    //    }

//iterating the various rotations
    ySpin+=speed;
    zSpin+=speed;
    orbits+=.05;
  }
}
