import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../models/game_factory.dart';
import '../models/game_state.dart';

class GameScreen extends StatefulWidget {
  final String difficulty;                                       
  const GameScreen({super.key, required this.difficulty});       

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  late Game game;                                                          // เกมปัจจุบัน
  final TextEditingController guessController = TextEditingController();   // ควบคุม input ตัวเลข
  String hintMessage = "";                                                 // ข้อความแนะนำผู้เล่น
  List<int> guessedNumbers = [];                                           // เก็บเลขที่ทายไปแล้ว

  @override
  void initState() {
    super.initState();
    game = GameFactory.createGame(widget.difficulty);        // สร้างเกมตามระดับใช้ GameFactory
    hintMessage = game.state.getMessage();                   // แสดงข้อความเริ่มต้น
  }

  // ฟังก์ชันกดปุ่ม Guess
  void makeGuessButton() {
    if (!game.state.canGuess()) return;

    int? guess = int.tryParse(guessController.text);
    if (guess == null) return;

    if (guess < 1 || guess > game.range) {
      setState(() => hintMessage = "กรอกเลข 1–${game.range} เท่านั้น");
      return;
    }

    setState(() {
      guessedNumbers.add(guess);
      game.makeGuess(guess);

      // อัปเดตข้อความตาม state
      if (game.state is WonState) {
        hintMessage = "คุณชนะ!";
      } else if (game.state is LostState) {
        hintMessage = "คุณแพ้ ตัวเลขคือ ${game.target}";
      } else {
        hintMessage = game.getHint(guess);
      }

      guessController.clear();
    });
  }

  // ฟังก์ชันกดปุ่ม Reset
  void resetGameButton() {
    setState(() {
      game.reset();
      hintMessage = game.state.getMessage();
      guessController.clear();
      guessedNumbers.clear();
    });
  }

