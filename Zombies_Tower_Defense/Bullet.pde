class Bullet {
  //Bullets current position
  PVector location;
  //where does the bullet shooting towards
  PVector target;
  //How fast Bullet move on screen
  float speed = 2;
  
  float size = 20;


  //bullet velocity
  PVector velocity;



  Bullet(float startX, float startY, float endX, float endY) {
    location = new PVector();
    target = new PVector();

    location.set(startX, startY);
    target.set(endX, endY);

    //compute the difference vector (start to end) = direction
    velocity = PVector.sub(target, location);

    //using normalize and multiple
    velocity.setMag(speed);
  }


  void update() {
    //update position based on velocity 
    location.add(velocity);
    
    
    //compute rotation angle from velocity
    float angle = velocity.heading();
    pushMatrix();
    translate(location.x,location.y);
    rotate(angle);
    stroke(0);
    color(#FF0000);
    line(0,0,size,0);
    popMatrix();
  }
}
