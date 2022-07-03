class KadoUserModel {
  final String _uid;
  final String _name;
  final String _email;
  final String _photoURL;

  KadoUserModel(this._uid, this._name, this._email, this._photoURL);

  get uid => _uid;
  get name => _name;
  get email => _email;
  get photoURL => _photoURL;
}
