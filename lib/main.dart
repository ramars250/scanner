import 'package:flutter/material.dart';
import 'package:scanner/widget_tree.dart';
import 'package:firebase_core/firebase_core.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.orange,
      ),
      home: const WidgetTree(),
    );
  }
}

// import 'dart:developer';
// import 'dart:io';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:http/http.dart' as http;
// import 'dart:convert';
// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';
// import 'package:qr_code_scanner/qr_code_scanner.dart';
// import 'package:scanner/pages/login.dart';

// void main() => runApp( MaterialApp(home: MyApp()));
//
// class MyApp extends StatelessWidget {
//    MyApp({Key? key}) : super(key: key);
//   final user = FirebaseAuth.instance.currentUser;
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('測試掃描'),
//       ),
//       drawer: Drawer(
//         child: ListView(
//           padding: EdgeInsets.zero,
//           children: [
//             const DrawerHeader(
//               decoration: BoxDecoration(color: Colors.greenAccent),
//               child: Center(
//                 child: SizedBox(
//                   width: 60,
//                   height: 60,
//                   child: CircleAvatar(
//                     child: Text('MA'),
//                   ),
//                 ),
//               ),
//             ),
//             ListTile(
//               leading: const Icon(Icons.person),
//               title: const Text('LOGIN'),
//               onTap: () {
//                 // Navigator.push(context,
//                 //     MaterialPageRoute(builder: (context) => Login()));
//               },
//             ),
//           ],
//         ),
//       ),
//       body: Center(
//         child: ElevatedButton(
//           onPressed: () {
//             Navigator.of(context).push(MaterialPageRoute(
//               builder: (context) => const QRViewExample(),
//             ));
//           },
//           child: const Text('qrView'),
//         ),
//       ),
//     );
//   }
// }
//
// class QRViewExample extends StatefulWidget {
//   const QRViewExample({super.key});
//
//   // ({Key? key}) : super(key: key);
//
//   @override
//   State<StatefulWidget> createState() => _QRViewExampleState();
// }
//
// class _QRViewExampleState extends State<QRViewExample> {
//   //用來查看是否有掃到條碼的變數
//   Barcode? result;
//   QRViewController? controller;
//   final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
//   final _form = GlobalKey<FormState>();
//
//   //儲存掃到內容的變數
//   late String title;
//
//   //寫入方法
//   void writeData() async {
//     _form.currentState?.save();
//     // Please replace the Database URL
//     // which we will get in “Add Realtime
//     // Database” step with DatabaseURL
//     var url =
//         "https://scanner-c3283-default-rtdb.firebaseio.com/" + "data.json";
//     // (Do not remove “data.json”,keep it as it is)
//     try {
//       final response = await http.post(
//         Uri.parse(url),
//         body: json.encode({"title": title}),
//       );
//     } catch (error) {
//       // ignore: use_rethrow_when_possible
//       throw error;
//     }
//   }
//
//   // In order to get hot reload to work we need to pause the camera if the platform
//   // is android, or resume the camera if the platform is iOS.
//   @override
//   void reassemble() {
//     super.reassemble();
//     //如果設備是Android就暫停相機，否則就重置相機
//     if (Platform.isAndroid) {
//       controller!.pauseCamera();
//     }
//     controller!.resumeCamera();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Column(
//         children: <Widget>[
//           Expanded(flex: 4, child: _buildQrView(context)),
//           Expanded(
//             flex: 1,
//             child: FittedBox(
//               fit: BoxFit.contain,
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                 children: <Widget>[
//                   if (result != null)
//                     Text(
//                         'Barcode Type: ${describeEnum(result!.format)}   Data: ${result!.code}')
//                   else
//                     const Text('Scan a code'),
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     crossAxisAlignment: CrossAxisAlignment.center,
//                     children: <Widget>[
//                       Container(
//                         margin: const EdgeInsets.all(8),
//                         child: ElevatedButton(
//                             onPressed: () async {
//                               await controller?.toggleFlash();
//                               setState(() {});
//                             },
//                             child: FutureBuilder(
//                               future: controller?.getFlashStatus(),
//                               builder: (context, snapshot) {
//                                 return Text('Flash: ${snapshot.data}');
//                               },
//                             )),
//                       ),
//                       Container(
//                         margin: const EdgeInsets.all(8),
//                         child: ElevatedButton(
//                             onPressed: () async {
//                               await controller?.flipCamera();
//                               setState(() {});
//                             },
//                             child: FutureBuilder(
//                               future: controller?.getCameraInfo(),
//                               builder: (context, snapshot) {
//                                 if (snapshot.data != null) {
//                                   return Text(
//                                       'Camera facing ${describeEnum(snapshot.data!)}');
//                                 } else {
//                                   return const Text('loading');
//                                 }
//                               },
//                             )),
//                       )
//                     ],
//                   ),
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     crossAxisAlignment: CrossAxisAlignment.center,
//                     children: <Widget>[
//                       Container(
//                         margin: const EdgeInsets.all(8),
//                         child: ElevatedButton(
//                           onPressed: () {
//                             setState(() {
//                               title = 'Data: ${result!.code} ${DateTime.now()}';
//                             });
//                             writeData();
//                             result = null;
//                             // await controller?.pauseCamera();
//                           },
//                           child: const Text(
//                               'Submit'
//                               // 'pause'
//                               ,
//                               style: TextStyle(fontSize: 20)),
//                         ),
//                       ),
//                       Container(
//                         margin: const EdgeInsets.all(8),
//                         child: ElevatedButton(
//                           onPressed: () async {
//                             await controller?.resumeCamera();
//                           },
//                           child: const Text('resume',
//                               style: TextStyle(fontSize: 20)),
//                         ),
//                       )
//                     ],
//                   ),
//                 ],
//               ),
//             ),
//           )
//         ],
//       ),
//     );
//   }
//
//   Widget _buildQrView(BuildContext context) {
//     // For this example we check how width or tall the device is and change the scanArea and overlay accordingly.
//     var scanArea = (MediaQuery.of(context).size.width < 400 ||
//             MediaQuery.of(context).size.height < 400)
//         ? 150.0
//         : 300.0;
//     // To ensure the Scanner view is properly sizes after rotation
//     // we need to listen for Flutter SizeChanged notification and update controller
//     return QRView(
//       key: qrKey,
//       onQRViewCreated: _onQRViewCreated,
//       overlay: QrScannerOverlayShape(
//           borderColor: Colors.red,
//           borderRadius: 10,
//           borderLength: 30,
//           borderWidth: 10,
//           cutOutSize: scanArea),
//       onPermissionSet: (ctrl, p) => _onPermissionSet(context, ctrl, p),
//     );
//   }
//
//   void _onQRViewCreated(QRViewController controller) {
//     setState(() {
//       this.controller = controller;
//     });
//     controller.scannedDataStream.listen((scanData) {
//       setState(() {
//         result = scanData;
//       });
//     });
//   }
//
//   void _onPermissionSet(BuildContext context, QRViewController ctrl, bool p) {
//     log('${DateTime.now().toIso8601String()}_onPermissionSet $p');
//     if (!p) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(content: Text('no Permission')),
//       );
//     }
//   }
//
//   @override
//   void dispose() {
//     controller?.dispose();
//     super.dispose();
//   }
// }
// ignore_for_file: prefer_adjacent_string_concatenation

// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'dart:convert';
//
// void main() {
//   runApp(MyApp());
// }
//
// class MyApp extends StatefulWidget {
//   @override
//   _MyAppState createState() => _MyAppState();
// }
//
// class _MyAppState extends State<MyApp> {
//   final _form = GlobalKey<FormState>();
//   late String title;
//   void writeData() async {
//     _form.currentState?.save();
//
//     // Please replace the Database URL
//     // which we will get in “Add Realtime
//     // Database” step with DatabaseURL
//     var url =
//         "https://scanner-c3283-default-rtdb.firebaseio.com/" + "data.json";
//
//     // (Do not remove “data.json”,keep it as it is)
//     try {
//       final response = await http.post(
//         Uri.parse(url),
//         body: json.encode({"title": title}),
//       );
//     } catch (error) {
//       // ignore: use_rethrow_when_possible
//       throw error;
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'RealTime Database',
//       theme: ThemeData(
//         primarySwatch: Colors.green,
//       ),
//       home: Scaffold(
//         appBar: AppBar(
//           title: const Text("測試掃描"),
//         ),
//         body: Form(
//           key: _form,
//           child: Center(
//             child: Column(
//               children: [
//                 const SizedBox(
//                   height: 10,
//                 ),
//                 TextFormField(
//                   decoration: const InputDecoration(hintText: "Enter Title"),
//                   onSaved: (value) {
//                     title = value!;
//                   },
//                 ),
//                 const SizedBox(
//                   height: 10,
//                 ),
//                 ElevatedButton(
//                     onPressed: writeData,
//                     // color: Colors.green,
//                     child: const Text(
//                       "Submit",
//                       style: TextStyle(color: Colors.white),
//                       textAlign: TextAlign.center,
//                     )),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
