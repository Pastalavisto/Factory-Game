ArrayList<ArrayList<ArrayList<int []>>> tabPerso = new ArrayList<ArrayList<ArrayList<int []>>>();
ArrayList<ArrayList<ArrayList<int []>>> tabAssembleur = new ArrayList<ArrayList<ArrayList<int []>>>();
ArrayList<ArrayList<ArrayList<int []>>> tabFour = new ArrayList<ArrayList<ArrayList<int []>>>();
class craft{
  private int selected = 0;
  private boolean display= false;
  private int nbrMaxX =5;
  private float taille = 6*dimension_case / this.nbrMaxX;
  private float x = width/2;
  private float y = height/2-int(6*dimension_case)/2;
  private boolean bandeauDroit ;
  ArrayList<ArrayList<ArrayList<int []>>> tab;
  private int nbr ;
  private inventaire inv;
  private inventaire invSecond;
  private float cd = 0;
  private float timeCraft = 0;
  craft(ArrayList<ArrayList<ArrayList<int []>>> t , inventaire i ,inventaire i2, float time,boolean bandeau){
    this.tab = t;
    this.nbr = t.size();
    this.inv = i;
    this.invSecond = i2;
    this.timeCraft = time;
    this.bandeauDroit = bandeau;
  }
  void draw(){
    if (display){
      if (mousePressed)this.mousePressed();
      //PARTIE GAUCHE
      invPerso.x = width/2-int(9*dimension_case+20)/2;
      invPerso.y = height/2;
      fill(100);
      stroke(50);
      strokeWeight(7);
      rect(this.x,this.y , 6*dimension_case, 6*dimension_case); 
      rect(this.x+6*dimension_case,this.y,3*dimension_case+20,6*dimension_case);
      int n=0;
      int y = 0;
      //AFFICHER LES CRAFTS 
      while (true){
        if (n + y * this.nbrMaxX == nbr)break;
        ArrayList<int []> a = tab.get(n + y * this.nbrMaxX).get(0);
        if (n == this.nbrMaxX){
          n=0;
          y++;
        }
        
        image(construction[a.get(0)[0]],this.x + n * taille + taille /3.2,this.y+y*taille +taille/3.2,taille/2.5,taille/2.5);
        noFill();
        if (this.selected == n + y * this.nbrMaxX)stroke(10);
        else stroke(50);
        rect(this.x + n * taille + taille /4,this.y +y*taille +taille/4,taille/2,taille/2); 
        fill(255);
        text(a.get(0)[1],this.x + n * taille + taille /4+taille/3,this.y +y*taille +taille/4 +taille/2.12);
        if (mouseX > this.x + n * taille + taille /4 && mouseX < this.x + n * taille + taille /4 + taille/2 && mouseY >this.y +y*taille +taille/4 && mouseY < this.y +y*taille +taille/4 + taille/2){
          stroke(50);
          popup(this.x + n * taille + taille /4,this.y +y*taille +taille/4 + taille/2,taille/2,taille/4,dicGetName.get(a.get(0)[0]),100,20);
        }
        n++;
      }
      //PARTIE DROITE
      //ITEM CRAFT
      stroke(50);
      ArrayList<int []> a = tab.get(this.selected).get(0);
      image(construction[a.get(0)[0]],this.x+6*dimension_case+(3*dimension_case+20)/2-(3*dimension_case+20)/8,this.y+(3*dimension_case+20)/8,(3*dimension_case+20)/4,(3*dimension_case+20)/4);
      noFill();
      rect(this.x+6*dimension_case+(3*dimension_case+20)/2-(3*dimension_case+20)/8,this.y+(3*dimension_case+20)/8,(3*dimension_case+20)/4,(3*dimension_case+20)/4);
      fill(255);
      text(a.get(0)[1],this.x+6*dimension_case+(3*dimension_case+20)/2-(3*dimension_case+20)/8+(3*dimension_case+20)/5.5,this.y+(3*dimension_case+20)/8+(3*dimension_case+20)/4.3);
      //RESSOURCE DEMANDER
      ArrayList<int []> b = tab.get(this.selected).get(1);
      for (int i = 0;i<b.size();i++){
        image(construction[b.get(i)[0]],this.x+6*dimension_case + i*((3*dimension_case+20)/4),this.y+int(6*dimension_case)/2,(3*dimension_case+20)/4,(3*dimension_case+20)/4);
        noFill();
        rect(this.x+6*dimension_case + i*((3*dimension_case+20)/4),this.y+int(6*dimension_case)/2,(3*dimension_case+20)/4,(3*dimension_case+20)/4);
        text(b.get(i)[1],this.x+6*dimension_case + i*((3*dimension_case+20)/4)+(3*dimension_case+20)/6,this.y+int(6*dimension_case)/2+(3*dimension_case+20)/4.5);
        if (mouseX > this.x+6*dimension_case + i*((3*dimension_case+20)/4) && mouseX < this.x+6*dimension_case + i*((3*dimension_case+20)/4) + (3*dimension_case+20)/4 && mouseY > this.y+int(6*dimension_case)/2 && mouseY < this.y+int(6*dimension_case)/2 + (3*dimension_case+20)/4){
          popup(this.x+6*dimension_case + i*((3*dimension_case+20)/4),this.y+int(6*dimension_case)/2-(3*dimension_case+20)/8,(3*dimension_case+20)/4,(3*dimension_case+20)/8,dicGetName.get(b.get(i)[0]),100,20);
        }
      }
      //BOUTON CRAFT
      if (bandeauDroit)popup(this.x+6*dimension_case + ((3*dimension_case+20)-(3*dimension_case+20)/1.2)/2,this.y+int(6*dimension_case)/2+(4*dimension_case+20)/4,(3*dimension_case+20)/1.2,1.5*dimension_case,"Craft",100,20);
      this.cd -= 0.1;
    }
  }
  
