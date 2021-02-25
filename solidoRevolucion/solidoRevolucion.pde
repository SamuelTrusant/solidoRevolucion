//import gifAnimation.*;

//array con las tiras del objeto
ArrayList<PShape> objs = new  ArrayList<PShape>();

//angulo en el que se divide la figura
int angle = 10;

//posiciones del ratón
FloatList mouseXPos = new FloatList();
FloatList mouseYPos = new FloatList();

//entero que controla el modo del programa: 0 pantalla inicio; 1 modo dibujo; 2 modo vista
int mode = 0;

//entero para guardar el modo al abrir la ayuda
int prevMode = 1;

// variables para rotar y escalar la figura
float rotX = 0;
float rotY = 0;
float zoom = 1;

//GifMaker gifExport;

String m = "Dibuja una linea seleccionando puntos con el botón izquierdo del ratón para crear el perfil.\n\nPuedes borrar el último punto con el botón derecho del ratón.\n\nPulsa \"enter\" para crear la figura.\n\nEn el modo vista manten el botón izquierdo del ratón para rotar la figura y el derecho para escalarla.\n\nPuedes pulsar la tecla 'h' en cualquier momento para ver esta pantalla de ayuda y puedes pulsar la tecla 'r' para resetear la figura.";


void setup ( ) {
  size(800 , 800 ,P3D) ;
  
  //gifExport = new GifMaker(this, "export.gif");
  //gifExport.setRepeat(0);
}

void draw ( ) {
  background (0);

  //pantalla de inicio
  if(mode == 0){
    stroke(123);
    line(width/2,-height,0,width/2,height*2,0);
    textSize(32);
    text("sólido de revolución", width/2 - 150, 60); 
    textSize(16);
    text(m, width/4 - 150, height/2 - 200, 300, 500); 
    textSize(18);
    text("Pulsa \"Enter\" para seguir",width/4 * 3 - 100, height/2);
  }
  
  if(mode == 2){
    translate(width/2, height/2,0);
    rotateX(radians(rotX));
    rotateY(radians(rotY));
    scale(zoom);
    for(int i = 0; i < objs.size(); i++){
      if(objs.get(i) != null)shape(objs.get(i));
    }
  }
  

  if(mode == 1){
    line(width/2,-height,0,width/2,height*2,0);
    PaintLine();
  } 
  
  //gifExport.addFrame();
}

void PaintLine(){
  stroke(123);
  for(int i = 0; i < mouseXPos.size()-1; i++){
    line(mouseXPos.get(i), mouseYPos.get(i), mouseXPos.get(i+1), mouseYPos.get(i+1));
  }
}

void mousePressed(){
  if(mode == 1){
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
  if(mode == 2){
    if (mouseButton == LEFT) {
      rotX += (pmouseY - mouseY);
      rotY += (mouseX - pmouseX);
    }
    if(mouseButton == RIGHT) {
      zoom += (pmouseY - mouseY) * 0.015f;
      if(zoom < 0.1) zoom = 0.1;
    }
  }
}

void keyPressed(){
  if(mode == 1){
    if(keyCode == ENTER){
      CreateFigure();
    }
  }
  
  if(key == 'r'){
    ResetFigure();
  }
  
  if(mode == 0){
    if(keyCode == ENTER){
      mode = prevMode;
    }
  }
  
  if(key == 'h'){
    prevMode = mode;
    mode = 0;
  }  
  
  /*if(key == 's'){
    gifExport.finish();
  }*/
}


void CreateFigure(){
  float[] point = new float[3];
  float[] currentColum = new float[3];
  float[] nextColum = new float[3];
  float angleRadians = radians(angle);
  
  if(mouseXPos.size() < 2) return;
  
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
          nextColum[m] += point[n] * maskY2[n][m];
        }
      }
      
      obj.vertex(currentColum[0], currentColum[1], currentColum[2]);
      obj.vertex(nextColum[0], nextColum[1], nextColum[2]);
    }
    obj.endShape();
    objs.add(obj);
  }
  mode = 2;
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
  mode = 1;
}
