import 'dart:convert';
import 'package:aws_ai/src/RekognitionHandler.dart';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:share/share.dart';
import 'dart:math';
import 'package:toughest/textStyle.dart';


class ShowDetail extends StatefulWidget {
  final String quest, ans;
  static var randomNumber = Random();
  ShowDetail({this.quest, this.ans});

  static final List<Color> _colors = [
    Colors.red,
    Colors.teal,
    Colors.orange,
    Colors.green,
    Colors.pink,
    Colors.purple,
    Colors.blue,
    Color(0xFFF1B136),
    Color(0xFF885F7F),
    Color(0xFF13B0A5),
    Color(0xFFD0C490),
    Color(0xFFEF6363),
  ];

  @override
  ShowDetailState createState() {
    return new ShowDetailState();
  }
}

class ShowDetailState extends State<ShowDetail> {

  share(String question, String answer) {
    Share.share("Q:" +
        question +
        "\n\n" +
        "A:" +
        answer +
        "\n\nDownload the app for more amazing Q/A\n " +
        "https://play.google.com/store/apps/details?id=tricky.questions");
  }

  Widget _card = new Container(
    // child: Text(text, style: TextStyle(fontSize: 15.0)),
    height: 170.0,
    margin: new EdgeInsets.all(8.0),
    decoration: new BoxDecoration(
      color: ShowDetail._colors[
          ShowDetail.randomNumber.nextInt(100) % ShowDetail._colors.length],
      shape: BoxShape.rectangle,
      borderRadius: new BorderRadius.circular(8.0),
      boxShadow: <BoxShadow>[
        new BoxShadow(
          color: Colors.black12,
          blurRadius: 10.0,
          offset: new Offset(0.0, 10.0),
        ),
      ],
    ),
  );

///add details in card.
  Widget cardDetail(String text) {
    return Stack(
      children: <Widget>[
        _card,
        Container(
            margin: EdgeInsets.all(20.0),
            child: Text(
              text,
              style: Style.commonTextStyle,
            )),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 10.0,
        backgroundColor: new Color(0xFFC67A7D),
        title: Text('Resultados'),
      ),
      body: ListView(
        children: <Widget>[
          Container(
            margin: EdgeInsets.all(8.0),
            child: RaisedButton(
              shape: BeveledRectangleBorder(borderRadius: new BorderRadius.circular(5.0)),
              splashColor: const Color(0xff382151),
              elevation: 20.0,
              child: Text(widget.quest,style: Style.regularTextStyle),
              onPressed: () => _optionsDialogBox(),
              color: Color(0xFF56cfdf),
            ),
          ),
          Container(
            margin: const EdgeInsets.all(8.0)
          ),
          Stack(children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
              widget.ans,style: Style.regularTextStyle),
            ),
          ]),
          SizedBox(
            height: 20.0,
          ),
          RaisedButton(
            shape: BeveledRectangleBorder(borderRadius: new BorderRadius.circular(5.0)),
            splashColor: const Color(0xff382151),
            elevation: 20.0,
            child: Text("Comparte esta foto en tus redes sociale",style: Style.regularTextStyle),
            color: Color(0xFF56cfdf),
            onPressed: () => share(widget.quest, widget.ans),
          ),
          SizedBox(height: 20.0),
      ],
      ),
     );
  }
  void _openCamera() {
    var picture = ImagePicker.pickImage(
      source: ImageSource.camera,
    );
      if(picture != null) {
        showAboutDialog(context: context);
          Navigator.pop(context);
          print("hola que hace");
      }
//    List<int> imageBytes = picture.readAsBytesSync();
//    print(imageBytes);
//    String base64Image = base64Encode(imageBytes);
//    print('string is');
//    print(base64Image);
//    print("You selected gallery image : " + picture.path);
//    setState(() {
//      _image = picture;
//    });
  }

  void _openGallery() {
    print('string is');
    var picture =  ImagePicker.pickImage(
      source: ImageSource.gallery,
    );
     if(picture != null) {
       Navigator.pop(context);
     }
//    List<int> imageBytes = picture.readAsBytesSync();
//    print(imageBytes);
//    String base64Image = base64Encode(imageBytes);
//    print('string is');
//    print(base64Image);
//    print("You selected gallery image : " + picture.path);
//    setState(() {
//      _image = picture;
//    });
  }

  Future<void> _optionsDialogBox() {
    return showDialog(context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            content: new SingleChildScrollView(
              child: new ListBody(
                children: <Widget>[
                  GestureDetector(
                    child: new Text('Capture fotografia'),
                    onTap: _openCamera,
                  ),
                  Padding(
                    padding: EdgeInsets.all(8.0),
                  ),
                  GestureDetector(
                    child: new Text('Seleccione de la galeria'),
                    onTap: _openGallery,
                  ),
                ],
              ),
            ),
          );
        });
  }
}
