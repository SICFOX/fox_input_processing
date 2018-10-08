class ExpressionState extends State {
  AudioPlayer playerExpression;
  AudioPlayer playerPhoto;
  
  
  int shot_count;
  int shoot;
  int baseTime;
  String received;
  boolean nextState;
  int deg;
  
  ExpressionState() {
    playerExpression = minim.loadFile("face_expression.mp3");
    playerPhoto = minim.loadFile("camera_shutter.mp3");
    shot_count = 1;
    shoot = 0;
    baseTime = millis();
    nextState = false;
    expressionFlag = true;
  }
  
  void drawState() {
    //3番目最初に呼ばれるクラス
    playerExpression.play();
    
    
    context.update();
    background(29,175,241);
    image(context.rgbImage(), 340, 250);
    
    image(img, 181,80,77,86);
    textFont(text, 48);  
    text("Take a picture with contdown", 600, 140);
    
    
    //text("Press 'h' to restart.", width * 0.5, height * 0.7);
    
    
    
    int countdown = millis() - baseTime;
    if(countdown < 6000){
      textFont(text, 40);  
      text("Show me your face", 168, 348);
      textFont(text, 72);  
      text("Contdown",164, 457);
      text("here",172, 520);
    }else if(countdown < 7000){
      textFont(text, 40);  
      text("Show me your face", 168, 348);
      textFont(text, 200);  
      text(str(3),172, 540);
    }else if (countdown < 8000){
      textFont(text, 40);  
      text("Show me your face", 168, 348);
      textFont(text, 200);  
      text(str(2),172, 540);
    }else if (countdown < 9000){
      textFont(text, 40);  
      text("Show me your face", 168, 348);
      textFont(text, 200);  
      text(str(1),172, 540);
    }else if (countdown > 9000){
      playerPhoto.play();
      textFont(text, 40);  
      text("Wait a moment", 168, 348);
      if (shoot == 2){
        expression_img = loadImage("./img/img1.jpg");
        image(expression_img, 340, 250);
      }
      rotateImage(-80, 220, loading_img, deg );
      deg = deg + 6;
      if( deg > 360) deg = 0;
      
      if(countdown > 11000){
        if (expressionFlag == true){
        String s = "savefaceimage";
        client.write(s);
        expressionFlag = false;
        //delay(3000);
        nextState = true;
      }
//      received = clientEvent();
      }

    }
    
    switch(shoot) {
      case 0:
        if (countdown > 9000) {
          print("Photo!!");
          shoot = 1;
        }
        break;
      case 1:
        PImage saveImage = get(340, 250, 640, 480);
        //saveImage.save(System.getProperty("user.home") + "/Documents/中西研究会/UIST2018/fox_input_processing/img/img2.jpg");
        saveImage.save("./img/img1.jpg");
        print("Save img1.jpg");
        shoot =  2;
        break;

      case 2:
        break;
    }
  }

  State decideState() {
    if (keyPressed && keyCode == RIGHT) {
      playerExpression.close();
      playerPhoto.close() ;
      return new AnalyzeState();
    }else if(keyPressed && keyCode == LEFT){
      playerExpression.close();
      playerPhoto.close() ;
      return new IntroState();
    }
    
    
    if (nextState) { // if ellapsed time is larger than
      playerExpression.close();
      playerPhoto.close() ;
      return new AnalyzeState(); // go to ending
    } 
    return this;
  }
}
