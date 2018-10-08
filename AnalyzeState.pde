class AnalyzeState extends State {
  
  AnalyzeState() {
  }
  
  void drawState() {
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
    text("Surprise", 200, 470);
    text("Yellow", 540, 470);
    text("20cm", 850,  470);
  }
  
  State decideState() {
    if (keyPressed && keyCode == RIGHT) {
//      playerExpression.close();
//      playerPhoto.close() ;
      return new HandState();
    }else if(keyPressed && keyCode == LEFT){
//      playerExpression.close();
//      playerPhoto.close() ;
      return new ExpressionState();
    }
    
    
//    if (nextState) { // if ellapsed time is larger than
////      playerExpression.close();
////      playerPhoto.close() ;
//      return new HandState(); // go to ending
//    } 
    return this;
  }
  
}
