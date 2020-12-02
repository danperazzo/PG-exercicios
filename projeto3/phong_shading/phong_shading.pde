  
// Function to comput diffuse phong component
void diffusephong(PVector Im, PVector Kd, PVector N, PVector L) {
  
  // Diffuse phong is Ks*(N.L)*Im
  float N_L = N.dot(L);
  
  RGB_im.x = RGB_im.x + N_L*Kd.x*Im.x;
  RGB_im.y = RGB_im.y + N_L*Kd.y*Im.y;
  RGB_im.z = RGB_im.z + N_L*Kd.z*Im.z;
}

// Function to compute specular component of Phong
void specularphong(PVector Im, PVector Ks, PVector N, PVector L, PVector V){
  
  // Compute R = 2*(N.L)*N - L 
  PVector R = PVector.sub(PVector.mult(N,2.0*N.dot(L)),L);
  
  // Equation is Im*Ks*(R.V)^q, where q=9 
  float R_L =(float)Math.pow((double)R.dot(V),9.0);
  
  
  RGB_im.x = RGB_im.x + Ks.x*R_L*Im.x;
  RGB_im.y = RGB_im.y + Ks.y*R_L*Im.y;
  RGB_im.z = RGB_im.z + Ks.z*R_L*Im.z;
}

// Function to compute Phong
void phong(PVector Im, PVector Ks, PVector Kd, PVector N, PVector L, PVector V){
  
  // Normalize V, N and L. It is necessary to avoid overflow
  V.normalize();
  N.normalize();
  L.normalize();
  
  // Compute Specular and Diffuse Phong. Initialize RGB value as 0 vector and sum vector in functions
  // Phong color = Specular_component + diffuse_component
  RGB_im = new PVector(0.0,0.0,0.0);
  specularphong(Im,Ks,N, L, V);
  //print(RGB_im,"\n");
  diffusephong(Im,Kd,N,L);
  
}

// Initialize texture maps
PImage base;                    // RGB_im
PImage mapNorm;                 // N
PImage mapSpec;                 // Ks

// Initialize final image
PImage finalImage;

// Initialize directional light vector
PVector direc_light;
PVector cur_im;

PVector RGB_im;

// Initialize V vector
PVector V;

int i = 0;
void change_image(){
  
  //int lenImage = width*height;
  //PImage myImage = loadImage("apples.jpg");
  //image(myImage, 0, 0);
  
  //loadPixels();
  //for (int i = 0; i < lenImage; i++) {
  //  pixels[i+lenImage] = pixels[i];
  //}
  //updatePixels();

  // Iterate on image pixels
  for(int i=0;i<width;i++){
    for(int j=0;j<height;j++){
      
      // Change V vector based on image pixels
      V.x = (float)i - width/2;
      V.y = (float)j - height/2;
      V.z = 1.0;
      
      // Now, Nati, change image
      //PVector v_out = new PVector(0.0,0.0,0.0);
      RGB_im.x = 0.0;
      RGB_im.y = 0.0;
      RGB_im.z = 0.0;
      
      PVector v_spec = new PVector(red(mapSpec.get(i,j)), green(mapSpec.get(i,j)), blue(mapSpec.get(i,j)));
      PVector v_base = new PVector(red(base.get(i,j)), green(base.get(i,j)), blue(base.get(i,j)));
      PVector v_norm = new PVector(red(mapNorm.get(i,j)), green(mapNorm.get(i,j)), blue(mapNorm.get(i,j)));
      
      phong(cur_im, v_spec, v_base, v_norm, direc_light, V);
      color final_color = color(int(RGB_im.x), int(RGB_im.y), int(RGB_im.z));
      finalImage.set(i,j,final_color);    
      //print(RGB_im,"\n");
      
    }
  }
}


void setup() {
  
  // Initialize Image and vector
  size(396, 600, P3D);
  camera(width/2.0, height/2.0, (height/2.0) / tan(PI*30.0 / 180.0), width/2.0, height/2.0, 0, 0, 1, 0);
  
  // Load texture images
  base = loadImage("Texturas/char1_d.png");
  mapNorm = loadImage("Texturas/char1_n.png");
  mapSpec = loadImage("Texturas/char1_s.png");
    
  // Initialize Directional light
  direc_light = new PVector(0.0,0.0,1.0);
  cur_im = new PVector(100.0,100.,100.);
  
  // Initialize V vector
  V = new PVector(0.0,0.0,1.0);
  
  RGB_im = new PVector(0.0,0.0,0.0);
  
  // Initialize final image
  finalImage = createImage(396, 600, RGB);
}
      
void draw() {
  // Get directional light from your mouse coordinates
  direc_light.x =  width/2 - mouseX;
  direc_light.y = height/2 - mouseY;
  
  // Change Image based on phong]
  change_image();
  
  // Draw image
  image(finalImage,0,0);
  
}
     
