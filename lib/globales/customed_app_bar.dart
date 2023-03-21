import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

Widget customedAppBar(
    {dynamic onPressed,
    String title = "",
    bool last = false,
    bool stop = false}) {
  return Container(
    width: double.infinity,
    height: last ? 100 : 60,
    margin: stop
        ? const EdgeInsets.only()
        : const EdgeInsets.only(right: 14, left: 14, top: 50),
    child: Column(
      children: [
        Expanded(
          child: Stack(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  IconButton(
                    icon: const Icon(
                      Icons.arrow_back,
                      color: Colors.white,
                      size: 25,
                    ),
                    onPressed: onPressed,
                  ),
                  last
                      ? Container()
                      : Expanded(
                          child: AutoSizeText(
                            title,
                            maxLines: 2,
                            style: const TextStyle(
                              fontFamily: "montserrat",
                              fontWeight: FontWeight.w700,
                              fontSize: 18,
                              color: Colors.white,
                            ),
                          ),
                        ),
                ],
              ),
              last
                  ? Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Container(
                          margin: const EdgeInsets.only(top: 20),
                          child: Text(
                            title,
                            style: const TextStyle(
                              fontFamily: "montserrat",
                              fontWeight: FontWeight.w700,
                              fontSize: 18,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    )
                  : Container(),
            ],
          ),
        ),
        last
            ? Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  const Text(
                    "No finalices sin antes estar seguro\nde tus nuevos cambios",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: "montserrat",
                      fontWeight: FontWeight.w400,
                      fontSize: 14,
                      color: Colors.white,
                    ),
                  ),
                ],
              )
            : Container(),
      ],
    ),
  );
}
