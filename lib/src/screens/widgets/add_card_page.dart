import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kado/src/config/global_constant.dart';
import 'package:kado/src/controller/stack_controller.dart';
import 'package:kado/src/database/db_service.dart';
import 'package:kado/src/utils/helper.dart';

class AddCardPage extends GetView<StackController> {
  AddCardPage({Key? key, required this.cardType}) : super(key: key);
  final String cardType;
  final _formKey = GlobalKey<FormState>();
  final RxString cardName = ''.obs;
  final RxString frontContent = ''.obs;
  final RxString backContent = ''.obs;
  final _cardNameController = TextEditingController();
  final _frontContentController = TextEditingController();
  final _backContentController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    String frontLabel = cardType == frontBack ? "Front Content" : "Question";
    String backLabel = cardType == frontBack ? "Back Content" : "Model Answer";

    void resetAllFields() {
      _cardNameController.clear();
      _frontContentController.clear();
      _backContentController.clear();
    }

    void validateAndAddCard() {
      FormState? fs = _formKey.currentState;
      if (fs != null && fs.validate()) {
        DBService.addCard(controller.selectedStack.value.id, cardName.value,
            frontContent.value, backContent.value, cardType);
        showSnackBar("New Card Added", cardName.value + " added successfully.",
            SnackPosition.TOP);
        resetAllFields();
      }
    }

    var cardNameField = TextFormField(
      controller: _cardNameController,
      validator: (value) =>
          value != null && value.isEmpty ? emptyCardName : null,
      decoration: const InputDecoration(
        icon: Icon(Icons.card_membership),
        labelText: 'Card Name',
        hintMaxLines: 1,
      ),
      onChanged: (val) => cardName.value = val,
      onFieldSubmitted: (_) => validateAndAddCard(),
    );

    var frontField = TextFormField(
      controller: _frontContentController,
      keyboardType: TextInputType.multiline,
      maxLines: 8,
      validator: (value) =>
          value != null && value.isEmpty ? emptyFrontContent : null,
      decoration: InputDecoration(
        labelText: frontLabel,
      ),
      onChanged: (val) => frontContent.value = val,
      onFieldSubmitted: (_) => validateAndAddCard(),
    );

    var backField = TextFormField(
      controller: _backContentController,
      keyboardType: TextInputType.multiline,
      maxLines: 8,
      validator: (value) =>
          value != null && value.isEmpty ? emptyBackContent : null,
      decoration: InputDecoration(
        labelText: backLabel,
      ),
      onChanged: (val) => backContent.value = val,
      onFieldSubmitted: (_) => validateAndAddCard(),
    );

    var bottomRow = Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        buildActionBtn(
            "Add", validateAndAddCard, null, const Icon(Icons.add_card)),
      ],
    );

    return Scaffold(
        appBar: AppBar(actions: [
          buildBackToHomeBtn(),
          buildProfileAvatar(),
          buildSignOutBtn(context)
        ]),
        body: Container(
          padding: const EdgeInsets.all(20.0),
          child: SingleChildScrollView(
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              buildLabel("Stack Name: ${controller.selectedStack.value.name}"),
              addVerticalSpacing(20.0),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: <Widget>[
                      cardNameField,
                      addVerticalSpacing(20.0),
                      frontField,
                      addVerticalSpacing(20.0),
                      backField,
                      addVerticalSpacing(20.0),
                      bottomRow
                    ],
                  ),
                ),
              ),
            ]),
          ),
        ));
  }
}