  // เลือกสีข้อความตาม state
  Color getMessageColor() {
    if (game.state is WonState) return Colors.greenAccent;
    if (game.state is LostState) return Colors.redAccent;
    return Colors.yellowAccent;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,  // ปิดไม่ให้ scaffold ขยับเวลา keyboard โผล่
      body: Stack(
        children: [
          
          // Background image
          Positioned.fill(
            child: Image.asset(
              "assets/images/background1.jpg",
              fit: BoxFit.cover,
              alignment: const Alignment(-0.4, 0.0),
            ),
          ),

          // Overlay ดำโปร่งแสง
          Positioned.fill(
            child: Container(color: Colors.black.withValues(alpha: 0.2)),
          ),
          SafeArea(
            child: GestureDetector(
              onTap: () => FocusScope.of(context).unfocus(),                    // แตะพื้นที่อื่นซ่อน keyboard
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(10),
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    minHeight: MediaQuery.of(context).size.height - 40,
                  ),
                  child: IntrinsicHeight(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        // ชื่อเกม
                        _Title(),
                        
                        const SizedBox(height: 20),
 
                        // Hint Box กล่องแสดงข้อความคำใบ้
                        HintBox(message: hintMessage, color: getMessageColor()),
                        
                        const SizedBox(height: 10),

                        // แสดงเลขที่ทายไปแล้ว
                        if (guessedNumbers.isNotEmpty)
                          GuessHistory(
                            guessedNumbers: guessedNumbers,
                            target: game.target,
                          ),
                          const SizedBox(height: 10),

                        // ช่องกรอกเลข
                        _InputField(
                          controller: guessController,
                          range: game.range,
                        ),

                        const SizedBox(height: 10),

                        // ปุ่ม Guess
                        _GuessButton(
                          onPressed: game.state.canGuess()
                              ? makeGuessButton
                              : null,
                        ),

                        const SizedBox(height: 15),

                        // แสดงจำนวนครั้งที่เหลือ
                        _Attempts(attempts: game.attempts),

                        const Spacer(),

                        // ปุ่ม Reset
                        _ResetButton(onPressed: resetGameButton),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// =================== Widgets ย่อย ===================

// Title ของเกม
class _Title extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Text(
      "NUMBER GUESS GAME",
      textAlign: TextAlign.center,
      style: Theme.of(context).textTheme.headlineSmall,
    );
  }
}

// Hint Box กล่องแสดงข้อความคำใบ้
class HintBox extends StatelessWidget {
  final String message;
  final Color color;
  const HintBox({super.key, required this.message, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.black.withValues(alpha: 0.7),
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: Colors.orangeAccent, width: 3),
        boxShadow: [
          BoxShadow(
            color: Colors.orange.withValues(alpha: 0.7),
            blurRadius: 10,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Text(
        message,
        textAlign: TextAlign.center,
        style: Theme.of(context).textTheme.bodyLarge!.copyWith(color: color),
      ),
    );
  }
}

// แสดงประวัติเลขที่ทายไปแล้ว
class GuessHistory extends StatelessWidget {
  final List<int> guessedNumbers;
  final int target;
  const GuessHistory({
    super.key,
    required this.guessedNumbers,
    required this.target,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.black.withValues(alpha: 0.5),
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: Colors.yellowAccent, width: 2),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("เลขที่ทายไปแล้ว", style: Theme.of(context).textTheme.bodyLarge),
          const SizedBox(height: 5),
          Wrap(
            alignment: WrapAlignment.start, 
            spacing: 8,
            runSpacing: 8,
            children: guessedNumbers.map((n) {
              Color chipColor;
              if (n == target) {
                chipColor = Colors.greenAccent;
              } else if (n < target) {
                chipColor = Colors.lightBlueAccent;
              } else {
                chipColor = Colors.redAccent;
              }
              return Chip(
                label: Text(
                  n.toString(),
                  style: const TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                backgroundColor: chipColor,
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}

// ช่องกรอกตัวเลข
class _InputField extends StatelessWidget {
  final TextEditingController controller;
  final int range;
  const _InputField({required this.controller, required this.range});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: TextField(
        controller: controller,
        keyboardType: TextInputType.number,
        textAlign: TextAlign.center,
        style: GoogleFonts.nunito(
          fontSize: 20,
          color: Colors.white,
          fontWeight: FontWeight.w600,
        ),
        decoration: InputDecoration(
          filled: true,
          fillColor: Colors.black.withValues(alpha: 0.6),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: const BorderSide(color: Colors.yellowAccent, width: 3),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: const BorderSide(color: Colors.yellowAccent, width: 3),
          ),
          labelText: "กรอกตัวเลข (1-$range)",
          labelStyle: Theme.of(context).textTheme.bodyMedium,
        ),
      ),
    );
  }
}

// ปุ่ม Guess
class _GuessButton extends StatelessWidget {
  final VoidCallback? onPressed;
  const _GuessButton({required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: onPressed != null ? Colors.orangeAccent : Colors.grey,
        padding: const EdgeInsets.symmetric(vertical: 8),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
          side: const BorderSide(color: Colors.yellowAccent, width: 3),
        ),
        elevation: 12,
        shadowColor: Colors.orangeAccent,
      ),
      child: Text(
        "GUESS",
        style: GoogleFonts.pressStart2p(fontSize: 14, color: Colors.black),
      ),
    );
  }
}

// แสดงจำนวนครั้งที่เหลือ
class _Attempts extends StatelessWidget {
  final int attempts;
  const _Attempts({required this.attempts});

  @override
  Widget build(BuildContext context) {
    return Text(
      "ครั้งที่เหลือ: $attempts",
      textAlign: TextAlign.center,
      style: GoogleFonts.nunito(
        fontSize: 20,
        fontWeight: FontWeight.w600,
        color: Colors.white,
      ),
    );
  }
}

// ปุ่ม Reset
class _ResetButton extends StatelessWidget {
  final VoidCallback onPressed;
  const _ResetButton({required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.redAccent,
        padding: const EdgeInsets.symmetric(vertical: 8),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
          side: const BorderSide(color: Colors.yellowAccent, width: 3),
        ),
        elevation: 12,
        shadowColor: Colors.redAccent,
      ),
      child: Text(
        "RESET",
        style: GoogleFonts.pressStart2p(fontSize: 14, color: Colors.black),
      ),
    );
  }
}