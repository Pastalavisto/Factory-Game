inventaire numToInv(int num) {
  if (num == 0) {
    return invPerso;
  }
  for (base i : tabConstruction) {
    if (i.inv.num == num) {
      return i.inv;
    }
    if (i.isInvSecond) {
      if (i.invSecond.num == num) {
        return i.invSecond;
      }
    }
  }
  return invPerso;
}


public class inventaire
{
  private int [][][] inv; // inv[i][j][0] c'est l'id et [1] la quantite
  private int x = width/2;
  private int y = height/2;
  public Boolean display = false;
  Boolean pressed = false;
  int intJoueur;
  int l, h, num;
  Boolean joueur;
  public inventaire(int l, int h, Boolean joueur) {
    this.l = l;
    this.h = h;
    this.joueur = joueur;
    this.intJoueur = joueur ? 1 : 0;
    this.inv = new int[l][h][2];
    this.num = nombreDinv;
    nombreDinv ++;
    for (int i = 0; i < l; i++)
    {
      for (int j = 0; j < h; j++)
      {
        inv[i][j][0] = -1;
        inv[i][j][1] = 0;
      }
    }
  }
  void draw() {

    if (this.display)
    {
      this.mousePressed();
      this.display();
      if (saisie[0] == 1 && this.num == 0)
      {
        this.saisie(saisie[1], saisie[2]);
      }
    } else
    {
      this.hotbar();
    }
  }
  void mousePressed() {

    fill(200);
    if (mousePressed && !pressed)
    {
      this.pressed = true;
      for (int i = 0; i < l; i++)
      {
        if (joueur) {
          if (mouseX > x + dimension_case * (i - (l / 2 - (1 - l%2) * (0.5 - l%2))) - 2*margeincase && mouseX < x + dimension_case * (i - (l / 2 - (1 - l%2) * (0.5 - l%2))) + 2*margeincase && mouseY < y - (h / 2 - (1 - h%2) * (0.5 - h%2)) * dimension_case + margeincase  && mouseY > y - ((h / 2 - (1 - h%2) * (0.5 - h%2)) + 1) * dimension_case + 2 * margeincase)
          {

            if (keyPressed)
            {
              if (keyCode == 16)
              {
                /*
                *
                *    Le joueur a shift clic
                *
                */
                saisie[0] = 2;
              }
            }
            if (saisie[0] == 1)
            {
              /*
              *
              *      On as un item dans la main et on clic sur la hotbar (si c'est un inventaire de joueur)
              *
              */
              inventaire invTemp = numToInv(saisie[3]);
              if ((i != saisie[1] || 0 != saisie[2]) && invTemp.inv[saisie[1]][saisie[2]][0] == inv[i][0][0]) {
                /*
                *  L'item est stackable
                */
                inv[i][0][1] += invTemp.inv[saisie[1]][0][1] ;
                invTemp.supItem(saisie[1], saisie[2], invTemp.inv[saisie[1]][saisie[2]][1]);
                saisie[0] = 0;
                saisie[3] = 0;
              } else {
                /*
                *  L'item n'est pas stackable
                */
                this.inverser(i, 0, saisie[1], saisie[2], numToInv(saisie[3]));
                saisie[0] = 0;
                saisie[3] = 0;
              }
            }
            else if (saisie[0] == 2)
            {
              /*
              *
              *      Bouge l'item suite au shift clic 
              *
              */
              int[] item = this.supItem(i, 0, this.inv[i][0][1]);

              this.addItem(item[0], item[1]);

              saisie[0] = 0;
            } 
            else if (this.inv[i][0][0] != -1)
              /*
              *
              *      On saisie un item de la hotbar
              *
              */
            {
              saisie[0] = 1;
              saisie[3] = this.num;
            }
            saisie[1] = i;
            saisie[2] = 0;
          }
        }
        for (int j = intJoueur; j < h; j++)
        {
          if (mouseX > x + dimension_case * (i - (l / 2 - (1 - l%2) * (0.5 - l%2))) - 2*margeincase && mouseX < x + dimension_case * (i - (l / 2 - (1 - l%2) * (0.5 - l%2))) + 2*margeincase && mouseY < y + (j - (h / 2 - (1 - h%2) * (0.5 - h%2))) * dimension_case + margeincase * 2  && mouseY > y + (j - (h / 2 - (1 - h%2) * (0.5 - h%2))) * dimension_case - margeincase)
          {
            if (keyPressed)
            {
              if (keyCode == 16)
              {
                /*
                *
                *    Le joueur a shift clic
                *
                */
                saisie[0] = 2;
              }
            }
            if (saisie[0] == 1)
            {
              /*
              *
              *      On as un item dans la main et on clic dans l'inventaire (du joueur [hotbar exclue] ou d'une construction)
              *
              */
              inventaire invTemp = numToInv(saisie[3]);

              if ((i != saisie[1] || j != saisie[2]) && invTemp.inv[saisie[1]][saisie[2]][0] == inv[i][j][0] ) {
                /*
                *  L'item est stackable
                */
                inv[i][j][1] += invTemp.inv[saisie[1]][saisie[2]][1] ;
                invTemp.supItem(saisie[1], saisie[2], invTemp.inv[saisie[1]][saisie[2]][1]);
                saisie[0] = 0;
                saisie[3] = 0;
              } else {
                /*
                *  L'item n'est pas stackable
                */
                this.inverser(i, j, saisie[1], saisie[2], numToInv(saisie[3]));
                saisie[0] = 0;
              }
            } else if (saisie[0] == 2)
            {
              /*
              *
              *      Bouge l'item suite au shift clic dans l'inventaire 
              *
              */
              int[] item = this.supItem(i, j, this.inv[i][j][1]);
              this.addItem(item[0], item[1]);
              saisie[0] = 0;
            } else if (this.inv[i][j][0] != -1)
            {
              saisie[0] = 1;
              saisie[3] = this.num;
            }
            saisie[1] = i;
            saisie[2] = j;
          }
        }
      }
    }
  }
  void inverser(int x1, int y1, int x2, int y2, inventaire inv) {
    /*
    *
    *     Inverse 2 item :
    *     - le premier ce trouvant dans l'inventaire actuel (this) dans la case (x1;y1)
    *     - le deuxieme se trouvant dans l'inventaire inv dans la case (x2;y2) 
    *
    */
    if (y2 < inv.h && y1 < h && inv.inv[x2][y2][0] != -1)
    {
      int [] stock = new int[2];
      stock = this.inv[x1][y1];
      this.inv[x1][y1] = inv.inv[x2][y2];
      inv.inv[x2][y2] = stock;
    }
  }
  int[] supItem(int x, int y, int quantite)
  {
    /*
    *
    *     Supprime une quantite d'item de la case (x;y) et renvoie l'id de l'item et la quantité supprimé    
    *
    */
    int[] item = new int[2];
    item[0] = -1;
    item[1] = 0;
    if (y < h)
    {
      item[0] = inv[x][y][0];
      if (inv[x][y][1] > quantite) {
        item[1] = quantite;
        inv[x][y][1] -= quantite;
      } else {
        inv[x][y][0] = -1;
        item[1] = inv[x][y][1];
        inv[x][y][1] = 0;
      }
    }
    return item;
  }
  Boolean addItem(int IdItem, int quantite) {
    /*
    *
    *     Essaie d'ajouter une quantite d'item et renvoie si il a reussi
    *
    */
    int i = 0;
    int j = 0;
    Boolean inserer = true;
    while (i < h && inserer)
    {
      while (j < l && inserer) {
        if (inv[j][i][0] == IdItem || inv[j][i][0] == -1) {
          inv[j][i][1] += quantite;
          inv[j][i][0] = IdItem;
          inserer = false;
          return true;
        }
        j++;
      }
      i++;
    }
    return false;
  }

