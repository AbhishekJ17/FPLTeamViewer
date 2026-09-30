# FPLTeamViewer

**How to Build and Run the Application**

1. Clone or download the repository to your local machine.
2. Open the project folder and double-click the .xcodeproj or .xcworkspace file to open it in Xcode.
3. Select an iOS Simulator (e.g., iPhone 17 Pro) or your physical device from the scheme target dropdown.
4. Press Cmd + R or click the Play button in Xcode to build and run the app.


**Architectural Decisions Made and Why**

1. MVVM with Clean Separation: Adopted a modular Model-View-ViewModel architecture supported by Use Cases and Repositories to isolate business logic, network layers, and state handling.
2. Swift Concurrency (async/await): Used modern native asynchronous programming instead of legacy completion handlers or third-party reactive frameworks, ensuring readability and strict thread-safety compliance.


**Anything You Would Improve with More Time**

1. CoreData / SQLite Integration: Migrate from basic file-based JSON serialization to a structured database like CoreData or SwiftData for more scalable offline querying.
2. Comprehensive UI Snapshot & Unit Testing: Expand test coverage to include UI snapshot tests and view model asynchronous timing assertions.
3. Image Caching & Placeholders: Implement an efficient image caching layer for player/team badges to handle offline image rendering gracefully.
