class TitleState extends State {
  void drawState() {
    //一番最初に呼ばれるクラス
    
    textFont(text, 72); 
    //text(表示文字列, x座標, y座標)
    text("Hi I'm FOX", width * 0.5, height * 0.3);
//    text("Press 's' key to start", width * 0.5, height * 0.7);
    image(img, width * 0.4 + 14,height * 0.4-28,100,110);
    
    image(test, 0, 0, 1000, 750);
  }

  State decideState() {
    if (keyPressed && keyCode == RIGHT) { 
      return new IntroState();
    }
    return this;
  }
}
