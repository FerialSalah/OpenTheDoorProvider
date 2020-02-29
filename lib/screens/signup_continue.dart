import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_openthedoorprovider/utili/apiProvider.dart';
import 'package:flutter_openthedoorprovider/utili/helpers.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../localization.dart';
import 'drawer.dart';

class SignUpFinalPage extends StatefulWidget {
  @override
  _SignUpFinalPageState createState() => _SignUpFinalPageState();
}

class _SignUpFinalPageState extends State<SignUpFinalPage> {
  TextEditingController _nameController = new TextEditingController();
  TextEditingController _emailController = new TextEditingController();

  bool isLoading = false;
  bool autovalidate = false;
  String birthDateInString = "Birth Date";

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  DateTime birthDate;

  bool isDateSelected;

  Future<void> validateInputs() async {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();
      try {
        setState(() {
          isLoading = true;
        });
        SharedPreferences prefs = await SharedPreferences.getInstance();
        ApiProvider api = new ApiProvider();
        await api.registration(
            img: img,
            password: prefs.getString('password'),
            passwordConfirmation: prefs.getString('password'),
            phone: _nameController.text,
            email: _emailController.text);
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => MyHomePage()));
      } catch (e) {
        print(e);
        setState(() {
          isLoading = false;
        });
        Helpers.showTheDialog(context, "error", "error");
      }
    } else {
      setState(() {
        autovalidate = true;
      });
    }
  }

  static File img;
  Widget profileImage(BuildContext context) {
    return Positioned(
        top: MediaQuery.of(context).size.height / 30,
        left: 100,
        right: 100,
        child: Container(
          alignment: Alignment.center,
          child: InkWell(
            onTap: () {
              img = Helpers.selectImg(context);
              setState(() {});
            },
            child: CircleAvatar(
              backgroundColor: Colors.yellow,
              backgroundImage: AssetImage(img == null ? "" : img.path),
              radius: 50.0,

//          child: Icon(
//            Icons.account_circle,
//            color: Color(0xFFC89C17),
//
//          ),
            ),
          ),
        ));
  }

  @override
  Widget build(BuildContext context) {
    // String birth=AppLocalizations.of(context).translateString('birth_date');

    return Scaffold(
      backgroundColor: Color(0xFFC89C17),
      appBar: AppBar(
        title:
            Text(AppLocalizations.of(context).translateString('btn_register')),
        backgroundColor: Color(0xFFC89C17),
        centerTitle: true,
        leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () => Navigator.pop(context, false)),
      ),
      body: Form(
        key: _formKey,
        autovalidate: autovalidate,
        child: SingleChildScrollView(
          child: Stack(
            children: <Widget>[
              Column(
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(
                        top: MediaQuery.of(context).size.height / 10),
                    padding: EdgeInsets.only(left: 10, right: 10),
                    child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      elevation: 8,
                      child: Padding(
                        padding: const EdgeInsets.all(30.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            SizedBox(
                              height: 15,
                            ),
                            TextFormField(
                              controller: _nameController,
                              validator: (String arg) {
                                if (arg.length < 1)
                                  return 'enter vaild name';
                                else
                                  return null;
                              },
                              keyboardType: TextInputType.text,
                              cursorColor: Color(0xFFC89C17),
                              decoration: InputDecoration(
                                  labelText: AppLocalizations.of(context)
                                      .translateString('name'),
                                  labelStyle: TextStyle(
                                    color: Color(0xFFC89C17),
                                  ),
                                  hasFloatingPlaceholder: true,
                                  prefixIcon: Icon(Icons.account_circle,
                                      color: Color(0xFFC89C17)),
                                  counterStyle:
                                      TextStyle(color: Color(0xFFC89C17))),
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            TextFormField(
                              controller: _emailController,
                              validator: (String arg) {
                                if (Helpers.emailvalidator(arg) == false)
                                  return 'enter vaild email';
                                else
                                  return null;
                              },
                              keyboardType: TextInputType.text,
                              cursorColor: Color(0xFFC89C17),
                              decoration: InputDecoration(
                                  labelText: AppLocalizations.of(context)
                                      .translateString('email'),
                                  labelStyle: TextStyle(
                                    color: Color(0xFFC89C17),
                                  ),
                                  hasFloatingPlaceholder: true,
                                  prefixIcon: Icon(Icons.email,
                                      color: Color(0xFFC89C17)),
                                  counterStyle:
                                      TextStyle(color: Color(0xFFC89C17))),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                              Flexible(
                                child: TextFormField(
                                  keyboardType: TextInputType.number,
                                  cursorColor: Color(0xFFC89C17),
                                  decoration: InputDecoration(
                                      labelText: 'Birth date',
                                      labelStyle: TextStyle(fontSize: 15.0),
                                      hasFloatingPlaceholder: true,
                                      prefixIcon: Icon(Icons.calendar_today,
                                          color: Color(0xFFC89C17)),
                                      counterStyle: TextStyle(
                                          color: Color(0xFFC89C17))),
                                ),
                              ),

                              IconButton(
                                  icon: Icon(
                                    Icons.date_range,
                                    size: 40.0,
                                    color: Color(0xFFC89C17),
                                  ),
                                  onPressed: () async {
                                    final datePick = await showDatePicker(
                                        context: context,
                                        initialDate: new DateTime.now(),
                                        firstDate: new DateTime(1900),
                                        lastDate: new DateTime(2100));
                                    if (datePick != null &&
                                        datePick != birthDate) {
                                      setState(() {
                                        birthDate = datePick;
                                        isDateSelected = true;

                                        // put it here
                                        birthDateInString =
                                            "${birthDate.month}/${birthDate.day}/${birthDate.year}";

                                        print(birthDateInString);
                                      });
                                    }
                                  })
                            ]),
                            SizedBox(
                              height: 10,
                            ),
                            Row(
                              children: <Widget>[
                                Text(
                                  "Gender:",
                                  style: TextStyle(fontStyle: FontStyle.normal),
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: <Widget>[
                                Radio(
                                  value: 1,
                                 // groupValue:,
                                  onChanged: (_) {},
                                  //activeColor: Colors.amber,
                                ),
                                Text('Male'),
                                Radio(
                                  value: 2,
                                 // groupValue: 2,
                                  onChanged: (_) {},
                                  activeColor: Colors.amber,
                                ),
                                Text('Female')
                              ],
                            ),
                            Row(
                              children: <Widget>[
                                Text(
                                  "Are You?",
                                  style: TextStyle(fontStyle: FontStyle.normal),
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: <Widget>[
                                Radio(
                                  value: 1,
                                 // groupValue: 1,
                                  onChanged: (_) {},
                                  activeColor: Colors.amber,
                                ),
                                Text('Citizan'),
                                Radio(
                                  value: 1,
                                  //groupValue: 1,
                                  onChanged: (_) {},
                                  activeColor: Colors.amber,
                                ),
                                Text('Resident')
                              ],
                            ),
                            FocusScope(
                              node: FocusScopeNode(),
                              child: TextFormField(
                                keyboardType: TextInputType.number,
                                cursorColor: Color(0xFFC89C17),
                                decoration: InputDecoration(
                                    hintText:'Residence or status card' ,
                                    labelStyle: TextStyle(fontSize: 15.0),
                                    hasFloatingPlaceholder: true,
                                    prefixIcon: Icon(Icons.add,
                                        color: Color(0xFFC89C17)),
                                    counterStyle:
                                        TextStyle(color: Color(0xFFC89C17))),
                              ),
                            ),
                            SizedBox(
                              height: 10.0,
                            ),
                            Row(
                              children: <Widget>[
                                Text(
                                  "Are You?",
                                  style: TextStyle(fontStyle: FontStyle.normal),
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: <Widget>[
                                Radio(
                                  value: 1,
                                 // groupValue: 1,
                                  onChanged: (_) {},
                                  activeColor: Colors.amber,
                                ),
                                Text('Employee'),
                                Radio(
                                  value: 1,
                                  //groupValue: 1,
                                  onChanged: (_) {},
                                  activeColor: Colors.amber,
                                ),
                                Text('Non_employee')
                              ],
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Flexible(
                                  flex: 1,
                                  child: TextFormField(
                                    keyboardType: TextInputType.number,
                                    cursorColor: Color(0xFFC89C17),
                                    decoration: InputDecoration(
                                        labelText: 'Place of employment',
                                        labelStyle: TextStyle(fontSize: 15.0),
                                        hasFloatingPlaceholder: true,
                                        prefixIcon: Icon(Icons.place,
                                            color: Color(0xFFC89C17)),
                                        counterStyle: TextStyle(
                                            color: Color(0xFFC89C17))),
                                  ),
                                ),
                                IconButton(
                                    icon: Icon(
                                      Icons.my_location,
                                      size: 40.0,
                                      color: Color(0xFFC89C17),
                                    ),
                                    onPressed: null)
                              ],
                            ),
                            SizedBox(
                              height: 10.0,
                            ),
                            Row(
                              children: <Widget>[
                                Text(
                                  " Evidence Files:",
                                  style: TextStyle(fontStyle: FontStyle.normal),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 10.0,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Text('Arecent Personal Image'),
                                IconButton(
                                  icon: Icon(
                                    Icons.cloud_upload,
                                    color: Color(0xFFC89C17),
                                    size: 30.0,
                                  ),
                                )
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Text('Image of residence'),
                                IconButton(
                                  icon: Icon(
                                    Icons.cloud_upload,
                                    color: Color(0xFFC89C17),
                                    size: 30.0,
                                  ),
                                )
                              ],
                            ),
                            SizedBox(
                              height: 10.0,
                            ),
                            FlatButton(
                              child: Text(AppLocalizations.of(context)
                                  .translateString('btn_register')),
                              color: Color(0xFFC89C17),
                              textColor: Colors.white,
                              padding: EdgeInsets.only(
                                  left: 38, right: 38, top: 15, bottom: 15),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5)),
                              onPressed: () {
                                validateInputs();
                              },
                            ),
                            SizedBox(
                              height: 15,
                            ),
                          ],
                        ),
                      ),
                    ),
                  )
                ],
              ),
              profileImage(context)
            ],
          ),
        ),
      ),
    );
  }
}
