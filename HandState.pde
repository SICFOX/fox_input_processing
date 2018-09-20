class HandState extends State {
  AudioPlayer playerHand;
  int shot_count;
  int shoot;
  int baseTime;
  
  
  HandState() {
    //音声の読み込み
    playerHand = minim.loadFile("hand_sign.mp3");
    shot_count = 1;
    shoot = 0;
    baseTime = millis();
  }
  
  
  void drawState() {
    text("Plase hand gesture", width * 0.5, height * 0.5);
    playerHand.play();
    text("Press 'w' to restart.", width * 0.5, height * 0.7);
    
    context.update();
    background(200, 0, 0);
    image(context.rgbImage(), 0, 0);
    int countdown = millis() - baseTime;
    switch(shoot) {
      case 0:
        if (countdown > 3000) {
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
    if (keyPressed && key == 'w') {
      playerHand.close() ;
      return new WaitState();
    }
    return this;
  }
}
