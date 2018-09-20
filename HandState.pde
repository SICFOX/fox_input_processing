class HandState extends State {
  AudioPlayer playerHand; 
  PVector com;
  PVector com2d;
  color[] userClr;
  
  
  HandState() {
    //音声の読み込み
    playerHand = minim.loadFile("hand_sign.mp3");
    userClr = new color[]{ 
      color(255,0,0),
      color(0,255,0),
      color(0,0,255),
      color(255,255,0),
      color(255,0,255),
      color(0,255,255)
    };
    com = new PVector();                                   
    com2d = new PVector();
    background(200,0,0);

    stroke(0,0,255);
    strokeWeight(3);
    smooth();  
    

    
  }
  
  
  void drawState() {
    playerHand.play();
    text("Plase hand gesture", width * 0.5, height * 0.5);
    text("Press 'w' to restart.", width * 0.5, height * 0.7);
    
    context2.update();
    image(context2.userImage(),0,0);
    
    int[] userList = context2.getUsers();
    for(int i=0;i<userList.length;i++){
      if(context2.isTrackingSkeleton(userList[i])){
        stroke(userClr[ (userList[i] - 1) % userClr.length ] );
        drawSkeleton(userList[i]);
      }      
      
    // draw the center of mass
      if(context2.getCoM(userList[i],com)){
        context2.convertRealWorldToProjective(com,com2d);
        stroke(100,255,0);
        strokeWeight(1);
        beginShape(LINES);
        vertex(com2d.x,com2d.y - 5);
        vertex(com2d.x,com2d.y + 5);
        vertex(com2d.x - 5,com2d.y);
        vertex(com2d.x + 5,com2d.y);
        endShape();
        fill(0,255,100);
        text(Integer.toString(userList[i]),com2d.x,com2d.y);
      }
    }    
    
  }
  
  // draw the skeleton with the selected joints
  void drawSkeleton(int userId){
  // to get the 3d joint data
    PVector rightHandPos = new PVector();
    PVector leftHandPos = new PVector();
    context2.getJointPositionSkeleton(userId,SimpleOpenNI.SKEL_RIGHT_HAND,rightHandPos);
    context2.getJointPositionSkeleton(userId,SimpleOpenNI.SKEL_LEFT_HAND,leftHandPos);
//  println(rightHandPos.x,leftHandPos.x);
    float diff = rightHandPos.x - leftHandPos.x;
    println("Size of Cotton Candy = ",int(diff/10),"cm");
//  float depth = (rightHandPos.z + leftHandPos.z)/2;
//  println(int(depth));
    
    context2.drawLimb(userId, SimpleOpenNI.SKEL_HEAD, SimpleOpenNI.SKEL_NECK);

    context2.drawLimb(userId, SimpleOpenNI.SKEL_NECK, SimpleOpenNI.SKEL_LEFT_SHOULDER);
    context2.drawLimb(userId, SimpleOpenNI.SKEL_LEFT_SHOULDER, SimpleOpenNI.SKEL_LEFT_ELBOW);
    context2.drawLimb(userId, SimpleOpenNI.SKEL_LEFT_ELBOW, SimpleOpenNI.SKEL_LEFT_HAND);

    context2.drawLimb(userId, SimpleOpenNI.SKEL_NECK, SimpleOpenNI.SKEL_RIGHT_SHOULDER);
    context2.drawLimb(userId, SimpleOpenNI.SKEL_RIGHT_SHOULDER, SimpleOpenNI.SKEL_RIGHT_ELBOW);
    context2.drawLimb(userId, SimpleOpenNI.SKEL_RIGHT_ELBOW, SimpleOpenNI.SKEL_RIGHT_HAND);

    context2.drawLimb(userId, SimpleOpenNI.SKEL_LEFT_SHOULDER, SimpleOpenNI.SKEL_TORSO);
    context2.drawLimb(userId, SimpleOpenNI.SKEL_RIGHT_SHOULDER, SimpleOpenNI.SKEL_TORSO);

    context2.drawLimb(userId, SimpleOpenNI.SKEL_TORSO, SimpleOpenNI.SKEL_LEFT_HIP);
    context2.drawLimb(userId, SimpleOpenNI.SKEL_LEFT_HIP, SimpleOpenNI.SKEL_LEFT_KNEE);
    context2.drawLimb(userId, SimpleOpenNI.SKEL_LEFT_KNEE, SimpleOpenNI.SKEL_LEFT_FOOT);

    context2.drawLimb(userId, SimpleOpenNI.SKEL_TORSO, SimpleOpenNI.SKEL_RIGHT_HIP);
    context2.drawLimb(userId, SimpleOpenNI.SKEL_RIGHT_HIP, SimpleOpenNI.SKEL_RIGHT_KNEE);
    context2.drawLimb(userId, SimpleOpenNI.SKEL_RIGHT_KNEE, SimpleOpenNI.SKEL_RIGHT_FOOT);  
  }
  
  void onNewUser(SimpleOpenNI curContext, int userId){
    println("onNewUser - userId: " + userId);
    println("\tstart tracking skeleton");
    curContext.startTrackingSkeleton(userId);
  }



  State decideState() {
    if (keyPressed && key == 'w') {
      playerHand.close() ;
      return new WaitState();
    }
    return this;
  }
}
