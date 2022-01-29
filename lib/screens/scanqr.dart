import 'package:barcode_widget/barcode_widget.dart';
import 'package:flutter/material.dart';
class CreateScreen extends StatefulWidget {


  @override
  _CreateScreenState createState() => _CreateScreenState();
}

class _CreateScreenState extends State<CreateScreen> with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var qrstr="Add Data";
    return Scaffold(
     appBar: AppBar(
       title: Text('Creating Qr code'),
     ),
      body: Column(
       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          BarcodeWidget(data:qrstr, barcode: Barcode.qrCode(),color:Colors.blue,
          height: 250,
          width: 250,),
        Container(
          alignment: Alignment.center
          ,width:MediaQuery.of(context).size.width*.8,
          child: TextField(
          onChanged:(val){
            setState(() {
              qrstr=val;
            });
          },
            decoration: InputDecoration(
              hintText: 'Enter your data here',
              border: OutlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.blue,
                  width: 2
                )
              ),
            ),
        )

        )
        ,SizedBox(width: MediaQuery.of(context).size.width,
          )
        ],


      ),
    );

}
}