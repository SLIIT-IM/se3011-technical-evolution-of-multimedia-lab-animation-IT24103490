
int state = 0; 


float px = 350, py = 175;
float step = 6;
float pr = 20;


float hx, hy;
float ease = 0.08;


float ox = 200, oy = 100;
float xs = 3, ys = 2;
float r = 15;


int score = 0;
int startTime;
int duration = 30;


boolean trails = false;

void setup() {
  size(700, 350);

  hx = px;
  hy = py;
}

void draw() {

 
  if (!trails) {
    background(255);
  } else {
    noStroke();
    fill(255,35);
    rect(0, 0, width, height);
  }

  
  if (state == 0) {

    textAlign(CENTER, CENTER);
    textSize(26);
    fill(0);
    text("ORB CATCH GAME", width/2, height/2 - 30);
    textSize(18);
    text("Press ENTER to Start", width/2, height/2 + 10);
  }

  
  if (state == 1) {

  
    int elapsed = (millis() - startTime) / 1000;
    int left = duration - elapsed;

    if (left <= 0) {
      state = 2;
    }

  
    if (keyPressed) {
      if (keyCode == RIGHT) px += step;
      if (keyCode == LEFT)  px -= step;
      if (keyCode == DOWN)  py += step;
      if (keyCode == UP)    py -= step;
    }

    px = constrain(px, pr, width - pr);
    py = constrain(py, pr, height - pr);

   
    ox += xs;
    oy += ys;

    if (ox > width - r || ox < r) xs *= -1;
    if (oy > height - r || oy < r) ys *= -1;

    float d = dist(px, py, ox, oy);

    if (d < pr + r) {

      score++;

     
      ox = random(r, width - r);
      oy = random(r, height - r);

      
      xs *= 1.1;
      ys *= 1.1;
    }

    
    hx = hx + (px - hx) * ease;
    hy = hy + (py - hy) * ease;

   
    fill(16, 120, 200);
    ellipse(px, py, pr*2, pr*2);

  
    fill(180, 100, 120);
    ellipse(hx, hy, 16, 16);

   
    fill(55, 150, 50);
    ellipse(ox, oy, r*2, r*2);

   
    fill(0);
    textSize(15);
    text(" Score: " + score, 20, 20);
    text(" Time: " + left, 20, 40);
    text(" Press T for Trails", 20, 60);
  }

  if (state == 2) {

    textAlign(CENTER, CENTER);
    textSize(26);
    fill(0);
    text(" Game Over!", width/2, height/2 - 20);

    textSize(20);
    text(" Final Score: " + score, width/2, height/2 + 20);
    text(" Press R to Restart", width/2, height/2 + 50);
  }
}


void keyPressed() {

  if (state == 0 && keyCode == ENTER) {
    state = 1;
    startTime = millis();
  }

  
  if (state == 2 && (key == 'r' || key == 'R')) {
    score = 0;
    px = width/2;
    py = height/2;
    ox = random(width);
    oy = random(height);
    xs = 3;
    ys = 2;
    startTime = millis();
    state = 1;
  }

 
  if (key == 't' || key == 'T') {
    trails = !trails;
  }
}
