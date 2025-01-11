import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

// class WithdrawlScreen extends StatelessWidget {
//   static const String routeName = '\WithdrawlScreen';

//   Future<double> fetchTotalPrice() async {
//     try {
//       final querySnapshot = await FirebaseFirestore.instance
//           .collection('orders')
//           .where('accepted', isEqualTo: true)
//           .get();

//       // Calculate the total price of approved orders
//       double totalPrice = querySnapshot.docs.fold(0.0, (sum, doc) {
//         return sum + (doc['productPrice'] ?? 0.0);
//       });

//       return totalPrice;
//     } catch (e) {
//       debugPrint('Error fetching data: $e');
//       throw Exception('Failed to fetch orders.');
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Withdrawal'),
//       ),
//       body: FutureBuilder<double>(
//         future: fetchTotalPrice(),
//         builder: (context, snapshot) {
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return const Center(child: CircularProgressIndicator());
//           } else if (snapshot.hasError) {
//             return Center(child: Text('Error: ${snapshot.error}'));
//           }

//           final totalPrice = snapshot.data ?? 0.0;

//           return Container(
//             width: double.infinity,
//             padding: const EdgeInsets.all(16.0),
//             decoration: BoxDecoration(
//               color: Colors.white,
//               boxShadow: [
//                 BoxShadow(
//                   color: Colors.black.withOpacity(0.1),
//                   blurRadius: 4,
//                   offset: const Offset(0, 2),
//                   spreadRadius: 2,
//                 ),
//               ],
//             ),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.center,
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 const Text(
//                   'Total Withdrawal Amount',
//                   style: TextStyle(
//                     fontSize: 24,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//                 const SizedBox(height: 20),
//                 Text(
//                   '\$${totalPrice.toStringAsFixed(2)}',
//                   style: const TextStyle(
//                     fontSize: 36,
//                     fontWeight: FontWeight.bold,
//                     color: Colors.green,
//                   ),
//                 ),
//               ],
//             ),
//           );
//         },
//       ),
//     );
//   }
// }


class WithdrawlScreen extends StatelessWidget {
  static const String routeName = '\WithdrawlScreen';

  Future<double> fetchTotalPrice() async {
    try {
      final querySnapshot = await FirebaseFirestore.instance
          .collection('orders')
          .where('accepted', isEqualTo: true)
          .get();

      // Calculate the total price of approved orders
      double totalPrice = querySnapshot.docs.fold(0.0, (sum, doc) {
        return sum + (doc['productPrice'] ?? 0.0);
      });

      return totalPrice;
    } catch (e) {
      debugPrint('Error fetching data: $e');
      throw Exception('Failed to fetch orders.');
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<double>(
      future: fetchTotalPrice(),
      builder: (BuildContext context, AsyncSnapshot<double> snapshot) {
        if (snapshot.hasError) {
          return Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.white,
              elevation: 0,
              title: const Text(
                "Withdrawal",
                style: TextStyle(color: Colors.black),
              ),
              iconTheme: const IconThemeData(color: Colors.black),
            ),
            body: Center(child: Text("Something went wrong")),
          );
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.white,
              elevation: 0,
              title: const Text(
                "Withdrawal",
                style: TextStyle(color: Colors.black),
              ),
              iconTheme: const IconThemeData(color: Colors.black),
            ),
            body: Center(
              child: CircularProgressIndicator(
                color: Colors.lightBlue.shade900,
              ),
            ),
          );
        }

        final totalPrice = snapshot.data ?? 0.0;

        return Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.white,
            elevation: 0,
            title: const Text(
              "Withdrawal",
              style: TextStyle(color: Colors.black),
            ),
            iconTheme: const IconThemeData(color: Colors.black),
          ),
          body: Center(
            child: Padding(
              padding: const EdgeInsets.all(14.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    height: 150,
                    width: MediaQuery.of(context).size.width * 0.3,
                    decoration: BoxDecoration(
                      color: Colors.lightBlue.shade900,
                      borderRadius: BorderRadius.circular(32),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        const Padding(
                          padding: EdgeInsets.all(10.0),
                          child: Text(
                            'TOTAL WITHDRAWAL',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Text(
                            '\$${totalPrice.toStringAsFixed(2)}',
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      // Implement withdrawal action
                    },
                    child: Container(
                      height: 40,
                      // width: MediaQuery.of(context).size.width - 40,
                      width:200,
                      decoration: BoxDecoration(
                        color: Colors.lightBlue.shade900,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: const Center(
                        child: Text(
                          'WITHDRAW',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 6,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
