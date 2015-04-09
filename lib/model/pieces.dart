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

class Cloud extends MovablePiece {
  Cloud(int id): super(id) {
    randomInit();
    width = 80;
    height = 56;
    shape = PieceShape.IMG;
    imgId = 'cloud';
  }
}

class Creature extends MovablePiece {
  Creature(int id): super(id) {
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
    for (var i = 1; i <= count; i++) {
      add(new Cloud(i));
    }
  }
}

class Creatures extends MovablePieces {
  Creatures(int count): super(count);

  createMovablePieces(int count) {
    for (var i = 1; i <= count; i++) {
      add(new Creature(i));
    }
  }
}

class YellowLine extends MovablePiece {
  YellowLine nextLine;

  YellowLine(int id): super(id) {
    width = 15;
    height = 50;
    color.main = 'yellow';
    color.border = 'yellow';
    speed.dy = 4;
    shape = PieceShape.RECT;
  }

  calcY() {
    if (nextLine == null) {
      y = -height;
    } else {
      y = nextLine.y - height * 1.5;
    }
  }
 }

class YellowLines extends MovablePieces {
  YellowLines(int count): super(count);

  createMovablePieces(int count) {
    var nextLine = new YellowLine(0);
    nextLine.y = -nextLine.height;
    var currentLine;
    for (var i = 1; i < count; i++) {
      currentLine = new YellowLine(i);
      currentLine.nextLine = nextLine;
      nextLine = currentLine;
      add(currentLine);
    }
  }

  calcY() {
    for (var line in this) {
      if (line.nextLine == null) {
        line.y = -line.height;
      }
    }
    for (var line in this) {
      if (line.nextLine != null) {
        line.y = line.nextLine.y - line.height * 1.5;
      }
    }
  }

  moveDown() {
    for (var line in this) {
      line.y += line.speed.dy;
      if (line.y > line.space.height) {
        line.calcY();
      }
    }
  }
}