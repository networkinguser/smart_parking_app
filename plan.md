# Smart Parking App Project Plan

## 1. App Structure & Navigation
- **Splash Screen**: Shows logo, then navigates to Login.
- **Login Screen**: Authenticates user, then navigates to Home Categories.
- **Sign Up Screen**: Multiple sign up options, then prompts for vehicle info.
- **Add Vehicle Screen**: User adds or skips first vehicle after sign up.
- **Home Categories Screen**: Dashboard with:
  - **Active Session Card** (if user is parked)
  - **Quick Actions** (Parking, Vehicles, History, Contact Us)
  - **My Vehicles** summary
  - **Recent Activity**
  - Profile button in app bar
- **Parking List (Home Screen)**: Grid of parking cards, each showing image, name, location, price, and status. Profile button in app bar.
- **Parking Details Screen**: Banner image, bold name/price, location with Google Maps button, opening hours, floor details with progress bars, parking summary, **Weekly Occupancy chart & AI tip**.
- **Profile Screen**: User info, contact, profile management (edit info, change email/password, logout).
- **Vehicles Screen**: List, add, set default, and delete vehicles.
- **History Screen**: List of parking sessions, filter by status, summary cards, session details.

## 2. Main Features
- User authentication (mocked)
- Category navigation (Parking, Vehicles, History, Contact Us)
- Parking listing and details
- **Active session tracking** (shows on dashboard, can end session)
- **Weekly occupancy/AI tips** in parking details
- User profile management
- Vehicle management
- Parking history tracking

## 3. Data Models
- **User**: id, name, email, phone, profileImage, gender, vehicles, parkingHistory
- **Vehicle**: id, plateNumber, brand, model, color, isDefault
- **ParkingHistory**: id, parkingName, vehiclePlate, entryTime, exitTime, totalCost, status
- **Parking**: id, name, location, imageUrl, pricePerHour, openTime, closeTime, isOpenNow, floors
- **Floor**: floorNumber, totalSpots, takenSpots, freeSpots (getter)

## 4. Mock Data
- `mock_user_data.dart`: Sample user, vehicles, and parking history
- `mock_data.dart`: Sample parkings and floors

## 5. UI Components
- **ParkingCard**: Reusable widget for parking grid/list
- **Category Card**: Used in home categories grid
- **ActiveSessionCard**: Shows current parking session on dashboard
- **WeeklyOccupancyChart**: Shows parking busyness for the week
- **AITip**: AI/statistics tip for parking

## 6. Navigation Flow
1. SplashScreen → LoginScreen
2. LoginScreen → HomeCategoriesScreen
3. HomeCategoriesScreen → HomeScreen (Parking) or other categories (future)
4. HomeScreen → ParkingDetailsScreen
5. HomeCategoriesScreen/HomeScreen → ProfileScreen
6. ProfileScreen → VehiclesScreen/HistoryScreen

## 7. Extensibility
- Shopping, Food, Gas Stations screens can be added later
- Authentication can be connected to backend
- Profile editing, settings, and help screens can be implemented
- **Local or cloud data persistence can be added** (currently, all data is in-memory and resets on app restart)

---
This plan reflects the current state and structure of the Smart Parking App as implemented in the codebase, including the latest features for active session tracking and parking statistics/AI tips. 