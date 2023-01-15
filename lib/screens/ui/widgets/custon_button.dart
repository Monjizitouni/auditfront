import 'package:flutter/material.dart';

class CustonButton extends StatelessWidget {
  final String texto;
  final Color? cor;
  final Color? background;
  final Function? onpressed;

  const CustonButton({
    Key? key,
    required this.texto,
    this.cor,
    this.background,
    this.onpressed
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        if (onpressed!=null){
          onpressed!();
          }
      } ,
      style: ButtonStyle(
        elevation: MaterialStateProperty.all(2),
        shape: MaterialStateProperty.all(
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(50))),
        backgroundColor: MaterialStateProperty.all(background),
        fixedSize: MaterialStateProperty.all(const Size(412, 60)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            texto,
            textAlign: TextAlign.center,
            style:  TextStyle(
                color: cor,
                fontSize: 22,
                fontWeight: FontWeight.w500),
          )
        ],
        
      ),
    );
  }
}