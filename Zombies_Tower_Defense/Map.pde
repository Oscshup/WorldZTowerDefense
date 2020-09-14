class Map {
  
  int level;
  float xMax;
  float yMax;
  float xStart;
  float yStart;
  float pW;
  
  color brown = color(117,75,13);

  Map(float pW_, int level_, float xMax_, float yMax_, float xStart_, float yStart_) {
    level = level_;
    xStart = xStart_;
    yStart = yStart_;
    xMax = xMax_;
    yMax = yMax_;
    pW = pW_;
  }

  void display() {
    noStroke();
    fill(brown);
    rectMode(CENTER);
          
    if (level == 3) {
      rect(xStart+(xMax-xStart)/2, yStart+(yMax/3-yStart)/2, pW, yMax/3-yStart);
      rect(xStart+xMax/8+pW/2+((xMax/2-pW/2)-xMax/8)/2, yStart+yMax/3+(yMax/3+pW-yMax/3)/2, (xMax/2-pW/2)-xMax/8+pW, pW);
      rect(xStart+xMax/8+pW/2, yStart+yMax/3+(yMax*2/3-yMax/3)/2, pW, yMax*2/3-yMax/3);
      rect(xStart+xMax/8+(xMax*2/3+pW-xMax/8)/2, yStart+yMax*2/3-pW/2, xMax*2/3+pW-xMax/8, pW);
      rect(xStart+xMax*2/3+pW/2, yStart+pW*3/2+(yMax*2/3-pW*3/2)/2, pW, yMax*2/3-pW*3/2);
      rect(xStart+xMax*2/3+(xMax-xMax/10-xMax*2/3)/2, yStart+pW*3/2+pW/2, xMax-xMax/10-xMax*2/3, pW);
      rect(xStart+xMax-xMax/10-pW/2, yStart+pW*3/2+(yMax*2/3+pW*5/2-pW*3/2)/2, pW, yMax*2/3+pW*5/2-pW*3/2);
      rect(xStart+xMax/3+(xMax-xMax/10-xMax/3)/2, yStart+yMax*2/3+pW*2, xMax-xMax/10-xMax/3, pW);
      rect(xStart+xMax/3+pW/2, yStart+yMax*2/3+pW*3/2+(yMax-(yMax*2/3+pW*3/2))/2, pW, yMax-(yMax*2/3+pW*3/2));
    }
    else if(level == 2){
      rect(xMax/8+pW/2, yStart+(yMax*3/4+pW-yStart)/2, pW, yMax*3/4+pW-yStart);
      rect(xMax/8+(xMax/2-xMax/8)/2, yMax*3/4+pW/2, xMax/2-xMax/8, pW);
      rect(xMax/2-pW/2, yMax/4-pW+(yMax*3/4+pW-(yMax/4-pW))/2, pW, yMax*3/4+pW-(yMax/4-pW));
      rect(xMax/2-pW+(xMax*3/4+pW-(xMax/2-pW))/2, yMax/4-pW/2, xMax*3/4+pW-(xMax/2-pW), pW);
      rect(xMax*3/4+pW/2, yMax/4-pW+(yMax/2-(yMax/4-pW))/2, pW, yMax/2-(yMax/4-pW));
      rect(xMax/2+pW*3/2+(xMax*3/4-(xMax/2+pW*3/2))/2, yMax/2-pW/2, xMax*3/4-(xMax/2+pW*3/2), pW);
      rect(xMax/2+pW*2, yMax/2-pW+(yMax*3/4+pW-(yMax/2-pW))/2, pW, yMax*3/4+pW-(yMax/2-pW));
      rect(xMax/2+pW*3/2+(xMax-(xMax/2+pW*3/2))/2, yMax*3/4+pW/2, xMax-(xMax/2+pW*3/2), pW);
    } 
    else if(level == 1){
      rect(xStart+(xMax/7-xStart)/2, yMax*3/4+pW/2, xMax/7-xStart, pW);
      rect(xMax/7-pW/2, pW +(yMax*3/4+pW-pW)/2, pW, yMax*3/4+pW-pW);
      rect(xMax/7-pW+(xMax-pW/2-(xMax/7-pW))/2, pW*3/2, xMax-pW/2-(xMax/7-pW), pW);
      rect(xMax-pW, pW+(yMax/2-pW)/2, pW, yMax/2-pW);
      rect(xMax/2+(xMax-pW/2-xMax/2)/2, yMax/2-pW/2, xMax-pW/2-xMax/2, pW);
      rect(xMax/2+pW/2, yMax/2-pW+(pW*4-(yMax/2-pW))/2, pW, pW*4-(yMax/2-pW));
      rect(xMax/7+pW*3/2+(xMax/2+pW-(xMax/7+pW*3/2))/2, pW*7/2, xMax/2+pW-(xMax/7+pW*3/2), pW);
      rect(xMax/7+pW*2, pW*3+(yMax/2+5*pW/2-pW*3)/2, pW, yMax/2+5*pW/2-pW*3);
      rect(xMax/7+pW*3/2+(xMax/2+pW-(xMax/7+pW*3/2))/2, yMax/2+pW*2, xMax/2+pW-(xMax/7+pW*3/2), pW);
      rect(xMax/2+pW/2, yMax/2+3*pW/2+(yMax*3/4+pW-(yMax/2+3*pW/2))/2, pW, yMax*3/4+pW-(yMax/2+3*pW/2));
      rect(xMax/2+(xMax-xMax/2)/2, yMax*3/4+pW/2, xMax-xMax/2, pW);
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