  public void saisie(int i, int j)
  {
    /*
    *
    *     Affichage de l'item que le joueur a dans la main
    *
    */
    imageMode(CENTER);
    if (j < numToInv(saisie[3]).h && i < numToInv(saisie[3]).l)
    {
      if (!(numToInv(saisie[3]).inv[i][j][0] == -1))
        image(construction[numToInv(saisie[3]).inv[i][j][0]], mouseX, mouseY, (dimension_case)*0.75, (dimension_case)*0.75);
    }
    imageMode(CORNER);
  }


  public void display() {
    fill(200);
    rectMode(CENTER);
    imageMode(CENTER);
    stroke(50);
    strokeWeight(7);

    rect(x, y + 10*(1-intJoueur), l*dimension_case+20, (h+intJoueur)*dimension_case + 40*(1-intJoueur));
    if (joueur) {
      for (int i = 0; i < l; i++)
      {
        fill(150);
        rect(x + dimension_case * (i - (l / 2 - (1 - l%2) * (0.5 - l%2))), y + dimension_case * - (h / 2 - (1 - h%2) * (0.5 - h%2)) - dimension_case * 0.1, dimension_case-margeincase, dimension_case-margeincase);
        fill(0);
        text(str(inv[i][0][1]), x + dimension_case * (i - (l / 2 - (1 - l%2) * (0.5 - l%2))) - dimension_case * 0.24, y + dimension_case * - (h / 2 - (1 - h%2) * (0.5 - h%2)) +  (dimension_case-margeincase) * 0.45 - dimension_case * 0.12);
        if (inv[i][0][0] != -1)
        {
          image(construction[inv[i][0][0]], x + dimension_case * (i - (l / 2 - (1 - l%2) * (0.5 - l%2))), y + dimension_case * - (h / 2 - (1 - h%2) * (0.5 - h%2)) - dimension_case * 0.13, (dimension_case-margeincase)*0.65, (dimension_case-margeincase)*0.65);
        }
      }
    }
    for (int j = intJoueur; j < h; j++)
    {
      for (int i = 0; i < l; i++)
      {

        stroke(50);
        strokeWeight(7);
        fill(150);
        rect(x + dimension_case * (i - (l / 2 - (1 - l%2) * (0.5 - l%2))), y + dimension_case * (j - (h / 2 - (1 - h%2) * (0.5 - h%2))) +  dimension_case * 0.15, dimension_case-margeincase, dimension_case-margeincase);
        fill(0);
        text(str(inv[i][j][1]), x + dimension_case * (i - (l / 2 - (1 - l%2) * (0.5 - l%2))) - dimension_case * 0.24, y + dimension_case * (j - (h / 2 - (1 - h%2) * (0.5 - h%2))) +  (dimension_case-margeincase) * 0.45 + dimension_case * 0.12);
        if (inv[i][j][0] != -1)
        {
          image(construction[inv[i][j][0]], x + dimension_case * (i - (l / 2 - (1 - l%2) * (0.5 - l%2))), y + dimension_case * (j - (h / 2 - (1 - h%2) * (0.5 - h%2))) + dimension_case * 0.13, (dimension_case-margeincase)*0.65, (dimension_case-margeincase)*0.65);
        }
      }
    }
    rectMode(CORNER);
    imageMode(CORNER);
  }
  void hotbar() {
    rectMode(CENTER);
    imageMode(CENTER);
    stroke(50);
    strokeWeight(7);
    fill(200);
    rect(x, height - dimension_case + margeincase, l*dimension_case+20, dimension_case+20);
    for (int i = 0; i < l; i++)
    {
      if (i == select[0]) {
        fill(255);
      } else {
        fill(150);
      }
      rect(x + dimension_case * (i - (l / 2 - (1 - l%2) * (0.5 - l%2))), height - dimension_case + margeincase, dimension_case-margeincase, dimension_case-margeincase);
      fill(0);
      text(str(inv[i][0][1]), x + dimension_case * (i - (l / 2 - (1 - l%2) * (0.5 - l%2))) + dimension_case * 0.24, height - dimension_case + margeincase - dimension_case * 0.1);
      if (inv[i][0][0] != -1)
      {
        image(construction[inv[i][0][0]], x + dimension_case * (i - (l / 2 - (1 - l%2) * (0.5 - l%2))), height - dimension_case + margeincase, (dimension_case-margeincase)*0.70, (dimension_case-margeincase)*0.70);
      }
    }
    rectMode(CORNER);
    imageMode(CORNER);
  }

  boolean isInInventory(int[] tab) {
    boolean ok = false;
    for (int [][] i : this.inv) {
      for (int [] n : i) {
        if (n[0] == tab[0] && n[1] >= tab[1]) ok = true;
      }
    }
    return ok;
  }

  void delItem(int item, int quantite) {
    for (int [][] i : this.inv) {
      for (int [] n : i) {
        if (n[0] == item) {
          n[1] -= quantite;
          if (n[1]<= 0) {
            n[0] = -1;
            n [1] = 0;
          }
        }
      }
    }
  }

  boolean isEmpty() {
    boolean ok = true;
    for (int [][] i : this.inv) {
      for (int [] n : i) {
        if (n[0] != -1)ok = false;
      }
    }
    return ok;
  }
}
