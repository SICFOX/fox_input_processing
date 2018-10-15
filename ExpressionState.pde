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
    playerExpression = minim.loadFile("audio/02video.mp3");
    playerPhoto = minim.loadFile("audio/camera_shutter.mp3");
    playerCountThree = minim.loadFile("audio/three.mp3");
    playerCountTwo = minim.loadFile("audio/two.mp3");
    playerCountOne = minim.loadFile("audio/one.mp3");
    shot_count = 1;
    shoot = 0;
    baseTime = millis();
    nextState = false;
    goState = false;
    expressionFlag = true;
  }
  
  void drawState() {
    playerExpression.play();
    
    
    context.update();
    background(29,175,241);
    image(context.rgbImage(), 340, 250);
    
    image(img, 181,80,77,86);
    textFont(text, 48);  
    text("Take a picture with contdown", 600, 140);
     
    int countdown = millis() - baseTime;
    if(countdown > 10300){
      playerExpression.close();
    }
    if(countdown < 12000){
      textFont(text, 40);  
      text("Show me your face", 168, 348);
      textFont(text, 72);  
      text("Contdown",164, 457);
      text("here",172, 520);
    }else if(countdown < 13000){
      playerCountThree.play();
      textFont(text, 40);  
      text("Show me your face", 168, 348);
      textFont(text, 200);  
      text(str(3),172, 540);
    }else if (countdown < 14000){
      playerCountThree.close();
      playerCountTwo.play();
      textFont(text, 40);  
      text("Show me your face", 168, 348);
      textFont(text, 200);  
      text(str(2),172, 540);
    }else if (countdown < 15000){
      playerCountTwo.close();
      playerCountOne.play();
      textFont(text, 40);  
      text("Show me your face", 168, 348);
      textFont(text, 200);  
      text(str(1),172, 540);
    }else if (countdown > 15000){
      playerCountOne.close();
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
      
      if(countdown > 17000){
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
        if (countdown > 15000) {
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
    
    
    if (goState) { // if ellapsed time is larger than
//      playerExpression.close();
      playerPhoto.close();
      goState = false;
      return new AnalyzeState(); // go to ending
    } 
    return this;
  }
}
