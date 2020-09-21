float angle = 0;




void setup()
{
  size(600, 600);
  smooth();
  frameRate(30);  
}

void draw()
{
  background(255);
  
  angle -= 0.01*PI;
  
  translate(width/2,height/2);
  rotate(angle);
  ellipse(0,0,2,2);
  ellipse(0,20,2,2);
  
  pushMatrix();
  translate(0,20);
  rotate(angle*2.0);
  
  ellipse(0,40,2,2);
  translate(0,-20);
  popMatrix();
}
