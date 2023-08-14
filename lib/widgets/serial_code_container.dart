import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class SerialCodeContainer extends StatefulWidget {
  const SerialCodeContainer({
    Key? key,
  }) : super(key: key);

  @override
  State<SerialCodeContainer> createState() => _SerialCodeContainerState();
}

class _SerialCodeContainerState extends State<SerialCodeContainer> {
  String modelCode = "";
  String modelName = "----";
  String serial = "----";
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          decoration: const BoxDecoration(color: Color(0xff485A7E)),
          child: Column(
            children: [
              SvgPicture.asset(
                'assets/images/icons/line.svg',
                width: 60,
                height: 10,
              ),
              const Spacer(),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "",
                    style: const TextStyle(
                      fontSize: 20.0,
                      fontFamily: 'Lato',
                      color: Color(0xffFFFFFF),
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(
                        'Marca: $modelName Código: $modelCode',
                        style: const TextStyle(
                          fontSize: 18.0,
                          fontFamily: 'Lato',
                          color: Color(0xffFFFFFF),
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              const Spacer(),
            ],
          ),
        ),
      ),
    );
  }
}