  void mousePressed(){
    int n =0;
    int y =0;
    while (true){
      if (n + y * this.nbrMaxX == nbr)break;
      if (n == this.nbrMaxX){
          n=0;
          y++;
      }
      if ((mouseX < this.x + n * taille + taille /4 + taille/2) &&(mouseX>this.x + n * taille + taille /4 )&&(mouseY < this.y +y*taille +taille/4 + taille/2) && (mouseY >this.y +y*taille +taille/4))this.selected =n + y * this.nbrMaxX; 
      n ++;  
    }
    if (bandeauDroit && cd <= 0 && mouseX > this.x+6*dimension_case + ((3*dimension_case+20)-(3*dimension_case+20)/1.2)/2 && mouseX < this.x+6*dimension_case + ((3*dimension_case+20)-(3*dimension_case+20)/1.2)/2 + (3*dimension_case+20) && mouseY > this.y+int(6*dimension_case)/2+(4*dimension_case+20)/4 && mouseY < this.y+int(6*dimension_case)/2+(4*dimension_case+20)/4 + 1.5*dimension_case){
      ArrayList<int []> b = tab.get(this.selected).get(1);
      crafting();
      this.cd = this.timeCraft;
    }
  }
  
  boolean canCraft(ArrayList<int []> tab){
    boolean ok = true;
    for (int [] i : tab){
      if (!inv.isInInventory(i)){
        ok = false;
      }
    }
   return ok;
  } 
  
  void crafting(){
    if (this.canCraft(tab.get(selected).get(1))){
      ArrayList<int []> a = tab.get(this.selected).get(0);
      ArrayList<int []> b = tab.get(this.selected).get(1);
      this.invSecond.addItem(a.get(0)[0],a.get(0)[1]);
      for (int [] i :b){
        this.inv.delItem(i[0],i[1]);
      }
    }
    if (select[0] != -1){
      if (invPerso.inv[select[0]][0][0] != -1){
        select[1] = dicGetTaille(invPerso.inv[select[0]][0][0]);
      }
    }
  }
  
}

void loadCraft(ArrayList<ArrayList<ArrayList<int []>>> tab,String fichier){
  String[] texte = loadStrings(fichier);
  int index = 0;
  for (String i : texte){
    String[] craft = i.split(":");
    tab.add(new ArrayList<ArrayList<int[]>>());
    tab.get(index).add(new ArrayList());
    tab.get(index).add(new ArrayList());
    String[] itemCraft = craft[0].split("~");
    tab.get(index).get(0).add(new int []{int(itemCraft[0]),int(itemCraft[1])}); 
    String craftReq = craft[1];
    for (String n : craftReq.split(",")){
      String[] craftReqUnite = n.split("~");
      tab.get(index).get(1).add(new int []{int(craftReqUnite[0]),int(craftReqUnite[1])});
      
    }
    index ++;
  }
}

void popup(float x ,float y,float tailleX,float tailleY,String txt,color cRect,color cText){
  float size = tailleY/2-txt.length()/2;
  fill(cRect);
  rect (x,y,tailleX,tailleY);
  textSize(size);
  fill(cText);
  text(txt,x+tailleX/2 - (size*txt.length())/4,y+tailleY/1.5);
  textSize(10);
}
