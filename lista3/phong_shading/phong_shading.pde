  
// Function to comput diffuse phong component
void diffusephong(PVector Im,PVector Kd,PVector N,PVector L, PVector RGB_im) {
  
  // Diffuse phong is Ks*(N.L)*Im
  float N_L = N.dot(L);
  
  RGB_im.x += N_L*Kd.x*Im.x;
  RGB_im.y += N_L*Kd.y*Im.y;
  RGB_im.z += N_L*Kd.z*Im.z;
}

// Function to compute specular component of Phong
void specularphong(PVector Im,float Ks,PVector N,PVector L,PVector V, PVector RGB_im){
  
  // Compute R = 2*(N.L)*N - L 
  PVector R = PVector.sub(PVector.mult(N,2.0*N.dot(L)),L);
  
  // Equation is Im*Ks*(R.V)^9
  float R_L =(float)Math.pow((double)R.dot(V),9.0);
  
  
  RGB_im.x += Ks*R_L*Im.x;
  RGB_im.y += Ks*R_L*Im.y;
  RGB_im.z += Ks*R_L*Im.z;
  
}

// Function to compute Phong
void phong(PVector Im,float Ks,PVector Kd,PVector N,PVector L,PVector V, PVector RGB_im){
  
  // Normalize V, N and L. It is necessary
  V.normalize();
  N.normalize();
  L.normalize();
  
  // Compute Specular and Diffuse Phong. Initialize RGB value as 0 vector and sum vector in functions
  // Phong color = Specular_component + diffuse_component
  RGB_im = new PVector(0.0,0.0,0.0);
  specularphong(Im,Ks,N, L, V, RGB_im);
  diffusephong(Im,Kd,N,L,RGB_im);
  
}

// Initialize texture maps
PImage base;
PImage mapNorm;
PImage mapSpec;

// Initialize final image
PImage finalImage;

// Initialize directional light vector
PVector direc_light;

void setup() {
  
  // Initialize Image and vector
  size(396, 600, P3D);
  camera(width/2.0, height/2.0, (height/2.0) / tan(PI*30.0 / 180.0), width/2.0, height/2.0, 0, 0, 1, 0);
  
  // Load texture images
  base = loadImage("Texturas/char1_d.png");
  mapNorm = loadImage("Texturas/char1_n.png");
  mapSpec = loadImage("Texturas/char1_s.png");
    
  // Initialize Directional light
  direc_light = new PVector(0.0,0.0,0.0);
  
  // Initialize final image
  finalImage = createImage(396, 600, RGB);
  
}
      
void draw() {
  
  // Get directional light from your mouse coordinates
  direc_light.x =  width/2 - mouseX;
  direc_light.y = height/2 - mouseY;
  
  // Print for debugging
  print(direc_light);
  print("\n");
}
     
