import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:pokedex/shared/ui/canvas/white_pokeball_canvas.dart';
import 'package:pokedex/theme/app_theme.dart';

class AppBarWidget extends StatefulWidget {
  final String title;
  final bool showAnimatedPokeball;
  final String? lottiePath;

  const AppBarWidget(
      {Key? key,
      required this.title,
      required this.showAnimatedPokeball,
      this.lottiePath})
      : super(key: key);

  @override
  _AppBarWidgetState createState() => _AppBarWidgetState();
}

class _AppBarWidgetState extends State<AppBarWidget>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();

    _controller =
        AnimationController(vsync: this, duration: Duration(seconds: 2))
          ..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      pinned: true,
      snap: false,
      floating: false,
      expandedHeight: 170.0,
      collapsedHeight: 70,
      elevation: 0,
      backgroundColor: AppTheme.colors.background,
      actions: [
        Padding(
          padding: EdgeInsets.only(top: 20),
          child: IconButton(
            onPressed: () {
              Scaffold.of(context).openEndDrawer();
            },
            icon: Icon(
              Icons.menu,
              color: Colors.black,
            ),
          ),
        )
      ],
      flexibleSpace: Stack(children: [
        FlexibleSpaceBar(
          centerTitle: false,
          background: widget.lottiePath != null
              ? Align(
                  alignment: Alignment.bottomRight,
                  child: Lottie.asset(widget.lottiePath!, height: 140.0),
                )
              : Container(),
          titlePadding: EdgeInsets.only(left: 15, bottom: 10),
          title: Row(
            children: [
              if (widget.showAnimatedPokeball)
                AnimatedBuilder(
                  animation: _controller,
                  builder: (_, child) {
                    return Transform.rotate(
                      angle: _controller.value * 2 * pi,
                      child: child,
                    );
                  },
                  child: CustomPaint(
                    size: Size(
                        24,
                        (24 * 1.0040160642570282)
                            .toDouble()), //You can Replace [WIDTH] with your desired width for Custom Paint and height will be calculated automatically
                    painter: PokeballLogoPainter(
                        color: AppTheme.colors.pokeballLogoBlack),
                  ),
                ),
              SizedBox(
                width: 5,
              ),
              Text(widget.title, style: AppTheme.texts.homePageTitle),
            ],
          ),
        ),
      ]),
    );
  }
}
