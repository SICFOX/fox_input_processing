class ThanksState extends State {
  AudioPlayer playerThanks;
  
  ThanksState() {
    playerThanks = minim.loadFile("audio/07goodbye.mp3");
  }
  void drawState() {
    playerThanks.play();
    background(29,175,241);
    image(img, 440,180,129,143);
    textAlign(CENTER);
    textFont(text, 48);  
    text("Thank you very much", 512, 400);
    textFont(text, 72);  
    text("#UIST_FOX", 502, 500);
    //textAlign(CENTER);
  }

  State decideState() {
    if (keyPressed && keyCode == RIGHT) { 
      playerThanks.stop();
      return new TitleState();
    }
    if (keyPressed && keyCode == LEFT) { 
      playerThanks.stop();
      return new WaitState();
    }
    return this;
  }
}
