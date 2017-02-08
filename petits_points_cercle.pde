int diametre;
float circleCenterX;
float circleCenterY;
boolean draw = true;
float ellipseSizeX, ellipseSizeY;

void setup() {
  fullScreen();
  //size(1000, 1000, P3D);
  //diametre = width/10 * 4;
  diametre = 530;
  circleCenterX = width/2;
  circleCenterY = height/2;
  ellipseSizeX = random(width);
  ellipseSizeY = random(height);
  background(255);
  noStroke();
  fill(0);
}
void draw() {
  ellipse(ellipseSizeX, ellipseSizeY, 8, 8);

  if (draw) {
    for (int i = 0; i<5500; i++) {
      float x1 = random(width);
      float y1 = random(height);
      float chance = map(dist(x1, y1, ellipseSizeX, ellipseSizeY), 0, sqrt((width*width)+(height*height)), 50, 5000);
      if (int(random(chance+1)%chance) == 0) {
        if (dist(x1, y1, circleCenterX, circleCenterY)<diametre) {
          //float size = map(dist(x1, y1, ellipseSizeX, ellipseSizeY), 0, sqrt((width*width)+(height*height)), 0.3, 5);
          float size = random(8, 12);
          //float size = 7;
          ellipse(x1, y1, size, size);
        }
      }
    }
  }
}

void mouseClicked() {
  background(255);  
  ellipseSizeX = random(width);
  ellipseSizeY = random(height);
}

void keyPressed() {
  if (key == CODED) {
    if (keyCode == UP) {
      draw = !draw;
    }
  }
}