import ddf.minim.spi.*;
import ddf.minim.signals.*;
import ddf.minim.*;
import ddf.minim.analysis.*;
import ddf.minim.ugens.*;
import ddf.minim.effects.*;

import processing.video.*;

import SimpleOpenNI.*;

import processing.net.*;

Minim minim;
State state;
SimpleOpenNI  context;
SimpleOpenNI  context2;

Movie blue;
Movie red;
Movie yellow;
Movie orange;

PImage img;
PImage logo_text;
PImage loading_img;
PImage expression_img;

boolean expressionFlag;
boolean handFlag;
boolean waitFlag;

PFont text;

Client client;

void setup() {
  client = new Client(this, "127.0.0.1", 5555);
  minim = new Minim(this);
  //size(640, 480);
  //size(1366,1024);
  size(1000,750);
  
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

  stroke(255, 255, 255);
  strokeWeight(3);
  noStroke();
  smooth();
  
  
  
  img = loadImage("Fox_logo.png");
  logo_text = loadImage("Logo_title.png");
  loading_img = loadImage("loading.png");
  text = loadFont("MrEavesModOT-Bold-200.vlw"); 
  blue = new Movie(this, "blue.MP4");
  blue.loop();
  blue.volume(0);
//  red = new Movie(this, "red.MP4");
//  red.loop();
//  red.volume(0);
//  yellow = new Movie(this, "yellow.MP4");
//  yellow.loop();
//  yellow.volume(0);
//  orange = new Movie(this, "yellow.MP4");
//  orange.loop();
//  orange.volume(0);
 
}

void draw() {
  background(29,175,241);
  state = state.doState();
  println( state.getClass().getName() );
}

// draw the skeleton with the selected joints
float drawSkeleton(int userId) {
  // to get the 3d joint data
  PVector rightHandPos = new PVector();
  PVector leftHandPos = new PVector();
  PVector torsoPos = new PVector();
  context.getJointPositionSkeleton(userId, SimpleOpenNI.SKEL_RIGHT_HAND, rightHandPos);
  context.getJointPositionSkeleton(userId, SimpleOpenNI.SKEL_LEFT_HAND, leftHandPos);
  context.getJointPositionSkeleton(userId, SimpleOpenNI.SKEL_TORSO, torsoPos);
  float diff = rightHandPos.x - leftHandPos.x;
  
  
  PVector convertedRightHand = new PVector();
  context.convertRealWorldToProjective(rightHandPos, convertedRightHand );

  PVector convertedLeftHand = new PVector();
  context.convertRealWorldToProjective(leftHandPos, convertedLeftHand );
  
  PVector convertedTorso = new PVector();
  context.convertRealWorldToProjective(torsoPos, convertedTorso );

   
  int positionX = int((convertedRightHand.x + convertedLeftHand.x)/2);
  int positionY = int((convertedRightHand.y + convertedLeftHand.y)/2);
  int diffPosition = int(convertedRightHand.x - convertedLeftHand.x);
  
  if(diffPosition < 50){
    diffPosition = 60;
    positionX = int(convertedTorso.x);
    positionY = int(convertedTorso.y);
//    positionY = height/2;
  }
  fill(0, 0, 255,50);
  noStroke();
  ellipse(positionX + 340,positionY + 250, diffPosition - 10, diffPosition - 10);
  
  //print(SimpleOpenNI.SKEL_HEAD);


//  context.drawLimb(userId, SimpleOpenNI.SKEL_HEAD, SimpleOpenNI.SKEL_NECK);
//
//  context.drawLimb(userId, SimpleOpenNI.SKEL_NECK, SimpleOpenNI.SKEL_LEFT_SHOULDER);
//  context.drawLimb(userId, SimpleOpenNI.SKEL_LEFT_SHOULDER, SimpleOpenNI.SKEL_LEFT_ELBOW);
//  context.drawLimb(userId, SimpleOpenNI.SKEL_LEFT_ELBOW, SimpleOpenNI.SKEL_LEFT_HAND);
//
//  context.drawLimb(userId, SimpleOpenNI.SKEL_NECK, SimpleOpenNI.SKEL_RIGHT_SHOULDER);
//  context.drawLimb(userId, SimpleOpenNI.SKEL_RIGHT_SHOULDER, SimpleOpenNI.SKEL_RIGHT_ELBOW);
//  context.drawLimb(userId, SimpleOpenNI.SKEL_RIGHT_ELBOW, SimpleOpenNI.SKEL_RIGHT_HAND);
//
//  context.drawLimb(userId, SimpleOpenNI.SKEL_LEFT_SHOULDER, SimpleOpenNI.SKEL_TORSO);
//  context.drawLimb(userId, SimpleOpenNI.SKEL_RIGHT_SHOULDER, SimpleOpenNI.SKEL_TORSO);
//
//  context.drawLimb(userId, SimpleOpenNI.SKEL_TORSO, SimpleOpenNI.SKEL_LEFT_HIP);
//  context.drawLimb(userId, SimpleOpenNI.SKEL_LEFT_HIP, SimpleOpenNI.SKEL_LEFT_KNEE);
//  context.drawLimb(userId, SimpleOpenNI.SKEL_LEFT_KNEE, SimpleOpenNI.SKEL_LEFT_FOOT);
//
//  context.drawLimb(userId, SimpleOpenNI.SKEL_TORSO, SimpleOpenNI.SKEL_RIGHT_HIP);
//  context.drawLimb(userId, SimpleOpenNI.SKEL_RIGHT_HIP, SimpleOpenNI.SKEL_RIGHT_KNEE);
//  context.drawLimb(userId, SimpleOpenNI.SKEL_RIGHT_KNEE, SimpleOpenNI.SKEL_RIGHT_FOOT);
  
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
void onVisibleUser(SimpleOpenNI curkinect, int userId)
{
//  println("onVisibleUser - userId: " + userId);
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

void movieEvent(Movie m) {
     m.read();
}

void rotateImage( int x, int y, PImage img, float deg ){ 
     pushMatrix();
     translate( x + img.width/2, y + img.height/2 );
     rotate(radians( deg )); 
     imageMode(CENTER); 
     image( img, 0, 0,126,132 );
     imageMode(CORNER); //⑥
     popMatrix(); //⑦
}
