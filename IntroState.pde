class IntroState extends State {
  AudioPlayer playerIntro;
  
  boolean nextState;
  int baseTime;
  
  IntroState() {
    playerIntro = minim.loadFile("intro.mp3");
    nextState = false;
    baseTime = millis();
  }
  
  void drawState() {
    text("I'm FOX", width * 0.5, height * 0.5);
    playerIntro.play();
    text("Press 'e' to restart.", width * 0.5, height * 0.7);
    int countdown = millis() - baseTime;
    if(countdown > 7000){
      nextState = true;
    }
  }

  State decideState() {
    if (keyPressed && key == 'e') {
      playerIntro.close() ;
      return new ExpressionState();
    }
    if (nextState) {
      playerIntro.close() ;
      return new ExpressionState();
    }
    return this;
  }
}
