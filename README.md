
# 📋 Contextual Cards Container  

### 🎯 **Overview**  
This repository contains the implementation of a **standalone container** for displaying a list of `Contextual Cards`. These cards are dynamically rendered from JSON responses fetched via an API and styled based on their properties such as text, colors, images, and CTAs.

The container is **plug-and-play**, meaning it can be seamlessly added to any Flutter screen or widget without dependencies on the rest of the app.

---

## 🚀 Features  

- **Dynamic Card Rendering**: Cards are rendered based on API responses, supporting various `design_types`.  
- **Actionable CTAs**: Handles all deeplinks for cards and buttons dynamically.  
- **Gesture Features**:
  - **Swipe Down** to refresh the list.  
  - **Long Press** on Big Display Card (HC3) to display action buttons (`Remind Later`, `Dismiss Now`).  
- **State Management**: Efficient state handling using **Cubit** (part of Bloc).  
- **Persistence**:
  - Cards marked as `Remind Later` reappear on the next app start.  
  - Cards marked as `Dismiss Now` never appear again.  
- **Beautiful UI**: Matches the design specifications as closely as possible using assets from Figma.  
- **Clean Architecture**: Implements a structured and modular project design for scalability and maintainability.

---

## 📡 API Details  

The app fetches data from the following API:  
`https://polyjuice.kong.fampay.co/mock/famapp/feed/home_section/?slugs=famx-paypage`  

Each API response includes **Card Groups**, which are rows of cards, with details about their layout, content, and behavior. For detailed schema, refer to the assignment instructions or inspect the API response directly.

---

## 🛠️ Tech Stack  

- **Flutter**  
- **Dart**  
- **Cubit** (for state management)  
- **HTTP** (for API requests)  
- **Shared Preferences** (for persistence)  
- **Get it** (for dependency injection)  

---

## 🎨 Card Types Supported  

The app supports the following `design_types` as per the API schema:  
1. **Small Display Card** (`HC1`)  
2. **Big Display Card** (`HC3`)  
3. **Image Card** (`HC5`)  
4. **Small Card with Arrow** (`HC6`)  
5. **Dynamic Width Card** (`HC9`)  

Refer to the [Figma Design](https://www.figma.com/file/AvK2BRGwMTv4kQab5ymJ0K/AAL3-Android-assignment-Design-Specs) for design specifications.

---

## 📂 Project Structure  

```plaintext
lib/
├── core/
│   ├── constants/
│   │   └── app_constants.dart      # App-wide constants
│   ├── utils/
│   │   └── launch_url.dart       # Helper to launch url's
│   │   └── hex_to_color.dart     # Helper to conver hex color code to flutter color code
│   └── error/
│       └── exceptions.dart        # Custom exceptions
├── data/
│   ├── models/
│   │   └── card_model.dart        # Model for a Card
│   │   └── cta_model.dart         # Model for Call to Action (CTA)
│   │   └── gradient_model.dart    # Model for Gradients
│   ├── datasources/
│   │   └── card_remote_data_source.dart  # Handles API requests
│   │   └── card_local_data_source.dart   # Handles persistence for dismissed/remind-later cards
│   └── repositories/
│       └── card_repository.dart   # Manages data access from data sources
├── presentation/
│   ├── cubit/
│   │   └── card_cubit.dart        # Cubit for managing card states
│   │   └── card_state.dart        # Card state definitions (loading, success, error, etc.)
│   ├── pages/
│   │   └── home_screen.dart       # The main screen rendering contextual cards
│   └── widgets/
│       ├── buttons/               # Remind Later and Dismiss now button
│       ├── design_hc1_widget.dart # List view of hc1 cards
│       └── design_hc3_widget.dart # List view of hc3 cards
│
├── init_dependencies.dart         # Imports for dependecy injections
├── init_dependencies.main.dart    # Dependencey injection
└── main.dart                      # Entry point of the application
```
---

## ⚙️ How to Run  

### Prerequisites  
- Flutter SDK installed.  
- Android Studio or VS Code set up for Flutter development.  

### Steps  

1. Clone the repository:  
   ```bash
   git clone https://github.com/Udhay-Adithya/famapp-flutter-assignment.git
   cd famapp-flutter-assignment
   ```

2. Install dependencies:  
   ```bash
   flutter pub get
   ```

3. Run the app:  
   ```bash
   flutter run
   ```

