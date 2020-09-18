class Loading {
  int num = 10;
  float scl = 2;
  float[] l = new float[num];
  float  lSize, lMaxSize = 80*scl;
  float posX = width*2, posY = height*2;
  float lLength;


  void startL() {
    for (int i=0; i< l.length; i++) {
      l[i] = PI/8*i;
    }
  }


  void display() {
    background(0);
    lSize = lMaxSize;
    for (float s : l) {
      lLength = random(PI/2, 2*PI/2);
      fill(0);
      color c = color(random(100, 255), 0, 0);
      stroke(c);
      arc(posX, posY, lSize, lSize, s, s+lLength);
      lSize-=10 * scl;
    }
    for (int i=0; i<l.length; i++) {
      l[i]+=PI/4;
    }
  }
}
