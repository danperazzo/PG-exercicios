float angle = 0;


void setup() {
  size(640, 360, P3D);
}

void draw() {
  
  angle += 0.01*PI;
  
  background(0);
  rotateY(PI/3);
  translate(width/2, height/2, -100);
  rect(0, 0, 200, 200);
  ellipse(100,100,100,100);
  
  pushMatrix();
  translate(100 + 50*cos(angle),100 + 50*sin(angle),0);
  
  ellipse(0,0,20,20);
  
  popMatrix();
  stroke(255);
  noFill();
}
