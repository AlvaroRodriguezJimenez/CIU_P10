
PShader sh3;

void setup() {
  size(600, 600, P2D);
  noStroke();
   
  sh3 = loadShader("shader3.glsl"); 
}


void draw() {
 
  sh3.set("u_resolution", float(width), float(height));
  sh3.set("u_mouse", float(mouseX), float(mouseY));
  sh3.set("u_time", millis() / 1000.0);
  shader(sh3);
  
  
  
  
  rect(0,0,width,height);
}
