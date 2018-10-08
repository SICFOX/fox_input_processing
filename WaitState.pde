class WaitState extends State {
  AudioPlayer playerWait;
  
  WaitState() {
   playerWait = minim.loadFile("wait.mp3");
   waitFlag = true;
   orange.noLoop();
   blue.noLoop();
   red.noLoop();
   yellow.noLoop();
   if(orangeFlag){
     orange.loop();
     orange.volume(0);
   }
   if(blueFlag){
      blue.loop();
      blue.volume(0);
    }
   if(redFlag){
     red.loop();
     red.volume(0);
   }
   if(yellowFlag){
     yellow.loop();
     yellow.volume(0);
   }
  }
  
  void drawState() {
    background(29,175,241);
    fill(255);
    
    
    playerWait.play();
    if(orangeFlag){image(orange, 260,140,760,640); }
    if(blueFlag){image(blue, 260,140,760,640);}
    if(redFlag){image(red, 260,140,760,640);}
    if(yellowFlag){image(yellow, 260,140,760,640);}
    
    image(img, 181,80,77,86);
    textFont(text, 48);  
    text("Please wait a minute", 600, 140);
    textAlign(LEFT);
    textFont(text, 40);  
    text("The expression is ", 100, 248);
    text("The color is ", 100, 420);
    text("The size is ", 100, 600);
    
    textFont(text, 80);  
    if (orangeFlag){
      text("Joy", 100, 320);
      text("Orange", 100, 500);
    }else if (blueFlag){
      text("Sorrow", 100, 320);
      text("Blue", 100, 500);
    }else if (redFlag){
      text("Anger", 100, 320);
      text("Red", 100, 500);
    }else if (yellowFlag){
      text("Surprise", 100, 320);
      text("Yellow", 100, 500);
    }
    text("22cm", 100, 680);
    
    textAlign(CENTER);
    
    if (waitFlag == true){
      String s = "senddata";
      client.write(s);
      waitFlag = false;
    }
  }

  State decideState() {
    if (keyPressed && keyCode == RIGHT) {
      orange.noLoop();
      blue.noLoop();
      red.noLoop();
      yellow.noLoop();
      playerWait.close();
      return new ThanksState();
    }else if(keyPressed && keyCode == LEFT){
      orange.noLoop();
      blue.noLoop();
      red.noLoop();
      yellow.noLoop();
      playerWait.close() ;
      return new HandState();
    }
    
    return this;
  }
}
