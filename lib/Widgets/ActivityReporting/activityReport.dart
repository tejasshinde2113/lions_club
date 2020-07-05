import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:lionsclub/Widgets/Models/activityModel.dart';

class ActivityReport extends StatefulWidget {
  final String title;
  @override
  ActivityReport(this.title);
  _ActivityReportState createState() => _ActivityReportState();
}

class _ActivityReportState extends State<ActivityReport>
    with SingleTickerProviderStateMixin {
  File _imageFile;

  Future<Null> _pickImageFromGallery() async {
    final File imageFile =
        await ImagePicker.pickImage(source: ImageSource.gallery);
    setState(() => this._imageFile = imageFile);
  }

  final List<Tab> myTabs = <Tab>[
    Tab(icon: Text("1")),
    Tab(icon: Text("2")),
    Tab(icon: Text("3")),
  ];
  String title = 'DropDownButton';
  static const menuItems = <String>[
    '  Diabetes ',
    '  Environment ',
    '  Hunger ',
    '  Vision  ',
    '  Childhood Cancer ',
    '  District Governors ',
    '  Education ',
    '  Medical Activities ',
    '  Permanent Projects ',
    '  Rural Welfare Activities ',
    '  Other Important Activities '
  ];

  final List<DropdownMenuItem<String>> _dropDownMenuItems = menuItems
      .map(
        (String value) => DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        ),
      )
      .toList();

  String _btn2SelectedVal;
  TabController _tabController;

  static Activities act;
  Future<Activities> addactivity(
      String activityTitle,
      String amount,
      String city,
      String date,
      String cabinetOfficers,
      String description,
      String lionHours,
      dynamic mediaCoverage,
      String peopleServed,
      dynamic activityType,
      String place,
      dynamic authorId,
      dynamic clubId,
      dynamic image) async {
    var url = 'http://lions3234d2.com/api.php';
    Map data = {
      "activityTitle": 'yes',
      "amount": "String",
      "city": "String",
      "date": "String",
      "description": "String",
      "cabinetOfficers": "String",
      "lionHours": "String",
      "mediaCoverage": "String",
      "peopleServed": "String",
      "activityType": "dynamic",
      "place": "String",
      "authorId": "String",
      "clubId": "String",
      "image": "dynamic",

      'add-activity': 'true'

      // "userName" : "ritam@brocodedevs.online",
      //"password" : "pata nahi",
      //'login'    : 'true'
    };

    var response = await http.post(
      url,
      body: data,
    );


    Activities act = Activities(description,city,clubId,authorId,activityTitle,activityType,date,amount,cabinetOfficers,mediaCoverage,peopleServed,place,image,lionHours);

    print("Response status: ${response.statusCode}");
    Map userMap = jsonDecode(response.body);
    print("Response body: " + userMap.toString());

//    userMap['details'] = array[]
//    userMap['details']['name'] // name = ritam

    print("description:" + userMap["details"]["description"]);

    act = Activities(
        userMap["details"]["activityTitle"],
        userMap["details"]["amount"],
        userMap["details"]["city"],
        userMap["details"]["date"],
        userMap["details"]["cabinetOfficers"],
        userMap["details"]["clubId"],
        userMap["details"]["lionHours"],
        userMap["details"]["description"],
        userMap["details"]["mediaCoverage"],
        userMap["details"]["peopleServed"],
        userMap["details"]["activityType"],
        userMap["details"]["place"],
        userMap["details"]["image"],
        userMap["details"]["authorId"]);

    return act;
  }

  void _navigateToSubmit(BuildContext context) {
    var object = addactivity(
        "activityTitle",
        "amount",
        "city",
        "date",
        "cabinetOfficers",
        "description",
        "lionHours",
        "mediaCoverage",
        "peopleServed",
        "activityType",
        "place",
        "authorId",
        "clubId",
        "image");

    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => ActivityReport(widget.title)),
    );
  }

  Widget basicInformation() {
    return ListView(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(left: 15, top: 20),
          child: Container(
            alignment: Alignment.centerLeft,
            child: Text(
              'Basic Information',
              style: TextStyle(
                fontSize: 23.0,
              ),
            ),
          ),
        ),
        SizedBox(
          height: 10,
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(15.0, 8.0, 15.0, 8.0),
          child: GestureDetector(
            onTap: () {
              return _navigateToSubmit(context);
            },
            child: TextField(
              //controller: this._controller,
              maxLines: 1,
              textCapitalization: TextCapitalization.sentences,
              decoration: InputDecoration(
                // counterText: '${this._controller.text.split(' ').length} words',
                labelText: 'Activity Title',
                border: OutlineInputBorder(),
              ),
              onChanged: (text) => setState(() {}),
            ),
          ),
        ),
        SizedBox(
          height: 10,
        ),
        Padding(
          padding: const EdgeInsets.only(left: 15, right: 15),
          child: GestureDetector(
            onTap: () {
              return _navigateToSubmit(context);
            },
            child: Container(
              height: 58.0,
              decoration: BoxDecoration(
                  border: Border.all(
                color: Colors.grey,
              )),
              child: DropdownButton(
                isExpanded: true,
                value: _btn2SelectedVal,
                underline: Container(),
                hint: Text(
                  '  Activity Type',
                  style: TextStyle(),
                ),
                onChanged: ((String newValue) {
                  setState(() {
                    _btn2SelectedVal = newValue;
                  });
                }),
                items: _dropDownMenuItems,
              ),
            ),
          ),
        ),
        SizedBox(
          height: 10,
        ),
        //Padding(
        //padding: const EdgeInsets.fromLTRB(15.0,8.0,15.0,8.0),
        //child: TextField(

        //textCapitalization: TextCapitalization.sentences,
        //decoration: InputDecoration(

        //labelText: 'Activity Date',
        //border: OutlineInputBorder(),
        //),
        //onTap: ,
        // onChanged: (text) => setState(() {}),
        //),
        //),
        Padding(
          padding: const EdgeInsets.fromLTRB(15.0, 8.0, 15.0, 8.0),
          child: GestureDetector(
            onTap: () {
              return _navigateToSubmit(context);
            },
            child: TextField(
              //controller: this._controller,
              maxLines: 1,
              textCapitalization: TextCapitalization.sentences,
              decoration: InputDecoration(
                //counterText: '${this._controller.text.split(' ').length} words',
                labelText: 'Activity Date',
                border: OutlineInputBorder(),
              ),
              onChanged: (text) => setState(() {}),
            ),
          ),
        ),

        SizedBox(
          height: 10,
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(15.0, 8.0, 15.0, 8.0),
          child: GestureDetector(
            onTap: () {
              return _navigateToSubmit(context);
            },
            child: TextField(
              //controller: this._controller,
              maxLines: 1,
              textCapitalization: TextCapitalization.sentences,
              decoration: InputDecoration(
                //counterText: '${this._controller.text.split(' ').length} words',
                labelText: 'Activity Place',
                border: OutlineInputBorder(),
              ),
              onChanged: (text) => setState(() {}),
            ),
          ),
        ),
        SizedBox(
          height: 10,
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(15.0, 8.0, 15.0, 8.0),
          child: GestureDetector(
            onTap: () {
              return _navigateToSubmit(context);
            },
            child: TextField(
              //controller: this._controller,
              maxLines: 1,
              textCapitalization: TextCapitalization.sentences,
              decoration: InputDecoration(
                //counterText: '${this._controller.text.split(' ').length} words',
                labelText: 'Activity City',
                border: OutlineInputBorder(),
              ),
              onChanged: (text) => setState(() {}),
            ),
          ),
        ),
        SizedBox(
          height: 20,
        ),
        Center(
          child: FlatButton(
            textColor: Colors.white,
            color: Colors.red,
            child: Text(
              'NEXT',
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            onPressed: () {
              setState(() {
                _tabController.animateTo((_tabController.index + 1) % 3);
//                  Navigator.push(
//                      context,
//                      MaterialPageRoute(
//                          builder: (context) =>
//                              Description('Activity reporting')));
              });
            },
          ),
        ),
      ],
    );
  }

  Widget detailedInformation() {
    return ListView(children: <Widget>[
      Padding(
        padding: const EdgeInsets.only(left: 10, top: 10),
        child: Container(
          alignment: Alignment.centerLeft,
          child: Text(
            'Detailed Information',
            style: TextStyle(
              fontSize: 25.0,
            ),
          ),
        ),
      ),
      SizedBox(
        height: 10,
      ),
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: GestureDetector(
          onTap: () {
            return _navigateToSubmit(context);
          },
          child: TextField(
            // controller: this._controller,
            maxLines: 1,
            textCapitalization: TextCapitalization.sentences,
            decoration: InputDecoration(
              // counterText: '${this._controller.text.split(' ').length} words',
              labelText: 'No. of Lions Hours',
              border: OutlineInputBorder(),
            ),
            onChanged: (text) => setState(() {}),
          ),
        ),
      ),
      SizedBox(
        height: 10,
      ),
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: GestureDetector(
          onTap: () {
            return _navigateToSubmit(context);
          },
          child: TextField(
            //controller: this._controller,
            maxLines: 1,
            textCapitalization: TextCapitalization.sentences,
            decoration: InputDecoration(
              //counterText: '${this._controller.text.split(' ').length} words',
              labelText: 'ANo. of people served',
              border: OutlineInputBorder(),
            ),
            onChanged: (text) => setState(() {}),
          ),
        ),
      ),
      SizedBox(
        height: 10,
      ),
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: GestureDetector(
          onTap: () {
            return _navigateToSubmit(context);
          },
          child: TextField(
            //controller: this._controller,
            maxLines: 1,
            textCapitalization: TextCapitalization.sentences,
            decoration: InputDecoration(
              //counterText: '${this._controller.text.split(' ').length} words',
              labelText: 'Total Amount Spent',
              border: OutlineInputBorder(),
            ),
            onChanged: (text) => setState(() {}),
          ),
        ),
      ),
      SizedBox(
        height: 10,
      ),
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: GestureDetector(
          onTap: () {
            return _navigateToSubmit(context);
          },
          child: TextField(
            //controller: this._controller,
            maxLines: 1,
            textCapitalization: TextCapitalization.sentences,
            decoration: InputDecoration(
              //  counterText: '${this._controller.text.split(' ').length} words',
              labelText: 'Cabinet Officers Present (if any)',
              border: OutlineInputBorder(),
            ),
            onChanged: (text) => setState(() {}),
          ),
        ),
      ),
      SizedBox(
        height: 10,
      ),
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: GestureDetector(
          onTap: () {
            return _navigateToSubmit(context);
          },
          child: TextField(
            //controller: this._controller,
            maxLines: 1,
            textCapitalization: TextCapitalization.sentences,
            decoration: InputDecoration(
              //counterText: '${this._controller.text.split(' ').length} words',
              labelText: 'Media Coverage (if any)',
              border: OutlineInputBorder(),
            ),
            onChanged: (text) => setState(() {}),
          ),
        ),
      ),
      SizedBox(
        height: 15,
      ),
      Center(
        child: FlatButton(
          textColor: Colors.white,
          color: Colors.red,
          child: Text(
            'NEXT',
            style: TextStyle(
              fontSize: 20.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          onPressed: () {
            setState(() {
              _tabController.animateTo((_tabController.index + 1) % 3);
            });
          },
        ),
      ),
    ]);
  }

  Widget description() {
    return ListView(
//        mainAxisAlignment: MainAxisAlignment.spaceBetween,
//        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(left: 10, top: 10),
            child: Container(
              alignment: Alignment.centerLeft,
              child: Text(
                'Description',
                style: TextStyle(
                  fontSize: 25.0,
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: GestureDetector(
              onTap: () {
                return _navigateToSubmit(context);
              },
              child: TextField(
                // controller: this._controller,
                maxLines: 3,
                textCapitalization: TextCapitalization.sentences,
                decoration: InputDecoration(
                  // counterText: '${this._controller.text.split(' ').length} words',
                  labelText: 'Add Description Here',
                  border: OutlineInputBorder(),
                ),
                onChanged: (text) => setState(() {}),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              ' Photos(Max 4)',
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Center(
            child: Row(
              children: <Widget>[
                GestureDetector(
                  onTap: () {
                    return _navigateToSubmit(context);
                  },
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ButtonBar(
                        children: <Widget>[
                          RaisedButton(
                            color: Colors.red,
                            textColor: Colors.white,
                            child: Text('CHOOSE IMAGE'),
                            //icon: Icon(Icons.photo),
                            onPressed: () async =>
                                await _pickImageFromGallery(),
                            // tooltip: 'Pick from gallery',
                          ),
                          this._imageFile == null
                              ? Text('')
                              // Placeholder()

                              : Padding(
                                  padding: const EdgeInsets.only(
                                      left: 8.0, right: 90.0),
                                  child: Image.file(
                                    this._imageFile,
                                    height: 80,
                                    width: 80,
                                  ),
                                ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: GestureDetector(
              onTap: () {
                return _navigateToSubmit(context);
              },
              child: TextField(
                //controller: this._controller,
                maxLines: 1,
                textCapitalization: TextCapitalization.sentences,
                decoration: InputDecoration(
                  //counterText: '${this._controller.text.split(' ').length} words',
                  labelText: 'Upload Drive Link (Add Photos/Videos)',
                  border: OutlineInputBorder(),
                ),
                onChanged: (text) => setState(() {}),
              ),
            ),
          ),
          SizedBox(
            height: 85,
          ),
          Center(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(8.0, 8.0, 8.0, 8.0),
              child: GestureDetector(
                onTap: () {
                  return _navigateToSubmit(context);
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.red,
                  ),

                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'SUBMIT',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20.0,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  //  onPressed: () {
                  //  setState(() {
                  //  _tabController.animateTo((_tabController.index + 1) % 3);
                  //});
                  // },
                ),
              ),
            ),
          ),
        ]);
  }

  Widget createBody() {
    return TabBarView(controller: _tabController, children: <Widget>[
      basicInformation(),
      detailedInformation(),
      description(),
    ]);
  }

  @override
  void initState() {
    super.initState();
    _tabController = TabController(vsync: this, length: myTabs.length);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        //backgroundColor: Colors.yellow,
        title: Text(widget.title),
        bottom: TabBar(
          unselectedLabelColor: Colors.red[150],
          indicator: BoxDecoration(
            borderRadius: BorderRadius.circular(50),
          ),
          controller: _tabController,
          tabs: myTabs,
        ),
      ),
      body: createBody(),
    );
  }
}
