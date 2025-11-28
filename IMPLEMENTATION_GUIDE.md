# Implementation Guide: Trainer Community Reusability

## Quick Start

### Using the Role-Aware Screens

#### For Trainer Role
```dart
// In TrainerCommunityScreen
EventsScreen(userRole: UserRole.trainer)
ChallengesScreen(userRole: UserRole.trainer)
```

#### For User Role
```dart
// In UserCommunityScreen
EventsScreen(userRole: UserRole.user)
ChallengesScreen(userRole: UserRole.user)
```

## Important Files to Reference

1. **Enum Definition:** `lib/core/models/enums/user_role.dart`
   - Central place for UserRole enum
   - Import this everywhere you use UserRole

2. **Trainer Events:** `lib/features/trainer/community/events/`
   - Screen: `screen/event_screen.dart`
   - Controller: `controller/event_controller.dart`

3. **Trainer Challenges:** `lib/features/trainer/community/challenges/`
   - Screen: `screen/challenges_screen.dart`
   - Controller: `controller/challenges_controller.dart`

4. **Community Screens:**
   - Trainer: `lib/features/trainer/community/posts/screen/trainer_community_screen.dart`
   - User: `lib/features/user/user_community/community_posts/screen/user_community_screen.dart`

## Usage Examples

### Example 1: Basic Usage
```dart
import 'package:gokul_ramk/core/models/enums/user_role.dart';
import 'package:gokul_ramk/features/trainer/community/events/screen/event_screen.dart';

// Show events for a trainer
EventsScreen(userRole: UserRole.trainer)

// Show events for a user
EventsScreen(userRole: UserRole.user)
```

### Example 2: In Community Screen
```dart
import 'package:gokul_ramk/core/models/enums/user_role.dart';

class MyCommunityScreen extends StatelessWidget {
  final UserRole userRole;

  @override
  Widget build(BuildContext context) {
    return EventsScreen(userRole: userRole);
  }
}
```

### Example 3: Passing Role to Controller
```dart
// The controller will automatically read userRole from Get.arguments
// If you navigate with role:
Get.put(EventsController(), arguments: UserRole.user);

// The controller will have:
// userRole.value == UserRole.user
```

## Behavior Matrix

### EventsScreen

| Scenario | Behavior |
|----------|----------|
| userRole = trainer | Shows "Host Event" button, FAB visible |
| userRole = user | Shows "Join Event" button, FAB hidden |
| No userRole passed | Defaults to trainer behavior |

### ChallengesScreen

| Scenario | Behavior |
|----------|----------|
| userRole = trainer | Shows "Host Challenge" button, FAB visible |
| userRole = user | Shows "Join Challenge" button, FAB hidden |
| No userRole passed | Defaults to trainer behavior |

## Code Patterns

### Pattern 1: Conditional Button Text
```dart
Text(
  userRole == UserRole.trainer
      ? "Host Event"
      : "Join Event",
  style: getTextStyle(
    color: Colors.white,
    fontWeight: FontWeight.bold,
  ),
)
```

### Pattern 2: Conditional UI Elements
```dart
userRole == UserRole.trainer
    ? GestureDetector(
        onTap: () { /* create event */ },
        child: Container(/* FAB */),
      )
    : SizedBox.shrink()
```

### Pattern 3: Controller Role Access
```dart
class EventsController extends GetxController {
  var userRole = Rxn<UserRole>();
  
  // Use userRole to customize behavior
  void handleEventAction() {
    if (userRole.value == UserRole.trainer) {
      // Trainer-specific action
    } else {
      // User-specific action
    }
  }
}
```

## Common Tasks

### Task 1: Add Role-Specific Navigation
```dart
// In EventsScreen
ElevatedButton(
  onPressed: () {
    if (userRole == UserRole.trainer) {
      Get.toNamed(AppRoute.createEvent);
    } else {
      // Show join dialog or navigate to details
    }
  },
  child: Text(userRole == UserRole.trainer ? "Host Event" : "Join Event"),
)
```

### Task 2: Add Role-Based Data Filtering
```dart
// In EventsController
Future<void> fetchEvents() {
  if (userRole.value == UserRole.trainer) {
    // Fetch trainer's own events
    return eventRepository.getMyEvents();
  } else {
    // Fetch all public events
    return eventRepository.getAllEvents();
  }
}
```

### Task 3: Add Role-Based Permissions Check
```dart
// In EventsScreen
if (userRole == UserRole.trainer) {
  // Show edit/delete buttons
} else {
  // Show only view
}
```

## Troubleshooting

### Issue: "The name 'UserRole' is not defined"
**Solution:** Import the enum
```dart
import 'package:gokul_ramk/core/models/enums/user_role.dart';
```

### Issue: UserRole conflict (defined in multiple places)
**Solution:** Ensure all files import from `lib/core/models/enums/user_role.dart` only

### Issue: Controller not getting userRole
**Solution:** Make sure to pass it when putting the controller:
```dart
// ✅ Correct
Get.put(EventsController(), arguments: UserRole.user);

// ❌ Wrong
Get.put(EventsController()); // Will default to trainer
```

## Testing

### Test 1: Verify Trainer UI
```
1. Navigate to TrainerCommunityScreen(userRole: trainer)
2. Click Events tab
3. Verify "Host Event" button is visible
4. Verify create button (FAB) is visible
```

### Test 2: Verify User UI
```
1. Navigate to UserCommunityScreen
2. Click Events tab
3. Verify "Join Event" button is visible
4. Verify create button (FAB) is hidden
```

### Test 3: Verify Controller Initialization
```
1. Initialize EventsController with UserRole.user
2. Verify controller.userRole.value == UserRole.user
3. Switch to UserRole.trainer
4. Verify controller.userRole.value == UserRole.trainer
```

## Best Practices

1. **Always use the shared enum:** `lib/core/models/enums/user_role.dart`
2. **Pass role consistently:** Use named parameters for clarity
3. **Default to trainer:** If no role is provided, default to trainer behavior
4. **Document role-specific code:** Add comments explaining role-specific logic
5. **Test both roles:** Ensure UI and behavior work for both trainer and user
6. **Use Rxn for optional values:** `var userRole = Rxn<UserRole>()`

## Migration from Old User Screens

If you still have the old user-specific screens:
- `UserEventsScreen` - Now use `EventsScreen(userRole: UserRole.user)`
- `UserChallengesScreen` - Now use `ChallengesScreen(userRole: UserRole.user)`

These can be safely removed once all references are updated.

## Future Enhancements

This architecture allows for:
1. **Role hierarchy:** Add admin, moderator roles
2. **Dynamic permissions:** Check role before showing buttons
3. **Role-specific analytics:** Track actions by role
4. **Role-based API endpoints:** Use different endpoints per role
5. **Permission system:** Extend to support granular permissions
