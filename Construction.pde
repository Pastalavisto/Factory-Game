ArrayList <base> tabConstruction = new ArrayList<base> ();
PImage [] construction = new PImage[20];
class base {
  private int taille;
  private int x;
  private int y;
  private int num;
  private boolean isInvSecond;
  private int sortie; //indice dans tabConstruction de la constru où on envoie les items
  public Boolean Interface;
  private int []tab;
  private inventaire inv;
  private inventaire invSecond;
  base(int [] _tab) {
    this.tab = _tab;
    this.x = tab[0];
    this.y = tab[1];
    this.taille = tab[2];
    this.num = tab[3];
    this.sortie = tab[4];
    this.Interface = false;
  }
  void display() {
    if (modeReseau && this.sortie != -1) {
      base consSort = tabConstruction.get(this.sortie);
      line(this.x + this.taille/2, this.y+ this.taille/2, consSort.x + consSort.taille/2, consSort.y + consSort.taille/2);
      rect(consSort.x + consSort.taille/2, consSort.y + consSort.taille/2, 20, 20);
    }
    image(construction[this.num], this.x, this.y, this.taille, this.taille);
  }
  void eachSecond() {
    if (second()!= sec){
      if(this.sortie != -1){
        base construSortie = tabConstruction.get(this.sortie);
        if (this.isInvSecond == false){
          for (int i = 0;i < this.inv.l;i++){
            for (int j = 0;j < this.inv.h;j++){
                if (construSortie.inv.addItem(this.inv.inv[i][j][0],this.inv.inv[i][j][1])){
                  this.inv.supItem(i,j,this.inv.inv[i][j][1]);
                  break;
                }
              }
            }
        }else{
          for (int i = 0;i < this.invSecond.l;i++){
            for (int j = 0;j < this.invSecond.h;j++){
                if (construSortie.inv.addItem(this.invSecond.inv[i][j][0],this.invSecond.inv[i][j][1])){
                  this.invSecond.supItem(i,j,this.invSecond.inv[i][j][1]);
                  break;
                }
              }
            }
          }
        }
      }
    }
  void displayInt() {
  }

  void saveBase() {
    this.tab[0] = this.x;
    this.tab[1] = this.y;
    this.tab[4] = this.sortie;
  }
  void setSortie(int indice, int indiceSelf) {
  
    if (this.sortie == indice || indice == indiceSelf) {
      this.sortie = -1;

    } else {
      this.sortie = indice;
    }
  }
}
class four extends base {
  private craft invCraft;
  private String mode = "Inventaire";
  private int vitesse = 5;
  private int repet = 0;
  private int prevSecond = second();
  four(int x, int y, int sortie) {
    super(new int []{x, y, 2*tileSize, 0, sortie});
    super.isInvSecond = true;
    super.inv = new inventaire(2,1,false);
    super.invSecond = new inventaire(1,1,false);
    this.invCraft = new craft(tabFour,super.inv,super.invSecond,2,false);
    this.invCraft.display = true;
    super.inv.x = int(width/2+(9*dimension_case+20)/2);
    super.inv.y = int(height/2-int(6*dimension_case)/2+(6*dimension_case)/2);
    super.invSecond.x = int(width/2+(9*dimension_case+20)/2) ;
    super.invSecond.y = int(height/2-int(6*dimension_case)/2+(6*dimension_case)/2)+int((super.invSecond.h+super.invSecond.intJoueur)*dimension_case + 40*(1-super.invSecond.intJoueur));
  }
  void displayInt() {
    if (Interface){
      invPerso.x = width/2-int(9*dimension_case+20)/2;
      invPerso.y = height/2;
      if (mousePressed)this.mouseClicked();
      stroke(50);
      strokeWeight(7);
      popup(this.invCraft.x,this.invCraft.y-dimension_case/3,dimension_case*1.5,dimension_case/3,"Inventaire",100,10);
      popup(this.invCraft.x+dimension_case*1.5,this.invCraft.y-dimension_case/3,dimension_case*1.5,dimension_case/3,"Craft",100,10);
      fill(100);
      if (this.mode == "Craft")this.invCraft.draw();
      if (this.mode == "Inventaire"){
        rect(width/2, height/2-int(6*dimension_case)/2, 9*dimension_case+20, 6*dimension_case); 
        super.inv.display = true;
        super.invSecond.display = true;
        super.invSecond.draw();
        super.inv.draw();
        
      }
    }
  }
  void mouseClicked(){
    if (mouseX>this.invCraft.x && mouseX < this.invCraft.x+dimension_case*1.5 && mouseY > this.invCraft.y-dimension_case/3 && mouseY < this.invCraft.y)this.mode = "Inventaire";
    if (mouseX>this.invCraft.x+dimension_case*1.5 && mouseX < this.invCraft.x+dimension_case*1.5+dimension_case*1.5 && mouseY > this.invCraft.y-dimension_case/3 && mouseY < this.invCraft.y)this.mode = "Craft";
  }
  
