import 'package:evento/exports.dart';
import 'package:flutter/material.dart';

class ExploreScreen extends StatelessWidget {
  const ExploreScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AppTheme theme = context.watch();
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/map-large.png'),
                  fit: BoxFit.cover,
                  colorFilter: ColorFilter.srgbToLinearGamma(),
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: Insets.l)
                  .add(EdgeInsets.symmetric(horizontal: Insets.l)),
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        color: theme.surface,
                        borderRadius: Corners.s5Border,
                      ),
                      child: Row(
                        children: [
                          HSpace.md,
                          EvIcBtn(
                            EvSvgIc(R.I.arrowLeft.svgT),
                            bgColor: theme.surface,
                            onPressed: () => Navigator.pop(context),
                          ),
                          Expanded(
                            child: EvSearchField(
                              onChanged: (value) {},
                              hint: 'Find Nearby Events...',
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  HSpace.md,
                  EvIcBtn(
                    EvSvgIc(R.I.gps.svgB, color: theme.primary),
                    bgColor: theme.surface,
                    padding: const EdgeInsets.all(14),
                    onPressed: () {},
                  ),
                ],
              ),
            ),
            Positioned(
              left: 0,
              right: 0,
              top: context.widthPct(.22),
              child: const _CategorySection(),
            ),
            Positioned(
              bottom: 10,
              height: 160,
              width: context.widthPx,
              child: PageView(
                controller: PageController(
                  viewportFraction: .89,
                  initialPage: 1,
                ),
                pageSnapping: true,
                children: [
                  ...List.generate(
                    10,
                    (index) => EventItem(
                      data: EventModel.fromJson(
                        {
                          'date': 'Web, Apr 28. 5:30 PM',
                          'name': "Jo Malone London's Mother's Day Presents",
                          'location': 'Radius Gallery. Santa Cruz, CA',
                          'img': 'e1',
                          'backdrop': 'e1l',
                        },
                      ),
                      margin: EdgeInsets.symmetric(
                        horizontal: 5,
                        vertical: Insets.sm,
                      ),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _CategorySection extends StatelessWidget {
  const _CategorySection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 60,
      child: EvHScroll(
        child: Row(
          children: [
            HSpace.lg,
            _buildItem(R.I.science.svgB, 'Science', Colors.amber),
            _buildItem(R.I.reserve.svgB, 'Food', Colors.indigo),
            _buildItem(R.I.music.svgB, 'Music', Colors.pink),
            _buildItem(R.I.brush.svgB, 'Art', Colors.green),
            _buildItem(R.I.bitcoin.svgB, 'Crypto', Colors.teal),
            _buildItem(R.I.code.svgB, 'Coding', Colors.blue),
            _buildItem(R.I.game.svgB, 'Games', Colors.deepOrange),
          ],
        ),
      ),
    );
  }

  Widget _buildItem(String icon, String title, Color color) {
    return Container(
      height: 40,
      padding: EdgeInsets.symmetric(horizontal: Insets.m),
      margin: EdgeInsets.only(right: Insets.m),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Colors.white,
        boxShadow: Shadows.m(Colors.grey, .1),
      ),
      child: Row(
        children: [
          EvSvgIc(icon, color: color),
          HSpace.md,
          Text(title, style: TextStyles.h6),
        ],
      ),
    );
  }
}
