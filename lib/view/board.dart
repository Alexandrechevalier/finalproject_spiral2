part of finalproject;

class Board extends Surface {
  Pieces clouds, creatures;
  Piece laser, spaceship;
  YellowLines yellowLines;
  AudioElement hitSound;
 // VideoElement invaderVideo; SURMENT A SUPP

  Board(CanvasElement canvas) {
    this.canvas = canvas;
    clouds = new Clouds(5);
    creatures = new Creatures(7);
    spaceship = new Spaceship();
    yellowLines = new YellowLines(9);
    laser = new Laser();
    hitSound = document.querySelector('#${laser.audioId}');
   // invaderVideo = document.querySelector('#${spaceship.videoId}'); SURMENT A SUPP
   // invaderVideo.hidden = true; SURMENT A SUPP
    canvas.onMouseMove.listen((MouseEvent e) {
      spaceship.x = e.offset.x - spaceship.width  / 2;
      spaceship.y = e.offset.y - spaceship.height / 2;
    });
    canvas.onMouseDown.listen((MouseEvent e) {
      laser.x = e.offset.x;
      laser.y = e.offset.y - spaceship.height;
      laser.isVisible = true;
    });

    yellowLines.forEach((YellowLine yellowLine) {
      yellowLine.space = area;
      yellowLine.x = yellowLine.space.width / 2;
    });
    yellowLines.calcY();
  }

  background() {
    context
        //..fillStyle = 'black'
        ..beginPath()
        ..fillRect(0, 0, width, height)
        ..closePath();
  }

  clear() {
    super.clear();
    background();
  }

  draw() {
    clear();
    drawRect(canvas, 0, 0, width, height, color: 'black', borderColor: 'red');

    yellowLines.moveDown();
    yellowLines.forEach((YellowLine yellowLine) {
      drawPiece(yellowLine);
    });

    if (creatures.any((Piece p) => p.isVisible)) {
      clouds.forEach((Cloud cloud) {
        cloud.move(Direction.UP);
        //cloud.minMaxSpace.minSize = new Size(width, height);
        //cloud.minMaxSpace.maxSize = new Size(width + cloud.width, height + cloud.height);
        drawPiece(cloud);
      });
      creatures.forEach((Creature creature) {
        if (creature.isVisible) {
          creature.move(Direction.DOWN);
          //creature.x += creature.dx;
          if (creature.x < 0 || creature.x > width) {
            creature.x = randomNum(width);
          }
          if (creature.isSelected && (creature.x < 0 || creature.y < 0)) {
            creature.isVisible = false;
          }
          if (!creature.isSelected && laser.isVisible && laser.hit(creature)) {
            creature.isSelected = true;
            if (creature.isCovered) {
              creature.tag.text = '\$';
              creature.tag.size = 32;
              creature.isTagged = true;
            } else {
              creature.imgId = 'explosion';
            }
            hitSound.load();
            hitSound.play();
            laser.isVisible = false;
          }
          drawPiece(creature);
        }
      });
      if (laser.isVisible) {
        laser.y = laser.y - 6;
        if (laser.y + laser.height < 0) {
          laser.isVisible = false;
        }
        drawPiece(laser);
      }
      drawPiece(spaceship);
    /*} else if (spaceship.usesVideo) {
      invaderVideo.hidden = false;
      invaderVideo.play();*/
    }
  }
}

