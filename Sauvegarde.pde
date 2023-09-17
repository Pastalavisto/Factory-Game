int InitSave(int SeedMap) {
  if (SeedMap== 0) {
    SeedMap = int(random(1, 100));
  }
  return SeedMap;
}


void sauvegarder() {
  String saveConstruction ="CONSTRUCTION\n" ;
  String saveInventaire = "INVENTAIRE\n";
  //CONSTRUCTION
  for (int i = 0; i<tabConstruction.size(); i++) {
    tabConstruction.get(i).saveBase();
    String line = "" ;
    for (int n : tabConstruction.get(i).tab) {
      line += str(n)+" ";
    }
    line += "inv";
    boolean ok = false;
    if(tabConstruction.get(i).inv.isEmpty() == false){
      for (int n = 0; n<tabConstruction.get(i).inv.inv.length; n++) {
        for (int k = 0; k<tabConstruction.get(i).inv.inv[n].length; k++) {
          if (tabConstruction.get(i).inv.inv[n][k][0] != -1) {
            ok = true;
            line += str(n)+" "+str(k)+" "+str(tabConstruction.get(i).inv.inv[n][k][0])+" "+str(tabConstruction.get(i).inv.inv[n][k][1]) + "~";
          }
        }
      }
    }
    if (ok)line = line.substring(0, line.length()-1);
    ok = false;
    if (tabConstruction.get(i).isInvSecond == true){
      if(tabConstruction.get(i).invSecond.isEmpty() == false){
        line += " inv";
        for (int n = 0; n<tabConstruction.get(i).invSecond.inv.length; n++) {
          for (int k = 0; k<tabConstruction.get(i).invSecond.inv[n].length; k++) {
            if (tabConstruction.get(i).invSecond.inv[n][k][0] != -1) {
              ok = true;
              line += str(n)+" "+str(k)+" "+str(tabConstruction.get(i).invSecond.inv[n][k][0])+" "+str(tabConstruction.get(i).invSecond.inv[n][k][1]) + "~";
            }
          }
        }
      }
    }
    if(ok)line = line.substring(0, line.length()-1);
    saveConstruction += line;
    saveConstruction += "\n";
  }
  saveConstruction = saveConstruction.substring(0, saveConstruction.length()-1);
  //INVENTAIRE
  for (int i = 0; i<invPerso.inv.length; i++) {
    String line = "";
    for (int n = 0; n<invPerso.inv[i].length; n++) {
      if (invPerso.inv[i][n][0] != -1) {

        line = str(i)+" "+str(n)+" "+str(invPerso.inv[i][n][0])+" "+str(invPerso.inv[i][n][1]);
        saveInventaire += line;
        saveInventaire += "\n";
      }
    }
  }
  saveInventaire = saveInventaire.substring(0, saveInventaire.length()-1);
  String [] save = new String[]{
    seedgen, "X:"+str(Xperso), "Y:"+str(Yperso), saveConstruction, saveInventaire
  };
  saveStrings("data/save/"+savename+".txt", save);
}

void loadSave(String savename) {
  String[] sauvegarde = loadStrings("data/save/"+ savename +".txt");
  String[] a = sauvegarde[0].split(":");
  seed =int(a[1]);
  a = sauvegarde[1].split(":");
  Xperso = int(a[1]);
  a = sauvegarde[2].split(":");
  Yperso = int(a[1]);
  seed = InitSave(seed);
  seedgen = "Seed :" + str(seed);
  String modeSave = "Seed";
  for (int i =1; i<sauvegarde.length; i++) {
    if (sauvegarde[i].equals("CONSTRUCTION")) {
      modeSave = "CONSTRUCTION";
    } else if (sauvegarde[i].equals("INVENTAIRE")) {
      modeSave = "INVENTAIRE";
    } else if (modeSave == "CONSTRUCTION") {
      String []ligne = (sauvegarde[i].split("inv"));
      String []construction = (ligne[0].split(" "));
      if (int(construction[3]) == 0) {
        tabConstruction.add(new four(int(construction[0]), int(construction[1]), int(construction[4])));
      }
      if (int(construction[3]) == 1) {
        tabConstruction.add(new coffre(int(construction[0]), int(construction[1]), int(construction[4])));
      }
      if (int(construction[3]) == 2) {
        tabConstruction.add(new mine(int(construction[0]), int(construction[1]), int(construction[4]), int(construction[5])));
      }
      if (int(construction[3]) == 7) {
        tabConstruction.add(new assembleur(int(construction[0]), int(construction[1]), int(construction[4])));
      }
      if (ligne.length >= 2){
        if (ligne[1].length() > 3){
          for(String n : ligne[1].split("~")){
            String [] invC = n.split(" ");
            tabConstruction.get(tabConstruction.size()-1).inv.inv[int(invC[0])][int(invC[1])][0] = int(invC[2]);
            tabConstruction.get(tabConstruction.size()-1).inv.inv[int(invC[0])][int(invC[1])][1] = int(invC[3]);
          }
        }
      }
      if (ligne.length == 3){
        if (ligne[2].length() > 3){
          for(String n : ligne[2].split("~")){
            String [] invC = n.split(" ");
            tabConstruction.get(tabConstruction.size()-1).invSecond.inv[int(invC[0])][int(invC[1])][0] = int(invC[2]);
            tabConstruction.get(tabConstruction.size()-1).invSecond.inv[int(invC[0])][int(invC[1])][1] = int(invC[3]);
          }
        }
      }
      
      
    } else if (modeSave == "INVENTAIRE") {
      String []inventaire = (sauvegarde[i].split(" "));
      invPerso.inv[int(inventaire[0])][int(inventaire[1])][0] = int(inventaire[2]);
      invPerso.inv[int(inventaire[0])][int(inventaire[1])][1] = int(inventaire[3]);
    }
  }
}
