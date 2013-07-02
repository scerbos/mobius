
float halfWi, halfHi;

///////////////////////////////2D GUI that is locked down to the screen//////////
void gui_Draw() {
  
  String c4arts = "Professor Dane Webster, with help from two of his students — Chris Russell and Mallory Brangan — used models and single-frame renderings from architecture firms Snohetta and STV to create a virtual fly through of the center.";
  String bat = "Part of an ongoing effort to partner with the Smithsonian National Museum of Natural History and create a large-scale digital repository of biological specimens,  these visualizations serve as both an education and outreach component of this research in addition to providing model manipulation tools for analyzing biological form and function relevant to engineering science.";
  String visionarium = "Built in June 2010, the VisBox VisCube(TM) is the replacement to the old CAVE. Like the CAVE before it, the VisCube has three rear-projected ten foot square walls and a top-projected floor with a cutout hiding a MOOG motion platform. The VisCube features numerous hardware and software upgrades to increase the fidelity of the visualization (more pixels (1920×1920 per wall!), more brightness, more contrast) as well as the ease of use for the researcher (wireless tracking).";


  //freezes the peasycam position  
  cam.beginHUD(); 
  hint(ENABLE_DEPTH_TEST);

  //these vaeriables have to be called within beginHUD or else the use the 3D coordinates.
  halfWi = width/2;
  halfHi = height/2;

  //block for all of the Image Studio projects
  if (image_Studio)
  
    if (imageProID >= 10) {
      rectMode(CENTER);
      fill(25, 230);
      rect(width/2, height/2, width, 400 );
      fill(220);
      rectMode(CORNER);
      cp5.getController("closeBox").setVisible(true);
      textAlign(LEFT);
      

      //block for the Center for the Arts
      if (imageProID == 10) {
        textFont(font, 24);
        text("Center for the Arts", halfWi+186, halfHi-160);
        textFont(font, 16);
        text(c4arts, halfWi+186, halfHi-130, 300, 300);
        vids[0].play();
        image(vids[0], halfWi-472, halfHi-180, 640, 360);
      } 
      else {
        vids[0].stop();
      }

      //block for the Bat Project 
      if (imageProID == 11) {
        textFont(font, 24);
        text("Bio-Inspired Design and Bats", halfWi+186, halfHi-160);
        textFont(font, 16);
        text(bat, halfWi+186, halfHi-130, 300, 300);
        vids[1].play();
        image(vids[1], halfWi-472, halfHi-180, 640, 360);
      } 
      else {
        vids[1].stop();
        vids[1].jump(0);
      }
      //block for the Visionarium
      if (imageProID == 12) {
  
        textFont(font, 24);
        text("Visionarium", halfWi+186, halfHi-160);
        textFont(font, 16);
        text(visionarium, halfWi+186, halfHi-130, 300, 300);
        vids[2].play();
        image(vids[2], halfWi-472, halfHi-180, 640, 360);
      } 
      else {
        vids[2].stop();
      }
    }

  //closes out the pop-up window for the projects
  //if (mouseX<25 && mouseY>(height/2)-25 && mouseY<(height/2)+25 && mousePressed) {
  if (closeBox) {
    imageProID = 0;
    vids[0].jump(0);
    vids[1].jump(0);
    vids[2].jump(0);
    vids[0].stop();
    vids[1].stop();
    vids[2].stop();
    cp5.getController("closeBox").setVisible(false);
  }

  noFill();
  ellipse(0, height/2, 25, 25);
  //finally draw all of the controlP5 GUI stuff on the screen
  //cp5.draw is set to false at the very first of draw();  
  cp5.draw();
  //un-freezes the peasycam  
  cam.endHUD();
}
