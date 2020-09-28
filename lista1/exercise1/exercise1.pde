static float DIAMETRO = 60.0, UC = 0.25, ANG = 90.0;
float PARTICLE_OFFSET = (DIAMETRO*UC)/2;
float VEL = 10.0 * UC;
float VEL_X = VEL*3*cos(ANG), VEL_Y = VEL*sin(ANG);

// A DynamicObject object (i.e., the particle)
DynamicObject particle;

void setup() {
  // Initializing the 370x280 screen and the particle 
  size(373,280);
  particle = new DynamicObject(); 
}

void draw() {  
  // Filling the backgroud with a shade of gray
  background(200);

  // Filling the floor (i.e., bottom half) with red 
  color red = color(255, 0, 0);
  fill(red);
  rect(0, height*0.5, width, height - height*0.5);
  
  frameRate(50);
    
  // Displaying the particle
  particle.display(); 
  
  // Updating the particle's location
  particle.update();
}

class DynamicObject {

  // The DynamicObject tracks location, velocity, and acceleration 
  PVector location;
  PVector velocity;
  PVector gravity;

  DynamicObject() {
    // Starting in the left corner and on the floor
    location = new PVector(0. + PARTICLE_OFFSET, height/2 - PARTICLE_OFFSET);
    velocity = new PVector(VEL_X,VEL_Y);
    gravity = new PVector(0.,-0.5 * UC);
  }

  void update() {   
    // Location changes by velocity
    location.add(velocity);
    
    // Add gravity to velocity
    velocity.add(gravity);
        
    // Bounce off edges
    if ((location.x > width) || (location.x < 0)) {
      velocity.x = velocity.x * - 1.0;
    }
    if (location.y < height / 4){
      velocity.y = velocity.y * -1.0; 
      location.y = height / 4 + PARTICLE_OFFSET;
    }
    else if (location.y > height / 2){
      velocity.y = velocity.y * -1.0; 
      location.y = height / 2 - PARTICLE_OFFSET;
    }
  }

  void display() {
    // Displaying a blue particle
    color blue = color(0, 0, 255);
    stroke(0);
    strokeWeight(1);
    fill(blue);
    ellipse(location.x,location.y,DIAMETRO*UC,DIAMETRO*UC);
  }

}
