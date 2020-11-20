import 'package:flutter/material.dart';
import 'package:flutter_appnew/Constants.dart';
import 'package:focused_menu/modals.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:focused_menu/focused_menu.dart';




const URL ='https://elephant-api.herokuapp.com/elephants';

class TabData extends StatefulWidget {
  @override
  _TabDataState createState() => _TabDataState();
}



class _TabDataState extends State<TabData> {

  List image = [];
  List names = [];
  bool isLoading = false;
  var _tapPosition;


  @override
  void initState() {
    // getUserData();
    super.initState();
    this.fetchUser();
    _tapPosition = Offset(0.0, 0.0);
  }




  fetchUser() async{
    setState(() {
      isLoading = true;
    });
    var response = await http.get(URL);
    print(response.statusCode);
    if(response.statusCode == 200){
      var items = json.decode(response.body).forEach((element){
        setState(() {
          names.add(element["name"]);
          image.add(element["image"]);
        });
      });
    }
    else{
      setState(() {
        names = [];
        isLoading = false;
      });
    }
  }






  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: names.length,
      itemBuilder: (BuildContext context, int index){
      return getCard(context, index);
    },
      separatorBuilder: (context, index) => Divider(thickness: 2,),
    );
  }



  Widget getCard(BuildContext context, int index){
    return InkWell(
      splashColor: Colors.green,
      onLongPress: (){
        _showPopupMenu();
      },
      child: Container(
        height: 100,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListTile(
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  height: 60,
                  width: 60,
                  decoration: BoxDecoration(
                    color: Colors.purple,
                    borderRadius: BorderRadius.circular(30),
                    image: DecorationImage(
                      image:
                      // Image.network('${image[index]}'),
                      // AssetImage(image.toString()),
                      NetworkImage('${image[index]}'),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),

                SizedBox(width: 20,),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[

                    Text('${names[index]}', style: kListTileTextNameStyle,),

                    SizedBox(height: 15,),
                    IntrinsicHeight(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[

                          Text('Live 31', style: kListTileTextLiveStyle,),

                          VerticalDivider(thickness: 1, color: Colors.grey,),

                          Text('Total 99', style: kListTileTextTotalStyle,),

                          SizedBox(width: 60,),
                          Text('Yesterday'),
                        ],
                      ),
                    ),

                  ],
                ),


                Icon(Icons.assignment_turned_in_outlined, color: Colors.greenAccent,),

              ],
            ),
          ),
        ),
      ),
    );
  }




  _showPopupMenu() async {
    final RenderBox overlay = Overlay.of(context).context.findRenderObject();

    await showMenu(
      context: context,
      position: RelativeRect.fromRect(
          _tapPosition & Size(40, 160), // smaller rect, the touch area
          Offset.zero & overlay.size, // Bigger rect, the entire screen
      ),
      items: [
        PopupMenuItem(
          height: 110,
          child: Container(
            // width: 520,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                GestureDetector(
                    child: Icon(Icons.arrow_back, size: 25,),
                  onTap: (){
                    // _settingModalBottomSheet(context);
                    Navigator.pop(context);
                    print('Back Button Presses');
                  },
                ),
                SizedBox(width: 20,),
                Text('1', style: TextStyle(fontSize: 25),),
                SizedBox(width: 20,),
                GestureDetector(
                    child: Icon(Icons.push_pin,size: 25,),
                  onTap: (){
                    _settingModalBottomSheet(context);
                    print('Pin Item selected');
                  },
                ),
                SizedBox(width: 20,),
                GestureDetector(
                    child: Icon(Icons.volume_off,size: 25,),
                  onTap: (){
                    _settingModalBottomSheet(context);
                    print('Mute Item selected');
                  },
                ),
                SizedBox(width: 20,),
                GestureDetector(
                    child: Icon(Icons.delete,size: 25,),
                  onTap: (){
                    _settingModalBottomSheet(context);
                    print('Delete ITem Selected');
                  },
                ),
                SizedBox(width: 20,),
                GestureDetector(
                    child: Icon(Icons.assignment_return_rounded,size: 25,),
                  onTap: (){
                    _settingModalBottomSheet(context);
                    print('Archive Item Selected');
                  },
                ),


              ],
            ),
          ),
        ),
      ],
      elevation: 8.0,
    );
  }






  void _settingModalBottomSheet(context) {
    showModalBottomSheet(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(topRight: Radius.circular(20),topLeft: Radius.circular(20)),
        ),
        context: context,
        builder: (BuildContext bc) {
          return Container(
            child: new Wrap(
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: GestureDetector(
                          child: Icon(Icons.cancel, size: 30,),
                        onTap: (){
                            Navigator.pop(context);
                        },
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: new ListTile(
                      leading: new Icon(Icons.camera_alt, color: Colors.purple,size: 45,),
                      title: new Text(
                        'Take Photo',
                        style: TextStyle(
                          fontSize: 25,
                        ),
                      ),
                      onTap: () => {}
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.only(left: 25.0, right: 25),
                  child: Divider(
                    thickness: 1.5,
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: new ListTile(
                    leading: new Icon(Icons.photo,color: Colors.green,size: 45,),
                    title: new Text(
                      'Upload Photo',
                      style: TextStyle(
                        fontSize: 25,
                      ),
                    ),
                    onTap: () => {},
                  ),
                ),
              ],
            ),
          );
        }
    );
  }


}



