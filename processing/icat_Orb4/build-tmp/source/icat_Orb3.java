import processing.core.*; 
import processing.data.*; 
import processing.opengl.*; 

import peasy.*; 
import processing.video.*; 
import controlP5.*; 

import java.applet.*; 
import java.awt.Dimension; 
import java.awt.Frame; 
import java.awt.event.MouseEvent; 
import java.awt.event.KeyEvent; 
import java.awt.event.FocusEvent; 
import java.awt.Image; 
import java.io.*; 
import java.net.*; 
import java.text.*; 
import java.util.*; 
import java.util.zip.*; 
import java.util.regex.*; 

public class icat_Orb3 extends PApplet {





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





/////////////////////////////////////////////SETUP/////////////////
public void setup () {
  size(1024, 768, P3D);
  smooth(8);
  colorMode(HSB, 360, 100, 100);

  cam = new PeasyCam(this, 0, 0, 0, 275);
  perspective(radians(60), PApplet.parseFloat(width)/PApplet.parseFloat(height), .1f, 3000);
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
    float speed = random(-1, 1)*.03f;
    int pColor = color(230);
    float pSize = .75f;
    spike = false;
    part[i] = new Particle(sRot, zRot, speed, pSize, pColor);
  }
}

//////////////////////////////////////////////DRAW////////////////////
public void draw() {
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
  
  noff += .1f;



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
      alphaUp +=.5f;
    }
    fill(340, 100, 40, alphaUp);
    noStroke();
    sphereDetail(24);
    sphere(99.5f);
  }
  /////////////////////////////////////////////orb 
  orb();


  /////////////////////////////Movie Playaer Stage
  gui3D();
  gui_Draw();


  //  if (frameCount%30 == 0) {
  //   println(frameRate); 
  //  }

  //println(burst);
}





////////////////////////////////CUSTOM FUNCTIONS//////////////
//////////////////////////////////////////////////////////////


public void movieEvent(Movie m) {
  m.read();
}


ControlP5 cp5;
DropdownList studioList, projectList;

String [] studios = {
  "IDEAS", "IMAGE", "IMPACT", "IMPLEMENT", "INHABIT"
};
String [] ideasPro = {
  "GAMES Project", "STEM", "MAKEr Camp", "Second Saturday Science", "Caine's Arcade", "Design Thinking", 
  "K2C"
};
String [] imagePro = {
  "Center for the Arts", "BioDesign - The Bat", "Visionarium", "NDSSL", "Paspahegh", "3D Blacksburg", 
  "Massive Model Rendering", "Crowd Rendering - GPU", "Dynamic Data Analysis"
};
String [] impactPro = {
  "pd-L2OrK", "Locative Audio", "Mind/Body Interactive", "Sound Spatialization"
};



String c4arts = "Professor Dane Webster, with help from two of his students \u2014 Chris Russell and Mallory Brangan \u2014 used models and single-frame renderings from architecture firms Snohetta and STV to create a virtual fly through of the center.";
String bat = "Part of an ongoing effort to partner with the Smithsonian National Museum of Natural History and create a large-scale digital repository of biological specimens,  these visualizations serve as both an education and outreach component of this research in addition to providing model manipulation tools for analyzing biological form and function relevant to engineering science.";
String visionarium = "Built in June 2010, the VisBox VisCube(TM) is the replacement to the old CAVE. Like the CAVE before it, the VisCube has three rear-projected ten foot square walls and a top-projected floor with a cutout hiding a MOOG motion platform. The VisCube features numerous hardware and software upgrades to increase the fidelity of the visualization (more pixels (1920\u00d71920 per wall!), more brightness, more contrast) as well as the ease of use for the researcher (wireless tracking).";

float studioID = 0;
float ideasProID = 0;
float imageProID = 0; 
float impactProID = 0;
float implementProID = 0;
float inhabitProID = 0;
boolean lightBox = false;

boolean [] studio_Names = new boolean [6];
boolean noStudio = true;
boolean ideas_Studio = false;
boolean image_Studio = false;
boolean impact_Studio = false;
boolean implement_Studio = false;
boolean inhabit_Studio =false;

