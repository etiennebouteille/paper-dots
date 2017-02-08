int diametre = 700;
float noiseSeed;
int noiseSegment;
int lastNoiseSegment;
int a = 255;
int LINE_LENGTH = 150;
int DPF = 10; //Draw Per Frame
boolean bgDraw = true;
int[] lastZone;
boolean drawOnce = true;

public void setup() {
  size(800, 1000);
  //fullScreen();
  background(255);
  noStroke();
  fill(0);
  noiseSeed = random(2000);
  lastZone = new int[width];
  for (int i = 0; i < lastZone.length; i++) {
    lastZone[i] = 3;                
  }
}

public void draw() {
  if (drawOnce) {
    background(255);

    //draw_bg();    //used for debugging zones

    for (int i = 0; i < height; i++) {
      for (int j = 0; j < width; j+= 7) {
        float posX = j;
        float posY = i;
        int zone = get_zone(posX, posY);
        if (zone != lastZone[j]) {
          drawLine(posX, posY, zone, j);
        }
        lastZone[j] = zone;
      }
    }
    drawOnce = false;
  }
}

public void mouseClicked() {
  background(255);
  bgDraw = !bgDraw;
  noiseSeed = random(2000);
  println(noiseSeed);
  drawOnce = true;
  for (int i = 0; i < lastZone.length; i++) {
    lastZone[i] = 3;
  }
}

public void drawLine(float xPos, float yPos, int startingZone, int startHeight) {
  float size = 6;
  float spacing = 3;
  yPos += 7;                                                               //évite la superposition avec la ligne du dessus
  for (int i = 0; i<LINE_LENGTH; i++) {
    int zone = get_zone(xPos, yPos);
    if (zone == startingZone) {
      if ((dist(xPos, yPos, width/2, height/2) > diametre/2)) {
        fill(255);
      } else {
        fill(0);
      }
      ellipse(xPos, yPos, size, size);
    } else {
      i = LINE_LENGTH;
    }
    yPos += spacing;
    //yPos++;
    //xPos += sin((startHeight + i) * 0.007);
    spacing *= 1.06;
  }
}

int get_zone(float x, float y) {                                          //takes x and y coordinates and returns in which "zone" the pixel is
  float noise =  noise(x * 0.0023 + noiseSeed, y*0.011 + noiseSeed);
  int zone = 0;
  if (noise <= 0.4f) {
    zone = 0;
  } else if (noise > 0.4f && noise <= 0.6f) {
    zone = 1;
  } else {
    zone = 2;
  }
  return zone;
}

void draw_bg() {                                                          //dessine les différentes zones en rgb
  for (int i = 0; i<150000; i++) {                                       
    float pointX  = random(width);
    float pointY = random(height);
    int zone = get_zone(pointX, pointY);
    if (zone == 0) {
      fill(255, 0, 0);
    } else if (zone == 1) {
      fill(0, 255, 0);
    } else {
      fill(0, 0, 255);
    }
    if (dist(pointX, pointY, width/2, height/2) < diametre/2) {
      ellipse(pointX, pointY, 5, 5);
    }
  }
  bgDraw = false;
}