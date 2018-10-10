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
    text("The expression is ", 180, 500);
    text("The color is ", 500, 500);
    text("The size is ", 820, 500);
    textAlign(LEFT);
    textFont(text, 80);  
    if (orangeFlag){
      text("Joy", 60, 570);
      text("Orange", 420, 570);
    }else if (blueFlag){
      text("Sorrow",60, 570);
      text("Blue", 420, 570);
    }else if (redFlag){
      text("Anger", 60, 570);
      text("Red", 420, 570);
    }else if (yellowFlag){
      text("Surprise", 60, 570);
      text("Yellow", 420, 570);
    }
    text("20cm", 740,  570);
    
    fill(255,150,80);
    image(smile_image,100,270,150,150);
    image(bottle_image, 740,270,150,150);
    ellipse(500,350,150,150);
    fill(255);
    
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
