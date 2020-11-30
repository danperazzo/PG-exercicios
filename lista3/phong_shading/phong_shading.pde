  
// Compute specular component of Phong rendering
void diffusephong(PVector Im,PVector Kd,PVector N,PVector L, PVector RGB_im) {
  
  float N_L = N.dot(L);
  
  RGB_im.x += N_L*Kd.x*Im.x;
  RGB_im.y += N_L*Kd.y*Im.y;
  RGB_im.z += N_L*Kd.z*Im.z;
}


void specularphong(PVector Im,float Ks,PVector N,PVector L,PVector V, PVector RGB_im){
  
  PVector R = PVector.sub(PVector.mult(N,2.0*N.dot(L)),L);
  
  float R_L =(float)Math.pow((double)R.dot(L),9.0);
  
  RGB_im.x += Ks*R_L*Im.x;
  RGB_im.y += Ks*R_L*Im.y;
  RGB_im.z += Ks*R_L*Im.z;
  
}

void phong(PVector Im,float Ks,PVector Kd,PVector N,PVector L,PVector V, PVector RGB_im){
  
  V.normalize();
  N.normalize();
  L.normalize();
  
  RGB_im = new PVector(0.0,0.0,0.0);
  specularphong(Im,Ks,N, L, V, RGB_im);
  diffusephong(Im,Kd,N,L,RGB_im);
  
}

PImage base;
PImage mapNorm;
PImage mapSpec;


void setup() {
  size(1000, 1000, P3D);
  stroke(255);
  
  base = loadImage("Texturas/char1_d.png");
  mapNorm = loadImage("Texturas/char1_n.png");
  mapSpec = loadImage("Texturas/char1_s.png");
  
  print(base.width);
}
      
void draw() {
  line(150, 25, mouseX, mouseY);
  image(mapSpec,0,0);
  print("iu");
}
     
void mousePressed() {
  background(192, 64, 0);
}
