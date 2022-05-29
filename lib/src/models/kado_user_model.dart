class KadoUserModel {
  final String _name;
  final String _email;
  final String _photoURL;

  KadoUserModel(this._name, this._email, this._photoURL);

  get name => _name;
  get email => _email;
  get photoURL => _photoURL;
}
