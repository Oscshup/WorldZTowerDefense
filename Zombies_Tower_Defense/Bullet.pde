class Bullet {
  //Bullets current position
  PVector location;
  //where does the bullet shooting towards
  //How fast Bullet move on screen
  float speed = 4;

  float size = 10;

  int id;

  //bullet velocity
  PVector velocity;



  Bullet(float startX, float startY, int id_) {
    location = new PVector(startX, startY);
    id = id_;
  }


  void update(PVector target) {
    //compute the difference vector (start to end) = direction
    velocity = PVector.sub(target, location);

    //using normalize and multiple
    velocity.setMag(speed);
    //update position based on velocity 
    location.add(velocity);


    //compute rotation angle from velocity
    float angle = velocity.heading();
    pushMatrix();
    translate(location.x, location.y);
    rotate(angle);
    stroke(0);
    line(0, 0, size, 0);
    popMatrix();
  }

 
}
