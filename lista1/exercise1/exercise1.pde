float RAIO = 30.0;
float UC = 0.5;
float PARTICLE_OFFSET = ((RAIO * UC) / 2);
float VEL_X = 12.0 * UC, VEL_Y = 10.0 * UC;

color RED = color(255, 0, 0);
color BLUE = color(0, 0, 255);


// A DynamicObject object (i.e., the particle)
DynamicObject particle;

void setup() {
  // Initializing the 390x280 screen and the particle 
  size(375,280);
  noStroke();
  
  particle = new DynamicObject(); 
}

void draw() {  
  // Filling the backgroud with a shade of gray
  background(200);

  // Filling the floor (i.e., bottom half) with red 
  fill(RED);
  rect(0, height*0.5, width, height - height*0.5);
  
  frameRate(30);
    
  // Updating the particle's location
  particle.update();
    
  // Displaying the particle
  particle.display(); 
}

class DynamicObject {
  // The DynamicObject tracks location, velocity, and gravity values 
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
    if (location.x > width - PARTICLE_OFFSET){
      velocity.x = velocity.x * - 1.0;
      location.x = width - PARTICLE_OFFSET;
    }
    else if (location.x < 0. + PARTICLE_OFFSET){
      velocity.x = velocity.x * - 1.0;
      location.x = 0. + PARTICLE_OFFSET;
    }
    if (location.y < (height / 2 - PARTICLE_OFFSET) - 100 * UC){
      velocity.y = velocity.y * -1.0; 
      location.y = (height / 2 - PARTICLE_OFFSET) - 100 * UC;
    }
    if (location.y > height / 2 - PARTICLE_OFFSET){
      velocity.y = velocity.y * -1.0; 
      location.y = height / 2 - PARTICLE_OFFSET;
    }   
  }

  void display() {
    // Displaying a blue particle
    fill(BLUE);
    ellipse(location.x,location.y,RAIO*UC,RAIO*UC);
  }
}
