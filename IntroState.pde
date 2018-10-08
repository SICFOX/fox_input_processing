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
    image(img, 192,304,129,143);
    textFont(text, 72);  
    text("I'm FOX", 560, 410);
    playerIntro.play();
    //text("Press 'e' to restart.", width * 0.5, height * 0.7);
    int countdown = millis() - baseTime;
    if(countdown > 19000){
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
