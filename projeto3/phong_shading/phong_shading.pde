
// Texture maps
PImage base;                    // Kd
PImage mapNorm;                 // N
PImage mapSpec;                 // Ks

PImage finalImage;              // Final image
PVector final_img;              // Phong's output
PVector direc_light;            // Directional light vector
PVector Im;                     // Light intensity
PVector V;                      // V vector

int color_mode = 0;                                   // Change the light color option
boolean show_diffuse = true, show_specular = true;    // Show images options
PFont f;                                              // Declare PFont variable for text displays
String output_message = "Difuse + Specular";          // Output message with the displayed result, for debugging purpose


// Function to comput diffuse phong component
void diffusephong(PVector Im, PVector Kd, PVector N, PVector L) {
  
  // Diffuse phong is Ks*(N.L)*Im
  float N_L = max(0.0,N.dot(L));
  
  // Adding diffuse component to the current final image
  final_img.x = constrain(final_img.x + N_L*Kd.x*Im.x,0,255);
  final_img.y = constrain(final_img.y + N_L*Kd.y*Im.y,0,255);
  final_img.z = constrain(final_img.z + N_L*Kd.z*Im.z,0,255);
}

PVector reflect(PVector dir, PVector normal){
  PVector norm = normal.normalize(); // make sure normal is normalized
  return dir.sub( norm.mult(2*dir.dot(norm)) );
}

// Function to compute specular component of Phong
void specularphong(PVector Im, PVector Ks, PVector N, PVector L, PVector V){
  
  // Compute R = 2*(N.L)*N - L 
  PVector incident = PVector.mult(L, -1);
  PVector R = reflect(incident, N);
  
  // Equation is Im*Ks*(R.V)^q, where q=9 
  float R_L =(float)Math.pow((double)R.dot(V),9.0);
  
  // Adding specular component to the current final image
  final_img.x = constrain(final_img.x + Ks.x*R_L*Im.x,0,255);
  final_img.y = constrain(final_img.y + Ks.y*R_L*Im.y,0,255);
  final_img.z = constrain(final_img.z + Ks.z*R_L*Im.z,0,255);
}

// Function to compute Phong
void phong(PVector Im, PVector Ks, PVector Kd, PVector N, PVector L, PVector V){
  
  // Normalize V, N, L, and Im. It is necessary to avoid overflow
  V.normalize();
  N.normalize();
  L.normalize();
  PVector cur_Im = new PVector(Im.x, Im.y, Im.z);
  cur_Im.normalize();
  
  // final_img = ambient_component, where ambient_component = 0
  final_img.x = 0.0;
  final_img.y = 0.0;
  final_img.z = 0.0;

  
  // Adding diffuse and specular components to the ambient  if they have not been disabled
  // final_img = ambient_component + diffuse_component + specular_component 
  if (show_diffuse){
    diffusephong(cur_Im,Kd,N,L);
  }
  if (show_specular){
    specularphong(cur_Im,Ks,N, L, V);
  }
}

void change_image(){

  // Iterate on image pixels
  for(int i=0;i<width;i++){
    for(int j=0;j<height;j++){
      
      // Change V vector based on image pixels
      V.x = ((float)2*i/width - 1);
      V.y = (float)2*j/height - 1;
      V.z = 1.0;
      
      // Getting the color value from the current pixel in each one of the three input textures
      color c_spec = mapSpec.get(i,j);
      color c_base = base.get(i,j);
      color c_norm = mapNorm.get(i,j);
      
      // Getting the Ks, Kd, and N current values (for each one of the image's color channel)
      PVector v_spec = new PVector(red(c_spec), green(c_spec), blue(c_spec));
      PVector v_base = new PVector(red(c_base), green(c_base), blue(c_base));
      PVector v_norm = new PVector(red(c_norm), green(c_norm), blue(c_norm));
      
      // generating the final image using the Phong algorithm
      phong(Im, v_spec, v_base, v_norm, direc_light, V);
      color final_color = color(int(final_img.x), int(final_img.y), int(final_img.z));
      finalImage.set(i,j,final_color);          
    }
  }
}


void setup() {
  
  // Initialize Image and vector
  size(396, 600, P3D);
  camera(width/2.0, height/2.0, (height/2.0) / tan(PI*30.0 / 180.0), width/2.0, height/2.0, 0, 0, 1, 0);
  
  // Load texture images
  base = loadImage("Texturas/char2_d.png");
  mapNorm = loadImage("Texturas/char2_n.png");
  mapSpec = loadImage("Texturas/char2_s.png");
    
  // Initialize Directional light
  direc_light = new PVector(0.0,0.0,1.0);
  Im = new PVector(255.,255.,255.);
  
  // Initialize V vector
  V = new PVector(0.0,0.0,1.0);
  
  // Initialize the output of the Phong algorithm with the ambient component
  final_img = new PVector(0.0,0.0,0.0);
  
  // Initialize final image
  finalImage = createImage(396, 600, RGB);
  
  // Create a Font
  f = createFont("Lucida Sans",16,true); 
}
      
void draw() {
  // Get directional light from your mouse coordinates
  direc_light.x =  width/2 - mouseX;
  direc_light.y = height/2 - mouseY;
  
  // Change the final image using the Phong algorithm
  change_image();
  
  // Display the final image
  image(finalImage,0,0);  
  
  writeText();
}


// Some interation are possible via keyboard keys
void keyPressed() {
  // Change the light color channels (R or r = red, G or g = green, B or b = blue)
  if (key == 'R' || key == 'r' || key == 'G' || key == 'g' || key == 'B' || key == 'b'){
    if (color_mode == 0)
      color_mode = key;
    else 
      color_mode = 0;
  }
 
 // If the change color mode is on, the user may alter the value with the UP and DOWN keys
  else if (key == CODED){
    if (color_mode != 0){
      if (keyCode == UP) {
        if (color_mode == 'R' || color_mode == 'r'){
          Im.x = min(255.0, Im.x+10);
        }
        else if (color_mode == 'G' || color_mode == 'g'){
          Im.y = min(255.0, Im.y+10);
        }
        else if (color_mode == 'B' || color_mode == 'b'){
          Im.z = min(255.0, Im.z+10);
        }
      }
      else if (keyCode == DOWN){
        if (color_mode == 'R' || color_mode == 'r'){
          Im.x = max(0.0, Im.x-10);
        }
        else if (color_mode == 'G' || color_mode == 'g'){
          Im.y = max(0.0, Im.y-10);
        }
        else if (color_mode == 'B' || color_mode == 'b'){
          Im.z = max(0.0, Im.z-10);
        }
      }
    }
  }
  
  // Disable/Enable the diffuse component 
  else if (key == 'D' || key == 'd'){
    show_diffuse = !(show_diffuse);
  }
  
  // Disable/Enable the specular component
  else if (key == 'S' || key == 's'){
    show_specular = !(show_specular);
  }
}

// Display the debug text in the canvas
void writeText(){
  if (show_diffuse && show_specular){
    output_message = "Diffuse + Specular";
  }
  else if (show_diffuse){
    output_message = "Diffuse Only";
  }
  else if (show_specular){
    output_message = "Specular Only";
  }
  else{
    output_message = "None";
  }
  
  textFont(f);       
  fill(255);
  textAlign(RIGHT);
  text(output_message,185,40); 
  
  if ((Im.x != 255. || Im.y != 255. || Im.z != 255.) &&  output_message != "None"){
       output_message = "(Light Color:[" + Im.x + "," + Im.y + "," + Im.z + "])";
       text(output_message,215,60); 
    }
}
