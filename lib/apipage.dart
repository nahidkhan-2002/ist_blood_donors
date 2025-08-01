import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:ist_blood_donors/style.dart';

productcreateRequest(formdata) async {
  var url = Uri.parse(
    "https://688c6580cd9d22dda5ccf721.mockapi.io/api/v1/informations",
  );
  var postBody = json.encode(formdata);
  var postHeader = {"Content-Type": "application/json"};

  final response = await http.post(url, headers: postHeader, body: postBody);
  var resultCode = response.statusCode;
  var resultBody = json.decode(response.body);

  if (resultCode >= 200 && resultCode < 300) {
  } else if (resultCode > 300) {
    showtoast('something wrong !');
  }
}
