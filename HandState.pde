class HandState extends State {
  AudioPlayer playerHand; 
  PVector com;
  PVector com2d;
  color[] userClr;
  int baseTime;
  int saved_size;
  boolean nextState;
  
  
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
    background(0,183,241);
    baseTime = millis();
    nextState = false;
    handFlag = true;
  }
  
  
  void drawState() {
    playerHand.play();
    
    
    context.update();
    //デバッグモード
    //image(context.rgbImage(),0,0);
    image(context.rgbImage(),0,0);
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
            text("size : " + str(cm_diff)+"cm", width * 0.8, height * 0.7);
            //text("cototn candy size : " + str(cm_diff)+"cm", width * 0.5, height * 0.7);
          //text("countdown : " + str(3),width * 0.5, height * 0.9);
          }else if(countdown < 12000){
            text("size : " + str(cm_diff)+"cm", width * 0.8, height * 0.7);
            text("countdown : " + str(3),width * 0.8, height * 0.9);
          }else if(countdown < 13000){
            text("size : " + str(cm_diff)+"cm", width * 0.8, height * 0.7);
            text("countdown : " + str(2),width * 0.8, height * 0.9);
          }else if(countdown < 14000){
            text("size : " + str(cm_diff)+"cm", width * 0.8, height * 0.7);
            text("countdown : " + str(1),width * 0.8, height * 0.9);
            saved_size = cm_diff;
          }else if(countdown > 14000){
            text("Thank you", width * 0.8, height * 0.7);
            text("Save size : " + str(saved_size)+"cm", width * 0.8, height * 0.9);
            if (handFlag == true){
              String s = str(saved_size);
              client.write(s);
              handFlag = false;
              //delay(3000);
              //nextState = true;
            }else if(countdown > 16000){
            text("Thank you", width * 0.8, height * 0.7);
            text("Save size : " + str(saved_size)+"cm", width * 0.8, height * 0.9);
              nextState = true;
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
        //fill(0,255,100);
        //text(Integer.toString(userList[i]),com2d.x,com2d.y);
      }
    }   
} 
    

  
 
  State decideState() {
     if (keyPressed && keyCode == RIGHT) {
      playerHand.close() ;
      return new WaitState();
    }else if(keyPressed && keyCode == LEFT){
      playerHand.close() ;
      return new ExpressionState();
    }
    if (nextState) {
      playerHand.close() ;
      return new WaitState();
    }
    return this;
  }
}
