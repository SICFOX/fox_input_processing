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
    text("The expression is ", 180, 400);
    text("The color is ", 500, 400);
    text("The size is ", 820, 400);
    textAlign(LEFT);
    textFont(text, 80);  
    if (orangeFlag){
      text("Joy", 60, 470);
      text("Orange", 420, 470);
    }else if (blueFlag){
      text("Sorrow",60, 470);
      text("Blue", 420, 470);
    }else if (redFlag){
      text("Anger", 60, 470);
      text("Red", 420, 470);
    }else if (yellowFlag){
      text("Surprise", 60, 470);
      text("Yellow", 420, 470);
    }
    text("20cm", 740,  470);
    
    textAlign(CENTER);
    
    int countdown = millis() - baseTime;
    if(countdown > 9000){
      playerAnalyze.close();
    }
    if (countdown > 13000){
      nextState = true;
    } 
  }
  
  State decideState() {
    if (keyPressed && keyCode == RIGHT) {
      playerAnalyze.close();
      return new HandState();
    }else if(keyPressed && keyCode == LEFT){
      playerAnalyze.close();
      return new ExpressionState();
    }
    if (nextState) { 
      playerAnalyze.close();
      return new HandState(); 
    } 
    return this;
  }
  
}
