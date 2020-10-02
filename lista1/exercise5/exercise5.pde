float angle = 0;
float scale=0.5;
color RED = color(255, 0, 0);
color BLUE = color(0, 0, 255);
color GREEN = color(0, 255, 0);
color BLACK = color(0, 0, 0);



void setup() {
  size(700, 400, P3D);
}

void draw() {
  
  angle += 0.01*PI;
  
  
  background(255);
  // JUST DOING SOME TRANSFORMATIONS TO AID VISUALIZATIONS
  translate(width/2, height/2, -100);
  rotateY(PI/3);
  rotateZ(PI/3-0.1);
  rotateZ(PI/3+PI/6);
  
  stroke(GREEN); //AXIS X
  line(0,0,1000,0);
  
  stroke(RED); // AXIS Y
  line(0,0,0,1000);
  
  stroke(BLUE); // AXIS Z
  line(0,0,0,0,0,1000);
  
  // ENDING VISUALIZER HELP, NOW WILL START DOING THIS QUESTION
  
  pushMatrix();
  
  rotateX(PI/3);
  stroke(BLACK);
  rect(0, 0, 400*scale, 400*scale);
  ellipse(200*scale,200*scale,200*scale,200*scale);
  
  translate(200*scale,200*scale,0);
  rotateZ(angle);
  translate(100*scale,0,0);
  rotateY(PI/2.0);
  translate(25*scale,0,0);
  
  // Drawing the red point in the inner circle
  stroke(RED);
  fill(RED);
  ellipse(scale*25*sin(-angle*4),scale*25*cos(-angle*4),2,2);
  
  stroke(BLACK);
  noFill();
  ellipse(0,0,50*scale,50*scale);
  
  
  popMatrix();
  stroke(255);
  noFill();
}
