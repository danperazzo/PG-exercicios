float angle = 0;
float velocity = (1/60.0)*(PI/6.0);
float UC = 20;
color BLUE = color(3,119,252);
void setup()
{
  size(600, 600);
  smooth();
  frameRate(30);  
}

void draw()
{
  background(BLUE);
  
  angle -= velocity;
  
  translate(width/2,height/2);
  rotate(angle);
  
  
  stroke(0);
  strokeWeight(5);
  line(0,0,0,2*UC);

  noStroke();
  fill(255);
  ellipse(0,0,UC*0.5,UC*0.5);
  
  
  if(angle<=-PI/6){
    angle = 0;
  }
  
  pushMatrix();
  translate(0,2*UC);
  rotate(angle*2.0);
  
  stroke(0);
  strokeWeight(5);
  line(0,3*UC,0,0);
  
  noStroke();
  ellipse(0,0,UC*0.5,UC*0.5);
  
  ellipse(0,3*UC,UC*0.5,UC*0.5);
  popMatrix();
}
