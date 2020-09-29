color red = color(255, 0, 0);
color green = color(0, 255, 0);
color blue = color(0, 0, 255);

int curve_counter = 1, fps = 60;
float dist = 3600, radius = 20, theta = 180, speed = (180 * radius ) / (fps * 4), w = speed / radius;
float center_x, center_y, pos_x, pos_y, old_pos_x, old_pos_y, old_radius;

void setup() {
  size(640, 640);
  
  // Calculating the axes center
  center_y = height/2;
  center_x = width/2;
  
  // Filling the backgroud with a shade of gray
  background(200);
  
  // Drawing x-axis
  stroke(blue);
  line(0, center_y, width, center_y);
  
  // Drawing y-axis
  stroke(green);
  line(center_x, 0, center_x, height);
  
  stroke(red);
  strokeWeight(1);
  smooth();
  
  frameRate(fps);
  
  old_pos_x = - radius;
  old_pos_y = 0.0;
}

void draw() { 
  // Calculating the new Updating the theta
  theta -= w;
  
  // Calculating the current point position
  pos_x = radius * cos(radians(theta));
  pos_y = radius * sin(radians(theta));
  
  // Recentering the y and x axes and drawing the points in the current trajectory
  translate(center_x, center_y);
  line(old_pos_x, old_pos_y, pos_x, pos_y);
  
  // Updating the old values
  old_pos_x = pos_x;
  old_pos_y = pos_y;

  // Changing the circle if the trajectory crosses the x-axis
  if (crossedOX() == 1){    
    curve_counter += 1;
    
    // Recentering the x-axis to integrate old and new cirlces
    if (curve_counter % 2 == 0){
      center_x -= radius;
    }
    else{
      center_x += radius;
    }
    
    // Calculating the new radius
    radius = 2 * radius;
    
    // Updating values for the new circle
    speed = (180 * radius ) / (fps * 4);   
    pos_x = radius * cos(radians(theta));
    old_pos_x = pos_x;
  }  
}

int crossedOX(){
  if ((theta % 180 == 0.0) || (theta == 0.0))
    return 1;
  return 0;
}
