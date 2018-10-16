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
      fill(255,150,80);
      ellipse(500,350,150,150);
      fill(255);
      image(joy_image,100,270,150,150);
      text("Joy", 60, 570);
      text("Orange", 420, 570);
    }else if (blueFlag){
      fill(137,252,254);
      ellipse(500,350,150,150);
      fill(255);
      image(sorrow_image,100,270,150,150);
      text("Sorrow",60, 570);
      text("Blue", 420, 570);
    }else if (redFlag){
      fill(250,135,192);
      ellipse(500,350,150,150);
      fill(255);
      image(anger_image,100,270,150,150);
      text("Anger", 60, 570);
      text("Red", 420, 570);
    }else if (yellowFlag){
//      fill(255,233,100);
      fill(123,239,94);
      ellipse(500,350,150,150);
      fill(255);
      image(smile_image,100,270,150,150);
      text("Surprise", 60, 570);
      text("Green", 420, 570);
    }
    text(str(random_size)+"cm", 740,  570); 
    
    image(bottle_image, 740,270,150,150);
    
    textAlign(CENTER);
    
    int countdown = millis() - baseTime;
    if(countdown > 8400){
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