  void eachSecond() {
    super.eachSecond();
    if (second() != this.prevSecond){
      this.prevSecond = second();
      this.repet ++;
    }
    if (this.repet == this.vitesse){
      this.repet = 0;
      this.invCraft.crafting();
    }
  }
}
class coffre extends base {
  coffre(int x, int y, int sortie) {
    super(new int []{x, y, 2*tileSize, 1, sortie});
    super.isInvSecond = false;
    super.inv = new inventaire(8,3,false);
    super.inv.x = int(width/2+(9*dimension_case+20)/2);
    super.inv.y = int(height/2-int(6*dimension_case)/2+(6*dimension_case)/2);
  }
  void displayInt() {
    if (this.Interface == true) {
      invPerso.x = width/2-int(9*dimension_case+20)/2;
      invPerso.y = height/2;
      fill(100);
      stroke(50);
      strokeWeight(7);
      rect(width/2, height/2-int(6*dimension_case)/2, 9*dimension_case+20, 6*dimension_case); 
      rect(width/2+(9*dimension_case+20)/2-dimension_case/2, height/2-int(6*dimension_case)/2+(6*dimension_case)/2-dimension_case/2, dimension_case, dimension_case);
      super.inv.display = true;
      super.inv.draw();
    }

  }
}
class mine extends base {
  private int idMinerai; 
  private int vitesse = 5;
  private int repet = 0;
  private int prevSecond = second();
  mine(int x, int y, int sortie, int id) {
    super(new int []{x, y, 2*tileSize, 2, sortie, id});
    super.isInvSecond = true;
    this.idMinerai = id;
    super.inv = new inventaire(1,1,false);
    super.invSecond = new inventaire(1,1,false);
    super.inv.x = int(width/2+(9*dimension_case+20)/2);
    super.inv.y = int(height/2-int(6*dimension_case)/2+(6*dimension_case)/2);
    super.invSecond.x = int(width/2+(9*dimension_case+20)/2+ super.invSecond.l*dimension_case+20);
    super.invSecond.y = int(height/2-int(6*dimension_case)/2+(6*dimension_case)/2);
    
}
  void displayInt() {
    if (this.Interface == true) {
      invPerso.x = width/2-int(9*dimension_case+20)/2;
      invPerso.y = height/2;
      fill(100);
      stroke(50);
      strokeWeight(7);
      rect(width/2, height/2-int(6*dimension_case)/2, 9*dimension_case+20, 6*dimension_case); 
      rect(width/2+(9*dimension_case+20)/2-dimension_case/2, height/2-int(6*dimension_case)/2+(6*dimension_case)/2-dimension_case/2, dimension_case, dimension_case);
      super.inv.display = true;
      super.invSecond.display = true;
      super.invSecond.draw();
      super.inv.draw();
   
  }
  }

  void eachSecond() {
    super.eachSecond();
    if (second() != this.prevSecond){
      this.prevSecond = second();
      this.repet ++;
    }
    if (this.repet == this.vitesse){
      this.repet = 0;
      super.invSecond.addItem(this.idMinerai,1);
      if(int(random(2)) == 0)super.inv.addItem(6,1);
    }
  }
}

class assembleur extends base{
  private craft invCraft;
  private String mode = "Inventaire";
  private int vitesse = 5;
  private int repet = 0;
  private int prevSecond = second();
  assembleur(int x, int y, int sortie ){
    super(new int []{x, y, 3*tileSize, 7, sortie});
    super.isInvSecond = true;
    super.inv = new inventaire(5,1,false);
    super.invSecond = new inventaire (5,1,false);
    this.invCraft = new craft(tabAssembleur,super.inv,super.invSecond,2,false);
    this.invCraft.display = true;
    super.inv.x = int(width/2+(9*dimension_case+20)/2);
    super.inv.y = int(height/2-int(6*dimension_case)/2+(6*dimension_case)/2);
    super.invSecond.x = int(width/2+(9*dimension_case+20)/2) ;
    super.invSecond.y = int(height/2-int(6*dimension_case)/2+(6*dimension_case)/2)+int((super.invSecond.h+super.invSecond.intJoueur)*dimension_case + 40*(1-super.invSecond.intJoueur));
  }
  