float labelSize = 6.5f;





//////////////////////////////////////////////////
public void gui_Setup() {

  cp5 = new ControlP5(this);

/*  //Set the DropdownList for the ICAT Studios
  studioList = cp5.addDropdownList("Studios")
    .setPosition(20, 25)
      .setSize(75, 20*6);
  customize(studioList);
  for (int i = 0; i<5; i++) {
    studioList.addItem(studios[i], i+1);
  }

  //Set the DropdownList for the Image Studio Project
  //Remember that the position of this one gets animated
  //on and off the screen depending on the Studio selected
  projectList = cp5.addDropdownList("Projects")
    .setPosition(100, 25)
      .setSize(125, 20*10);
  customize(projectList);
  for (int i = 0; i<9; i++) {
    projectList.addItem(imagePro[i], i+10);
  }*/

  cp5.addToggle("ideas_Studio")
    .setSize(20, 10)
      .setPosition(20, 10)
        .setValue(false);

  cp5.addToggle("image_Studio")
    .setSize(20, 10)
      .setPosition(20, 40)
        .setValue(false);

  cp5.addToggle("impact_Studio")
    .setSize(20, 10)
      .setPosition(20, 70)
        .setValue(false);

  cp5.addToggle("implement_Studio")
    .setSize(20, 10)
      .setPosition(20, 100)
        .setValue(false);

  cp5.addToggle("inhabit_Studio")
    .setSize(20, 10)
      .setPosition(20, 130)
        .setValue(false);
}







//////////////////////////////////////////////////customizing the DropdownLists
public void customize(DropdownList ddl) {
  // a convenience function to customize a DropdownList
  ddl.setBackgroundColor(color(80));
  ddl.setItemHeight(20);
  ddl.setBarHeight(15);
  ddl.captionLabel().style().marginTop = 3;
  ddl.captionLabel().style().marginLeft = 3;
  ddl.valueLabel().style().marginTop = 3;
  ddl.setColorBackground(color(60));
  ddl.setColorActive(color(255, 128));
}






///////////////////////////////2D GUI that is locked down to the screen//////////
public void gui_Draw() {

  //freezes the peasycam position  
  cam.beginHUD(); 
  hint(ENABLE_DEPTH_TEST);

  //block for the Center for the Arts Project
  if (image_Studio)

    if (imageProID >= 10) {
      rectMode(CENTER);
      fill(25, 230);
      rect(width/2, height/2, width, height/2 );
      fill(220);
      rectMode(CORNER);

      //block for the Center for the Arts
      if (imageProID == 10) {
        textFont(font, 16);
        textAlign(LEFT);
        text(c4arts, 700, 206, 300, 300);
        vids[0].play();
        image(vids[0], 40, 202, 640, 360);
      } 
      else {
        vids[0].stop();
      }

      //block for the Bat Project 
      if (imageProID == 11) {
        rectMode(CORNER);
        textFont(font, 16);
        textAlign(LEFT);
        text(bat, 700, 206, 300, 300);
        vids[1].play();
        image(vids[1], 40, 202, 640, 360);
      } 
      else {
        vids[1].stop();
        vids[1].jump(0);
      }
      //block for the Visionarium
      if (imageProID == 12) {
        rectMode(CORNER);
        textFont(font, 16);
        textAlign(LEFT);
        text(visionarium, 700, 206, 300, 300);
        vids[2].play();
        image(vids[2], 40, 202, 640, 360);
      } 
      else {
        vids[2].stop();
      }
    }

  //closes out the pop-up window for the projects
  if (mouseX<25 && mouseY>(height/2)-25 && mouseY<(height/2)+25 && mousePressed) {
    imageProID = 0;
    vids[0].jump(0);
    vids[1].jump(0);
    vids[2].jump(0);
    vids[0].stop();
    vids[1].stop();
    vids[2].stop();
  }

  noFill();
  ellipse(0, height/2, 25, 25);  
  cp5.draw();
  //un-freezes the peasycam  
  cam.endHUD();
}






