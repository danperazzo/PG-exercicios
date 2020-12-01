color RED = color(199, 12, 12);
color BLUE = color(3,119,252);

int FPS = 60, TRAJECTORY_X = 360;
float UC = 0.25;
float PARTICLE_RADIUS = 30.0 * UC;
float PARTICLE_OFFSET = PARTICLE_RADIUS;
float GRAVITY = (-0.5 * UC);
float V0_X = (TRAJECTORY_X / (2 * FPS)), V0_Y = 10.0 * UC;
float s, h, s0, h0, v_y, v_x;

void setup() {
  size(375,280);
  noStroke();
  frameRate(FPS);
  
  // Initializing the particle 
  s0 = PARTICLE_OFFSET;
  h0 = -PARTICLE_OFFSET;
  s = s0;
  h = h0;
  v_x = V0_X;
  v_y = V0_Y;
}

void draw() {  
  // Filling the backgroud with a shade of gray
  background(200);

  // Filling the floor (i.e., bottom half) with red 
  fill(RED);
  rect(0, height/2, width, height - height/2);
    
  // Drawning the blue particle
  translate(0, height/2);
  fill(BLUE);
  ellipse(s, h, 2 * PARTICLE_RADIUS, 2 * PARTICLE_RADIUS);
  
  // Updating the particle's position 
  s += v_x;
  h -= v_y;
  
  // Updating the vertical velocity
  v_y += GRAVITY;
   
  // Bounce off edges
  if(s >= width - PARTICLE_OFFSET){
    v_x = v_x * -1;
    s0 = width - PARTICLE_OFFSET;
  }
  else if(s <= 0 + PARTICLE_OFFSET){
    v_x = v_x * -1;
    s0 = PARTICLE_OFFSET;
  }
  
  if(h >= 0 - PARTICLE_OFFSET){
    v_y = V0_Y;
    h0 = -PARTICLE_OFFSET;
  }
}
