import 'package:test/test.dart';
import 'package:carrom_game/models/player.dart';      // Import the Player class
import 'package:carrom_game/models/game.dart';        // Import the Game class

void main() {
  group('Player Class Initial Values', () {
    test('score should start at 0', () {
      expect(Player().getScore(), 0);
    });
    test('idle count should start at 0', () {
      expect(Player().getIdleCount(), 0);
    });
    test('foul count should start at 0', () {
      expect(Player().getFoulCount(), 0);
    });
  });

  group('Player Class Change Values', () {
    final Player player = Player();

    test('score should be changed', () {
      player.setScore(1);
      expect(player.getScore(), 1);
    });

    test('idle count should be changed', () {
      player.setIdleCount(1);
      expect(player.getIdleCount(), 1);
    });

    test('foul count should be changed', () {
      player.setFoulCount(1);
      expect(player.getFoulCount(), 1);
    });
  });

  group('Game Class Tests', () {
    final game = Game();

    test('initial turn should be with player 1', () {
      expect(game.getCurrentPlayer(), 1);
    });

    test('switching turn should change to player 2', () {
      game.actions(6);  // simulate idle pass (change player)
      expect(game.getCurrentPlayer(), 2);
    });

    test('player should score after a strike', () {
      game.actions(1);  // simulate strike
      expect(game.getPlayerScore(0), 1);
    });

    test('player should lose points after striker strike (foul)', () {
      game.actions(4);  // simulate striker strike (foul)
      expect(game.getPlayerScore(0), -1);
    });

    test('red coin strike should add 3 points', () {
      game.setRedCoins(1);   // ensure there's 1 red coin
      game.actions(3);  // simulate red coin strike
      expect(game.getPlayerScore(0), 3);
    });

    test('defunct coin scenario should subtract points', () {
      game.setBlackCoins(2); // ensure there are black coins
      game.actions(5);  // simulate defunct coin scenario
      expect(game.getPlayerScore(0), -2);
    });
  });
}
