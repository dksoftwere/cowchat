import 'package:flutter/foundation.dart';

class DialogRequest {
   String ?title;
   String ?description;
   String ?buttonTitle;
   String ?cancelTitle;

  DialogRequest(
      {@required this.title,
      @required this.description,
      @required this.buttonTitle,
      this.cancelTitle});
}

class DialogResponse {
   String ?fieldOne;
   String ?fieldTwo;
   bool ?confirmed;

  DialogResponse({
    this.fieldOne,
    this.fieldTwo,
    this.confirmed,
  });
}
