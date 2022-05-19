import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MyPageView extends ConsumerWidget {
  MyPageView({
    Key? key,
  }) : super(key: key);

  final PageController controller = PageController();

  // void _currentTabChanged(StateController<int> value) {
  //   controller.animateToPage(
  //     value.state,
  //     duration: const Duration(milliseconds: 300),
  //     curve: Curves.fastOutSlowIn,
  //   );
  // }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return PageView(
      controller: controller,
      physics: const NeverScrollableScrollPhysics(),
      // children: const [TodoPage(), MemoriesPage()],
    );
  }
}
