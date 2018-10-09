class AnalyzeState extends State {
  
  AudioPlayer playerAnalyze;
  
  int baseTime;
  boolean nextState;
  
  AnalyzeState() {
     playerAnalyze = minim.loadFile("audio/03analyze.mp3");
     nextState = false;
     baseTime = millis();
  }
  
  void drawState() {
    playerAnalyze.play();
    
    
    background(29,175,241);
    fill(255);
    image(img, 181,80,77,86);
    textFont(text, 48);  
    text("Analyzing is completed", 600, 140);
    
    textFont(text, 40);  
    text("The expression is ", 200, 400);
    text("The color is ", 525, 400);
    text("The size is ", 840, 400);
    
    textFont(text, 80);  
    if (orangeFlag){
      text("Joy", 200, 470);
      text("Orange", 540, 470);
    }else if (blueFlag){
      text("Sorrow", 200, 470);
      text("Blue", 540, 470);
    }else if (redFlag){
      text("Anger", 200, 470);
      text("Red", 540, 470);
    }else if (yellowFlag){
      text("Surprise", 200, 470);
      text("Yellow", 540, 470);
    }
    text("20cm", 850,  470);
    
    int countdown = millis() - baseTime;
    if(countdown > 9000){
      playerAnalyze.close();
    }
    if (countdown > 14000){
      nextState = true;
    }
    
    
  }
  
  State decideState() {
    if (keyPressed && keyCode == RIGHT) {
//      playerExpression.close();
//      playerPhoto.close() ;
      playerAnalyze.close();
      return new HandState();
    }else if(keyPressed && keyCode == LEFT){
//      playerExpression.close();
//      playerPhoto.close() ;
      playerAnalyze.close();
      return new ExpressionState();
    }
    
    
    if (nextState) { // if ellapsed time is larger than
      playerAnalyze.close();
      return new HandState(); // go to ending
    } 
    return this;
  }
  
}
