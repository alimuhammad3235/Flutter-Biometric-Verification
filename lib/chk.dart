import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class ChkPage extends StatefulWidget {
  const ChkPage({super.key});

  @override
  State<ChkPage> createState() => _ChkPageState();
}

class _ChkPageState extends State<ChkPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(
            child: Lottie.asset('animations/fin2.json',
                height: 250, repeat: false, fit: BoxFit.cover),
          ),
        const Padding(
          padding: EdgeInsets.symmetric(vertical: 40),
          child: Text("Authenticate Successfully",style:TextStyle(fontStyle: FontStyle.italic,fontSize: 26,fontWeight:FontWeight.w500,color: Colors.white)),
        ),


        ],
      ),
    );
  }
}
