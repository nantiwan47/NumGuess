import 'dart:math';
import 'game_state.dart';

// -------- Abstract Product --------
abstract class Game {
  int target;                                      // เลขเป้าหมายที่ต้องเดา
  int maxAttempts;                                 // จำนวนครั้งเดาสูงสุด (ขึ้นกับระดับความยาก)
  int range;                                       // ขอบเขตตัวเลขที่สุ่มได้
  int attempts;                                    // จำนวนครั้งที่เหลือ
  GameState state;                                 // Context ที่เก็บ State สถานะของเกม (Playing, Won, Lost)

  Game(this.target, this.maxAttempts, this.range)
    : attempts = maxAttempts,
      state = PlayingState(range); 

  String getHint(int guess);                       // ส่งคำตอบเมื่อผู้เล่นเดา

  void makeGuess(int guess);                       // ตรวจคำตอบและอัปเดต state

  void reset();
}


// -------- Concrete class --------
class EasyGame extends Game {
  EasyGame() : super(Random().nextInt(50) + 1, 12, 50);

  @override
  String getHint(int guess) {
    if (guess > target) {
      return "สูงเกินไป";
    } else if (guess < target) {
      return "ต่ำเกินไป";
    } else {
      return "ถูกต้อง";
    }
  }

  @override
  void makeGuess(int guess) {
    attempts--;
    if (guess == target) {
      state = WonState();
    } else if (attempts <= 0) {
      state = LostState();
    }
  }

  @override
  void reset() {
    target = Random().nextInt(50) + 1;
    attempts = maxAttempts;
    state = PlayingState(range); 
  }
}

class MediumGame extends Game {
  MediumGame() : super(Random().nextInt(100) + 1, 8, 100);

  @override
  String getHint(int guess) {
    if (guess > target) {
      return "สูงเกินไป";
    } else if (guess < target) {
      return "ต่ำเกินไป";
    } else {
      return "ถูกต้อง";
    }
  }

   @override
  void makeGuess(int guess) {
    attempts--;
    if (guess == target) {
      state = WonState();
    } else if (attempts <= 0) {
      state = LostState();
    }
  }

  @override
  void reset() {
    target = Random().nextInt(100) + 1;
    attempts = maxAttempts;
    state = PlayingState(range); 
  }
}

class HardGame extends Game {
  HardGame() : super(Random().nextInt(200) + 1, 6, 200);

  @override
  String getHint(int guess) {
    if (guess > target) {
      return "สูงเกินไป";
    } else if (guess < target) {
      return "ต่ำเกินไป";
    } else {
      return "ถูกต้อง";
    }
  }

   @override
  void makeGuess(int guess) {
    attempts--;
    if (guess == target) {
      state = WonState();
    } else if (attempts <= 0) {
      state = LostState();
    }
  }

  @override
  void reset() {
    target = Random().nextInt(200) + 1;
    attempts = maxAttempts;
    state = PlayingState(range); 
  }
}


// -------- Factory Class --------
class GameFactory {
  static Game createGame(String difficulty) {
    switch (difficulty.toLowerCase()) {
      case 'easy':
        return EasyGame();
      case 'medium':
        return MediumGame();
      case 'hard':
        return HardGame();
      default:
        return EasyGame();
    }
  }
}