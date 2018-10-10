class IntroState extends State {
  AudioPlayer playerIntro;
  
  boolean nextState;
  int baseTime;
  
  IntroState() {
    playerIntro = minim.loadFile("audio/01intro.mp3");
    nextState = false;
    baseTime = millis();
  }
  
  void drawState() {
    image(img, 240,304,129,143);
    textFont(text, 72);  
    text("I'm FOX", 600, 410);
    playerIntro.play();
    int countdown = millis() - baseTime;
    if(countdown > 6000){
      nextState = true;
    }
  }

  State decideState() {   
    if (keyPressed && keyCode == RIGHT) {
      playerIntro.close() ;
      return new ExpressionState();
    }else if(keyPressed && keyCode == LEFT){
      playerIntro.close() ;
      return new TitleState();
    }
    if (nextState) {
      playerIntro.close() ;
      return new ExpressionState();
    }
    return this;
  }
}
