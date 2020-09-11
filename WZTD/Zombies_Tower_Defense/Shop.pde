class Shop {
  PImage shopImg;
  PImage shopCoins;
  PImage s1;
  PImage s2;
  // PImage s3;
  PImage l1;
  PImage l2;
  PImage sp1;




  int money;
  int off = 50;
  Shop(int cur_) {
    money = cur_;
    shopImg = loadImage("shop.png");
    shopCoins = loadImage("coins.png");
    s1  = loadImage("Handgun.gif");
    s2  = loadImage("AR.png");
    l1 = loadImage("rifle.png");
    l2 = loadImage("Plane.png");
    sp1 = loadImage("Mine.png");
    shopCoins.resize(50, 50);
    s1.resize(50, 50);
    s2.resize(50, 50);
    l1.resize(50, 50);
    l2.resize(50, 50);
    sp1.resize(50, 50);
    shopImg.resize(int(shopLength), height+off);
  }

  void mouseClicked() {
    
    
  }

  void display() {
    //  fill(155,100,1);
    // rect(width-200,0,200,height);
    image(shopImg, width-shopLength, -off);
    ;

    image(shopCoins, width-shopLength+45, 175);
    image(s1, width-shopLength+45, 225);
    image(s2, width-shopLength+45, 275);
    image(l1, width-shopLength+45, 375);
    image(l2, width-shopLength+45, 425);
    image(sp1, width-shopLength+45, 525);
    textSize(32);
    fill(0);
    text("SHOP", width-shopLength+shopLength/3, 150);
    text(money, width-shopLength+shopLength/2, 210);
    //    text(t.price,width-shopLength+shopLength/2,210);
  }
}
