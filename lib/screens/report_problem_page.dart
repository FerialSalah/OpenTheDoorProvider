import 'package:flutter/material.dart';

class ReportProblem extends StatefulWidget {
  @override
  _ReportProblemState createState() => _ReportProblemState();
}

class _ReportProblemState extends State<ReportProblem> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor:Colors.white ,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(32.0))),
      contentPadding: EdgeInsets.only(top: 10.0),
      content: Container(
        width: MediaQuery.of(context).size.width/2,
        height: MediaQuery.of(context).size.height/2,
        child: Column(

          children: <Widget>[

            Text('Report A Problem',
              style: TextStyle(fontWeight: FontWeight.bold,fontSize: 30,color:Color(0xFFC89C17), ),
            ),

            SizedBox(height: 10.0,),
            Text('Report a problem about..',
              style: TextStyle(fontWeight: FontWeight.bold,),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                maxLines: 3,
                autocorrect: true,
                cursorColor: Color(0xFFC89C17),
                decoration: InputDecoration(
                  hintText: 'write here the reasons..',


                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Color(0xFFC89C17)),
                  ),
                ),),
            ),
            SizedBox(height: 50.0,),

            MaterialButton(
              minWidth: 200.0,
              height: 20.0,
              child: Text('Report',style:TextStyle(color: Colors.white),),
              color: Color(0xFFC89C17),
              textColor: Color(0xFFC89C17),
              padding: EdgeInsets.all(8.0),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5)),
              onPressed: () {





              },
            ),

            SizedBox(height: 20.0,),



          ],
        ),
      ),
    );
  }
}
