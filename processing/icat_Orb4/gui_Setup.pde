
ControlP5 cp5;
DropdownList studioList, projectList;
controlP5.Toggle ideasButton, imageButton, impactButton, implementButton, interactButton, closeBoxButton;


String [] studios = {
  "IDEAS", "IMAGE", "IMPACT", "IMPLEMENT", "INTERACT"
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


float studioID = 0;
float ideasProID = 0;
float imageProID = 0; 
float impactProID = 0;
float implementProID = 0;
float interactProID = 0;
boolean lightBox = false;

boolean [] studio_Names = new boolean [6];
boolean noStudio = true;
boolean ideas_Studio = false;
boolean image_Studio = false;
boolean impact_Studio = false;
boolean implement_Studio = false;
boolean interact_Studio =false;
boolean closeBox = false;

float labelSize = 7;




//////////////////////////////////////////////////
void gui_Setup() {

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

  ideasButton = cp5.addToggle("ideas_Studio")
    .setPosition(20, 10);
  customize2(ideasButton);

  imageButton = cp5.addToggle("image_Studio")
    .setPosition(20, 40);
  customize2(imageButton);

  impactButton = cp5.addToggle("impact_Studio")
    .setPosition(20, 70);
  customize2(impactButton);

  implementButton = cp5.addToggle("implement_Studio")
    .setPosition(20, 100);
  customize2(implementButton);

  interactButton = cp5.addToggle("inhabit_Studio")
    .setPosition(20, 130);
  customize2(interactButton);

  closeBoxButton = cp5.addToggle("closeBox")
    .setSize(20, 20)
      .setPosition((width/2)+186, (height/2)+145);
  customize2(closeBoxButton);

  cp5.getController("closeBox").setVisible(false);

  //  ideasButton.captionLabel()
  //             .setFont(cp5_font)
  //             .setSize(24)
  //             .toUpperCase(false)
  //             .setText("Image_Studio");
}

//sets the color style for all of the buttons
void customize2(controlP5.Toggle buttonName) {
  buttonName.setColorForeground(#9B9B9B)
    .setColorBackground(#676767)
      .setColorActive(#670021)
        .setValue(false);

  if (buttonName != closeBoxButton) {
    buttonName.setSize(20, 10);
  }
}



//////////////////////////////////////////////////customizing the DropdownLists
/*
void customize(DropdownList ddl) {
  ddl.setBackgroundColor(color(80));
  ddl.setItemHeight(20);
  ddl.setBarHeight(15);
  ddl.captionLabel().style().marginTop = 3;
  ddl.captionLabel().style().marginLeft = 3;
  ddl.valueLabel().style().marginTop = 3;
  ddl.setColorBackground(color(60));
  ddl.setColorActive(color(255, 128));
}
*/




float labelGrow = 0;
//////////////////////////////////////////3D GUI Matched to the Camera
void gui3D() {

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
      textFont(font, labelSizeA[i]);
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
      textFont(font, labelSizeA[i+10]);
      fill(220);
      if(imageProID>=10) {
        fill(220,0);
      }
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
      textFont(font, labelSizeA[i+20]);
      fill(220);
      text(impactPro[i], 0, 0);
      popMatrix();
    }
  }

  /////////////////////////////////////////////////////////mouseOver and Select
  for (int i = 0; i<30; i++) {
    float d = dist(mouseX, mouseY, part[i].sX, part[i].sY);
    if (d<20 && mousePressed) {
      imageProID = i;
      lightBox = true;
      println(lightBox + " - " + imageProID);
    } 
    else {
      lightBox = false;
    }


    //RollOver Growing for the text
    if (d<20) {
      if (labelSizeA[i] < 9) {
        labelSizeA[i]+= .2;
      }
    } 
    else if (d>20) {
      if (labelSizeA[i] > 6) {
        labelSizeA[i] -=.2;
      }
    }

    //mouseOver for closing the LightBox
    if (lightBox) {
      if (closeBox == true) {
        imageProID = 0;
        lightBox = false;
        println(lightBox + " - " + imageProID);
      }
    }
  }
}




////////////////////////////////ICAT LOGO

float sqX1, sqY1, sqX2, sqY2;
float radOff = 0;
float alphaT = 255; 

void icat_Logo() {

  if (frameCount < 300) {

    hint(ENABLE_DEPTH_TEST);
    //hint(ENABLE_DEPTH_SORT);
    pushMatrix();
    translate(0, 0, 110);
    scale(.75, .75, .75);

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
      radOff+=.25;
    }
  }
}


void noSelect() {
  if (ideas_Studio == true ||
    image_Studio == true ||
    impact_Studio == true ||
    implement_Studio == true ||
    interact_Studio == true) {
    noStudio = false;
  }
  else {
    noStudio = true;
  }
}



/*
void controlEvent(ControlEvent theEvent) {
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
 */
