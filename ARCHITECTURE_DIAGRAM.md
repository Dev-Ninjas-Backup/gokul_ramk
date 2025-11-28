# Trainer Community Reusability Architecture

## Before Refactoring
```
User Community                          Trainer Community
├── community_events/                   ├── community_events/
│   ├── controller/                     │   ├── controller/
│   │   └── event_controller.dart      │   │   └── event_controller.dart
│   └── screen/                         │   └── screen/
│       └── event_screen.dart (User)   │       └── event_screen.dart (Trainer)
│       └── UserEventsScreen            │       └── EventsScreen
│
├── community_challenges/               ├── community_challenges/
│   ├── controller/                     │   ├── controller/
│   │   └── challenges_controller.dart  │   │   └── challenges_controller.dart
│   └── screen/                         │   └── screen/
│       └── challenges_screen.dart      │       └── challenges_screen.dart
│       └── UserChallengesScreen        │       └── ChallengesScreen

❌ Code Duplication: Same logic in two places
```

## After Refactoring
```
Shared Resources
├── core/models/enums/
│   └── user_role.dart
│       ├── enum UserRole { trainer, user }
│       └── Used everywhere for role tracking

User Community                          Trainer Community
├── community_posts/                    ├── community_posts/
│   └── screen/                         │   └── screen/
│       └── user_community_screen.dart  │       └── trainer_community_screen.dart
│           └── EventsScreen(role:user) │           └── EventsScreen(role:trainer)
│           └── ChallengesScreen(...)   │           └── ChallengesScreen(...)
│
├── community_groups/ ──────────────────┼── community_groups/
├── community_posts/ ───────────────────┼── community_posts/
│   (Separate, no changes)              │   (Separate, no changes)

Reused Trainer Screens
├── features/trainer/community/
│   ├── events/
│   │   ├── controller/
│   │   │   └── event_controller.dart
│   │   │       └── var userRole: Rxn<UserRole>
│   │   └── screen/
│   │       └── event_screen.dart
│   │           ├── const EventsScreen({UserRole userRole})
│   │           ├── Shows "Host Event" if trainer
│   │           └── Shows "Join Event" if user
│   │
│   └── challenges/
│       ├── controller/
│       │   └── challenges_controller.dart
│       │       └── var userRole: Rxn<UserRole>
│       └── screen/
│           └── challenges_screen.dart
│               ├── const ChallengesScreen({UserRole userRole})
│               ├── Shows "Host Challenge" if trainer
│               └── Shows "Join Challenge" if user

✅ Single Source of Truth: Logic in one place, reused by both roles
✅ Role-Aware Components: UI dynamically changes based on role
```

## Data Flow

### User Views Events Tab
```
UserCommunityScreen
    ↓
selectedTab.value == 2
    ↓
EventsScreen(userRole: UserRole.user)
    ↓ (Passed to controller via Get.put)
EventsController(userRole: user)
    ├─ Fetches events from API
    └─ Shows "Join Event" button (because userRole == user)
```

### Trainer Views Events Tab
```
TrainerCommunityScreen(userRole: trainer)
    ↓
selectedTab.value == 2
    ↓
EventsScreen(userRole: UserRole.trainer)
    ↓ (Passed to controller via Get.put)
EventsController(userRole: trainer)
    ├─ Fetches events from API
    ├─ Shows "Host Event" button (because userRole == trainer)
    └─ Shows FAB (Create Event button)
```

## Role-Based UI Changes

### EventsScreen & ChallengesScreen

| Feature | Trainer | User |
|---------|---------|------|
| Button Text | "Host Event/Challenge" | "Join Event/Challenge" |
| Create FAB | ✅ Visible | ❌ Hidden |
| API Endpoint | Same (fetches all events) | Same (fetches all events) |
| Data Display | Complete | Complete |

### Controllers

Both `EventsController` and `ChallengesController`:
- Store `var userRole = Rxn<UserRole>()`
- Read role from `Get.arguments` on init
- Default to `UserRole.trainer` if not provided
- Can be used to customize behavior if needed in future

## Key Design Patterns

### 1. Parameter Passing
```dart
// Trainer side
EventsScreen(userRole: UserRole.trainer)

// User side  
EventsScreen(userRole: UserRole.user)
```

### 2. Role Check in UI
```dart
userRole == UserRole.trainer ? "Host Event" : "Join Event"
userRole == UserRole.trainer ? FAB(...) : SizedBox.shrink()
```

### 3. Controller Role Tracking
```dart
@override
void onInit() {
  // Can use this for future role-specific API calls or logic
  userRole.value = Get.arguments ?? UserRole.trainer;
}
```

## Future Extensions

This architecture supports:
1. Role-specific API endpoints (if needed)
2. Role-specific data filtering
3. Role-specific permissions
4. Role-specific analytics tracking
5. Easy addition of new roles (admin, moderator, etc.)
