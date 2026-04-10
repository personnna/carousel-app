# Carousel Test Task (SwiftUI & UIKit)

## Overview
This project demonstrates the same screen implemented using two different UI frameworks:
- SwiftUI
- UIKit

The goal is to compare approaches while keeping behavior and UI consistent.

---

## Branches

- `main` – SwiftUI implementation (recommended entry point)
- `swiftui` – SwiftUI version
- `uikit` – UIKit version

---

## Features

- Horizontal image carousel with paging
- Page indicator synced with carousel
- Dynamic list of items per page
- Search with debounce
  - Filters by **title and subtitle**
- Bottom sheet with statistics:
  - Current page index
  - Total items count
  - Top 3 most frequent characters (letters only)

---

## Architecture

- MVVM
- Services layer:
  - `DataProvider`
  - `StatsService`
- Dependency Injection via protocols
- Business logic separated from UI
- Unit tests for core logic

---

## UIKit Notes

- `UICollectionView` with paging enabled
- Spacing handled inside cells to avoid paging issues
- Single `UIScrollView` layout (no nested scrolling conflicts)
- `UITableView` scrolling disabled
- Bottom sheet implemented with `UISheetPresentationController`

---

## Technical Decisions

- No third-party libraries
- Local mock data with extensible data source (`DataSourceType`)
- Focus on clarity, maintainability, and platform best practices

---

## How to Run

1. Open the project in Xcode
2. Select target
3. Run on Simulator or device

---

## Notes

- Images are stored in Assets
- Mock data used for simplicity
- The project intentionally avoids over-engineering
