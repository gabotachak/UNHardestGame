float control = 2;
float posicion_inicial_x = 60;
float posicion_inicial_y = 120;
float personaje_x = posicion_inicial_x;
float personaje_y = posicion_inicial_y;
float personaje_radio = 9;
float personaje_velocidad_x = 1.75;
float personaje_velocidad_y = 1.75;
color personaje_color = color(255, 0, 0);
color inicio_final = color(0, 255, 0);
boolean mover_izq, mover_der, mover_arriba, mover_abajo; 
boolean colision_personaje = false;
boolean llave;
int ev = 3;
int indiceenemigo = ev;
int muertes;
float[] posxenemigo = new float[20];
float[] posyenemigo = new float[20];

void setup() {
    size(720, 240);
    muertes = 0;
    llave = false;
    for (int i = 0; i < 20; i++) {
        posxenemigo[i] = height / 2;
        posyenemigo[i] = 132 + (24 * i);
    }
}

void draw() {
    background(0);
    textSize(20);
    text("Muertes: ", 10, 30);
    text(muertes, 10, 60);
    if (llave == true) {
        text(1,10,100);
    }
    stroke(255, 255, 0);
    strokeWeight(0);
    fill(inicio_final);
    stroke(inicio_final);
    rect(0, 80, 120, 80);
    rect(600, 80, 600, 80);
    fill(255);
    stroke(255);
    rect(120, 0, 480, 240);
    colision_personaje(personaje_x, personaje_y, posxenemigo,posyenemigo);
    cogerllave(personaje_x, personaje_y);
    if ((personaje_x <= 601) || (llave == false)) {
        dibujaPersonaje(personaje_x, personaje_y, personaje_radio + 1, personaje_color);
        dibujaEnemigos(personaje_radio - 1);
        if (llave == false) {
            dibujallaves();
        }
        //dibuje aqui a los enemigos
        actualizarPersonaje(personaje_velocidad_x, personaje_velocidad_y);
        if (posxenemigo[0] <= 11) {
            indiceenemigo = ev;
        }
        if (posxenemigo[0] >= height - 11) {
            indiceenemigo = - ev;
        }
        actualizarenemigo(posxenemigo, indiceenemigo);
    } else{
        fill(255,0,0);
        textSize(50);
        text("Ganaste", width / 2 - 100, height / 2);
    }
}
//FUNCIONES DEL ENEMIGO
void dibujaEnemigos(float radio) {
    pushStyle();
    noStroke();
    fill(0, 0, 255);
    for (int i = 0; i < 20; ++i) {
       ellipse(posyenemigo[i], posxenemigo[i], radio * 2, radio * 2);
    }
    popStyle();
}
void dibujaPersonaje(float x, float y, float radio, color c) {
    pushStyle();
    noStroke();
    fill(c);
    ellipse(x, y, 2 * radio, 2 * radio);
    popStyle();
}
void dibujallaves() {
    pushStyle();
    stroke(0);
    strokeWeight(1);
    fill(255,255,0);
    ellipse(width / 2, height / 2, 2 * 4, 2 * 4);
    popStyle();
}
void colision_personaje(float px, float py, float[] ex, float[] ey) {
    for (int i = 0; i < 20; i++) {
        if (sqrt(sq(ex[i] - py) + sq(ey[i] - px))<= 18) {
            personaje_x = posicion_inicial_x;
            personaje_y = posicion_inicial_y;
            muertes++;
            llave = false;
        }
    }
}
void cogerllave(float px, float py) {
    if (sqrt(sq((height / 2) - py) + sq((width / 2) - px))<= 14) {
        llave = true;
    }
}

void actualizarPersonaje(float velocidad_x, float velocidad_y) {
    if(((personaje_x >= 12) && (personaje_y >= 92) && (personaje_x <= 708) && (personaje_y <= 148)) || ((personaje_x >= 132) && (personaje_y >= 12) && (personaje_x <= 588) && (personaje_y <= 228))) {
        if (mover_izq) personaje_x -= velocidad_x;
        if (mover_der) personaje_x += velocidad_x;
        if (mover_arriba) personaje_y -= velocidad_y;
        if (mover_abajo) personaje_y += velocidad_y;
    } else {
        if (personaje_x < 12) {
            personaje_x++;
        }
        if (personaje_x > 708) {
            personaje_x--;
        }
        if (personaje_y < 12) {
            personaje_y++;
        }
        if (personaje_y > 228) {
            personaje_y--;
        }
        if ((personaje_x < 132) && (personaje_y < 92)) {
           if (132 - personaje_x >= 92 - personaje_y) {
                personaje_y++;
        } else {
                personaje_x++;
        }
        }
        if ((personaje_x < 132) && (personaje_y > 148)) {
           if (132 - personaje_x >= personaje_y - 148) {
                personaje_y--;
        } else {
                personaje_x++;
        }
        }
        if ((personaje_x > 588) && (personaje_y < 92)) {
           if (personaje_x - 588 >= 92 - personaje_y) {
                personaje_y++;
        } else {
                personaje_x--;
        }
        }
        if ((personaje_x > 588) && (personaje_y > 148)) {
           if (personaje_x - 588 >= personaje_y - 148) {
                personaje_y--;
        } else {
                personaje_x--;
        }
        }
    }
}

void actualizarenemigo(float[] posxenemigo, int k) {
    for (int i = 0; i < 20; i++) {
        if (i % 2 == 0) {
            posxenemigo[i] +=k;
     } else{
            posxenemigo[i] -=k;
     }
    }
}

void moverPersonaje(boolean activar) {
    switch(keyCode) {
        case LEFT:
    {
            mover_izq = activar;
            break;
        }
        case UP:
    {
            mover_arriba = activar;
            break;
        }
        case RIGHT:
    {
            mover_der = activar;
            break;
        }
        case DOWN:
    {
            mover_abajo = activar;
            break;
        }
    }
}

void keyPressed() {
    if(key == CODED) {
        moverPersonaje(true);
    }
}

void keyReleased() {
    if(key == CODED) {
        moverPersonaje(false);
    }
}
