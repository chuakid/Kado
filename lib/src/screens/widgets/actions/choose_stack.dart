import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kado/main.dart';
import 'package:kado/src/config/global_constant.dart';
import 'package:kado/src/controller/stack_controller.dart';
import 'package:kado/src/models/card_stack.dart';
import 'package:kado/src/utils/helper.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';

class ChooseStack extends StatelessWidget {
  const ChooseStack({Key? key}) : super(key: key);

  void popUpChooseUsers() {}

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      StacksChoices(),
      addVerticalSpacing(20.0),
      buildActionBtn("Confirm", popUpChooseUsers, null)
    ]);
  }
}

class StacksChoices extends GetView<StackController> {
  StacksChoices({Key? key}) : super(key: key);
  final darkBlue = Colors.blue[600];
  final RxList<CardStack> selectedStacks = <CardStack>[].obs;
  final bool isDarkMode = MyApp.themeNotifier.value == ThemeMode.dark;

  @override
  Widget build(BuildContext context) {
    Color borderColor = isDarkMode ? opaqueWhite : Colors.blue;
    Color textColor = isDarkMode ? opaqueWhite : Colors.black;
    RxBool selectAll = false.obs;
    MultiSelectItem<Object> selectAllTile = MultiSelectItem(selectAll, "");
    RxList<MultiSelectItem<Object>> _items = [
      selectAllTile,
      ...controller.stacks
          .map((stack) => MultiSelectItem<CardStack>(stack, stack.name))
    ].obs;

    return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Obx(
          () => Column(
            children: [
              MultiSelectDialogField(
                listType: MultiSelectListType.LIST,
                chipDisplay: MultiSelectChipDisplay.none(),
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(Radius.circular(40)),
                  border: Border.all(
                    color: borderColor,
                    width: 2,
                  ),
                ),
                buttonIcon: const Icon(
                  Icons.book,
                ),
                buttonText: const Text(
                  "Available Stacks",
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
                items: _items,
                title: const Text(chooseStack),
                selectedColor: darkBlue,
                unselectedColor: textColor,
                selectedItemsTextStyle: TextStyle(color: textColor),
                itemsTextStyle: TextStyle(color: textColor),
                searchable: true,
                onSelectionChanged: (value) {
                  // Select all has been checked
                  if (value.contains(selectAll)) {
                    // Select all has already been checked
                    if (!selectAll.value) {
                      for (var multiSelectItem in _items) {
                        multiSelectItem.selected = true;
                      }
                      selectAll.toggle();
                    }
                  } else {
                    // Select all was unchecked
                    if (selectAll.value) {
                      for (var multiSelectItem in _items) {
                        multiSelectItem.selected = false;
                      }
                      selectAll.toggle();
                    }
                  }
                },
                onConfirm: (results) {
                  selectedStacks.clear();
                  for (var msItem in _items.sublist(1)) {
                    if (msItem.selected &&
                        msItem.value.runtimeType == CardStack) {
                      selectedStacks.add(msItem.value as CardStack);
                    }
                  }
                },
              ),
              addVerticalSpacing(20.0),
              selectedStacks.isEmpty
                  ? const Text("No stack selected")
                  : MultiSelectChipDisplay<CardStack>(
                      items: selectedStacks
                          .map((stack) =>
                              MultiSelectItem<CardStack>(stack, stack.name))
                          .toList(),
                      alignment: Alignment.center,
                    ),
            ],
          ),
        ));
  }
}
