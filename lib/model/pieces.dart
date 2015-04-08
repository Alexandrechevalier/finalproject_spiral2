part of finalproject;

class Spaceship extends MovablePiece {  
  Spaceship() {
    randomInit();
    width = 70;
    height = 70;
    shape = PieceShape.IMG;
    imgId = 'spaceship';
    videoId = 'invader';
    usesVideo = false;
  }
}

class Laser extends MovablePiece {  
  Laser() {
    randomInit();
    width = 4;
    height = 50;
    color.main = 'gray';
    color.border = 'red';
    speed.dy = 6;
    shape = PieceShape.RECT;
    isVisible = false;
    audioId = 'collision';
    usesAudio = true;
  }
}
class YellowLine extends MovablePiece {
  YellowLine(int id) {
    x = 200;
    //y = 50;
    width = 15;
    height = 50;
    color.main = 'yellow';
    color.border = 'yellow';
    speed.dy = 6;
    shape = PieceShape.RECT;
  }
  
  moveDown(){
    y += speed.dy;
  }
 }

class Cloud extends MovablePiece {  
  Cloud(int id) {
    randomInit();
    width = 80;
    height = 56;
    shape = PieceShape.IMG;
    imgId = 'cloud';
  }
}

class Creature extends MovablePiece {  
  Creature(int id) {
    randomExtraInit();
    width = 48;
    height = 64;
    if (dy < 2) {
      dy = 2;
    }
    if (dx >= dy) {
      dx = dy - 1;
    } 
    y = -y;
    var ri = randomInt(7);
    isTagged = false;
    dx = randomSign(ri) * dx; 
    shape = PieceShape.IMG;
    imgId = 'creature';
  }
}

class Clouds extends MovablePieces {
  Clouds(int count): super(count);

  createMovablePieces(int count) {
    var id = 0;
    for (var i = 0; i < count; i++) {
      add(new Cloud(++id));
    }
  }
}

class Creatures extends MovablePieces {
  Creatures(int count): super(count);

  createMovablePieces(int count) {
    var id = 0;
    for (var i = 0; i < count; i++) {
      add(new Creature(++id));
    }
  }
}

class YellowLines extends MovablePieces {
  YellowLines(int count): super(count);

  createMovablePieces(int count) {
    var id = 0;
    for (var i = 0; i < count; i++) {
      var ligne = new YellowLine(++id);
      if (i == 0) {
        ligne.y = 20;
      }else if(i == 1){
        ligne.y == 100;
      }else if(i == 2){
        ligne.y == 200;
      }else if(i == 3){
        ligne.y == 300;
      }else if(i == 4){
        ligne.y == 400;
      }else if(i == 5){
        ligne.y == 500;
      }
      add(ligne);
    }
  } 
}