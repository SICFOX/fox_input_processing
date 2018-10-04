class WaitState extends State {
  AudioPlayer playerWait;
  
  WaitState() {
   playerWait = minim.loadFile("wait.mp3");
   waitFlag = true;
  }
  
  void drawState() {
    fill(255);
    image(img, width * 0.2,height * 0.4-28,100,110);
    text("Wait a minitue", width * 0.6, height * 0.5);
    playerWait.play();
    if (waitFlag == true){
      String s = "senddata";
      client.write(s);
      waitFlag = false;
    }
    if (t > 3) {
      fill(255);
      text("Press 'z' to restart.", width * 0.5, height * 0.7);
    }
  }

  State decideState() {
    if (key == CODED) {
      if (keyCode == RIGHT) {  
        println("右が押された");
      } else if (keyCode == LEFT) {
         println("左が押された");
      }
    }

    if (keyPressed && keyCode == RIGHT) {
      playerWait.close() ;
      return new TitleState();
    }else if(keyPressed && keyCode == LEFT){
      playerWait.close() ;
      return new HandState();
    }
    
    return this;
  }
}
