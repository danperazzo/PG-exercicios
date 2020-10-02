float angle = 0;
float UC=1;
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
  translate(width/2, height/2, -150);
  rotateX(PI/2-PI/4);
  rotateZ(PI/2+PI/6);
  rotateX(PI/2);
  
  stroke(RED); //AXIS X
  line(0,0,1000,0);
  
  stroke(BLUE); // AXIS Y
  line(0,0,0,1000);
  
  stroke(GREEN); // AXIS Z
  line(0,0,0,0,0,1000);
  
  // ENDING VISUALIZER HELP, NOW WILL START DOING THIS QUESTION
  
  pushMatrix();
  
  rotateX(PI/3);
  stroke(BLACK);
  rect(0, 0, 200*UC, 200*UC);
  ellipse(100*UC,100*UC,100*UC,100*UC);
  
  translate(100*UC,100*UC,0);
  rotateZ(angle);
  translate(50*UC,0,0);
  rotateY(PI/2.0);
  translate(25*0.5*UC,0,0);
  
  // Drawing the red point in the inner circle
  stroke(RED);
  fill(RED);
  ellipse(UC*25*0.5*sin(-angle*4),UC*25*0.5*cos(-angle*4),2,2);
  
  stroke(BLACK);
  noFill();
  ellipse(0,0,25*UC,25*UC);
  
  
  popMatrix();
  stroke(255);
  noFill();
}
