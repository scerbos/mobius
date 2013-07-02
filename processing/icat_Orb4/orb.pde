/////////////////////////////////////////////////////ORB/////////////
void orb() {
  
//labelSize = 7;

  for (int i = 0; i<1000; i++) {

    part[i].pColor = color(230);
    part[i].pSize = .75;

    if (ideas_Studio) {
      part[i].pColor = color(230, 50);
      part[i].pSize = .2;

      if (i<10) {
        fill(340, 100, 50, 75);
        stroke(220, 100);
        strokeWeight(1.5);
        bezier(part[i].x2, part[i].y2, part[i].z2, part[i].x/5, part[i].y/5, part[i].z/2.5, -50, 0, 0, 0, 0, 0);
        part[i].pColor = color(195, 69, 76);
        part[i].pSize = 8;
      }
    }

    if (image_Studio) {
      if(ideas_Studio == false) {
      part[i].pColor = color(230, 50);
      part[i].pSize = .2;
      }

      if (i>=10 && i<20) {

        fill(0, 100, 50, 75);
        stroke(220, 100);
        strokeWeight(1.5);
        bezier(part[i].x2, part[i].y2, part[i].z2, part[i].x/5, part[i].y/5, part[i].z/3, -50, 0, 0, 0, 0, 0);
        part[i].pColor = color(195, 69, 76);
        part[i].pSize = 8;
      }
    }

    if (impact_Studio) {

      if(ideas_Studio == false || image_Studio == false) {
      part[i].pColor = color(230, 50);
      part[i].pSize = .2;
      }

      if (i>=20 && i<25) {
        fill(20, 100, 50, 75);
        stroke(220, 100);
        strokeWeight(1.5);
        bezier(part[i].x2, part[i].y2, part[i].z2, part[i].x/5, part[i].y/5, part[i].z/3, -50, 0, 0, 0, 0, 0);
        part[i].pColor = color(195, 69, 76);
        part[i].pSize = 8;
      }
    }
  }//////////////////////////////////Completes the For Loop
  
  if (ideas_Studio) labelSize-= 1;
  if (image_Studio) labelSize-= 1;
  if (impact_Studio) labelSize-= 1;
}
