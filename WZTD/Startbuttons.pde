class StartButtons {
  
  float x;
  float y;
  float w;
  float h;
  int level;
  
  StartButtons(float x_, float y_, float w_, float h_, int level_){
    x = x_;
    y = y_;
    w = w_;
    h = h_;
    level = level_;
  }
  
  void display(){
    stroke(0);
    strokeWeight(5);
    noFill();
    rectMode(CENTER);
    rect(x, y, w, h);
  }
  
  int clicked(){
    if(mouseX >= x-w/2 && mouseX <= x+w/2){
      if(mouseY >= y-h/2 && mouseY <= y+h/2){
        return level;
      }
    }
    return 0;
  }
  
}
