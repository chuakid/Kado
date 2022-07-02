class CheckBoxItem {
  dynamic content;
  bool checked = false;

  CheckBoxItem(this.content);

  bool get getChecked => checked;

  set setChecked(bool checked) => this.checked = checked;
}
