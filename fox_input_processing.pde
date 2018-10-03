import ddf.minim.spi.*;
import ddf.minim.signals.*;
import ddf.minim.*;
import ddf.minim.analysis.*;
import ddf.minim.ugens.*;
import ddf.minim.effects.*;

import SimpleOpenNI.*;

import processing.net.*;

Minim minim;
State state;
SimpleOpenNI  context;
SimpleOpenNI  context2;

PImage img;

boolean expressionFlag;
boolean handFlag;
boolean waitFlag;

Client client;

void setup() {
  client = new Client(this, "127.0.0.1", 5555);
  minim = new Minim(this);
  size(640, 480);
  //size(displayWidth, displayHeight);
  textSize(32);
  textAlign(CENTER);
  fill(255);
  state = new TitleState();
  
  expressionFlag = true;
  handFlag = true;
  waitFlag = true;

  context = new SimpleOpenNI(this);
  if (context.isInit() == false) {
    println("Can't init SimpleOpenNI, maybe the camera is not connected!"); 
    exit();
    return;
  }
  context.setMirror(true);
  context.enableRGB();

  context.enableDepth();
  context.enableUser();

  stroke(0, 0, 255);
  strokeWeight(3);
  smooth();
  
  img = loadImage("Fox_logo.png");
}

void draw() {
  background(0,183,241);
  state = state.doState();
  println( state.getClass().getName() );
}

// draw the skeleton with the selected joints
float drawSkeleton(int userId) {
  // to get the 3d joint data
  PVector rightHandPos = new PVector();
  PVector leftHandPos = new PVector();
  context.getJointPositionSkeleton(userId, SimpleOpenNI.SKEL_RIGHT_HAND, rightHandPos);
  context.getJointPositionSkeleton(userId, SimpleOpenNI.SKEL_LEFT_HAND, leftHandPos);
  float diff = rightHandPos.x - leftHandPos.x;
  
  PVector convertedRightHand = new PVector();
  context.convertRealWorldToProjective(rightHandPos, convertedRightHand );

  PVector convertedLeftHand = new PVector();
  context.convertRealWorldToProjective(leftHandPos, convertedLeftHand );

   
  int positionX = int((convertedRightHand.x + convertedLeftHand.x)/2);
  int positionY = int((convertedRightHand.y + convertedLeftHand.y)/2);
  int diffPosition = int(convertedRightHand.x - convertedLeftHand.x);

  fill(255, 0, 0);
  ellipse(positionX,positionY, diffPosition - 10, diffPosition - 10);


  context.drawLimb(userId, SimpleOpenNI.SKEL_HEAD, SimpleOpenNI.SKEL_NECK);

  context.drawLimb(userId, SimpleOpenNI.SKEL_NECK, SimpleOpenNI.SKEL_LEFT_SHOULDER);
  context.drawLimb(userId, SimpleOpenNI.SKEL_LEFT_SHOULDER, SimpleOpenNI.SKEL_LEFT_ELBOW);
  context.drawLimb(userId, SimpleOpenNI.SKEL_LEFT_ELBOW, SimpleOpenNI.SKEL_LEFT_HAND);

  context.drawLimb(userId, SimpleOpenNI.SKEL_NECK, SimpleOpenNI.SKEL_RIGHT_SHOULDER);
  context.drawLimb(userId, SimpleOpenNI.SKEL_RIGHT_SHOULDER, SimpleOpenNI.SKEL_RIGHT_ELBOW);
  context.drawLimb(userId, SimpleOpenNI.SKEL_RIGHT_ELBOW, SimpleOpenNI.SKEL_RIGHT_HAND);

  context.drawLimb(userId, SimpleOpenNI.SKEL_LEFT_SHOULDER, SimpleOpenNI.SKEL_TORSO);
  context.drawLimb(userId, SimpleOpenNI.SKEL_RIGHT_SHOULDER, SimpleOpenNI.SKEL_TORSO);

  context.drawLimb(userId, SimpleOpenNI.SKEL_TORSO, SimpleOpenNI.SKEL_LEFT_HIP);
  context.drawLimb(userId, SimpleOpenNI.SKEL_LEFT_HIP, SimpleOpenNI.SKEL_LEFT_KNEE);
  context.drawLimb(userId, SimpleOpenNI.SKEL_LEFT_KNEE, SimpleOpenNI.SKEL_LEFT_FOOT);

  context.drawLimb(userId, SimpleOpenNI.SKEL_TORSO, SimpleOpenNI.SKEL_RIGHT_HIP);
  context.drawLimb(userId, SimpleOpenNI.SKEL_RIGHT_HIP, SimpleOpenNI.SKEL_RIGHT_KNEE);
  context.drawLimb(userId, SimpleOpenNI.SKEL_RIGHT_KNEE, SimpleOpenNI.SKEL_RIGHT_FOOT);
  
  return diff;
}

void onNewUser(SimpleOpenNI curContext, int userId) {
  println("onNewUser - userId: " + userId);
  println("\tstart tracking skeleton");
  curContext.startTrackingSkeleton(userId);
}

void onLostUser(SimpleOpenNI curContext, int userId)
{
  println("onLostUser - userId: " + userId);
  curContext.startTrackingSkeleton(userId);
}

//サーバーからデータを受け取るときに呼ばれるコールバック関数
void clientEvent(Client c) {
  String s = c.readString();
  if (s != null) {
    println("client receieved: " + s);
    //println((char)s);
    print(unbinary(s));
    if (unbinary(s) == 1){
      expressionFlag = false;
      waitFlag = true;
    }
    if (unbinary(s) == 2){
      handFlag = false;
    }
    if (unbinary(s) == 3){
      waitFlag = false;
      expressionFlag = true;
      handFlag = true;
      
    }
  }
}
