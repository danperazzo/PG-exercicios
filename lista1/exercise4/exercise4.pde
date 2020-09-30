color RED = color(255, 0, 0);
color BLUE = color(0, 0, 255);

int UC = 2,  FPS = 30;
float RADIUS_COUT = 100 * UC, RADIUS_CIN = 25 * UC, RADIUS_CINTER = RADIUS_COUT - RADIUS_CIN;
float VEL = (2 * PI * RADIUS_COUT) / (4 * FPS);
float center_x, center_y, pos_x, pos_y, theta_out = PI / 2, theta_in = PI / 2;

void setup(){
  size(640,480);
  frameRate(FPS); 
}

void draw(){
  // Filling the background with a shade of gray and setting up the configurations for drawing the circles
  background(200);
  stroke(BLUE);
  strokeWeight(1);
  smooth();
  noFill();
  
  // Drawing the outer circle
  ellipse(width/2, height/2, 2*RADIUS_COUT, 2*RADIUS_COUT);
  
  // Updating the center of the inner circle
  translate(width/2, height/2);
  center_x = RADIUS_CINTER * cos(theta_out);
  center_y = -RADIUS_CINTER * sin(theta_out);
  
  // Drawing the inner circle
  ellipse(center_x, center_y, 2*RADIUS_CIN, 2*RADIUS_CIN);
  
  // Updating the position of the contact point
  translate(center_x, center_y);
  pos_x = 0;
  pos_y = -RADIUS_CIN; 
  rotate(theta_in - theta_out);
  
  // Drawing the red point in the inner circle
  stroke(RED);
  fill(RED);
  ellipse(pos_x, pos_y, 3, 3);
  
  // Updating the thetas
  theta_out += (2 * PI) / (4 * FPS);
  theta_in += (2 * PI) / FPS;
}
