
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

// Color channel option
int color_mode = 0;

// Show images options
boolean show_diffuse = false, show_specular = false;


// Function to comput diffuse phong component
void diffusephong(PVector Im, PVector Kd, PVector N, PVector L) {
  
  // Diffuse phong is Ks*(N.L)*Im
  float N_L = max(0.0,N.dot(L));
  
  RGB_im.x = RGB_im.x + N_L*Kd.x*Im.x;
  RGB_im.y = RGB_im.y + N_L*Kd.y*Im.y;
  RGB_im.z = RGB_im.z + N_L*Kd.z*Im.z;
}

// Function to compute specular component of Phong
void specularphong(PVector Im, PVector Ks, PVector N, PVector L, PVector V){
  
  // Compute R = 2*(N.L)*N - L 
  PVector R = PVector.sub(PVector.mult(N,2.0*(max(0.0,N.dot(L)))),L);
  
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
  if (show_specular)
    specularphong(Im,Ks,N, L, V);
  if (show_diffuse)
    diffusephong(Im,Kd,N,L);
}

void change_image(){

  // Iterate on image pixels
  for(int i=0;i<width;i++){
    for(int j=0;j<height;j++){
      
      // Change V vector based on image pixels
      V.x = (float)i - width/2;
      V.y = (float)j - height/2;
      V.z = 1.0;
      
      RGB_im.x = 0.0;
      RGB_im.y = 0.0;
      RGB_im.z = 0.0;
      
      color c_spec = mapSpec.get(i,j);
      color c_base = base.get(i,j);
      color c_norm = mapNorm.get(i,j);
      
      PVector v_spec = new PVector(red(c_spec), green(c_spec), blue(c_spec));
      PVector v_base = new PVector(red(c_base), green(c_base), blue(c_base));
      PVector v_norm = new PVector(red(c_norm), green(c_norm), blue(c_norm));
      
      phong(cur_im, v_spec, v_base, v_norm, direc_light, V);
      color final_color = color(int(RGB_im.x), int(RGB_im.y), int(RGB_im.z));
      finalImage.set(i,j,final_color);          
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
  cur_im = new PVector(1.,1.,1.);
  
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


void keyPressed() {
  if (key == 'R' || key == 'r' || key == 'G' || key == 'g' || key == 'B' || key == 'b'){
    if (color_mode == 0)
      color_mode = key;
    else 
      color_mode = 0;
  }
 
  else if (key == CODED){
    if (color_mode != 0){
      if (keyCode == UP) {
        if (color_mode == 'R' || color_mode == 'r'){
          cur_im.x = min(1.0, cur_im.x+0.1);
        }
        else if (color_mode == 'G' || color_mode == 'g'){
          cur_im.y = min(1.0, cur_im.y+0.1);
        }
        else if (color_mode == 'B' || color_mode == 'b'){
          cur_im.z = min(1.0, cur_im.z+0.1);
        }
      }
      else if (keyCode == DOWN){
        if (color_mode == 'R' || color_mode == 'r'){
          cur_im.x = max(0.0, cur_im.x-0.1);
        }
        else if (color_mode == 'G' || color_mode == 'g'){
          cur_im.y = max(0.0, cur_im.y-0.1);
        }
        else if (color_mode == 'B' || color_mode == 'b'){
          cur_im.z = max(0.0, cur_im.z-0.1);
        }
      }
    }
  }
  
  else if (key == 'D' || key == 'd'){
    show_diffuse = !(show_diffuse);
  }
  
  else if (key == 'S' || key == 's'){
    show_specular = !(show_specular);
  }
}