  void displayInt(){
    if (Interface){
      invPerso.x = width/2-int(9*dimension_case+20)/2;
      invPerso.y = height/2;
      if (mousePressed)this.mouseClicked();
      stroke(50);
      strokeWeight(7);
      popup(this.invCraft.x,this.invCraft.y-dimension_case/3,dimension_case*1.5,dimension_case/3,"Inventaire",100,10);
      popup(this.invCraft.x+dimension_case*1.5,this.invCraft.y-dimension_case/3,dimension_case*1.5,dimension_case/3,"Craft",100,10);
      fill(100);
      if (this.mode == "Craft")this.invCraft.draw();
      if (this.mode == "Inventaire"){
        rect(width/2, height/2-int(6*dimension_case)/2, 9*dimension_case+20, 6*dimension_case); 
        super.inv.display = true;
        super.invSecond.display = true;
        super.inv.draw();
        super.invSecond.draw();
      }
    }
  }
  
  void mouseClicked(){
    if (mouseX>this.invCraft.x && mouseX < this.invCraft.x+dimension_case*1.5 && mouseY > this.invCraft.y-dimension_case/3 && mouseY < this.invCraft.y)this.mode = "Inventaire";
    if (mouseX>this.invCraft.x+dimension_case*1.5 && mouseX < this.invCraft.x+dimension_case*1.5+dimension_case*1.5 && mouseY > this.invCraft.y-dimension_case/3 && mouseY < this.invCraft.y)this.mode = "Craft";
  }
  
  void eachSecond() {
    super.eachSecond();
    if (second() != this.prevSecond){
      this.prevSecond = second();
      this.repet ++;
    }
    if (this.repet == this.vitesse){
      this.repet = 0;
      this.invCraft.crafting();
    }
  }
}
boolean verificationPose(int item, int x, int y) {
  int n;
  for (int i : dicConstuire(item)) {
    for (int m = 0; m<select[1]/tileSize; m++) {
      for (int k =0; k<select[1]/tileSize; k++) {
        n = getTile((x+Xperso)/tileSize+buffer/2+m, (y+Yperso)/tileSize+buffer/2+k); 
        if (n == i) {
          return false;
        }
      }
    }
  }
  return true;
}

void drawConstructionInterface() {
  for (base i : tabConstruction) {
    i.displayInt();
  }
}
void drawConstruction() {
  for (base i : tabConstruction) {
    i.eachSecond();
    i.display();
    if (saisie[0] == 3)
    {
      if (tabConstruction.get(saisie[1]) == i && modeReseau){
        line(i.x + i.taille/2, i.y+i.taille/2, mouseX, mouseY);
      }
    }
  }
}

void mouvementConstruction() {
  for (base i : tabConstruction) {
    if (haut) {
      i.y+=speed;
    }
    if (bas) {
      i.y-=speed;
    }
    if (gauche) {
      i.x+=speed;
    }
    if (droite) {
      i.x-=speed;
    }
  }
}

void construire(int item, int x, int y) {
  boolean poser = true;
  if (tabConstruction.size() != 0) {
    for (base i : tabConstruction) {
      if (((x >= i.x && x < i.x +i.taille)||(x + select[1] > i.x && x +select[1] < i.x+i.taille))&&((y >= i.y && y < i.y +i.taille)||(y + select[1] > i.y && y +select[1] < i.y+i.taille))) {
        poser = false;
      }
    }
  }
  if (poser && verificationPose(item, x, y) && !modeReseau && dicGetConstru(item)) {
    if (item == 0) {
      tabConstruction.add(new four(x, y, -1));
    } else if (item == 1) {
      tabConstruction.add(new coffre(x, y, -1));
    } else if (item == 2) {
      tabConstruction.add(new mine(x, y, -1, getTile((x+Xperso)/tileSize+buffer/2, (y+Yperso)/tileSize+buffer/2)));
    } else if (item == 7) {
      tabConstruction.add(new assembleur(x, y, -1));
    }
    invPerso.inv[select[0]][0][1] -= 1;
  }
}
