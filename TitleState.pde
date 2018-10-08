class TitleState extends State {
  void drawState() {
    //一番最初に呼ばれるクラス
    
   
    //text(表示文字列, x座標, y座標)
    //text("Hi I'm FOX", width * 0.5, height * 0.3);
//    text("Press 's' key to start", width * 0.5, height * 0.7);
    image(logo_text,334,495,327,65);
    image(img, 387,196,215,239);
    
    //image(test, 0, 0, 1000, 750);
  }

  State decideState() {
    if (keyPressed && keyCode == RIGHT) { 
      return new IntroState();
    }
    return this;
  }
}
