class ExpressionState extends State {
  AudioPlayer playerExpression;
  
  ExpressionState() {
    playerExpression = minim.loadFile("face_expression.mp3");
  }
  
  void drawState() {
    //3番目最初に呼ばれるクラス
    text("Please show your face", width * 0.5, height * 0.5);
    playerExpression.play();
    text("Press 'h' to restart.", width * 0.5, height * 0.7);
  }

  State decideState() {
    if (keyPressed && key == 'h') { // if ellapsed time is larger than
      playerExpression.close() ;
      return new HandState(); // go to ending
    } 
    return this;
  }
}