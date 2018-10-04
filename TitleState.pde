class TitleState extends State {
  void drawState() {
    //一番最初に呼ばれるクラス
    text("FOX", width * 0.5, height * 0.3);
//    text("Press 's' key to start", width * 0.5, height * 0.7);
    image(img, width * 0.4 + 14,height * 0.4-28,100,110);
  }

  State decideState() {
    if (keyPressed && keyCode == RIGHT) { 
      return new IntroState();
    }
    return this;
  }
}
