import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'game.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String? selectedDifficulty;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage(
              "assets/images/background2.jpg",
            ), // พื้นหลังทะเลทราย
            fit: BoxFit.cover,
            alignment: Alignment(-0.8, 0.0),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              const SizedBox(height: 40),

              // หัวข้อเกม
              Text(
                "NUMBER GUESS GAME",
                textAlign: TextAlign.center,
                style: GoogleFonts.pressStart2p(
                  fontSize: 24,
                  color: Colors.yellowAccent,
                  shadows: [
                    Shadow(
                      offset: const Offset(3, 3),
                      blurRadius: 10,
                      color: Colors.red.withValues(alpha: 0.8),
                    ),
                    Shadow(
                      offset: const Offset(-3, -3),
                      blurRadius: 10,
                      color: Colors.greenAccent.withValues(alpha: 0.8),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 30),

              // กล่องดำครอบปุ่มเลือกความยาก + ปุ่มเริ่มเกม
              Container(
                width: double.infinity, //ทำให้กว้างเต็มจอ
                margin: const EdgeInsets.symmetric(
                  horizontal: 10,
                ), // <<< เว้นระยะซ้ายขวา
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.black.withValues(alpha: 0.5), // ดำโปร่ง
                  borderRadius: BorderRadius.circular(15),
                  border: Border.all(color: Colors.yellowAccent, width: 2),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.orange.withValues(alpha: 0.5),
                      blurRadius: 10,
                      offset: const Offset(0, 6),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    Text(
                      "เลือกระดับความยาก",
                      style: GoogleFonts.nunito(
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                        shadows: [
                          const Shadow(
                            offset: Offset(1, 1),
                            blurRadius: 6,
                            color: Colors.black,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),

                    buildGameButton("ง่าย EASY", "easy", Colors.green),
                    const SizedBox(height: 15),
                    buildGameButton(
                      "ปานกลาง MEDIUM",
                      "medium",
                      Colors.orangeAccent,
                    ),
                    const SizedBox(height: 15),
                    buildGameButton("ยาก HARD", "hard", Colors.redAccent),

                    const SizedBox(height: 30),

                    // ปุ่มเริ่มเกม
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(
                          vertical: 18,
                          horizontal: 50,
                        ),
                        backgroundColor: selectedDifficulty == null
                            ? const Color.fromARGB(255, 113, 111, 111)
                            : Colors.amber,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                          side: const BorderSide(color: Colors.black, width: 3),
                        ),
                        elevation: 12,
                        shadowColor: Colors.orange,
                      ),
                      onPressed: selectedDifficulty == null
                          ? null
                          : () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => GameScreen(
                                    difficulty: selectedDifficulty!,
                                  ),
                                ),
                              );
                            },
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Image.asset(
                            "assets/images/play_icon.png",
                            width: 24,
                            height: 24,
                          ),
                          const SizedBox(width: 15),
                          Text(
                            "เริ่มเกม",
                            style: GoogleFonts.pressStart2p(
                              fontSize: 16,
                              color: Colors.black,
                              shadows: const [
                                Shadow(
                                  offset: Offset(2, 2),
                                  blurRadius: 4,
                                  color: Colors.white,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 30),

              // กติกาเกม
              Expanded(
                child: SingleChildScrollView(
                  child: Container(
                    width: double.infinity, //ทำให้กว้างเต็มจอ
                    margin: const EdgeInsets.symmetric(
                      horizontal: 10,
                    ), // <<< เว้นระยะซ้ายขวา
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Colors.black.withValues(alpha: 0.6),
                      border: Border.all(color: Colors.yellowAccent, width: 2),
                      borderRadius: BorderRadius.circular(15),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.orange.withValues(alpha: 0.5),
                          blurRadius: 10,
                          offset: const Offset(0, 6),
                        ),
                      ],
                    ),
                    child: Text(
                      "กติกา\n\n"
                      "1. เลือกระดับความยาก\n"
                      "2. ระบบสุ่มเลขลับ\n"
                      "3. เดาตัวเลขได้ตามจำนวนครั้ง\n"
                      "4. ระบบใบ้: สูงไป ต่ำไป\n"
                      "5. หากเดาถูกก่อนจำนวนครั้งที่เหลือจะชนะเกม\n"
                      "6. หากจำนวนครั้งที่เหลือหมดก่อนเดาถูกจะแพ้เกม",
                      style: GoogleFonts.nunito(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                        height: 1.5,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ฟังก์ชันสร้างปุ่มเลือกความยาก
  Widget buildGameButton(String text, String difficulty, Color color) {
    final isSelected = selectedDifficulty == difficulty;

    return SizedBox(
      width: double.infinity, // กว้างสุดในแนวนอน
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: isSelected ? color : Colors.blueGrey,
          padding: const EdgeInsets.symmetric(vertical: 18),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          overlayColor: Colors.transparent,
          side: isSelected
              ? const BorderSide(color: Colors.yellowAccent, width: 2)
              : null,
        ),
        onPressed: () {
          setState(() {
            selectedDifficulty = difficulty;
          });
        },
        child: Text(
          text,
          textAlign: TextAlign.center, // จัดข้อความให้อยู่กลาง
          style: GoogleFonts.pressStart2p(fontSize: 14, color: Colors.white),
        ),
      ),
    );
  }
}
