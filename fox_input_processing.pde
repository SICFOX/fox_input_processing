import ddf.minim.spi.*;
import ddf.minim.signals.*;
import ddf.minim.*;
import ddf.minim.analysis.*;
import ddf.minim.ugens.*;
import ddf.minim.effects.*;

import SimpleOpenNI.*;

Minim minim;
State state;
SimpleOpenNI  context;
SimpleOpenNI  context2;

void setup() {
  minim = new Minim(this);
  size(640, 480);
  textSize(32);
  textAlign(CENTER);
  fill(255);
  state = new TitleState();
  
  context = new SimpleOpenNI(this);
    if (context.isInit() == false){
      println("Can't init SimpleOpenNI, maybe the camera is not connected!"); 
      exit();
      return;
    }
  context.setMirror(true);

  // enable ir generation
  context.enableRGB();
  
  context2= new SimpleOpenNI(this);
    if (context2.isInit() == false){
      println("Can't init SimpleOpenNI, maybe the camera is not connected!"); 
      exit();
      return;
    }

  context2.setMirror(true);

  // enable ir generation
  context2.enableRGB();
  // enable depthMap generation 
  context2.enableDepth();
   
  // enable skeleton generation for all joints
  context2.enableUser();
  
  
  
 
  
}

void draw() {
  background(0);
  state = state.doState();
}
