# BR Game Prototype — শুরুর ধাপ

এটা একটা **original** battle-royale style প্রজেক্টের শুরু — নিজের নাম, নিজের ডিজাইন দিয়ে বানানোর জন্য (Free Fire/BGMI-এর কোনো asset, নাম, লোগো এখানে নেই)।

## ১. যা যা আছে এখন
- একটা টেস্ট ম্যাপ (ঘাসের মাঠ + কয়েকটা বক্স/অবস্টাকল)
- একটা ক্যারেক্টার যেটা দিয়ে করা যায়:
  - **WASD** = হাঁটা
  - **Shift** = দৌড়ানো (sprint)
  - **Space** = লাফ (jump)
  - **Ctrl** = বসা (crouch)
  - **মাউস** = ক্যামেরা ঘোরানো (mobile-এ পরে touch joystick বসাবো)

## ২. কম্পিউটারে চালানোর ধাপ
1. [Godot 4.2+](https://godotengine.org/download) ডাউনলোড করো (ফ্রি, ~80MB) — **Standard** version, .NET না।
2. Godot খুলে "Import" করে এই ফোল্ডারের `project.godot` ফাইলটা সিলেক্ট করো।
3. উপরে ▶️ (Run) বাটনে ক্লিক করলেই তোমার টেস্ট ম্যাপে ক্যারেক্টার movement টেস্ট করতে পারবে।

## ৩. পরবর্তী ধাপগুলো (roadmap)
এগুলো নিয়ে ধাপে ধাপে এগোবো — একবারে সব সম্ভব না:

1. ✅ ক্যারেক্টার movement (হয়ে গেছে — এখন শুধু capsule shape, পরে 3D model বসাবো)
2. ⬜ Touch controls (মোবাইলের জন্য virtual joystick + jump/crouch বাটন)
3. ⬜ বড় ম্যাপ ডিজাইন (নিজের নামে — যেমন "Sonar Bangla" বা তুমি যা চাও)
4. ⬜ Character model/skin (নিজের ডিজাইন — 3D model বা simple stylized)
5. ⬜ Shooting/weapon system
6. ⬜ Shrinking zone (battle royale circle)
7. ⬜ Android APK export
8. ⬜ (অনেক পরে, কঠিন ধাপ) Multiplayer networking

## ৪. Android APK export করতে যা লাগবে (পরে, যখন গেম কিছুটা রেডি হবে)
- Godot-এ Android export template ইনস্টল করা
- Java JDK + Android SDK (Godot নিজেই গাইড করে সেটআপে)
- এটা network লাগবে বলে আমি সরাসরি করে দিতে পারবো না — কিন্তু step-by-step গাইড করে দিতে পারবো।

---
**পরবর্তী মেসেজে বলো** — touch controls বানাবো, নাকি ম্যাপ বড় করবো, নাকি character-এর দেখতে কেমন হবে সেটা design করবো?
