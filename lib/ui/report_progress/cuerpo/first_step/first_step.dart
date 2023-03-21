import 'package:appalimentacion/ui/widgets/widgets.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'buscador.dart';
import 'first_step_provider.dart';
import 'progress_card.dart';

class FirstStepBody extends StatelessWidget {
  const FirstStepBody._();

  static Widget init() {
    return ChangeNotifierProvider(
      create: (context) =>
          FirstStepProvider(projectsCacheRepository: context.read()),
      child: const FirstStepBody._(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final firstStepProvider = Provider.of<FirstStepProvider>(context);

    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(top: 230),
      child: ListView(
        physics: const BouncingScrollPhysics(),
        children: <Widget>[
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 31),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const <Widget>[
                TextTitle(text: 'Ingrese el avance'),
                SizedBox(height: 2),
                TextSubtitle(
                    text: 'Ingrese cantidad de avance por actividad'),
              ],
            ),
          ),
          const SizedBox(height: 18),
          Padding(
            padding: const EdgeInsets.only(left: 30.0, right: 34),
            child: buscador(
              onChanged: (value) {
                firstStepProvider.txtBuscarAvance = value;
              },
              onPressed: () =>
                  firstStepProvider.filter(firstStepProvider.txtBuscarAvance),
            ),
          ),
          const SizedBox(height: 26.23),
          CarouselSlider(
            options: CarouselOptions(
              enableInfiniteScroll: false,
              scrollPhysics: const BouncingScrollPhysics(),
              enlargeCenterPage: true,
              height: 435.0,
            ),
            items: <Widget>[
              for (final activity in firstStepProvider.filteredActivites)
                ProgressCard(
                  activity: activity,
                  valueSaved: firstStepProvider
                          .activitiesProgress[activity.getStringId] ??
                      '0',
                  onChanged: (value) {
                    firstStepProvider.saveValue(activity.actividadId, value);
                  },
                ),
            ],
          ),
        ],
      ),
    );
  }
}
