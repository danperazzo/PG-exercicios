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
  translate(100,100,0);
  rotateZ(angle);
  translate(50,0,0);
  rotateY(PI/2.0);
  translate(-50,0,0);
  
  ellipse(50*sin(angle),50*cos(angle),5,5);
  ellipse(0,0,100,100);
  
  popMatrix();
  stroke(255);
  noFill();
}
