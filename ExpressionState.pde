class ExpressionState extends State {
  AudioPlayer playerExpression;
  AudioPlayer playerPhoto;


  int shot_count;
  int shoot;
  int baseTime;
  String received;
  boolean nextState;

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
    background(51,183,241);
    image(context.rgbImage(), 340, 250);


    //text("Press 'h' to restart.", width * 0.5, height * 0.7);



    int countdown = millis() - baseTime;
    if(countdown < 6000){
      textSize(28);
      text("Show me your face", 150, 300);
      text("Take your picture",150, 400);
    }else if(countdown < 7000){
      textSize(28);
      text("Show your face me", 150, 300);
      text("countdown : ",150, 400);
      textSize(100);
      text(str(3),150, 500);
    }else if (countdown < 8000){
      textSize(28);
      text("Show your face me", 150, 300);
      text("countdown : ",150, 400);
      textSize(100);
      text(str(2),150, 500);
    }else if (countdown < 9000){
      textSize(28);
      text("Show your face me", 150, 300);
      text("countdown : ",150, 400);
      textSize(100);
      text(str(1),150, 500);
    }else if (countdown > 9000 && countdown < 11000){
      playerPhoto.play();
    }else if (countdown > 11000){
      textSize(28);
      text("Thank you",150, 300);
      text("Save your face",150, 400);

      //print(expressionFlag);
      if (expressionFlag == true){
        String s = "savefaceimage";
        client.write(s);
        expressionFlag = false;
        //delay(3000);
        nextState = true;
      }
//      received = clientEvent();
    }

    switch(shoot) {
      case 0:
        if (countdown > 9000) {
          print("Photo!!");
          shoot = 1;
        }
        break;
      case 1:
        PImage saveImage = get(340, 250,640,480);
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
    if (key == CODED) {
      if (keyCode == RIGHT) {
        println("右が押された！");
      } else if (keyCode == LEFT) {
         println("左が押された！");
      }
    }
    if (keyPressed && keyCode == RIGHT) {
      playerExpression.close();
      playerPhoto.close() ;
      return new HandState();
    }else if(keyPressed && keyCode == LEFT){
      playerExpression.close();
      playerPhoto.close() ;
      return new IntroState();
    }


    if (nextState) { // if ellapsed time is larger than
      playerExpression.close();
      playerPhoto.close() ;
      return new HandState(); // go to ending
    }
    return this;
  }
}
