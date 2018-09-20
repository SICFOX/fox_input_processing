class HandState extends State {
  AudioPlayer playerHand; 
  PVector com;
  PVector com2d;
  color[] userClr;
  int baseTime;
  int saved_size;
  
  
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
    baseTime = millis();
  }
  
  
  void drawState() {
    playerHand.play();
    
    
    context.update();
    image(context.userImage(),0,0);
    fill(255);
    //text("Please hand gesture", width * 0.5, height * 0.5);
    
    
    //print(context.rightHandPos.x);
    
    int[] userList = context.getUsers();
    for(int i=0;i<userList.length;i++){
      if(context.isTrackingSkeleton(userList[i])){
        stroke(userClr[ (userList[i] - 1) % userClr.length ] );
        float diff = drawSkeleton(userList[i]);
        int cm_diff = int(diff/10);
        println("Size of Cotton Candy = ", str(cm_diff), "cm");
        fill(255);
        if (cm_diff > 0) {
          int countdown = millis() - baseTime;
          if(countdown < 11000){
            //text("cototn candy size : " + str(cm_diff)+"cm", width * 0.5, height * 0.7);
          //text("countdown : " + str(3),width * 0.5, height * 0.9);
          }else if(countdown < 12000){
            //text("cototn candy size : " + str(cm_diff)+"cm", width * 0.5, height * 0.7);
            text("countdown : " + str(3),width * 0.5, height * 0.9);
          }else if(countdown < 13000){
            //text("cototn candy size : " + str(cm_diff)+"cm", width * 0.5, height * 0.7);
            text("countdown : " + str(2),width * 0.5, height * 0.9);
          }else if(countdown < 14000){
            //text("cototn candy size : " + str(cm_diff)+"cm", width * 0.5, height * 0.7);
            text("countdown : " + str(1),width * 0.5, height * 0.9);
            saved_size = cm_diff;
          }else if(countdown > 14000){
            text("Thank you", width * 0.5, height * 0.7);
            text("Save size : " + str(saved_size)+"cm", width * 0.5, height * 0.9);
            if (handFlag == true){
              String s = str(saved_size);
              client.write(s);
              handFlag = false;
            }
          }
         }
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
