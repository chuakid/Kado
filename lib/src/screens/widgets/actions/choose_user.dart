import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:get/get.dart';
import 'package:kado/src/config/global_constant.dart';
import 'package:kado/src/controller/user_controller.dart';
import 'package:kado/src/database/db_service.dart';
import 'package:kado/src/models/card_stack.dart';
import 'package:kado/src/screens/misc/loader.dart';
import 'package:kado/src/utils/helper.dart';
import 'package:kado/styles/palette.dart';

class ChooseUser extends GetView<UserController> {
  ChooseUser(this.selectedStacks, {Key? key}) : super(key: key);
  final RxList<CardStack> selectedStacks;
  final RxList<String> selectedEmails = <String>[].obs;
  final inputController = TextEditingController();
  final RxBool isLoading = false.obs;
  final RxBool showErrorMsg = false.obs;
  final RxString errorMsg = "".obs;

  @override
  Widget build(BuildContext context) {
    void validateAndAddEmail() {
      isLoading.toggle();
      String emailInput = inputController.text;
      if (!isEmailValid(emailInput)) {
        showErrorMsg.value = true;
        errorMsg.value = "Please enter a valid email address";
        isLoading.toggle();
        return;
      }
      isLoading.toggle();
      inputController.clear();
      showErrorMsg.value = false;
      selectedEmails.add(emailInput);
    }

    void validateAndSend() async {
      isLoading.toggle();
      if (selectedEmails.isEmpty) {
        showErrorMsg.value = true;
        errorMsg.value = "Please enter at least 1 user";
        isLoading.toggle();
        return;
      }

      for (String email in selectedEmails) {
        bool userDoesExists = await DBService.userExists(email);
        if (!userDoesExists) {
          showErrorMsg.value = true;
          errorMsg.value = "Please ensure that all users are registered";
          isLoading.toggle();
          return;
        }
      }

      for (String email in selectedEmails) {
        for (CardStack stack in selectedStacks) {
          DBService.addStackCardsToUserByEmail(email, stack);
        }
      }

      DBService.addUserSuggestions(selectedEmails);

      Get.back();
      Get.back();
      showSnackBar("Success", "Stacks sent successfully", SnackPosition.BOTTOM);
    }

    Widget buildAutoSuggestForm() => Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: TypeAheadField<String>(
                    debounceDuration: const Duration(milliseconds: 500),
                    textFieldConfiguration: TextFieldConfiguration(
                      controller: inputController,
                      decoration: const InputDecoration(
                        prefixIcon: Icon(Icons.email),
                        border: OutlineInputBorder(),
                        hintText: 'Email Address',
                      ),
                    ),
                    suggestionsCallback: DBService.getUserSuggestions,
                    itemBuilder: (context, String? email) => ListTile(
                      title: Text(email!),
                    ),
                    noItemsFoundBuilder: (context) => const SizedBox(
                      height: 50,
                      child: Center(
                        child: Text(
                          'No Users Found',
                          style: TextStyle(fontSize: 16),
                        ),
                      ),
                    ),
                    onSuggestionSelected: (String? email) {
                      inputController.text = email!;
                    },
                  ),
                ),
                addHorizontalSpacing(10.0),
                IconButton(
                    onPressed: () => validateAndAddEmail(),
                    icon: const Icon(Icons.add)),
              ],
            ),
            Obx(() => showErrorMsg.value
                ? Column(children: [
                    addVerticalSpacing(10.0),
                    buildErrorMsg(errorMsg.value)
                  ])
                : Container()),
            addVerticalSpacing(20.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                buildActionBtn(
                    "Send", validateAndSend, null, const Icon(Icons.send)),
                addHorizontalSpacing(10.0),
                buildActionBtn("Back", () => Get.back(), null)
              ],
            )
          ],
        );

    Widget buildSelectedEmailsView() => selectedEmails.isEmpty
        ? const Text("No user added")
        : Container(
            constraints: const BoxConstraints(maxHeight: 100),
            child: SingleChildScrollView(
                child: Wrap(
                    children: selectedEmails
                        .map((email) =>
                            ChosenUsers(email, selectedEmails, showErrorMsg))
                        .toList())));

    return Obx(() => Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0),
          child: isLoading.value
              ? const Loader()
              : Column(
                  children: [
                    buildSelectedEmailsView(),
                    addVerticalSpacing(20.0),
                    buildAutoSuggestForm(),
                  ],
                ),
        ));
  }
}

class ChosenUsers extends StatelessWidget {
  final String email;
  final RxList<String> selectedEmails;
  final RxBool showErrorMsg;
  const ChosenUsers(this.email, this.selectedEmails, this.showErrorMsg,
      {Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(5),
      child: DecoratedBox(
        decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular((15.0))),
            color: darkBlue),
        child: Padding(
          padding: const EdgeInsets.all(5),
          child: TextButton(
            onPressed: () {
              showErrorMsg.value = false;
              selectedEmails.remove(email);
            },
            child: Wrap(
              alignment: WrapAlignment.spaceBetween,
              crossAxisAlignment: WrapCrossAlignment.center,
              children: [
                Text(email, style: const TextStyle(color: Colors.white)),
                addHorizontalSpacing(10.0),
                const Icon(Icons.delete)
              ],
            ),
          ),
        ),
      ),
    );
  }
}
