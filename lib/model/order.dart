import 'dart:convert';

class IOrderForm {
  late String email, firstName, lastName, add1, add2, city, country, zip;

  IOrderForm({
    required this.email,
    required this.firstName,
    required this.lastName,
    required this.add1,
    required this.add2,
    required this.city,
    required this.country,
    required this.zip,
  });

  Map<String, dynamic> toJson() => {
        "email": email,
        "firstName": firstName,
        "lastName": lastName,
        "add1": add1,
        "add2": add2,
        "city": city,
        "country": country,
        "zip": zip,
      };

  factory IOrderForm.fromJson(Map<String, dynamic> json) => IOrderForm(
        email: json["email"],
        firstName: json["firstName"],
        lastName: json["lastName"],
        add1: json["add1"],
        add2: json["add2"],
        city: json["city"],
        country: json["country"],
        zip: json["zip"],
      );

  @override
  String toString() {
    return 'email: $email, firstName: $firstName, lastName: $lastName, add1: $add1, add2: $add2, city: $city, country: $add2, zip: $zip';
  }
}

class CreateOrderResult {
  CreateOrderResult({
    required this.createOrder,
  });

  CreatedOrder createOrder;

  factory CreateOrderResult.fromJson(Map<String, dynamic> json) =>
      CreateOrderResult(
        createOrder: CreatedOrder.fromJson(json["createOrder"]),
      );

  @override
  String toString() {
    return 'createOrder: $createOrder';
  }
}

class OrderItemInput {
  late String orderId;
  late String productId;
  late int quantity;

  OrderItemInput({
    required this.orderId,
    required this.productId,
    required this.quantity,
  });

  Map<String, dynamic> toJson() =>
      {"orderId": orderId, "productId": productId, "quantity": quantity};
}

class OrderInput {
  late String customerEmailPhone;
  late String customerFullName;
  late String customerAddress1;
  late String customerAddress2;
  late String customerCity;
  late String country;
  late String zipCode;
  late List<OrderItemInput> orderItems;

  OrderInput({
    required this.customerEmailPhone,
    required this.customerFullName,
    required this.customerAddress1,
    required this.customerAddress2,
    required this.customerCity,
    required this.country,
    required this.zipCode,
    required this.orderItems,
  });

  Map<String, dynamic> toJson() => {
        "customerEmailPhone": customerEmailPhone,
        "customerFullName": customerFullName,
        "customerAddress1": customerAddress1,
        "customerAddress2": customerAddress2,
        "customerCity": customerCity,
        "country": country,
        "zipCode": zipCode,
        "orderItems": List<dynamic>.from(orderItems.map((x) => x.toJson())),
      };
}

class CreatedOrder {
  late String orderId;
  late String orderNumber;
  late String deliveryDate;

  CreatedOrder({
    required this.orderId,
    required this.orderNumber,
    required this.deliveryDate,
  });

  factory CreatedOrder.fromJson(Map<String, dynamic> json) => CreatedOrder(
        orderId: json["orderId"],
        orderNumber: json["orderNumber"],
        deliveryDate: json["deliveryDate"],
      );

  Map<String, dynamic> toJson() => {
        "orderId": orderId,
        "orderNumber": orderNumber,
        "deliveryDate": deliveryDate,
      };

  @override
  String toString() {
    return 'orderId: $orderId, orderNumber: $orderNumber, deliveryDate: $deliveryDate';
  }
}
