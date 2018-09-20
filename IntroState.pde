class IntroState extends State {
  AudioPlayer playerIntro;
  
  IntroState() {
    playerIntro = minim.loadFile("intro.mp3");
  }
  
  void drawState() {
    text("I'm FOX", width * 0.5, height * 0.5);
    playerIntro.play();
    text("Press 'e' to restart.", width * 0.5, height * 0.7);
  }

  State decideState() {
    if (keyPressed && key == 'e') {
      playerIntro.close() ;
      return new ExpressionState();
    }
    return this;
  }
}
