class HandState extends State {
  AudioPlayer playerHand;
  AudioPlayer playerKinect;
  AudioPlayer playerPhoto;
  PVector com;
  PVector com2d;
  color[] userClr;
  int baseTime;
  int shoot;
  int deg;
  int countdown;
  int exception;
  boolean nextState;


  HandState() {
    playerHand = minim.loadFile("audio/04upload02.mp3");
    playerKinect = minim.loadFile("audio/05kinect.mp3");
    playerPhoto = minim.loadFile("audio/camera_shutter.mp3");
    playerCountThree = minim.loadFile("audio/three.mp3");
    playerCountTwo = minim.loadFile("audio/two.mp3");
    playerCountOne = minim.loadFile("audio/one.mp3");
    
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
    goState = false;
    handFlag = true;
  }


  void drawState() {
    playerHand.play();

    context.update();
    //デバッグモード
    image(context.userImage(),340, 250);
    image(context.rgbImage(),340, 250);
    fill(255);

    image(img, 181,80,77,86);
    textFont(text, 48);  
    text("Adjust the size of the cotton candy", 600, 140);
    textFont(text, 40);  
    text("The size is ",160, 283);
    text("Hold your arm", 160, 508);
    
    textFont(text, 56);  
    text("not detected",160,360 );
    textFont(text, 72);  
    text("Contdown",164, 600);
    text("here",172, 680);
    
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
          if (countdown > 8000) {
            playerHand.close();
            playerKinect.play();
          }
          if (countdown < 14000) {
            fill(29,175,241);
            noStroke();
            rect(0,300, 300, 100);
            fill(255);
            textFont(text, 120); 
            text(str(cm_diff)+"cm",188,420);
            if (cm_diff > 50 || cm_diff < 15){
              fill(29,175,241);
              noStroke();
              //stroke(255,0,0);
              rect(20,300, 300, 124);
              fill(255,0,0);
              textFont(text, 120); 
              text("Over",188,420);
            }
          } else if (countdown < 15000) {
            playerCountThree.play();
            fill(29,175,241);
            noStroke();
            rect(0,300, 300, 100);
            rect(0,540, 310, 200);
            fill(255);
            textFont(text, 120);  
            text(str(cm_diff)+"cm",172,420 );
            if (cm_diff > 50 || cm_diff < 15){
              fill(29,175,241);
              noStroke();
              //stroke(255,0,0);
              rect(20,300, 300, 124);
              fill(255,0,0);
              textFont(text, 120); 
              text("Over",188,420);
            }
            fill(255);
            textFont(text, 200);  
            text(str(3),172, 680);
          } else if (countdown < 16000) {
            playerCountThree.close();
            playerCountTwo.play();
            fill(29,175,241);
            noStroke();
            rect(0,300, 300, 100);
            rect(0,540, 310, 200);
            fill(255);
            textFont(text, 120);  
            text(str(cm_diff)+"cm",172,420 );
            if (cm_diff > 50 || cm_diff < 15){
              fill(29,175,241);
              noStroke();
              //stroke(255,0,0);
              rect(20,300, 300, 124);
              fill(255,0,0);
              textFont(text, 120); 
              text("Over",188,420);
            }
            fill(255);
            textFont(text, 200);  
            text(str(2),172, 680);
          } else if (countdown < 17000) {
            playerCountTwo.close();
            playerCountOne.play();
            fill(29,175,241);
            noStroke();
            rect(0,300, 300, 100);
            rect(0,540, 310, 200);
            fill(255);
            if(cm_diff > 50){
              saved_size = 50;
            }else if (cm_diff < 15){
              saved_size = 15;
            }else{
              saved_size = cm_diff;
            }
            saved_size = cm_diff;
            textFont(text, 120);  
            text(str(saved_size)+"cm",172,420 );
            if (cm_diff > 50 || cm_diff < 15){
              fill(29,175,241);
              noStroke();
              //stroke(255,0,0);
              rect(20,300, 300, 124);
              fill(255,0,0);
              textFont(text, 120); 
              text("Over",188,420);
            }
            fill(255);
            textFont(text, 200);  
            text(str(1),172, 680);
          } else if (countdown > 17000) {
              fill(29,175,241);
              noStroke();
              rect(0,320, 320, 400);
              fill(255);
              textFont(text, 120);  
              text(str(saved_size)+"cm",172,420 );
              textFont(text, 40);  
              text("Wait a moment", 168, 508);
              if (shoot == 2){
                expression_img = loadImage("./img/img2.jpg");
                image(expression_img, 340, 250);
               }
              rotateImage(-80, 340, loading_img, deg );
              deg = deg + 6;
              if( deg > 360) deg = 0;
            if (countdown > 19000){
              if (handFlag == true) {
              String s = str(saved_size);
              client.write(s);
              handFlag = false;
              //delay(3000);
              nextState = true;
            }
            }
            switch(shoot) {
              case 0:
                if (countdown > 17000) {
                    print("Photo!!");
                    shoot = 1;
                }      
                break;
              case 1:
                 playerCountOne.close();
                 playerPhoto.play();
                 PImage saveImage = get(340, 250, 640, 480);
                 saveImage.save("./img/img2.jpg");
                  print("Save img2.jpg");
                  shoot =  2;
                  break;

                case 2:
                    break;
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
      nextState = false;
      goState = false;
      return new WaitState();
    }
    return this;
  }
}
