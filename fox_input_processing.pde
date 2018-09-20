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
  
}

void draw() {
  background(0);
  state = state.doState();
}