//////////////////////////////////////////3D GUI Matched to the Camera
public void gui3D() {

  ///////draw the ellipse around the ORB
  float [] xyzRot;
  pushMatrix();
  xyzRot = cam.getRotations();
  noFill();
  stroke(150, 150);
  strokeWeight(2);
  rotateX(xyzRot[0]);
  rotateY(xyzRot[1]);
  rotateZ(xyzRot[2]);
  ellipse(0, 0, 230, 230);
  popMatrix();

  ////////////////////////////ORB Labels 
  if (ideas_Studio) {
    for (int i =0; i<7; i++) {
      float [] xyzRot2;
      pushMatrix();
      xyzRot2 = cam.getRotations();
      translate(part[i].x2, part[i].y2, part[i].z2);
      rotateX(xyzRot2[0]);
      rotateY(xyzRot2[1]);
      rotateZ(xyzRot2[2]);
      textAlign(CENTER);
      textFont(font, labelSize);
      fill(220);
      text(ideasPro[i], 0, 0);
      popMatrix();
    }
  }

  if (image_Studio) {
    for (int i =0; i<9; i++) {
      float [] xyzRot2;
      pushMatrix();
      xyzRot2 = cam.getRotations();
      translate(part[i+10].x2, part[i+10].y2, part[i+10].z2);
      rotateX(xyzRot2[0]);
      rotateY(xyzRot2[1]);
      rotateZ(xyzRot2[2]);
      textAlign(CENTER);
      textFont(font, labelSize);
      fill(220);
      text(imagePro[i], 0, 0);
      popMatrix();
    }
  }

  if (impact_Studio) {
    for (int i =0; i<4; i++) {
      float [] xyzRot2;
      pushMatrix();
      xyzRot2 = cam.getRotations();
      translate(part[i+20].x2, part[i+20].y2, part[i+20].z2);
      rotateX(xyzRot2[0]);
      rotateY(xyzRot2[1]);
      rotateZ(xyzRot2[2]);
      textAlign(CENTER);
      textFont(font, labelSize);
      fill(220);
      text(impactPro[i], 0, 0);
      popMatrix();
    }
  }

  /////////////////////////////////////////////////////////mouseOver and Select
  for (int i = 10; i<20; i++) {
    float d = dist(mouseX, mouseY, part[i].sX, part[i].sY);
    if (d<20 && mousePressed) {
      imageProID = i;
      lightBox = true;
      println(lightBox + " - " + imageProID);
    } 
    else {
      lightBox = false;
    }
  }


  if (lightBox) {
    if (mouseY < 200 && mousePressed) {
      imageProID = 0;
      lightBox = false;
      println(lightBox + " - " + imageProID);
    }
  }
}




////////////////////////////////ICAT LOGO

float sqX1, sqY1, sqX2, sqY2;
float radOff = 0;
float alphaT = 255; 

public void icat_Logo() {

  if (frameCount < 300) {

    hint(ENABLE_DEPTH_TEST);
    //hint(ENABLE_DEPTH_SORT);
    pushMatrix();
    translate(0, 0, 110);
    scale(.75f, .75f, .75f);

    fill(12, alphaT);
    rect(-2000, -2000, 4000, 4000);
    //noStroke();
    //sphere(210);

    translate(0, 0, 1);
    stroke(255, alphaT);
    strokeWeight(2);
    noFill();
    rectMode(CORNER);
    rect(radOff/2, radOff/2, -100, -100, 0, 0, radOff/2, 0);
    rect(-radOff/2, -radOff/2, 60, 60, radOff/2, 0, 0, 0);


    fill(340, 100, 40, alphaT);
    ellipse(0, 0, radOff, radOff);

    textLeading(150);
    fill(180, alphaT);
    textFont(font, 9);
    textAlign(LEFT);
    text("Institute for Creativity, Arts, and Technology", -85+(radOff/2), -85+(radOff/2), 50, 200);
    popMatrix();

    if (frameCount > 120) {
      alphaT += -2;
    }
    if (frameCount<60) {
      radOff+=.25f;
    }
    
  }
}


