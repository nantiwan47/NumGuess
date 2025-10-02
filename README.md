# แอปพลิเคชันเกมทายตัวเลข (Number Guess Game App)

แอปพลิเคชันเกมทายตัวเลขเป็น Mini project ในรายวิชา Software Design and Pattern 68/1 พัฒนาด้วย Flutter เพื่อให้ผู้เล่นทายตัวเลขที่สุ่มขึ้นภายในช่วงและจำนวนครั้งที่กำหนด แอปนี้ใช้ **GoF Design Patterns** (Factory Method และ State Pattern) เพื่อจัดการการสร้างเกมและสถานะของเกม

### วัตถุประสงค์ของซอฟต์แวร์

- เพื่อพัฒนาแอปพลิเคชันเกมทายตัวเลข  
- เพื่อให้ผู้เล่นสามารถทายตัวเลขที่ระบบสุ่มไว้ภายในช่วงและจำนวนครั้งที่กำหนด โดยระบบช่วยแนะนำว่าควรทายตัวเลขสูงขึ้นหรือต่ำลง  
- เพื่อให้ผู้เล่นสามารถเลือกกำหนดระดับความยากได้ (Easy, Medium, Hard)  

### ปัญหาที่สนใจ
- เมื่อผู้เล่นทายตัวเลขผิดหลายครั้ง ระบบต้องสามารถบอก Hint ได้อย่างถูกต้องว่าควรทายสูงขึ้นหรือต่ำลง
- ต้องมีการจัดการ State ของเกมให้เหมาะสม เช่น ขณะเล่นอยู่ (Playing) เมื่อผู้เล่นชนะ (Won) และเมื่อผู้เล่นแพ้ (Lost)
- UI ต้องอัปเดตตาม State ของเกม เพื่อให้ผู้เล่นเข้าใจสถานะปัจจุบันได้ทันที

### Pattern ที่เลือกใช้และเหตุผล

#### 1. Factory Method Pattern

* ใช้สำหรับสร้าง instance ของเกมแต่ละระดับความยาก (EasyGame, MediumGame, HardGame)
* ตัว Factory (`GameFactory`) ช่วยสร้างเกมโดยไม่ต้องรู้ class ที่แท้จริง
* หากต้องการเพิ่มระดับความยากใหม่ในอนาคต สามารถทำได้ง่ายโดยไม่กระทบโค้ดหลัก

#### 2. State Pattern

* ใช้เพื่อจัดการพฤติกรรมของเกมตามสถานะ ได้แก่

  * `PlayingState`: เกมกำลังเล่น
  * `WonState`: ผู้เล่นชนะ
  * `LostState`: ผู้เล่นแพ้
* แต่ละ State มีพฤติกรรมแตกต่างกัน เช่น การอัปเดต Hint และการเปิด/ปิดปุ่มทาย
* ช่วยลดการใช้ if-else ซ้ำซ้อน ทำให้โค้ดสะอาด แยกความรับผิดชอบชัดเจน และดูแลรักษาง่าย

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
