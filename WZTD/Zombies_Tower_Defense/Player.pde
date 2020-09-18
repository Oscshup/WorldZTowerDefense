class Player {

  float health;

  int current;
  PImage[] img;

  Player(float health_, PImage[] tempImage) {
    health = health_;
    current = 0;
    img = tempImage;
    for (int i = 0; i < img.length; i++) {
      img[i].resize(50, 50);
    }
  }

  void update() {
    live();
    if (health <= 0) {
      die();
    }
  }

  void die() {
    screenNumber = 2;
    if(waveNumber > highScore){
      highScore = waveNumber;
      highScoreText = "New HighScore: " + highScore;
    }  else {
      highScoreText = "New HighScore: " + highScore;
    }
    String[] highScoreList = new String[1];
    highScoreList[0] = str(highScore);
    saveStrings("HighScore.txt", highScoreList);
  }


  void live() {
    textSize(30);
    fill(255);
    textAlign(CENTER);  
    text(int(health), width-130, height/2-300);
    image(img[current], width-200, height/2-330);
  }
}