public void noSelect() {
  if (ideas_Studio == true ||
    image_Studio == true ||
    impact_Studio == true ||
    implement_Studio == true ||
    inhabit_Studio == true) {
    noStudio = false;
  }
  else {
    noStudio = true;
  }
}



public void controlEvent(ControlEvent theEvent) {
  // DropdownList is of type ControlGroup.
  // A controlEvent will be triggered from inside the ControlGroup class.
  // therefore you need to check the originator of the Event with
  // if (theEvent.isGroup())
  // to avoid an error message thrown by controlP5.

  if (theEvent.isGroup()) {

    if (theEvent.getGroup().getValue() < 6) {
      studioID = theEvent.getGroup().getValue();
      println(studioID + "- studioID");
    }

    if (theEvent.getGroup().getValue() > 10 ) {
      imageProID = theEvent.getGroup().getValue();
      println(imageProID + "- imageProID");
    }
  }

  else if (theEvent.isController()) {
    println("event from controller : "+theEvent.getController().getValue()+" from "+theEvent.getController());
  }
}

/////////////////////////////////////////////////////ORB/////////////
public void orb() {
  
  labelSize = 6.5f;

  for (int i = 0; i<1000; i++) {

    part[i].pColor = color(230);
    part[i].pSize = .75f;

    if (ideas_Studio) {
      part[i].pColor = color(230, 50);
      part[i].pSize = .2f;

      if (i<10) {
        fill(340, 100, 50, 75);
        stroke(220, 100);
        strokeWeight(1.5f);
        bezier(part[i].x2, part[i].y2, part[i].z2, part[i].x/5, part[i].y/5, part[i].z/2.5f, -50, 0, 0, 0, 0, 0);
        part[i].pColor = color(195, 69, 76);
        part[i].pSize = 8;
      }
      
    }

    if (image_Studio) {
      if(ideas_Studio == false) {
      part[i].pColor = color(230, 50);
      part[i].pSize = .2f;
      }

      if (i>=10 && i<20) {
        fill(0, 100, 50, 75);
        stroke(220, 100);
        strokeWeight(1.5f);
        bezier(part[i].x2, part[i].y2, part[i].z2, part[i].x/5, part[i].y/5, part[i].z/3, -50, 0, 0, 0, 0, 0);
        part[i].pColor = color(195, 69, 76);
        part[i].pSize = 8;
      }
    }

    if (impact_Studio) {

      if(ideas_Studio == false || image_Studio == false) {
      part[i].pColor = color(230, 50);
      part[i].pSize = .2f;
      }

      if (i>=20 && i<25) {
        fill(20, 100, 50, 75);
        stroke(220, 100);
        strokeWeight(1.5f);
        bezier(part[i].x2, part[i].y2, part[i].z2, part[i].x/5, part[i].y/5, part[i].z/3, -50, 0, 0, 0, 0, 0);
        part[i].pColor = color(195, 69, 76);
        part[i].pSize = 8;
      }
    }
  }//////////////////////////////////Completes the For Loop
  
  if (ideas_Studio) labelSize-= 0.5f;
  if (image_Studio) labelSize-= 0.5f;
  if (impact_Studio) labelSize-= 0.5f;
    

}

class Particle {

  PVector p = new PVector(100, 0, 0);
  PVector p2 = new PVector(120, 0, 0);
  PVector p3 = new PVector(100, 0, 0);
  PVector shrink = new PVector(-.5f, 0, 0);
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
  int pColor;
  float projectID;


  Particle(float _startRot, float _zSpin, float _speed, float _pSize, int _pColor) { 
    startRot = _startRot;
    zSpin = _zSpin;
    speed = _speed;
    pSize = _pSize;
    pColor = _pColor;
  }



  public void display(float burst) {

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
    orbits+=.05f;
  }
}

  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "--full-screen", "--bgcolor=#030303", "--stop-color=#cccccc", "icat_Orb3" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
