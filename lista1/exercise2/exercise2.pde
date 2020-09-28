float angle = 0;
float velocity = (1/60.0)*(PI/6.0);

void setup()
{
  size(600, 600);
  smooth();
  frameRate(30);  
}

void draw()
{
  background(255);
  
  angle -= velocity;
  
  translate(width/2,height/2);
  rotate(angle);
  ellipse(0,0,2,2);
  line(0,0,0,20);
  ellipse(0,20,2,2);
  
  if(angle<=-PI/6){
    angle = 0;
  }
  
  pushMatrix();
  translate(0,20);
  rotate(angle*2.0);
  line(0,50,0,0);
  ellipse(0,50,2,2);
  translate(0,-20);
  popMatrix();
}
