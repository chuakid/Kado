import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:get/get.dart';
import 'package:kado/src/config/global_constant.dart';
import 'package:kado/src/controller/user_controller.dart';
import 'package:kado/src/database/db_service.dart';
import 'package:kado/src/utils/helper.dart';
import 'package:kado/styles/palette.dart';

class ChooseUser extends GetView<UserController> {
  ChooseUser({Key? key}) : super(key: key);
  final RxList<String> selectedEmails = <String>[].obs;
  final inputController = TextEditingController();
  final RxBool showErrorMsg = false.obs;
  final RxString errorMsg = "".obs;

  @override
  Widget build(BuildContext context) {
    void validateAndAddEmail() {
      String emailInput = inputController.text;
      if (!isEmailValid(emailInput)) {
        showErrorMsg.value = true;
        errorMsg.value = "Please enter a valid email address";
        return;
      }
      inputController.clear();
      showErrorMsg.value = false;
      selectedEmails.add(emailInput);
    }

    void validateAndSend() {
      if (selectedEmails.isEmpty) {
        showErrorMsg.value = true;
        errorMsg.value = "Please enter at least 1 user";
        return;
      }
      inputController.clear();
      showErrorMsg.value = false;
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
                        prefixIcon: Icon(Icons.search),
                        border: OutlineInputBorder(),
                        hintText: 'Search Email Address',
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
                          'No Users Found.',
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
        ? const Text("No user selected")
        : Container(
            constraints: const BoxConstraints(maxHeight: 100),
            child: SingleChildScrollView(
                child: Wrap(
                    children: selectedEmails
                        .map((email) => ChosenUsers(email, selectedEmails))
                        .toList())));

    return Obx(() => Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0),
          child: Column(
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
  const ChosenUsers(this.email, this.selectedEmails, {Key? key})
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
            onPressed: () => selectedEmails.remove(email),
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
