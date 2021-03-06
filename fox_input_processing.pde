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

Client client;

State state;

SimpleOpenNI  context;
SimpleOpenNI  context2;

Movie blue;
Movie red;
Movie yellow;
Movie orange;

AudioPlayer playerCountOne;
AudioPlayer playerCountTwo;
AudioPlayer playerCountThree;

PImage img;
PImage logo_text;
PImage loading_img;
PImage expression_img;
PImage bottle_image;
PImage joy_image;
PImage smile_image;
PImage anger_image;
PImage sorrow_image;
float diff;

boolean expressionFlag;
boolean handFlag;
boolean waitFlag;

boolean yellowFlag;
boolean blueFlag;
boolean redFlag;
boolean orangeFlag;

boolean goState;

boolean userCheck;

PFont text;

int saved_size;
int random_size;



void setup() {
  client = new Client(this, "127.0.0.1", 5555);
  minim = new Minim(this);
  //size(640, 480); Kinectの映像サイズ
  size(1000,750);
  textSize(32);
  textAlign(CENTER);
  fill(255);
  state = new TitleState();
  expressionFlag = true;
  handFlag = true;
  waitFlag = true;
  yellowFlag = false;
  blueFlag = false;
  redFlag = false;
  orangeFlag = false;
  goState = false;

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
  bottle_image = loadImage("cottoncandy_size.png");
  joy_image = loadImage("joy.png");
  smile_image = loadImage("surprise.png");
  anger_image = loadImage("anger.png");
  sorrow_image = loadImage("sorrow.png");
  text = loadFont("MrEavesModOT-Bold-200.vlw");
  blue = new Movie(this, "blue.MP4");
  red = new Movie(this, "pink.MP4");
  yellow = new Movie(this, "green.MP4");
  orange = new Movie(this, "orange.MP4");

}

void draw() {
  background(29,175,241);
  state = state.doState();
  //println( state.getClass().getName() );
}

// draw the skeleton with the selected joints
float drawSkeleton(int userId) {
  PVector rightHandPos = new PVector();
  PVector leftHandPos = new PVector();
  PVector neckPos = new PVector();
  context.getJointPositionSkeleton(userId, SimpleOpenNI.SKEL_RIGHT_HAND, rightHandPos);
  context.getJointPositionSkeleton(userId, SimpleOpenNI.SKEL_LEFT_HAND, leftHandPos);
  context.getJointPositionSkeleton(userId, SimpleOpenNI.SKEL_HEAD, neckPos);
  


  PVector convertedRightHand = new PVector();
  context.convertRealWorldToProjective(rightHandPos, convertedRightHand );

  PVector convertedLeftHand = new PVector();
  context.convertRealWorldToProjective(leftHandPos, convertedLeftHand );

  PVector convertedNeck = new PVector();
  context.convertRealWorldToProjective(neckPos, convertedNeck );


  int positionX = int((convertedRightHand.x + convertedLeftHand.x)/2);
  int positionY = int((convertedRightHand.y + convertedLeftHand.y)/2);
  int diffPosition = int(convertedRightHand.x - convertedLeftHand.x);

  int neckPositionZ = int(convertedNeck.z);
  int neckPositionX = int(convertedNeck.x);
  
  if(orangeFlag){ fill(245,140,25,90); }
  if(blueFlag){fill(140,252,254,90);}
  if(redFlag){fill(250,135,192,90);}
  if(yellowFlag){fill(123,239,94,90);}
  println("z軸:" + str(neckPositionZ));
  println("x軸:" + str(neckPositionX));
  if(neckPositionZ > 1600 && neckPositionZ < 1800 ){
       println("Z軸の条件を満たしました");
      if(neckPositionX > 100 && neckPositionX < 500){
       println("X軸の条件を満たしました");
      noStroke();
      ellipse(positionX + 340,positionY + 250, diffPosition - 10, diffPosition - 10);
      diff = rightHandPos.x - leftHandPos.x;
    }
  }

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
  userCheck = true;
}

void onLostUser(SimpleOpenNI curContext, int userId)
{
  println("onLostUser - userId: " + userId);
  curContext.startTrackingSkeleton(userId);
  userCheck = false;
}
void onVisibleUser(SimpleOpenNI curkinect, int userId)
{
//  println("onVisibleUser - userId: " + userId);
  userCheck = true;
}

//サーバーからデータを受け取るときに呼ばれるコールバック関数
void clientEvent(Client c) {
  String s = c.readString();
  if (s != null) {
    println("client receieved: " + s);
    print(s);
    random_size = int(random(15, 30));
    if (int(s) == 0){
      orangeFlag = false;
      blueFlag = false;
      redFlag = false;
      yellowFlag = true;
      expressionFlag = false;
      waitFlag = true;
    }else if (int(s) == 1){
      orangeFlag = true;
      blueFlag = false;
      redFlag = false;
      yellowFlag = false;
      expressionFlag = false;
      waitFlag = true;
    }else if (int(s) == 2){
      orangeFlag = false;
      blueFlag = true;
      redFlag = false;
      yellowFlag = false;
      expressionFlag = false;
      waitFlag = true;
    }else if (int(s) == 3){
      orangeFlag = false;
      blueFlag = false;
      redFlag = true;
      yellowFlag = false;
      expressionFlag = false;
      waitFlag = true;
    }else if (int(s) == 4){
      print("4だよ");
      handFlag = false;
    }else if (int(s) == 5){
      print("5だよ");
      waitFlag = false;
      expressionFlag = true;
      handFlag = true;
    }
    goState = true;
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
     imageMode(CORNER);
     popMatrix();
}
