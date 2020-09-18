class TowerMenu {
  float damage;
  float range;
  float fireRate;
  float blastRadius;

  PImage skillPointImg;

  int damageLevel = 1;
  int rangeLevel = 1;
  int fireRateLevel = 1;
  int blastRadiusLevel = 1;
  float[] upgrades;
  int[] cost;
  float boxW = 160;
  float boxH = (m[levelNumber].yMax-m[levelNumber].yStart)/5-20-20;

  float damageIncrease = 1.5;
  float rangeIncrease = 1.3;
  float fireRateIncrease = 0.8;
  float blastRadiusIncrease = 1.5;

  int id;
  int sellPrice;

  Tower tower;

  PVector location;
  PVector buttonLocation;
  PVector buttonSize;

  PVector[] upgradeButtonLocation;
  PVector[] upgradeButtonSize;

  PVector sellButtonLocation;
  PVector sellButtonSize;

  TowerMenu(int sellPrice_, int id_, float damage_, float range_, float fireRate_, float blastRadius_) {
    id = id_;
    sellPrice = sellPrice_;
    skillPointImg = loadImage("Skill.png");
    skillPointImg.resize(30, 30);
    for (int i = 0; i < listT.size(); i++) {
      if (listT.get(i).id == id) {
        tower = listT.get(i);
        break;
      }
    }
    damage = damage_;
    range = range_;
    fireRate = fireRate_;
    blastRadius = blastRadius_;
    if (blastRadius != 0) {
      upgrades = new float[4];
      cost = new int[4];
      upgradeButtonLocation = new PVector[4];
      upgradeButtonSize = new PVector[4];
      for (int i = 0; i < upgrades.length; i++) {
        if (i == 0) {
          upgrades[i] = damage;
          cost[i] = 10;
        } else if (i == 1) {
          upgrades[i] = range;
          cost[i] = 10;
        } else if (i == 2) {
          upgrades[i] = fireRate;
          cost[i] = 10;
        } else if (i == 3) {
          upgrades[i] = blastRadius;
          cost[i] = 50;
        }
      }
    } else {
      upgrades = new float[3];
      cost = new int[3];
      upgradeButtonLocation = new PVector[3];
      upgradeButtonSize = new PVector[3];
      for (int i = 0; i < upgrades.length; i++) {
        if (i == 0) {
          upgrades[i] = damage;
          cost[i] = 10;
        } else if (i == 1) {
          upgrades[i] = range;
          cost[i] = 10;
        } else if (i == 2) {
          upgrades[i] = fireRate;
          cost[i] = 10;
        }
      }
    }

    location = new PVector(m[levelNumber].xStart+(m[levelNumber].xMax-m[levelNumber].xStart)/2, m[levelNumber].yMax-(m[levelNumber].yMax-m[levelNumber].yStart)/5/2);
    buttonLocation = new PVector(location.x, location.y - ((m[levelNumber].yMax-m[levelNumber].yStart)/5)/2 - 10);
    buttonSize = new PVector(width-(width-shopLength/5), height/(100/7)-10);

    for (int i = 0; i < upgradeButtonLocation.length; i++) {
      upgradeButtonLocation[i] = new PVector(20+i*(boxW+10)+boxW/2, location.y+boxH/4);
      upgradeButtonSize[i] = new PVector(buttonSize.x+20, buttonSize.y);
    }
  }

  void onClick() {
    if (mouseX >= sellButtonLocation.x-sellButtonSize.x && mouseX <= sellButtonLocation.x+sellButtonSize.x && mouseY >= sellButtonLocation.y-sellButtonSize.y && mouseY <= sellButtonLocation.y+sellButtonSize.y) {
      shop.money+=sellPrice;
      for(int i = listT.size()-1; i >= 0; i--){
        if(listT.get(i).id == id){
          listT.remove(i);
          break;
        }
      }
    } else {
      for (int i = 0; i < upgrades.length; i++) {
        if (skillPoints >= cost[i]) {
          if (mouseX >= upgradeButtonLocation[i].x - upgradeButtonSize[i].x && mouseX <= upgradeButtonLocation[i].x + upgradeButtonSize[i].x) {
            if (mouseY >= upgradeButtonLocation[i].y - upgradeButtonSize[i].y && mouseX <= upgradeButtonLocation[i].y + upgradeButtonSize[i].y) {
              skillPoints-=cost[i];
              cost[i]*=2;
              sellPrice+=cost[i]*10;
              if (i == 0) {
                upgrades[i]*=damageIncrease;
                tower.damage*=damageIncrease;
              } else if (i == 1) {
                upgrades[i]*=rangeIncrease;
                tower.range*=rangeIncrease;
              } else if (i == 2) {
                upgrades[i]*=fireRateIncrease;
                tower.fireRate*=fireRateIncrease;
              } else if (i == 3) {
                upgrades[i]*=blastRadiusIncrease;
                tower.blastRadius*=blastRadiusIncrease;
              }
            }
          }
        }
      }
    }
  }

  void display() {
    displayMenu();
    displaySellButton();
    displayBoxes();
  }
  void displaySellButton() {
    fill(200); 
    stroke(0, 120, 0); 
    strokeWeight(5); 
    rectMode(CENTER); 
    sellButtonLocation = new PVector(location.x + ((m[levelNumber].xMax-m[levelNumber].xStart)-20)/2-110, location.y + ((m[levelNumber].yMax-m[levelNumber].yStart)/5-20)/2 - 35);
    sellButtonSize = new PVector(buttonSize.x+100, buttonSize.y);
    rect(sellButtonLocation.x, sellButtonLocation.y, sellButtonSize.x, sellButtonSize.y, 15, 15, 15, 15); 
    fill(0); 
    textSize(18); 
    String textSell = "Sell for " + sellPrice;
    ; 
    textAlign(CENTER); 
    text(textSell, location.x + ((m[levelNumber].xMax-m[levelNumber].xStart)-20)/2-125, location.y + ((m[levelNumber].yMax-m[levelNumber].yStart)/5-20)/2 - 30);
    imageMode(CENTER);
    image(shop.shopCoins, location.x + ((m[levelNumber].xMax-m[levelNumber].xStart)-20)/2-50, location.y + ((m[levelNumber].yMax-m[levelNumber].yStart)/5-20)/2 - 35, 30, 30);
  }
  void displayMenu() {
    rectMode(CENTER); 
    stroke(0); 
    fill(0, 200, 0, 200); 
    rect(location.x, location.y, (m[levelNumber].xMax-m[levelNumber].xStart)-20, (m[levelNumber].yMax-m[levelNumber].yStart)/5-20, -10, -10, -10, -10); 
    fill(0, 200, 0, 200); 
    rect(location.x, location.y, (m[levelNumber].xMax-m[levelNumber].xStart)-20, (m[levelNumber].yMax-m[levelNumber].yStart)/5); 
    fill(0); 
    rect(location.x, location.y, (m[levelNumber].xMax-m[levelNumber].xStart), (m[levelNumber].yMax-m[levelNumber].yStart)/5-20); 
    fill(200); 
    stroke(0, 120, 0); 
    strokeWeight(5); 
    rectMode(CENTER); 
    rect(buttonLocation.x, buttonLocation.y, buttonSize.x, buttonSize.y, 15, 15, 15, 15); 
    fill(0); 
    textSize(18); 
    String textDown = "Close"; 
    textAlign(CENTER); 
    text(textDown, buttonLocation.x, buttonLocation.y+5);

    String textSkillPoints = "You Have " + skillPoints;
    textSize(20);
    fill(200);
    textAlign(CORNER);
    text(textSkillPoints, location.x + ((m[levelNumber].xMax-m[levelNumber].xStart)-20)/2-180, location.y - ((m[levelNumber].yMax-m[levelNumber].yStart)/5-20)/2+40);
    imageMode(CENTER);
    image(skillPointImg, location.x + ((m[levelNumber].xMax-m[levelNumber].xStart)-20)/2-35, location.y - ((m[levelNumber].yMax-m[levelNumber].yStart)/5-20)/2+30);
  }
  void displayBoxes() {
    for (int i = 0; i < upgrades.length; i++) {
      rectMode(CENTER);
      fill(150, 200);
      stroke(50);
      strokeWeight(3);
      rect(20+boxW/2+i*(boxW+10), location.y, boxW, boxH, 10, 10, 10, 10);
      fill(0);
      textSize(15);
      textAlign(CORNER);
      String upgradeText1 = "";
      if (i == 0) {
        upgradeText1 = "Damage\nUpgrade cost: " + cost[0];
      } else if (i == 1) {
        upgradeText1 = "Range\nUpgrade cost: " + cost[1];
      } else if (i == 2) {
        upgradeText1 = "Fire-Rate\nUpgrade cost: " + cost[2];
      } else if (i == 3) {
        upgradeText1 = "Blast-Radius\nUpgrade cost: " + cost[3];
      } 
      text(upgradeText1, 20+i*(boxW+10)+5, location.y-boxH/2+20);
      imageMode(CORNER);
      image(skillPointImg, 20+i*(boxW+10)+boxW-25, location.y-boxH/2+20); 
      imageMode(CENTER);

      fill(0, 200, 0); 
      stroke(0, 120, 0); 
      strokeWeight(5); 
      rectMode(CENTER); 
      rect(upgradeButtonLocation[i].x, upgradeButtonLocation[i].y, upgradeButtonSize[i].x, upgradeButtonSize[i].y, 15, 15, 15, 15);
      fill(0);
      textSize(15);
      textAlign(CENTER);
      String upgradeText2 = "Upgrade!";
      text(upgradeText2, upgradeButtonLocation[i].x, upgradeButtonLocation[i].y+5);
    }
  }
}
