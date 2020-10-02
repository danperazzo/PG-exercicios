float angle = PI/2;
float UC=1;
color GREEN = color(113,184,94);
color RED = color(199, 12, 12);
color BLUE = color(3,119,252);
color BLACK =0;



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
  
  strokeWeight(1);
  stroke(RED); //AXIS X
  line(0,0,1000,0);
  
  stroke(BLUE); // AXIS Y
  line(0,0,0,1000);
  
  stroke(GREEN); // AXIS Z
  line(0,0,0,0,0,1000);
  
  // ENDING VISUALIZER HELP, NOW WILL START DOING THIS QUESTION
  

  
  rotateX(PI/3);
  stroke(BLACK);
  strokeWeight(2);
  rect(0, 0, 200*UC, 200*UC);
  fill(255);
  ellipse(100*UC,100*UC,200*UC,200*UC);
  
  translate(100*UC,100*UC,0);
  rotateZ(angle);
  translate(100*UC,0,0);
  rotateY(PI/2.0);
  translate(25*UC,0,0);
  
  // Drawing the red point in the inner circle
  stroke(RED);
  fill(RED);
  ellipse(-UC*25*cos(-angle*4),UC*25*sin(-angle*4),4*UC,4*UC);
  
  stroke(BLACK);
  noFill();
  ellipse(0,0,50*UC,50*UC);
  
  

  stroke(255);
  noFill();
}
