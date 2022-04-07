
import 'package:event_bus/event_bus.dart';

class AppEvent {

  static EventBus event = EventBus();
}

//刷新用户信息
class ReloadUserInfoEvent {
  ReloadUserInfoEvent();
}