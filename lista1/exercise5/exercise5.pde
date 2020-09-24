float angle = 0;


void setup() {
  size(700, 400, P3D);
}

void draw() {
  
  angle += 0.01*PI;
  
  background(0);
  rotateY(PI/3);
  translate(width/2, height/2, -100);
  rect(0, 0, 400, 400);
  ellipse(200,200,200,200);
  
  pushMatrix();
  translate(200,200,0);
  rotateZ(angle);
  translate(100,0,0);
  rotateY(PI/2.0);
  translate(-25,0,0);
  
  ellipse(25*sin(angle),25*cos(angle),5,5);
  ellipse(0,0,50,50);
  
  popMatrix();
  stroke(255);
  noFill();
}
