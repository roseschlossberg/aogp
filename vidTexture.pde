// Art of Graphics Programming
// Section Example 004: "Storing Geometries: A Generic Approach"
// Example Stage: D (Part C)
// Course Materials by Patrick Hebron

import processing.opengl.*;
import codeanticode.glgraphics.*;
import codeanticode.gsvideo.*;

GSPipeline pipeline;
GSMovie movie;
GLTexture vidTexture, starTexture;
PImage stars, currFrame;

TMesh mesh;

void setup() {
  // In this stage, we add the ability to attach a texture to a TMesh object.
  // This will only display correctly if vertex positions, UVs and normals
  // are properly setup. (See TMesh for more details)
  
   size( 1280, 720, OPENGL);
   stars = loadImage("stars.png");
   movie = new GSMovie(this, "station.mov");
   //starTexture = new GLTexture(this, "stars.png");
   //vidTexture = new GLTexture(this);
   //vidTexture.loadTexture();
 // movie.setPixelDest(vidTexture);
   movie.loop();

   
  
   
   pipeline = new GSPipeline (this, "station.mov");
 
  pipeline.setPixelDest(vidTexture);
  pipeline.play();
  
  // Choose the number of UVs in the mesh
  int meshPointsU = 10;
  int meshPointsV = 10;
  // Choose a size for the mesh
  float sideLength = 500.0;
  float bsWidth = 1280.0;
  float bsHeight = 720.0;
  
  // Using noiseSeed so that we get the same terrain
  // every time we run the program (for comparison with 004DA)
  noiseSeed(25);
  
  // Create new mesh factory
  TMeshFactory meshFactory = new TMeshFactory();
  
  // Create a new mesh object
  mesh = new TMesh();
  // Create terrain
  mesh = meshFactory.createTerrain( meshPointsU, meshPointsV, bsWidth, bsHeight, 0.0, bsWidth/5.0, 8, 0.8 );
  
  // Center the mesh in window
  mesh.setPosition( new PVector( width/2.0, height/2.0, -300.0 ) );
  
  // Set mesh texture
 // mesh.setTexture(starTexture);
  
  mesh.setTexture(vidTexture);
   
}
void pipelineEvent(GSPipeline pipeline){
  if (pipeline.available()== true){
  pipeline.read();

  }
}

//void movieEvent(GSMovie movie){
//  if(movie.available()){
//  movie.read();
//  }
//}

void draw() {
//  
 if(vidTexture.putPixelsIntoTexture()){
    mesh.setTexture(vidTexture);
 }
  
  // Clear window
 
  // Set colors
  stroke( 255, 0, 0 );
  
  // Use lights to show the effect of normals
  // (We'll look at lights more closely in a later example)
  spotLight( 255, 255, 255, mouseX, 100.0, -200.0, 0.0, 1.0, 0.0, HALF_PI, 10.0 );
  directionalLight( 100, 100, 100, 0, 0, -1 );
  
  // Draw the mesh
  mesh.draw();
}
