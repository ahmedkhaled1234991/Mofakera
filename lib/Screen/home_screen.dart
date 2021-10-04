import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:mofakera/Screen/disc_screen.dart';
import 'package:mofakera/Screen/review_screen.dart';
import 'package:mofakera/helper/helper_note.dart';
import '../constant.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  @override
  void initState() {
    Note().db.then((value) {
      print("value $value");
    });
    // TODO: implement initState
    super.initState();
  }

  Color getColor(int i, AsyncSnapshot<dynamic> snapshot){
    String colorString = snapshot.data[i].color;
    String valueString = colorString.split('(0x')[1].split(')')[0];
    int value = int.parse(valueString, radix: 16);
    Color otherColor = Color(value);
    return otherColor;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "ToDo",
          style: TextStyle(
            color: textcolor,
            fontSize: fontLarge,
          ),
        ),
        centerTitle: true,
        backgroundColor: primarydarkcolor,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(RadiusCircular),
          bottomRight: Radius.circular(RadiusCircular),
        )),
      ),
      backgroundColor: primarycolor,
      body: FutureBuilder(
        future: Note().getdata(),
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          if(snapshot.hasData){
            if(snapshot.data.length == 0){
              return const Center(
                child: Text(
                  "Your ToDo list is Empty 😁😒 ",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              );
            }else{
              return Padding(
                padding: const EdgeInsets.all(5.0),
                child: StaggeredGridView.countBuilder(
                    itemCount: snapshot.data.length,
                    crossAxisCount: 2,
                    crossAxisSpacing: 10.0,
                    mainAxisSpacing: 10.0,
                    staggeredTileBuilder: (index) => const StaggeredTile.fit(1),
                    itemBuilder: (context, index) {
                      return Slidable(
                        actionPane: const SlidableDrawerActionPane(),
                        child: GestureDetector(
                          onTap: (){
                            Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) {
                              return ReviewScreen(date: snapshot.data[index].date ,description: snapshot.data[index].description ,title: snapshot.data[index].title ,done: snapshot.data[index].done);
                            }));
                          },
                          child: Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            elevation: 5,
                            color: getColor(index, snapshot),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("${snapshot.data[index].title}", style: const TextStyle(fontSize: 25, fontWeight: FontWeight.bold),),
                                  Text("${snapshot.data[index].date}", style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),),
                                  const SizedBox(height: 10,),
                                  Text("${snapshot.data[index].description}", style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),)
                                ],
                              ),
                            ),
                          ),
                        ),
                        actions: scrollright(index, snapshot),
                        secondaryActions: scrollleft(index, snapshot),
                      );
                    }),
              );
            }
          }else{
            return const Center(
              child: CircularProgressIndicator(
                backgroundColor: primarycolor,
                valueColor: AlwaysStoppedAnimation(Colors.white),
              ),
            );
          }
        },),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => DiscScreen()));
        },
        backgroundColor: primarydarkcolor,
        child: const Icon(
          Icons.add,
          color: textcolor,
        ),
      ),
    );
  }

  List<Widget> scrollright(int i, AsyncSnapshot<dynamic> snapshot){
    if(i %2 ==1){
      return [
        IconSlideAction(
          foregroundColor: Colors.red,
          caption: 'Delete',
          color: primarycolor,
          iconWidget: const Icon(
            Icons.delete,
            color: Colors.red,
              size: 30,
          ),
          onTap: () {
            Note().deletetodo(snapshot.data[i].id).then((value) {
              setState(() {
                print("value: $value");
              });
            });
          },
        ),
        //const SizedBox(width: 3,),
      ];
    }else{
      return [];
    }
  }

  List<Widget> scrollleft(int i, AsyncSnapshot<dynamic> snapshot){
    if(i %2 ==0){
      return [
        IconSlideAction(
          foregroundColor: Colors.red,
          caption: 'Delete',
          color: primarycolor,
          iconWidget: const Icon(
            Icons.delete,
            color: Colors.red,
            size: 30,
          ),
          onTap: () {
            Note().deletetodo(snapshot.data[i].id).then((value) {
              setState(() {
                print("value: $value");
              });
            });
          },
        ),
      ];
    }else{
      return [];
    }
  }
}
