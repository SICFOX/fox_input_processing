class WaitState extends State {
  AudioPlayer playerWait;
  
  WaitState() {
   playerWait = minim.loadFile("wait.mp3");
  }
  
  void drawState() {
    fill(255);
    text("Wait!", width * 0.5, height * 0.5);
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
    if (keyPressed && key == 'z') {
      playerWait.close() ;
      return new TitleState();
    }
    return this;
  }
}
