
# Flutter Tooltip Plus

A lightweight and customizable Flutter tooltip widget for displaying helpful hints and contextual information with smooth animations and flexible positioning.

---

## ✨ Features

* Fully customizable UI
* Smooth scale animation
* Easy integration
* Supports any widget as tooltip content
* Works with overlay system
* Custom background and border radius
* Lightweight and performant

---

## Example
<img src="https://github.com/thedeepakgupta/flutter_tooltip_plus/blob/main/screen/left.png?raw=true" width=360/>
<img src="https://github.com/thedeepakgupta/flutter_tooltip_plus/blob/main/screen/right.png?raw=true" width=360/>
<img src="https://github.com/thedeepakgupta/flutter_tooltip_plus/blob/main/screen/left-bottom.png?raw=true" width=360/>
<img src="https://github.com/thedeepakgupta/flutter_tooltip_plus/blob/main/screen/right-bottom.png?raw=true" width=360/>

---


## 📦 Installation

Add this to your `pubspec.yaml`:

```yaml
dependencies:
  flutter_tooltip_plus: latest_version
```

Then run:

```bash
flutter pub get
```

---

## 🚀 Usage

Import the package:

```dart
import 'package:flutter_tooltip_plus/flutter_tooltip_plus.dart';
```

Wrap any widget with `FlutterTooltip`:

```dart
FlutterTooltip(
  background: Colors.amber,
  borderRadius: BorderRadius.circular(12),
  padding: EdgeInsets.all(12),
  content: Column(
    mainAxisSize: MainAxisSize.min,
    children: const [
      Text(
        "Tool tip content",
        style: TextStyle(color: Colors.black),
      ),
    ],
  ),
  child: const Icon(Icons.info_outline_rounded),
),
```

---

## ⚙️ Parameters

| Property       | Description                      |
|----------------|----------------------------------|
| `child`        | Widget that triggers the tooltip |
| `content`      | Widget displayed inside tooltip  |
| `background`   | Tooltip background color         |
| `borderRadius` | Corner radius of the tooltip     |
| `padding`      | Internal spacing                 |

---

## 🛠️ Customization Tips

* Use `background` to match your app theme
* Adjust `borderRadius` for sharp or rounded style
* Wrap large content in `SingleChildScrollView` if needed
* Add animations using built-in transitions

---

## 🤝 Contributions

Pull requests are welcome!
If you find a bug or want a feature, feel free to open an issue.

