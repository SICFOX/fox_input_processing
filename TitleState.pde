class TitleState extends State {
  void drawState() {
    //一番最初に呼ばれるクラス
    text("FOX", width * 0.5, height * 0.3);
    text("Press 's' key to start", width * 0.5, height * 0.7);
  }

  State decideState() {
    if (keyPressed && key == 's') { // if 'z' key is pressed
      return new IntroState(); // start game
    }
    return this;
  }
}