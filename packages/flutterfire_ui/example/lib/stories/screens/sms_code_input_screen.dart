import 'package:flutterfire_ui/auth.dart';
import 'package:flutterfire_ui_example/stories/stories_lib/story.dart';
import 'package:flutter/widgets.dart';

class SMSCodeInputScreenStory extends StoryWidget {
  const SMSCodeInputScreenStory({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final story = storyOf(context);

    story.category = 'Screens';
    story.title = 'SMSCodeInputScreen';

    return const SMSCodeInputScreen(
      flowKey: Object(),
    );
  }
}
