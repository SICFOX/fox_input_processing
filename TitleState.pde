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
    
    int countdown = millis() - baseTime;
    if(countdown > 10000){
      nextState = true;
    }
  }

  State decideState() {
    if (keyPressed && keyCode == RIGHT) { 
      return new IntroState();
    }
    if (keyPressed && keyCode == LEFT) { 
       return new ThanksState();
//      int countdown = millis() - baseTime;
//      if(countdown > 5000){
//        nextState = true;
//      }
    }
//    if (nextState) { 
//      return new IntroState(); 
//    } 
    return this;
  }
}
