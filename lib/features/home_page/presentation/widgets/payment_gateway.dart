import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:uuid/uuid.dart';

class PaymentGateway extends StatefulWidget {
  static const routePath = '/payment';
  const PaymentGateway({super.key});

  @override
  State<PaymentGateway> createState() => _PaymentGatewayState();
}

class _PaymentGatewayState extends State<PaymentGateway> {
  final _amountController = TextEditingController();
  final _razorpay = Razorpay();
  late String uuid;

  Future<void> payAmount() async {
    await doPayment();
  }

  Future<dynamic> createOrder() async {
    final amount = int.parse(_amountController.text);
    final dio = Dio();
    uuid = const Uuid().v4();

    try {
      final response = await dio.post(
        'https://api.razorpay.com/v1/orders',
        options: Options(
          contentType: 'application/json',
          headers: {
            'Authorization':
                'Basic ${base64.encode(utf8.encode('rzp_test_bANz8FD56E23d9:5cn1aSqKKUpsQtZf4uxxx5UA'))}',
          },
        ),
        data: jsonEncode({
          "amount": (100 * amount),
          "currency": "INR",
          "receipt": uuid,
        }),
      );
      return response.data;
    } catch (e) {
      print(e);
    }
  }

  Future<void> doPayment() async {
    final orderData = await createOrder();

    var options = {
      'key': 'rzp_test_bANz8FD56E23d9',
      'amount': orderData['amount'],
      'name': 'MUHAMMED RASHID P',
      'order_id': '${orderData['id']}',
      'description': 'Chair',
      'timeout': 60 * 2,
    };

    _razorpay.open(options);
  }

  void _handlePaymentSuccess(PaymentSuccessResponse response) {
    final keySecret = utf8.encode('5cn1aSqKKUpsQtZf4uxxx5UA');
    final bytes = utf8.encode('${response.orderId}|${response.paymentId}');

    final hmacSha256 = Hmac(sha256, keySecret);
    final generatedSignature = hmacSha256.convert(bytes);

    if (generatedSignature.toString() == response.signature) {
      print("Payment was successful!");
      //Handle what to do after a successful payment.
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text("Success : payment successful"),
            // content: const Text("Are you sure you wish to delete this item?"),
            actions: <Widget>[
              ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                    // PlaceOrderPrepaid();
                  },
                  child: const Text("OK"))
              // ),
            ],
          );
        },
      );
    } else {
      print("The payment was fake!");
    }
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    // Do something when payment fails
    print('payment error ${response.message}');
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    // Do something when an external wallet is selected
    print('${response.walletName} opened');
  }

  @override
  void initState() {
    super.initState();

    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
  }

  @override
  void dispose() {
    _amountController.dispose();
    _razorpay.clear();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 36),
        child: Center(
          child: TextFormField(
            controller: _amountController,
            decoration: const InputDecoration(
              hintText: 'Amount',
            ),
            keyboardType: TextInputType.number,
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => payAmount(),
        child: const Icon(Icons.payment),
      ),
    );
  }
}
