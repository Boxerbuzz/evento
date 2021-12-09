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
                  return _navItems[index]['isIcon'] == true
                      ? InkWell(
                          onTap: () => store.currentPage = index,
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SvgIcon(
                                store.currentPage == index
                                    ? _navItems[index]['selected']
                                    : _navItems[index]['icon'],
                                color: index == store.currentPage
                                    ? Theme.of(context).colorScheme.primary
                                    : Colors.grey[400],
                                size: 24,
                              ),
                              const VSpace(3),
                              Text(
                                _navItems[index]['label'],
                                style: TextStyles.caption.textColor(
                                    index == store.currentPage
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
          elevation: 1,
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
        "isIcon": true,
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
