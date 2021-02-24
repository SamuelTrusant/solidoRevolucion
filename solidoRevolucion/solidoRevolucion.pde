ArrayList<PShape> objs = new  ArrayList<PShape>();

int cameraPos = 1;
int angle = 10;
float[] cameraOptions = {-600/2, 600/2, height+height/2};

FloatList mouseXPos = new FloatList();
FloatList mouseYPos = new FloatList();

boolean objectCreated = false;

float rotStep = 10;


float rotX = 0;
float rotY = 0;
float zoom = 1;

void setup ( ) {
  size(600 , 600 ,P3D) ;
}

void draw ( ) {
  if(objectCreated){
    translate(width/2, height/2,0);
    rotateX(radians(rotX));
    rotateY(radians(rotY));
    scale(zoom);
  }
  
  background (0);

  if(!objectCreated){
    line(width/2,-height,0,width/2,height*2,0);
    PaintLine();
  } else {
    for(int i = 0; i < objs.size(); i++){
      if(objs.get(i) != null)shape(objs.get(i));
    }
  }
}

void PaintLine(){
  stroke(123);
  for(int i = 0; i < mouseXPos.size()-1; i++){
    line(mouseXPos.get(i), mouseYPos.get(i), mouseXPos.get(i+1), mouseYPos.get(i+1));
  }
}

void mousePressed(){
  if(!objectCreated){
    if(mouseX < width/2) return;
    if(mouseButton == LEFT) {
      mouseXPos.append(mouseX);
      mouseYPos.append(mouseY);
    }  
    if(mouseButton == RIGHT){
      mouseXPos.remove(mouseXPos.size()-1);
      mouseYPos.remove(mouseYPos.size()-1);
    }
  }
}

void mouseDragged(){
  if(objectCreated){
    if (mouseButton == LEFT) {
      rotX += (pmouseY - mouseY);
      rotY += (mouseX - pmouseX);
    }
     if (mouseButton == RIGHT) {
            zoom -= (pmouseY - mouseY) * 0.015f;
            if(zoom < 0.1) zoom = 0.1;
        }
  }
}

void keyPressed(){
  if(keyCode == ENTER){
    CreateFigure();
    objectCreated = true;
  }
  
  if(key == 'r'){
    ResetFigure();
  }
  if(objectCreated){
    if(keyCode == UP){
      /*
      cameraPos++;
      switch(cameraPos){
        case 0:
          camera(width/2, height/4, (height/2) / tan(PI/6), width/2, height/2, 0, 0, 1, 0);
          break;
        case 1:
          camera(0, -height/2, 0, width/2, height/2, 0, 0, 1, 0);
          break;
  
        default:
          camera(0, height+height/2, 0, width/2, height/2, 0, 0, 1, 0);
          cameraPos = -1;
          break;
      }*/
      rotX += rotStep;
    }
    if(keyCode == DOWN){
      rotX -= rotStep;
    }
    if(keyCode == RIGHT){
       rotY += rotStep;
    }
    if(keyCode == LEFT){
       rotY -= rotStep;
    }
  }
}

void CreateFigure(){
  /*obj=createShape();
  obj.beginShape(TRIANGLE_STRIP);
  obj.fill(102);
  obj.stroke (255);
  obj.strokeWeight(2);*/
  
  float[] point = new float[3];
  //float[][] currentCol = new float[mouseXPos.size()][3];
  float[] currentColum = new float[3];
  float[] nextColum = new float[3];
  //float[][] prevCol = new float[mouseXPos.size()][3];

//AQUÍ EMPIEZA LAS ITERACIONES DE ROTACIONES

//PUEDES PONER RADIANS(x) PARA PASAR X GRADOS A RADIANES
  float angleRadians = radians(angle);
  
  if(mouseXPos.size() == 0) return;
  for(int j = 0; j < 360/angle; j++){
    float[][] maskY = {{cos(angleRadians * j), 0, sin(angleRadians * j)}, {0, 1, 0}, {-sin(angleRadians * j), 0, cos(angleRadians * j)}};
    float[][] maskY2 = {{cos(angleRadians * j + angleRadians), 0, sin(angleRadians * j + angleRadians)}, {0, 1, 0}, {-sin(angleRadians * j + angleRadians), 0, cos(angleRadians * j + angleRadians)}};

    PShape obj=createShape();
    obj.beginShape(TRIANGLE_STRIP);
    obj.fill(102);
    obj.stroke (255);
    obj.strokeWeight(2);
    for(int i = 0; i < mouseXPos.size(); i++){
      
      point[0] = mouseXPos.get(i) - width/2;
      point[1] = mouseYPos.get(i) - height/2;
      point[2] = 0;
      currentColum[0] = 0;
      currentColum[1] = 0;
      currentColum[2] = 0;
      nextColum[0] = 0;
      nextColum[1] = 0;
      nextColum[2] = 0;


      for(int m = 0; m < point.length; m++){
        for(int n = 0; n < point.length; n++){
          currentColum[m] += point[n] * maskY[n][m];
        }
      }
            
      for(int m = 0; m < point.length; m++){
        for(int n = 0; n < point.length; n++){
          nextColum[m] += point[n] * maskY2[n][m];
        }
      }
      
      obj.vertex(currentColum[0], currentColum[1], currentColum[2]);
      obj.vertex(nextColum[0], nextColum[1], nextColum[2]);
    }
    obj.endShape();
    objs.add(obj);
    //objs[0] = obj;
  }
    
  //mouseXPos = new ArrayList<Float>();
  //mouseYPos = new ArrayList<Float>();
}


void ResetFigure(){
  while(objs.size() > 0){
    objs.remove(0);
  }
  
  mouseXPos = new FloatList();
  mouseYPos = new FloatList();
  rotX = 0;
  rotY = 0;
  zoom = 1;
  objectCreated = false;
}
