class ThanksState extends State {
  AudioPlayer playerThanks;
  
  ThanksState() {
    playerThanks = minim.loadFile("audio/07goodbye.mp3");
  }
  void drawState() {
    playerThanks.play();
    background(29,175,241);
    image(img, 440,280,129,143);
    textFont(text, 72);  
    textAlign(LEFT);
    text("Thank you very much", 215, 500);
    textAlign(CENTER);
  }

  State decideState() {
    if (keyPressed && keyCode == RIGHT) { 
      return new TitleState();
    }
    if (keyPressed && keyCode == LEFT) { 
      return new WaitState();
    }
    return this;
  }
}
