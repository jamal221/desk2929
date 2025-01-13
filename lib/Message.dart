class Messages {
   String _msg;
   String _type;
   String _date1;
   String _date2;
   String _msg_admin;

   Messages(this._msg, this._type, this._date1, this._date2, this._msg_admin);

   String get msg_admin => _msg_admin;

  String get date2 => _date2;

  String get date1 => _date1;

  String get type => _type;

  String get msg => _msg;
}