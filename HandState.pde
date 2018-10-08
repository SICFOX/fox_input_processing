class HandState extends State {
  AudioPlayer playerHand;
  PVector com;
  PVector com2d;
  color[] userClr;
  int baseTime;
  int countdown;
  int exception;
  int saved_size;
  boolean nextState;


  HandState() {
    playerHand = minim.loadFile("hand_sign.mp3");
    userClr = new color[] {
      color(255, 0, 0),
      color(0, 255, 0),
      color(0, 0, 255),
      color(255, 255, 0),
      color(255, 0, 255),
      color(0, 255, 255)
    };
    com = new PVector();
    com2d = new PVector();
    background(29,175,241);
    baseTime = millis();
    nextState = false;
    handFlag = true;
  }


  void drawState() {
    playerHand.play();


    context.update();
    //デバッグモード
    image(context.userImage(),340, 250);
    image(context.rgbImage(),340, 250);
    fill(255);
    //text("Please hand gesture", width * 0.5, height * 0.5);


    //print(context.rightHandPos.x);
    
    image(img, 181,80,77,86);
    textFont(text, 48);  
    text("Adjust the size of the cotton candy", 600, 140);
    textFont(text, 40);  
    text("The size is ",148, 283);
    text("Hold your arm", 148, 560);
    
    textFont(text, 72);  
    text("Contdown",164, 560);
    text("here",172, 640);

    int[] userList = context.getUsers();
    for (int i=0; i<userList.length; i++) {
      if (context.isTrackingSkeleton(userList[i])) {
        stroke(userClr[ (userList[i] - 1) % userClr.length ] );
        float diff = drawSkeleton(userList[i]);
        int cm_diff = int(diff/10);
        println("Size of Cotton Candy = ", str(cm_diff), "cm");
        fill(255);
        if (cm_diff > 0) {
          exception = 0;
          countdown = millis() - baseTime - exception;
          if (countdown < 11000) {
            textFont(text, 120);  
            text(str(cm_diff)+"cm",188,420);
//            textFont(text, 72);  
//            text("Contdown",164, 560);
//            text("here",172, 640);
            //text("cototn candy size : " + str(cm_diff)+"cm", width * 0.5, height * 0.7);
            //text("countdown : " + str(3),width * 0.5, height * 0.9);
          } else if (countdown < 12000) {
            textFont(text, 120);  
            text(str(cm_diff)+"cm",172,420 );
            textFont(text, 200);  
            text(str(3),172, 680);
          } else if (countdown < 13000) {
            textFont(text, 120);  
            text(str(cm_diff)+"cm",172,420 );
            textFont(text, 200);  
            text(str(2),172, 680);
          } else if (countdown < 14000) {
            textFont(text, 120);  
            text(str(cm_diff)+"cm",172,420 );
            textFont(text, 200);  
            text(str(1),172, 680);
            saved_size = cm_diff;
          } else if (countdown > 14000) {
            text("Thank you", width * 0.8, height * 0.7);
            text("Save size : " + str(saved_size)+"cm", width * 0.8, height * 0.9);
            if (handFlag == true) {
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
      } else {
        exception = millis();
        print(exception);
      }


      // draw the center of mass
      if (context.getCoM(userList[i], com)) {
        context.convertRealWorldToProjective(com, com2d);
//        stroke(100, 255, 0);
//        strokeWeight(1);
//        beginShape(LINES);
//        vertex(com2d.x, com2d.y - 5);
//        vertex(com2d.x, com2d.y + 5);
//        vertex(com2d.x - 5, com2d.y);
//        vertex(com2d.x + 5, com2d.y);
//        endShape();
//        fill(0,255,100);
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
      return new AnalyzeState();
    }
    if (nextState) {
      playerHand.close() ;
      return new WaitState();
    }
    return this;
  }
}
