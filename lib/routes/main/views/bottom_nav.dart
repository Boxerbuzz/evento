import 'package:evento/exports.dart';
import 'package:flutter/material.dart';

class EVBottomNav extends StatelessWidget {
  const EVBottomNav({Key? key, this.items}) : super(key: key);
  final List<dynamic>? items;

  @override
  Widget build(BuildContext context) {
    return Consumer<AppProvider>(
      builder: (context, store, child) {
        return BottomAppBar(
          clipBehavior: Clip.antiAliasWithSaveLayer,
          notchMargin: Insets.sm,
          shape: const CircularNotchedRectangle(),
          elevation: 1,
          child: Container(
            height: 60,
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: Shadows.m(Colors.grey, .05),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: List.generate(_navItems.length, (index) {
                  var item = _navItems[index];
                  return item['isIcon'] == true
                      ? InkWell(
                          onTap: () => store.currentPage = index,
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              EvSvgIc(
                                store.currentPage == index
                                    ? item['selected']
                                    : item['icon'],
                                color: index == store.currentPage
                                    ? Theme.of(context).colorScheme.primary
                                    : Colors.grey[400],
                                size: 24,
                              ),
                              const VSpace(3),
                              Text(
                                item['label'],
                                style: TextStyles.caption.textColor(
                                    index == store.currentPage
                                        ? Theme.of(context).colorScheme.primary
                                        : Colors.black45),
                              ),
                            ],
                          ),
                        )
                      : index == 1
                          ? InkWell(
                              onTap: () => Navigator.push(
                                context,
                                RouteHelper.fadeScale(
                                  () => const ExploreScreen(),
                                ),
                              ),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  EvSvgIc(
                                    store.currentPage == index
                                        ? item['selected']
                                        : item['icon'],
                                    color: index == store.currentPage
                                        ? Theme.of(context).colorScheme.primary
                                        : Colors.grey[400],
                                    size: 24,
                                  ),
                                  const VSpace(3),
                                  Text(
                                    item['label'],
                                    style: TextStyles.caption.textColor(index ==
                                            store.currentPage
                                        ? Theme.of(context).colorScheme.primary
                                        : Colors.black45),
                                  ),
                                ],
                              ),
                            )
                          : Container();
                }),
              ),
            ),
          ),
        );
      },
    );
  }
}

List<dynamic> get _navItems => [
      {
        "icon": R.I.home.svgT,
        "selected": R.I.home.svgB,
        "label": "Home",
        "isIcon": true
      },
      {
        "icon": R.I.discover.svgT,
        "selected": R.I.discover.svgB,
        "label": "Explore",
        "isIcon": false,
      },
      {
        "icon": R.I.discover.svgT,
        "selected": R.I.discover.svgB,
        "label": "Explore",
        "isIcon": false,
      },
      {
        "icon": R.I.calendar.svgT,
        "selected": R.I.calendar.svgB,
        "label": "Events",
        "isIcon": true
      },
      {
        "icon": R.I.profile.svgT,
        "selected": R.I.profile.svgB,
        "label": "Profile",
        "isIcon": true
      }
    ];
