class StartButtons {

  float x;
  float y;
  float w;
  float h;
  int level;

  StartButtons(float x_, float y_, float w_, float h_, int level_) {
    x = x_;
    y = y_;
    w = w_-10;
    h = h_-10;
    level = level_;
    if (level != 0) {
      levelImages[level] = loadImage("Level" + level + ".JPG");
      levelImages[level].resize(int(w-5), int(h-5));
    }
  }

  void display() {
    if (level != 0) {
      stroke(0);
      strokeWeight(5);
      noFill();
      rectMode(CENTER);
      rect(x, y, w, h);
      imageMode(CENTER);
      image(levelImages[level], x, y);
      int textSize = 30;
      textSize(textSize);
      textAlign(CENTER);
      fill(0);
      String textStartLevel = "Level: " + level;
      text(textStartLevel, x, y-h/2-textSize);
    }
  }

  int clicked() {
    if (mouseX >= x-w/2 && mouseX <= x+w/2) {
      if (mouseY >= y-h/2 && mouseY <= y+h/2) {
        return level;
      }
    }
    return 0;
  }
}
