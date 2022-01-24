import 'package:flutter/material.dart';

class CircularButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
      child: Stack(
        children: <Widget>[

          Center(
              child: ClipOval(
                child: Container(
                  color: Colors.blue,
                  height: 250.0, // height of the button
                  width: 250.0, // width of the button
                ),
              )),
          Center(
              child: GestureDetector(
                onTap: () {},
                child: ClipOval(
                  child: Container(
                    //color: Colors.green,
                    height: 230.0, // height of the button
                    width: 230.0, // width of the button
                    decoration: BoxDecoration(
                        color: Colors.green,
                        border: Border.all(
                            color: Colors.white,
                            width: 2.0,
                            style: BorderStyle.solid),
                        boxShadow: [
                          BoxShadow(
                              color: Colors.grey,
                              offset: Offset(21.0, 10.0),
                              blurRadius: 20.0,
                              spreadRadius: 40.0)
                        ],
                        shape: BoxShape.circle),
                    child: Center(
                        child: Text('Your car is safe',
                            style:
                            TextStyle(color: Colors.white,fontSize: 25,fontWeight: FontWeight.bold))),
                  ),
                ),
              )),

        ],
      ),
    );
  }
}