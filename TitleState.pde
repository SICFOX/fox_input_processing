class TitleState extends State {
  int baseTime;
  boolean nextState;
  
  TitleState(){
     nextState = false;
     baseTime = millis();
  }
  void drawState() {
    image(logo_text,334,495,327,65);
    image(img, 387,196,215,239);
    
//    int countdown = millis() - baseTime;
//    if(countdown > 5000){
//      playerAnalyze.close();
//    }
  }

  State decideState() {
    if (keyPressed && keyCode == RIGHT) { 
      return new IntroState();
    }
//    if (nextState) { 
//      return new IntroState(); 
//    } 
    return this;
  }
}
