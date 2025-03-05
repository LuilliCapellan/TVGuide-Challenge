# 📺 TVGuide

TVGuide is an iOS application that allows users to explore TV shows, actors, and their favorite programs. The app follows **Clean Architecture** principles and utilizes **MVVM (Model-View-ViewModel)** for better maintainability, scalability, and testability.

---

## 🏗 Project Structure

The project is structured following **Clean Architecture**:

TVGuide  
│── Presentation (UI + ViewModels)  
│   ├── Views  
│   │   ├── TVGuideView.swift  
│   │   ├── PeopleView.swift  
│   │   ├── FavoritesView.swift  
│   │   ├── ShowDetailView.swift  
│   │   ├── EpisodeDetailView.swift  
│   ├── ViewModels  
│   │   ├── TVGuideViewModel.swift  
│   │   ├── PeopleViewModel.swift  
│   │   ├── FavoritesViewModel.swift  
│   │   ├── ShowDetailViewModel.swift  
│   ├── ViewModelContainer.swift  
│  
│── Domain (Business Logic)  
│   ├── UseCases  
│   │   ├── FetchTVShowsUseCase.swift  
│   │   ├── FetchShowDetailsUseCase.swift  
│   │   ├── FetchShowEpisodesUseCase.swift  
│   │   ├── FetchPeopleUseCase.swift  
│   │   ├── FetchPersonShowCreditsUseCase.swift  
│   │   ├── AddFavoriteUseCase.swift  
│   │   ├── RemoveFavoriteUseCase.swift  
│   │   ├── IsFavoriteUseCase.swift  
│   │   ├── SearchFavoritesUseCase.swift  
│   ├── Models  
│   │   ├── TVShow.swift  
│   │   ├── Episode.swift  
│   │   ├── Person.swift  
│   │   ├── FavoriteTVShow.swift  
│  
│── Data (Repositories + Persistence)  
│   ├── Repositories  
│   │   ├── TVRepository.swift  
│   │   ├── PeopleRepository.swift  
│   │   ├── FavoriteRepository.swift  
│   ├── Repository Implementations  
│   │   ├── TVRepositoryImpl.swift  
│   │   ├── PeopleRepositoryImpl.swift  
│   │   ├── FavoriteRepositoryImpl.swift  
│   ├── RepositoryContainer.swift  
│  
│── Core (Utilities, Extensions, Dependency Injection)  
│   ├── DI (Dependency Injection)  
│   │   ├── ServiceLocator.swift  
│   │   ├── AppContainer.swift  
│   ├── Extensions  
│   │   ├── String+Extensions.swift  
│   │   ├── View+Modifiers.swift  
│   ├── Networking  
│   │   ├── NetworkService.swift  
│  
│── Resources (Assets, Localizable Strings)  
│── Tests (Unit & UI Testing)  

---

## 🚀 Features

- 🔍 **Browse TV Shows** – Explore popular TV shows with detailed information.  
- 🎭 **Search for Actors** – Find actors and view their show credits.  
- ❤️ **Favorite Shows** – Save your favorite TV shows.  
- 🔄 **Paginated Lists** – Infinite scrolling for better performance.  
- 🌍 **Clean Architecture** – Modular and scalable design.  
- 🧪 **Unit & UI Testing** – Ensures reliability.  

---

## 🛠 Requirements

- **Xcode 15+**  
- **iOS 17+**  
- **Swift 5.9+**  
- **Swift Package Manager (SPM)**  

---

## ▶️ Running the Project

### 1️⃣ Clone the Repository
`sh
git clone https://github.com/your-username/TVGuide.git
cd TVGuide`

### 2️⃣ Install Dependencies
The project uses **Swift Package Manager (SPM)** for dependency management. Open the `.xcodeproj` or `.xcworkspace` and ensure that all dependencies are resolved.

1. Open **Xcode**.  
2. Go to **File** → **Packages** → **Update to Latest Package Versions**.  

### 3️⃣ Open the Project in Xcode
- Open `TVGuide.xcodeproj`.  
- Select **an iOS simulator** (e.g., iPhone 15 Pro).  
- Press **Cmd + R** or click **Run ▶️**.  

### 4️⃣ Running Tests
To run the unit and UI tests:  
- Open **Xcode**.  
- Select `Product` → `Test` (`Cmd + U`).  

---

## 📄 License

This project is licensed under **MIT License**.  
