import 'package:flutter/material.dart';

const addCard = "Add New Card";
const addStack = "Add New Stack";
const chooseStack = "Choose Stacks";
const sendStack = "Send Stacks";
const chooseUser = "Choose Users";
const addTag = "Add New Tag";
const editStack = "Edit Stack Details";
const searchHint = "Search stacks by tag or name";

// Different Card Types
const cardTypeSelect = "Select a card type";
const frontBack = "Front-Back";
const fillInBlank = "Fill-In-The-Blank";
const cardTypes = [frontBack, fillInBlank];

// Validation messages
const emptyStackName = "Enter Stack Name";
const emptyCardName = "Enter Card Name";
const emptyTagName = "Enter Tag Name";
const emptyFrontContent = "Enter Front Content";
const emptyBackContent = "Enter Back Content";

const title = "Kado";
const appBarIconSpacing = 20.0;
const opaqueWhite = Color.fromARGB(255, 250, 250, 250);

Widget addVerticalSpacing(double size) => SizedBox(height: size);
Widget addHorizontalSpacing(double size) => SizedBox(width: size);
