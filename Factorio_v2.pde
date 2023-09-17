import controlP5.*;
import java.io.FilenameFilter;
import java.io.*;
PFont font;
ControlP5 charger;
ControlP5 creer;
int sec = 0;
personnage Personnage;
inventaire invPerso;
public boolean haut, bas, droite, gauche;
public int speed = 2;
public int [] select = new int[2];
int derniere = ' ';
String seedgen;
int seed;
Boolean modeReseau = false;

float dimension_case; //demandé a Enzo si vous comprennez pas mais en gros:
//je prends le rapport entre la taille de l'image (1280) et celle afficher(width / 1.5) et comme je sais
//que mes case sont espacé de 140 dans l'image initial je multiplie par ce rapport pour avoir l'espace entre les case
float margeincase;
int XInventaire;
int YInventaire;
int nombreDinv = 0;

int[] saisie = new int[4];//saisie[0] si = 0 --> rien
//si = 1 --> drag un item
//si = 2 --> shift clic
//si = 3 --> cable en main (reseau d'item)

int id_menu=0; //0 = menu principal 1 = INGAME
int nbsave;
String savename;
void setup() {
  font = createFont("data/Font/ProcessingSansPro-Regular.ttf",128);
  textFont(font);
  loadCraft(tabPerso,"data/Craft/personnage.txt");
    loadCraft(tabAssembleur,"data/Craft/assembleur.txt");
  loadCraft(tabFour,"data/Craft/four.txt");
  charger = new ControlP5(this);
  charger.addButton("Charger")
    .setPosition(100, 100)
    .setSize(200, 19)
    ;
  creer = new ControlP5(this);
  creer.addButton("Creer")
    .setLabel("Créer une nouvelle partie")
    .setPosition(100, 200)
    .setSize(200, 19)
    ;
  println("Chargement des images");
  for (int i = 0; i < 6; i++) {
    environnement[i] = loadImage("data/Environnement/"+i+".png");
    environnement[i].resize(tileSize, 0);
  }
  for(int i = 0;i < 11;i++){
    construction[i] = loadImage("data/Construction/"+i+".png");
    construction[i].resize(tileSize*2, 0);
  }
  initDictionnaire();
  println("Initialisation des variables");
  dimension_case = width / 1.5 / 1280 * 100;
  invPerso = new inventaire(9,5,true);
  Personnage = new personnage();
  select[0] = -1;
  select[1] = tileSize;
  Personnage.x = width/2;
  Personnage.y = height/2;
  margeincase = dimension_case * 0.25;
  w = width/tileSize + buffer;
  h = height/tileSize + buffer;
  tiles = new int[w][h];
  seedX = 50;
  seedY = 50;
  fullScreen();
  println("Initialisation de la sauvegarde");
  File folder = new File(sketchPath("data/save"));
  nbsave = folder.listFiles().length + 1;
  println("Fin setup");
}

void draw() {
  if (id_menu==0) {
    background(0);
  } else if (id_menu==1) {
    stroke(0);
    strokeWeight(1);
    clear();
    mouvementCarte();
    mouvementConstruction();
    drawTiles();
    Personnage.display();
    selection();
    drawConstruction();
    drawConstructionInterface();
    Personnage.invCraft.draw();
    invPerso.draw();
  }
}

void keyPressed() {
  if (keyCode == derniere) {
    select[0]=-1;
    select[1]=tileSize;
    derniere = ' ';
  } else if (key == 'z' || key == 'Z') {
    haut=true;
  } else if (key == 's' || key == 'S') {
    bas=true;
  } else if (key == 'q' || key == 'Q') {
    gauche=true;
  } else if (key == 'd' || key == 'D') {
    droite=true;
  }
  
  else if (key == 'e' || key == 'E') {
    for (base i : tabConstruction){
      if (invPerso.display==true){
         if(i.Interface==true){
           i.Interface = false;
           invPerso.x = width/2;
           invPerso.y = height/2;
         }
      }
    }
    if (Personnage.invCraft.display == true){
      Personnage.invCraft.display = false;
      invPerso.x = width/2;
      invPerso.y = height/2;
    }
    invPerso.display = !invPerso.display;
    
  } else if (key == '&') { //linux : 150 , win : 49
    select[0]=0;
    select[1]=dicGetTaille(invPerso.inv[select[0]][0][0]);
    derniere= keyCode;
  } else if (key == 'é' || key == 'É') { //linux : 0 , win : 50
    select[0]=1;
    select[1]=dicGetTaille(invPerso.inv[select[0]][0][0]);
    derniere= keyCode;
  } else if (key == '"') {
    select[0]=2;
    select[1]=dicGetTaille(invPerso.inv[select[0]][0][0]);
    derniere = keyCode;
  } else if (key == '\'') {
    select[0]=3;
    select[1]=dicGetTaille(invPerso.inv[select[0]][0][0]);
    derniere = keyCode;
  } else if (key == '(') {
    select[0]=4;
    select[1]=dicGetTaille(invPerso.inv[select[0]][0][0]);
    derniere = keyCode;
  } else if (key == '-') {
    select[0]=5;
    select[1]=dicGetTaille(invPerso.inv[select[0]][0][0]);
    derniere = keyCode;
  } else if (key == 'È' || key == 'è') {
    select[0]=6;
    select[1]=dicGetTaille(invPerso.inv[select[0]][0][0]);
    derniere = keyCode;
  } else if (key == '_') {
    select[0]=7;
    select[1]=dicGetTaille(invPerso.inv[select[0]][0][0]);
    derniere = keyCode;
  } else if (key == 'ç' || key == 'Ç') {//linux : 152 , win : 51
    select[0]=8;
    select[1]=dicGetTaille(invPerso.inv[select[0]][0][0]);
    derniere = keyCode;
  } else if (key=='a') {
    sauvegarder();
  } else if (key == 'f' || key == 'F') { //linux : 150 , win : 49
    modeReseau = !modeReseau;
    saisie[0] = 0;
  } else if (key==TAB) {
    id_menu=0;
    charger.show();
    creer.show();
  }
  else if (key == 't'){
    if (Personnage.invCraft.display == true){
      invPerso.x = width/2;
      invPerso.y = height/2;
      Personnage.invCraft.display = false;
      invPerso.display = false;
    }else{
      Personnage.invCraft.display = true;
      invPerso.display = true;
    }
  }
  if (keyCode == ' '){
    Personnage.isMining = true;
  }
}

