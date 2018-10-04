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
    image(img, width * 0.3,height * 0.4-28,100,110);
    text("I'm FOX", width * 0.6, height * 0.5);
    playerIntro.play();
    //text("Press 'e' to restart.", width * 0.5, height * 0.7);
    int countdown = millis() - baseTime;
    if(countdown > 7000){
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
