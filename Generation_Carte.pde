public int tileSize = 20;
PImage [] environnement = new PImage[6]; //image des mineraux arbres etc...
int [][] tiles;//tableau qui stock les différents environnement que l'on doit afficher
int w, h;//largueur,hauteur
int seedX, seedY;//deuxieme seed pour la génération des minéraux
int Xperso, Yperso;//coordonnée pour faire bouger la carte
float scl = 0.05;//
int buffer=4;


void drawTiles() {
  for (int i = 0; i<w; i++) {
    for (int j = 0; j<h; j++) {
      tiles[i][j] = getTile(i+Xperso/tileSize, j+Yperso/tileSize);
      image(environnement[tiles[i][j]], (i-buffer/2)*tileSize -(Xperso%tileSize), (j-buffer/2)*tileSize -(Yperso%tileSize),tileSize,tileSize);
      textSize(10);
    }
  }
}

void mouvementCarte(){
  if (haut){
    Yperso-=speed;
  }
  if (bas){
    Yperso+=speed;
  }
  if (gauche){
    Xperso-=speed;
  }
  if (droite){
    Xperso+=speed;
  }
}
int getTile(int x, int y) {
  float v = noise(x*scl, y*scl);
  if (v < 0.22) {
    //eau
    return 0;
  } else if (v<0.26) {
    //sable
    return 5;
  } else if (v<0.7) {
    float v2 = noise((seedX+x)*scl, (seedY+y)*scl);
    if (v2<0.2 && v >0.30 && v<0.65) {
      //charbon
      return 3;
    } else if (v2 >0.75 && v >0.30 && v<0.65) {
      //fer
      return 4;
    } else {
      //herbe
      return 1;
    }
  } else {
    //arbre
    return 2;
  }
}
