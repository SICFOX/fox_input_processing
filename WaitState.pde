class WaitState extends State {
  AudioPlayer playerWait;
  
  WaitState() {
   playerWait = minim.loadFile("wait.mp3");
   waitFlag = true;
  }
  
  void drawState() {
    background(29,175,241);
    fill(255);
    image(img, 181,80,77,86);
    textFont(text, 48);  
    text("Please wait a munites", 600, 140);
    playerWait.play();
    
    image(test, 340,250,640,480);
    
    if (waitFlag == true){
      String s = "senddata";
      client.write(s);
      waitFlag = false;
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
