class ExpressionState extends State {
  AudioPlayer playerExpression;
  AudioPlayer playerPhoto;
  
  int shot_count;
  int shoot;
  int baseTime;
  
  ExpressionState() {
    playerExpression = minim.loadFile("face_expression.mp3");
    playerPhoto = minim.loadFile("camera_shutter.mp3");
    shot_count = 1;
    shoot = 0;
    baseTime = millis();
  }
  
  void drawState() {
    //3番目最初に呼ばれるクラス
    playerExpression.play();
    
    
    context.update();
    background(200, 0, 0);
    image(context.rgbImage(), 0, 0);
    
    
    //text("Press 'h' to restart.", width * 0.5, height * 0.7);
    
    
    
    int countdown = millis() - baseTime;
    if(countdown < 6000){
      text("Show your face me", width * 0.5, height * 0.5);
      text("Take your picture",width * 0.5, height * 0.7);
    }else if(countdown < 7000){
      text("Show your face me", width * 0.5, height * 0.5);
      text("countdown : " + str(3),width * 0.5, height * 0.7);
    }else if (countdown < 8000){
      text("Show your face me", width * 0.5, height * 0.5);
      text("countdown : " + str(2),width * 0.5, height * 0.7);
    }else if (countdown < 9000){
      text("Show your face me", width * 0.5, height * 0.5);
      text("countdown : " + str(1),width * 0.5, height * 0.7);
    }else if (countdown > 9000 && countdown < 11000){
      //text("Shot!!",width * 0.5, height * 0.7);
      playerPhoto.play();
    }else if (countdown > 11000){
      text("Thank you",width * 0.5, height * 0.5);
      text("Save your face",width * 0.5, height * 0.7);
    }
    
    switch(shoot) {
      case 0:
        if (countdown > 9000) {
          print("Photo!!");
          shoot = 1;
        }
        break;
      case 1:
        PImage saveImage = get(0, 0, 640, 480);
        saveImage.save(System.getProperty("user.home") + "/Documents/中西研究会/UIST2018/System/img/img1.jpg");
        print("Save img1.jpg");
        shoot = 2;
        break;

      case 2:
        break;
    }
  }

  State decideState() {
    if (keyPressed && key == 'h') { // if ellapsed time is larger than
      playerExpression.close();
      playerPhoto.close() ;
      return new HandState(); // go to ending
    } 
    return this;
  }
}
