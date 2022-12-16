
import 'package:cowchat/models/WalkThroughModel.dart';

List<WalkThroughModel> walkThroughList() {
  List<WalkThroughModel> list = [];
  list.add(WalkThroughModel(
      title: "Find and book care workers", description: "Join CareVicinity and get access to a pool of dedicated care workers in your local community.", image: 'assets/images/chat-bubble.png'));
  list.add(WalkThroughModel(
      title: "Easy Onboarding process", description: "For both care-seekers and care workers.", image: 'assets/images/chat_boat.png'));
  list.add(WalkThroughModel(
      title: "Trusted and Safe Environment", description: "To chat and create agreements.", image: 'assets/images/chat_box.png'));

  return list;
}