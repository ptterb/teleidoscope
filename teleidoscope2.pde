import processing.video.*;
import java.awt.*;

Capture cam;
PImage img;
Polygon tri;

int lastMillis;
int angle = 0;

void setup() {
  size(640, 480);
  noStroke();
  background(0);



  cam = new Capture(this, width, height);
  cam.start();
  img = new PImage(width, height);
  img.format = ARGB;

  // Create a triangle for the video to be displayed from camera
  int xPoly[] = new int[3];
  int yPoly[] = new int[3];

  xPoly[0] = width/2 - 100;
  xPoly[1] = width/2;
  xPoly[2] = width/2 + 100;

  yPoly[0] = height/2;
  yPoly[1] = height/2 - 200;
  yPoly[2] = height/2;

  tri = new Polygon(xPoly, yPoly, 3);
}

void draw() {
  background(0);

  // Grab the camera feed
  if (cam.available()) {
    cam.read();	

    for (int x=0; x < width; x++ ) {
      for (int y = 0; y<height; y++) {
        int cIndex = x + y * cam.width;

        if (tri.contains(x, y)) {
          img.pixels[cIndex] = cam.pixels[cIndex];
        } 
        else {
          img.pixels[cIndex] = color(0, 0, 0, 0);
        }
      }
    }
  }

  // Rotate the polygons
  if (millis() - lastMillis > 100) {

    angle++;

    lastMillis = millis();
  }

  //Draw the triangles with the video imposed and rotating
  img.updatePixels();
  translate(width/2, height/2);
  rotate(radians(angle));
  image(img, -img.width/2, -img.height/2, width, height);

  image(img, -img.width/2 + 100, -img.height/2 + 200, width, height);
  image(img, -img.width/2 - 100, -img.height/2 + 200, width, height);

  image(img, -img.width/2 - 200, -img.height/2, width, height);
  image(img, -img.width/2 + 200, -img.height/2, width, height);

  // For the upside-down triangles
  rotate(radians(-180));
  image(img, -img.width/2, -img.height/2, width, height);	

  image(img, -img.width/2 - 200, -img.height/2, width, height);
  image(img, -img.width/2 + 200, -img.height/2, width, height);

  image(img, -img.width/2 - 100, -img.height/2 + 200, width, height);
  image(img, -img.width/2 + 100, -img.height/2 + 200, width, height);
}

