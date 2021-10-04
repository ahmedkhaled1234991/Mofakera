import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/painting.dart';
import 'package:mofakera/helper/share_function.dart';
import '../constant.dart';

class ReviewScreen extends StatefulWidget {

  var description;
  var title;
  var date;
  var done;


  ReviewScreen({this.description, this.title, this.date, this.done});

  @override
  _ReviewScreenState createState() => _ReviewScreenState();
}

class _ReviewScreenState extends State<ReviewScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "${widget.title}",
          style: const TextStyle(
            color: textcolor,
            fontSize: fontLarge,
          ),
        ),
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back_ios,
            color: textcolor,
            size: 25,
          ),
        ),
        backgroundColor: primarydarkcolor,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(RadiusCircular),
              bottomRight: Radius.circular(RadiusCircular),
            )),
      ),
      backgroundColor: primarycolor,
      body: Padding(
        padding: const EdgeInsets.all(DPadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("${widget.date}", style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),),
            const SizedBox(height: 20,),
            Text("${widget.description}", style: const TextStyle(fontSize: fonttitel),),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          ShareFunction().shareLink("-title: ${widget.title} \n-date: ${widget.date} \n-description: ${widget.description}");
        },
        backgroundColor: primarydarkcolor,
        child: const Icon(
          Icons.share,
          color: textcolor,
        ),
      ),
    );
  }
}
