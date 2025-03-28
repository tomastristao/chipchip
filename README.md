//
//  Readme.md
//  ChipChip
//
//  Created by Tomas Tristao on 28/03/2025.
//

# chipchip

## 📱

- 📋 List of dog breeds + sub-breeds
- 👉🏻 Present Sheet on item tap
- 🖼️ Random 10 images on a 3x grid for selected breed
- 🔍 Flat-mapped breed naming: `breed-subBreed`
- 🌐 Async/await networking
- 🧭 Coordinator Router pattern using NavigationStack (for scalability)
- 💡 Protocol-oriented for a testable architecture
- ✅ Unit tests and mocks

---

## 🧠

**MVVM + Coordinator Router + Modularization**

- **ViewModels** manage state and business logic
- **Coordinators** handle navigation and V & VM initialization
- **Repositories** abstract networking
- **NetworkEngine** has dependency injection
- **Models** Separated between data and domain layers for flexible testing

---

## 🧪

Unit tests for `BreedListViewModel`, covering:

- ✅ Successful fetch
- ❌ Error handling on fetch failure
- 🧭 Navigation trigger via `tapOn` action

---

## 🛠

- SwiftUI
- MVVM + Coordinator
- Async/Await
- Modularization
- XCTest
- Dependency Injection
- Protocol-Oriented Programming

---

Thank you

Tomas