void keyReleased() {
  if (key == 'z' || key == 'Z') {
    haut=false;
  }
  if (key == 's' || key == 'S') {
    bas=false;
  }
  if (key == 'q' || key == 'Q') {
    gauche=false;
  }
  if (key == 'd' || key == 'D') {
    droite=false;
  }
  if (keyCode == ' '){
    Personnage.isMining = false;
  }
}


void mouseReleased() {
  invPerso.pressed = false;
  if (!tabConstruction.isEmpty()){
    for (int i=0;i<tabConstruction.size();i++){
      tabConstruction.get(i).inv.pressed = false;
      if (tabConstruction.get(i).isInvSecond){
        tabConstruction.get(i).invSecond.pressed = false;
      }
      if (!invPerso.display){
        if ( (mouseX >= tabConstruction.get(i).x && mouseX < tabConstruction.get(i).x +tabConstruction.get(i).taille)&&(mouseY >= tabConstruction.get(i).y && mouseY < tabConstruction.get(i).y +tabConstruction.get(i).taille)){
          if(tabConstruction.get(i).Interface==false){
            if (modeReseau){
              if (saisie[0] == 3){
                saisie[0] = 0;
                tabConstruction.get(saisie[1]).setSortie(i,saisie[1]);
              }else {
                saisie[0] = 3;
                saisie[1] = i;
              }
            }else if(mouseButton == RIGHT){
              tabConstruction.get(i).Interface=true;
              invPerso.display=true;
            }
          }
        }
      }
    }
  }
}

void Charger() {
  ArrayList<String> nomsave = new ArrayList<String>();
  if (nbsave-1 != 0) {
    for (int i=1; i<nbsave; i++) {
      nomsave.add("Partie :  " +String.valueOf(i) );
    }
  }
  DropdownList p1;
  p1 = charger.addDropdownList("Vos parties :", 310, 100, 100, 120);
  for (int i=0; i<nomsave.size(); i++) {
    p1.addItem(nomsave.get(i), i);
  }
}


void Creer() {
  File folder = new File(sketchPath("data/save"));
  int nbsave = folder.listFiles().length + 1;
  savename="save"+nbsave;
  PrintWriter save;
  save = createWriter("save/"+savename +".txt");
  seed = int(random(1, 100));
  save.print("Seed :"+seed +"\nX:0\nY:0\nCONSTRUCTION\nINVENTAIRE");
  save.flush();
  save.close();
  if (id_menu==0) {
    for (int [][] i : invPerso.inv){
     for (int [] n : i){
       n[0] = -1;
       n[1] = 0;
     }
    }
    tabConstruction = new ArrayList<base> ();
    loadSave(savename);
    id_menu=1;
    charger.hide();
    creer.hide();
  }
}

void controlEvent(ControlEvent theEvent) {
  if (theEvent.getName() != "Charger" && theEvent.getName() !="Creer" ) {
    for (int [][] i : invPerso.inv){
     for (int [] n : i){
       n[0] = -1;
       n[1] = 0;
     }
    }
    tabConstruction = new ArrayList<base> ();
    int numsave = Math.round(theEvent.getValue()) + 1;
    savename = "save"+numsave;
    loadSave(savename);
    id_menu=1;
    charger.hide();
    creer.hide();
    noiseSeed(seed);
  }
}
void fullInv(){
  for (int i = 0;i<9;i++)invPerso.addItem(i,1);
}
