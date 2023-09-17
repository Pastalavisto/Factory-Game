import java.util.Dictionary;
import java.util.Enumeration;
import java.util.Hashtable;

Dictionary<Integer, String> dicConstru = new Hashtable<Integer, String>();
Dictionary<Integer, Integer> dicTailleConstru = new Hashtable<Integer, Integer>();
Dictionary<Integer, String> dicGetName = new Hashtable<Integer, String>();
void initDictionnaire(){
  dicConstru.put(0,"0:2");
  dicConstru.put(1,"0:2");
  dicConstru.put(2,"0:2:1:5");
  dicConstru.put(7,"0:2");
  
  dicTailleConstru.put(-1,tileSize);
  dicTailleConstru.put(0,2*tileSize);
  dicTailleConstru.put(1,2*tileSize);
  dicTailleConstru.put(2,2*tileSize);
  dicTailleConstru.put(7,3*tileSize);
  
  dicGetName.put(0,"four");
  dicGetName.put(1,"coffre");
  dicGetName.put(2,"mine");
  dicGetName.put(3,"charbon");
  dicGetName.put(4,"fer");
  dicGetName.put(5,"sable");
  dicGetName.put(6,"pierre");
  dicGetName.put(7,"assembleur");
  dicGetName.put(8,"barre de fer");
  dicGetName.put(9,"vis");
  dicGetName.put(10,"bois");
}
// EAU = 0, HERBE = 1, ARBRE = 2, CHARBON = 3, FER = 4, SABLE = 5
ArrayList<Integer> dicConstuire(int construction){
  String val = dicConstru.get(construction);
  ArrayList<Integer> tab2 = new ArrayList <Integer>();
  if (val != null){
    String[] tab = val.split(":");
    for (int i = 0 ; i<tab.length;i++){
      tab2.add(int(tab[i]));
    }
  }
  return tab2;
}

int dicGetTaille (int item){
  Enumeration enu = dicTailleConstru.keys();
  int taille = tileSize;
  while (enu.hasMoreElements()) {
    if (enu.nextElement().equals(item)){
      taille = dicTailleConstru.get(item);
    }
  }
  return taille;
}

boolean dicGetConstru (int item){
  Enumeration enu = dicConstru.keys();
  boolean ok = false;
  while (enu.hasMoreElements()) {
    if (enu.nextElement().equals(item)){
      ok = true;
    }
  }
  return ok;
}
