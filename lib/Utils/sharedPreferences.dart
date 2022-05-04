import 'package:shared_preferences/shared_preferences.dart';
import 'package:techawks_shoplly_ecommerce_app/model/order.dart';

class OrderSharedPreference {
  setOrdreInfo(IOrderForm orderForm) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("email", orderForm.email);
    prefs.setString("firstName", orderForm.firstName);
    prefs.setString("lastName", orderForm.lastName);
    prefs.setString("add1", orderForm.add1);
    prefs.setString("add2", orderForm.add2);
    prefs.setString("city", orderForm.city);
    prefs.setString("country", orderForm.country);
    prefs.setString("zip", orderForm.zip);
  }

  Future<IOrderForm> getOrderInfo() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String email = prefs.getString("email") ?? "";
    String firstName = prefs.getString("firstName") ?? "";
    String lastName = prefs.getString("lastName") ?? "";
    String add1 = prefs.getString("add1") ?? "";
    String add2 = prefs.getString("add2") ?? "";
    String city = prefs.getString("city") ?? "";
    String country = prefs.getString("country") ?? "";
    String zip = prefs.getString("zip") ?? "";
    return IOrderForm(
      email: email,
      firstName: firstName,
      lastName: lastName,
      add1: add1,
      add2: add2,
      city: city,
      country: country,
      zip: zip,
    );
  }
}
