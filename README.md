# แอปพลิเคชันเกมทายตัวเลข (Number Guess Game App)

แอปพลิเคชันเกมทายตัวเลขเป็น Mini project ในรายวิชา Software Design and Pattern 68/1 และพัฒนาด้วย Flutter เพื่อให้ผู้เล่นทายตัวเลขที่สุ่มขึ้นภายในช่วงและจำนวนครั้งที่กำหนด แอปนี้ใช้ **GoF Design Patterns** (Factory Method และ State Pattern) เพื่อจัดการการสร้างเกมและสถานะของเกม

### วัตถุประสงค์ของซอฟต์แวร์
- ให้ผู้เล่นทายตัวเลขที่ระบบสุ่มไว้
- ใช้ **Factory Method Pattern** เพื่อสร้างเกมตามระดับความยาก (Easy, Medium, Hard)
- ใช้ **State Pattern** เพื่อจัดการสถานะของเกม (Playing, Won, Lost)

### ปัญหาที่สนใจ
- เมื่อผู้เล่นทายตัวเลขผิดหลายครั้ง ระบบต้องสามารถบอกว่าควรทายสูงหรือต่ำได้
- ต้องจัดการ State ของเกมให้เหมาะสม เช่น เล่นต่อได้ ชนะ แพ้ และต้องอัปเดต UI ตาม State

### Pattern ที่เลือกใช้และเหตุผล

#### 1. Factory Method Pattern

* ใช้สำหรับสร้าง instance ของเกมแต่ละระดับความยาก (EasyGame, MediumGame, HardGame)
* ตัว Factory (`GameFactory`) ช่วยสร้างเกมโดยไม่ต้องรู้ class ที่แท้จริง
* หากต้องการเพิ่มระดับความยากใหม่ในอนาคต สามารถทำได้ง่ายโดยไม่กระทบโค้ดเดิม

#### 2. State Pattern

* เนื่องจากเกมมีหลาย **State** ได้แก่

  * `PlayingState`: เกมกำลังเล่น
  * `WonState`: ผู้เล่นชนะ
  * `LostState`: ผู้เล่นแพ้
* แต่ละ State มีพฤติกรรมแตกต่างกัน เช่น ปุ่ม GUESS ใช้ได้หรือไม่ได้ และแสดงข้อความ Hint ยังไง โดยการใช้ State Pattern ช่วยแยก Logic ตาม State ออกจากกัน ทำให้โค้ดสะอาดและแก้ไขง่าย

### หน้าตาเกม (ตัวอย่าง)

<table align="center">
  <tr>
    <td><img src="https://github.com/user-attachments/assets/d9e765fa-4ccd-4a7f-b3c7-29f77044a704" width="120"/></td>
    <td><img src="https://github.com/user-attachments/assets/796df500-63a9-4dbd-b725-4f9e5adccf61" width="120"/></td>
    <td><img src="https://github.com/user-attachments/assets/3e34f523-9f43-4fc5-978e-f792d6677094" width="120"/></td>
  </tr>
</table>

### การติดตั้งและรันโปรเจกต์

#### 1. Clone โปรเจกต์
```bash
git clone https://github.com/nantiwan47/NumGuess.git
cd NumGuess
````

#### 2. ติดตั้ง Dependencies

```bash
flutter pub get
```

#### 3. รันแอป

* **บน Chrome (Web)**

```bash
flutter run -d chrome
```

* **บน Emulator หรือ Device**

```bash
flutter run
```
