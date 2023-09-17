int selectX,selectY;

public class personnage{
  private PImage  texture = loadImage("data/Personnage/perso.png");
  private PImage [] tabTextureLaser;
  private int hauteur = tileSize*2;
  private int largeur = tileSize*2;
  private int x = width/2;
  private int y = height/2;
  private craft invCraft = new craft(tabPerso,invPerso,invPerso,1.5,true);
  private int mineSpeed = 2;
  private boolean okMine = true;
  private boolean isMining = false;
  private int delay = 0;
  private int numTextureMining = 0;
  public int getX(){return this.x;}  
  public int getY(){return this.y;}
  personnage(){
    this.tabTextureLaser = new PImage [7];
    for (int i = 0;i<tabTextureLaser.length;i++){
       this.tabTextureLaser[i] = loadImage("data/Personnage/laser"+i+".png");
    }
  }
  void display(){
    if (modeReseau){fill(0,255,0);}
    else{fill(255,0,0);}
    textSize(20);
    text("mode réseau : " + str(modeReseau),10,20);
    textSize(10);
    fill(255);
    if (this.isMining){
      this.miner();
      this.delay ++;
      if (this.numTextureMining != tabTextureLaser.length-1 && delay%4 == 0){this.numTextureMining ++;}
      this.texture = this.tabTextureLaser[this.numTextureMining];
    }
    else {
      this.texture = loadImage("data/Personnage/perso.png");
      this.numTextureMining = 0;
    }
    image(this.texture,this.x-this.largeur/2,this.y-this.hauteur/2,this.largeur,this.hauteur);
  }
  
  
  void miner(){
  int minerai = getTile((Xperso+this.getX())/tileSize+buffer/2,(Yperso+this.getY())/tileSize+buffer/2);
  this.isMining = true;
  if (second()%this.mineSpeed == 0 && this.okMine){
    if (minerai == 3){
      invPerso.addItem(minerai,int(random(1,3)));
      invPerso.addItem(6,int(random(1,4)));
    }
    if (minerai == 4){
      invPerso.addItem(minerai,int(random(1,2)));
      invPerso.addItem(6,int(random(1,4)));
    }
    if (minerai == 5){
      invPerso.addItem(minerai,int(random(1,5)));
    }
    if (minerai == 2){
      invPerso.addItem(10,int(random(1,5)));
    }
    this.okMine = false;
  }
  else if (second()%this.mineSpeed != 0){
    this.okMine = true;
  }
}

}

void selection(){
  noFill();
  //rect (mouseX-(abs(mouseX+seedX)%tileSize),mouseY-(abs(mouseY+seedY)%tileSize),tileSize,tileSize);
  if (mouseX+Xperso<0){
    selectX = mouseX-tileSize+abs(mouseX+Xperso)%tileSize;
  }else{
    selectX = mouseX-(mouseX+Xperso)%tileSize;
  }
  if (mouseY+Yperso<0){
   selectY = mouseY-(tileSize-abs(mouseY+Yperso)%tileSize);
  }else{
   selectY = mouseY-(mouseY+Yperso)%tileSize; 
  }
  rect (selectX,selectY,select[1],select[1]);
  if (mousePressed && select[0] != -1 && !invPerso.display){
    
    if (invPerso.inv[select[0]][0][1] >= 1){
      construire(invPerso.inv[select[0]][0][0],selectX,selectY);
    } 
     else
    {
      construire(invPerso.inv[select[0]][0][0],selectX,selectY);
      invPerso.supItem(select[0],0,invPerso.inv[select[0]][0][1]);
      select[1] = tileSize;
    }
  }
  text(selectX,10,10);
}
