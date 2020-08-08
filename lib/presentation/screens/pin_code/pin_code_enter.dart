import 'package:flutter/material.dart';
import 'package:zimsmobileapp/main.dart';

class DigitButton extends StatefulWidget {
  final int digit;
  final Function notifyParent;

  const DigitButton({Key key, this.digit, this.notifyParent}) : super(key: key);

  @override
  _DigitButtonState createState() => _DigitButtonState();
}

class _DigitButtonState extends State<DigitButton> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        if (dotNum < 4) {
          dots[dotNum] = true;
          pinEnter[dotNum] = this.widget.digit;
          dotNum++;
          widget.notifyParent();
        } else {
          dots = [false, false, false, false];
          widget.notifyParent();
        }
      },
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Text(widget.digit.toString(), style: TextStyle(fontSize: 30),),
      ),
    );
  }
}

class PinCodeEnter extends StatefulWidget {
  final Function notifyParent;
  const PinCodeEnter({Key key, this.notifyParent}) : super(key: key);
  @override
  _PinCodeEnterState createState() => _PinCodeEnterState();
}

class _PinCodeEnterState extends State<PinCodeEnter> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              DigitButton(digit: 1, notifyParent: this.widget.notifyParent),
              DigitButton(digit: 2, notifyParent: this.widget.notifyParent),
              DigitButton(digit: 3, notifyParent: this.widget.notifyParent),
            ],
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          ),
          Row(
            children: <Widget>[
              DigitButton(digit: 4, notifyParent: this.widget.notifyParent),
              DigitButton(digit: 5, notifyParent: this.widget.notifyParent),
              DigitButton(digit: 6, notifyParent: this.widget.notifyParent),
            ],
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          ),
          Row(
            children: <Widget>[
              DigitButton(digit: 7, notifyParent: this.widget.notifyParent),
              DigitButton(digit: 8, notifyParent: this.widget.notifyParent),
              DigitButton(digit: 9, notifyParent: this.widget.notifyParent),
            ],
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          ),
          Row(
            children: <Widget>[
              InkWell(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Icon(Icons.cancel, color: Colors.black),
                ),
                onTap: () {
                  dotNum = 0;
                  pinEnter = [null, null, null, null];
                  dots = [false, false, false, false];
                  widget.notifyParent();
                },
              ),
              DigitButton(digit: 0, notifyParent: this.widget.notifyParent),
              InkWell(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Icon(Icons.backspace, color: Colors.black),
                ),
                onTap: () {
                  if (dotNum > 0) {
                    dotNum--;
                    pinEnter[dotNum] = null;
                    dots[dotNum] = false;
                    widget.notifyParent();
                  }
                },
              ),
            ],
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          )
        ],
      ),
    );
  }
}
