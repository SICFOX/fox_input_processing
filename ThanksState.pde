class ThanksState extends State {
  AudioPlayer playerThanks;
  
  ThanksState() {
    playerThanks = minim.loadFile("audio/07goodbye.mp3");
  }
  void drawState() {
    playerThanks.play();
    background(29,175,241);
    image(img, 440,180,129,143);
    textAlign(LEFT);
    textFont(text, 48);  
    text("Thank you very much", 320, 400);
    textFont(text, 72);  
    text("#Fuzzy Order eXperience", 160, 500);
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
