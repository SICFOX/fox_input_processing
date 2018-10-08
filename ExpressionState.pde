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
    background(51,183,241);
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
    }else if (countdown > 9000 && countdown < 11000){
      playerPhoto.play();
      textFont(text, 40);  
      text("Wait a moment", 168, 348);
      //expression_img = loadImage("./img/img1.jpg");
      //image(expression_img, 340, 250);
      //image(loading_img, 108, 420,126,132);
      rotateImage(-80, 220, loading_img, deg );
      deg = deg + 6;
      if( deg > 360) deg = 0;

    }else if (countdown > 11000){
      text("Thank you",width * 0.5, height * 0.5);
      text("Save your face",width * 0.5, height * 0.7);
      
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
  
  void rotateImage( int x, int y, PImage img, float deg ){ 
 pushMatrix(); //①
 
 //画像中央を回転の中心にする
 translate( x + img.width/2, y + img.height/2 ); //②
 
 //回転する
 rotate(radians( deg )); //③
 
 //回転の中心が画像中央なので、画像描画原点も画像中央にする
 //こうすると、(0,0)に配置すれば期待した位置に画像が置ける
 //これをしないと、⑤のimage()命令で配置する座標計算がメンドクサイ
 imageMode(CENTER); //④
 
 //画像を描画
 image( img, 0, 0,126,132 ); //⑤
 
 //画像描画原点を元（画像の左上隅）に戻す
 imageMode(CORNER); //⑥
 
 popMatrix(); //⑦
}
}
