int levelsTotal = 3;
int levelNumber = 3;
Map[] m = new Map[levelsTotal+1];
Screen s;
int screenNumber = 0;
int startHealth = 100;
Zombie z;
Player p;
int waveNumber = 1;
LevelKoords[] lk = new LevelKoords[levelsTotal+1];
float shopLength = 100;
float pathWidth;
StartButtons[] sb = new StartButtons[levelsTotal+1];


void setup() {
  size(900, 900);
  Start();
}

void Start() {
  for (int i = 0; i < sb.length; i++) {
    sb[i] = new StartButtons(i*width/4, height/2, width/4, width/4, i);
  }
  pathWidth = (width-shopLength)/13;
  for (int i = 0; i < m.length; i++) {
    m[i] = new Map(pathWidth, i, width-shopLength, height, 0, 0);
  }
  s = new Screen();
  for (int i = 0; i < lk.length; i++) {
    if (i == 0) {
      lk[i] = new LevelKoords(0, 0, 0, 0);
    } else if (i == 1) {
      lk[i] = new LevelKoords(0, height*3/4-pathWidth/2, 0, 0);
    } else if (i == 2) {
      lk[i] = new LevelKoords(width/8+pathWidth/2, 0, width, height*3/4+pathWidth/2);
    } else if (i == 3) {
      lk[i] = new LevelKoords(width/2, 0, width/3+pathWidth/2, height);
    }
  }
}

void draw() {
  s.update(screenNumber, levelNumber);
}

void startGame() {
  p = new Player(startHealth);
}

void mouseClicked() {
  if (screenNumber == 0) {
    for (int i = 0; i < sb.length; i++) {
      int tempLevel = sb[i].clicked();
      if (tempLevel != 0) {
        screenNumber = 1;
        levelNumber = tempLevel;
        startGame();
      }
    }
  }
}

void keyPressed() {
  if (key == ENTER) {
    s.startWave(waveNumber, lk[levelNumber].start.x, lk[levelNumber].start.y);
  }
}
