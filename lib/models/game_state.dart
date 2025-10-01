// -------- State --------
abstract class GameState {
  String getMessage();                     // ข้อความตาม state
  bool canGuess();                         // สามารถเดาได้หรือไม่
}


// -------- Concrete States --------
class PlayingState implements GameState {
  final int range;
  PlayingState(this.range);

  @override
  String getMessage() => "ทายตัวเลข (1-$range)";
 
  @override
  bool canGuess() => true;
}

class WonState implements GameState {
  @override
  String getMessage() => "คุณชนะแล้ว";
  
  @override
  bool canGuess() => false;
}

class LostState implements GameState {
  @override
  String getMessage() => "เกมจบ คุณแพ้";
  
  @override
  bool canGuess() => false;
}