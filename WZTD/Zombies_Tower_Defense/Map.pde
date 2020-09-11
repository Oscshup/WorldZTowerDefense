class Map {
  
  int level;
  float xMax;
  float yMax;

  Map(float xMax_, float yMax_, int level_) {
    level = level_;
    xMax = xMax_;
    yMax = yMax_;
  }

  void display() {

    stroke(0);
    strokeWeight(3);
    if (level == 3) {
      line(xMax/2-pathWidth/2, 0, xMax/2-pathWidth/2, yMax/3);
      line(xMax/2+pathWidth/2, 0, xMax/2+pathWidth/2, yMax/3+pathWidth);
      
      line(xMax/2-pathWidth/2, yMax/3, xMax/8, yMax/3);
      line(xMax/2+pathWidth/2, yMax/3+pathWidth, xMax/8+pathWidth, yMax/3+pathWidth);
      
      line(xMax/8, yMax/3, xMax/8, yMax*2/3);
      line(xMax/8+pathWidth, yMax/3+pathWidth, xMax/8+pathWidth, yMax*2/3-pathWidth);
      
      line(xMax/8, yMax*2/3, xMax*2/3+pathWidth, yMax*2/3);
      line(xMax/8+pathWidth, yMax*2/3-pathWidth, xMax*2/3, yMax*2/3-pathWidth);
      
      line(xMax*2/3+pathWidth, yMax*2/3, xMax*2/3+pathWidth, pathWidth*5/2);
      line(xMax*2/3, yMax*2/3-pathWidth, xMax*2/3, pathWidth*3/2);
      
      line(xMax*2/3+pathWidth, pathWidth*5/2, xMax-xMax/10-pathWidth, pathWidth*5/2);
      line(xMax*2/3, pathWidth*3/2, xMax-xMax/10, pathWidth*3/2);
      
      line(xMax-xMax/10-pathWidth, pathWidth*5/2, xMax-xMax/10-pathWidth, yMax*2/3+pathWidth*3/2);
      line(xMax-xMax/10, pathWidth*3/2, xMax-xMax/10, yMax*2/3+pathWidth*5/2);
      
      line(xMax-xMax/10-pathWidth, yMax*2/3+pathWidth*3/2, xMax/3, yMax*2/3+pathWidth*3/2);
      line(xMax-xMax/10, yMax*2/3+pathWidth*5/2, xMax/3+pathWidth, yMax*2/3+pathWidth*5/2);
      
      line(xMax/3, yMax*2/3+pathWidth*3/2, xMax/3, yMax);
      line(xMax/3+pathWidth, yMax*2/3+pathWidth*5/2, xMax/3+pathWidth, yMax);
    }
    else if(level == 2){
      line(xMax/8,0,xMax/8,yMax*3/4+pathWidth);
      line(xMax/8+pathWidth, 0, xMax/8+pathWidth, yMax*3/4);
      
      line(xMax/8, yMax*3/4+pathWidth, xMax/2, yMax*3/4+pathWidth);
      line(xMax/8+pathWidth, yMax*3/4, xMax/2-pathWidth, yMax*3/4);
      
      line(xMax/2, yMax*3/4+pathWidth, xMax/2, yMax/4);
      line(xMax/2-pathWidth, yMax*3/4, xMax/2-pathWidth, yMax/4-pathWidth);
      
      line(xMax/2, yMax/4, xMax*3/4, yMax/4);
      line(xMax/2-pathWidth, yMax/4-pathWidth, xMax*3/4+pathWidth, yMax/4-pathWidth);
      
      line(xMax*3/4, yMax/4, xMax*3/4, yMax/2-pathWidth);
      line(xMax*3/4+pathWidth, yMax/4-pathWidth, xMax*3/4+pathWidth, yMax/2);
      
      line(xMax*3/4, yMax/2-pathWidth, xMax/2+pathWidth*3/2, yMax/2-pathWidth);
      line(xMax*3/4+pathWidth, yMax/2, xMax/2+pathWidth*5/2, yMax/2);
      
      line(xMax/2+pathWidth*3/2, yMax/2-pathWidth, xMax/2+pathWidth*3/2, yMax*3/4+pathWidth);
      line(xMax/2+pathWidth*5/2, yMax/2, xMax/2+pathWidth*5/2, yMax*3/4);
      
      line(xMax/2+pathWidth*3/2, yMax*3/4+pathWidth, xMax, yMax*3/4+pathWidth);
      line(xMax/2+pathWidth*5/2, yMax*3/4, xMax, yMax*3/4);
    } else if(level == 1){
      line(0,yMax*3/4+pathWidth, xMax/7, yMax*3/4+pathWidth);
      line(0,yMax*3/4, xMax/7-pathWidth, yMax*3/4);
      
      line(xMax/7, yMax*3/4+pathWidth, xMax/7, pathWidth*2);
      line(xMax/7-pathWidth, yMax*3/4, xMax/7-pathWidth, pathWidth);
      
      line(xMax/7, pathWidth*2, xMax-pathWidth*3/2, pathWidth*2);
      line(xMax/7-pathWidth, pathWidth, xMax-pathWidth/2, pathWidth);
      
      line(xMax-pathWidth*3/2, pathWidth*2, xMax-pathWidth*3/2, yMax/2-pathWidth);
      line(xMax-pathWidth/2, pathWidth, xMax-pathWidth/2, yMax/2);
      
      line(xMax-pathWidth*3/2, yMax/2-pathWidth, xMax/2+pathWidth, yMax/2-pathWidth);
      line(xMax-pathWidth/2, yMax/2, xMax/2, yMax/2);
      
      line(xMax/2+pathWidth, yMax/2-pathWidth, xMax/2+pathWidth, pathWidth*3);
      line(xMax/2, yMax/2, xMax/2, pathWidth*4);
      
      line(xMax/2+pathWidth, pathWidth*3, xMax/7+pathWidth*3/2, pathWidth*3);
      line(xMax/2, pathWidth*4, xMax/7+pathWidth*5/2, pathWidth*4);
      
      line(xMax/7+pathWidth*3/2, pathWidth*3, xMax/7+pathWidth*3/2, yMax/2+5*pathWidth/2);
      line(xMax/7+pathWidth*5/2, pathWidth*4, xMax/7+pathWidth*5/2, yMax/2+3*pathWidth/2);
      
      line(xMax/7+pathWidth*3/2, yMax/2+5*pathWidth/2, xMax/2, yMax/2+5*pathWidth/2);
      line(xMax/7+pathWidth*5/2, yMax/2+3*pathWidth/2, xMax/2+pathWidth, yMax/2+3*pathWidth/2);
      
      line(xMax/2, yMax/2+5*pathWidth/2, xMax/2, yMax*3/4+pathWidth);
      line(xMax/2+pathWidth, yMax/2+3*pathWidth/2, xMax/2+pathWidth, yMax*3/4);
      
      line(xMax/2, yMax*3/4+pathWidth, xMax, yMax*3/4+pathWidth);
      line(xMax/2+pathWidth, yMax*3/4, xMax, yMax*3/4);
    }
  }
}

class LevelKoords{
  
  PVector start;
  PVector end;
  
  LevelKoords(float xStart_, float yStart_, float xEnd_, float yEnd_){
    start = new PVector(xStart_, yStart_);
    end = new PVector(xEnd_, yEnd_);
  }
}
