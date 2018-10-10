class ThanksState extends State {
  void drawState() {
    background(29,175,241);
    image(img, 440,280,129,143);
    textFont(text, 72);  
    textAlign(LEFT);
    text("Thank you very much", 215, 500);
    textAlign(CENTER);
  }

  State decideState() {
    if (keyPressed && keyCode == RIGHT) { 
      return new TitleState();
    }
    if (keyPressed && keyCode == LEFT) { 
      return new WaitState();
    }
    return this;
  }
}
