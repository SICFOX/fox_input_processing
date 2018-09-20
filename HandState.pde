class HandState extends State {
  AudioPlayer playerHand; 
  PVector com;
  PVector com2d;
  color[] userClr;
  
  
  HandState() {
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
  }
  
  
  void drawState() {
    playerHand.play();
    text("Plase hand gesture", width * 0.5, height * 0.5);
    text("Press 'w' to restart.", width * 0.5, height * 0.7);
    
    context.update();
    image(context.userImage(),0,0);
    
    //print(context.rightHandPos.x);
    
    int[] userList = context.getUsers();
    for(int i=0;i<userList.length;i++){
      if(context.isTrackingSkeleton(userList[i])){
        stroke(userClr[ (userList[i] - 1) % userClr.length ] );
        float diff = drawSkeleton(userList[i]);
        println("Size of Cotton Candy = ", int(diff/10), "cm");
      }      
      
    // draw the center of mass
      if(context.getCoM(userList[i],com)){
        context.convertRealWorldToProjective(com,com2d);
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
  
 
  State decideState() {
    if (keyPressed && key == 'w') {
      playerHand.close() ;
      return new WaitState();
    }
    return this;
  }
}
