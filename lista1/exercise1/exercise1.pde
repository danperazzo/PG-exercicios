color RED = color(255, 0, 0);
color BLUE = color(0, 0, 255);

int FPS = 60;
float UC = 0.25;
float PARTICLE_RADIUS = 30.0 * UC;
float PARTICLE_OFFSET = PARTICLE_RADIUS;
float GRAVITY = -0.5 * UC;
float v0_x = (360 / (2 * FPS)), v0_y = 10.0 * UC;
float s, h, s0, h0, v_y;
int t_1 = 1, t_2 = 1, t0 = millis(), f1= 1;


void setup() {
  size(375,280);
  noStroke();
  
  // Initializing the particle 
  s0 = PARTICLE_OFFSET;
  h0 = -PARTICLE_OFFSET;
  s = s0;
  h = h0;
}

void draw() {  
  // Filling the backgroud with a shade of gray
  background(200);

  // Filling the floor (i.e., bottom half) with red 
  fill(RED);
  rect(0, height/2, width, height - height/2);
  
  frameRate(FPS);
  
  // Drawning the blue particle
  translate(0, height/2);
  fill(BLUE);
  ellipse(s, h, 2 * PARTICLE_RADIUS, 2 * PARTICLE_RADIUS);
  
  
  // Updating the particle's position and vertical velocity
  s = s0 + v0_x * t_1;
  h = h0 - v0_y * t_2 + (1 / 2) * (GRAVITY * pow(t_2,2));
  v_y = v0_y + GRAVITY * t_2;
  
  // Bounce off edges
  if(s >= width - PARTICLE_OFFSET){
    v0_x = v0_x * -1;
    s0 = width - PARTICLE_OFFSET;
    t_1 = 1;
  }
  else if(s <= 0 + PARTICLE_OFFSET){
    v0_x = v0_x * -1;
    s0 = PARTICLE_OFFSET;
    t_1 = 1;
  }
  
  if(v_y == 0){
    v0_y = v0_y * -1;
    h0 = h;
    t_2 = 1;
  }
  else if(h >= 0){
    v0_y = v0_y * -1;
    h0 = -PARTICLE_OFFSET;
    t_2 = 1;
  }
  
  // Updating the internal times (used to calculate the current particle's position)
  t_1 += 1;
  t_2 += 1;
}
