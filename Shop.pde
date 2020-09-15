class Shop {
  PImage shopImg;
  PImage shopCoins;
  PImage sr1;
  PImage sr2;
  PImage sr3;
  PImage lr1;
  PImage lr2;
  PImage lr3;
  PImage sp1;  
  PImage sp2;
  PImage sp3;

  int money;
  int off = 50;

  Shop(int cur_) {
    money = cur_;
    shopImg = loadImage("shop.png");
    shopCoins = loadImage("coins.png");
    sr1  = loadImage("Handgun.gif");
    sr2  = loadImage("AR.png");
    sr3 = loadImage("sentry.png");
    lr1 = loadImage("rifle.png");
    lr2 = loadImage("Plane.png");
    lr3 = loadImage("Missile.png");
    //sp1 = loadImage("BLANK.png");
    sp2 = loadImage("Mine.png");
    sp3 = loadImage("supplyDropIcon.png");



    shopCoins.resize(50, 50);
    sr1.resize(50, 50);
    sr2.resize(50, 50);
    sr3.resize(50, 50);
    lr1.resize(50, 50);
    lr2.resize(50, 50);
    lr3.resize(50, 50);
    // sp1.resize(50, 50);
    sp2.resize(50, 50);
    sp3.resize(50, 50);
    shopImg.resize(int(shopLength), height+off);
  }

  void mouseClicked() {
  }

  void display() {
    //  fill(155,100,1);
    // rect(width-200,0,200,height);

    imageMode(CORNER);
    image(shopImg, width-shopLength, -off);
    image(shopCoins, width-shopLength+45, 175);
    image(sr1, width-shopLength+45, 225);
    image(sr2, width-shopLength+45, 275);
    image(sr3, width-shopLength+45, 325);
    image(lr1, width-shopLength+45, 375);
    image(lr2, width-shopLength+45, 425);
    image(lr3, width-shopLength+45, 475);
    //   image(sp1, width-shopLength+45, 525);
    image(sp2, width-shopLength+45, 575);
    image(sp3, width-shopLength+45, 625);
    textSize(32);
    fill(0);
    text("SHOP", width-shopLength+shopLength/3, 150);
    text(money, width-shopLength+shopLength/2, 210);
    for (int i = 0; i < t.size(); i++) {
      text(t.get(i).p, width-shopLength+shopLength/2, 270+i*60);
    }
  }
}
