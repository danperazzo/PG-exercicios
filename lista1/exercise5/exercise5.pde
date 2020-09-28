float angle = 0;
float scale=0.25;


void setup() {
  size(700, 400, P3D);
}

void draw() {
  
  angle += 0.01*PI;
  
  background(0);
  rotateX(PI/3);
  translate(width/2, height/2, -100);
  rect(0, 0, 400*scale, 400*scale);
  ellipse(200*scale,200*scale,200*scale,200*scale);
  
  pushMatrix();
  translate(200*scale,200*scale,0);
  rotateZ(angle);
  translate(100*scale,0,0);
  rotateY(PI/2.0);
  translate(-25*scale,0,0);
  
  ellipse(scale*25*sin(angle),scale*25*cos(angle),1,1);
  ellipse(0,0,50*scale,50*scale);
  
  popMatrix();
  stroke(255);
  noFill();
}
