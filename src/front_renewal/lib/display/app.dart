import 'package:flutter/material.dart';
import 'package:front_renewal/binding/init_binding.dart';
import 'package:front_renewal/controller/app_controller.dart';
import 'package:front_renewal/display/pages/home.dart';
import 'package:front_renewal/display/pages/my.dart';
import 'package:front_renewal/display/pages/search.dart';
import 'package:get/get.dart';

class App extends GetView<AppContlloer> {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        shape: const Border(
          bottom: BorderSide(color: Colors.grey, width: 0.5),
        ),
        title: const Text("Title"),
      ),
      body: Obx(() {
        switch (RouteName.values[controller.currentIndex.value]) {
          case RouteName.home:
            return const Home();
            // ignore: dead_code
            break;
          case RouteName.search:
            return const Search();
            // ignore: dead_code
            break;
          case RouteName.my:
            return const My();
            // ignore: dead_code
            break;
          default:
            return Container();
        }
      }),
      // 하단 메뉴 바 구현
      bottomNavigationBar: Theme(
        //Theme 위젯은 하단 바 내의 요소들의 공통적인 속성을 부여하기 위해서 쓰는 것,
        //특히 하단 바에서 쓰이는 기본애니메이션 없애기 위해서 씀.
        data: ThemeData(splashColor: Colors.transparent),
        child: Obx(
          () => BottomNavigationBar(
            // selectedIconTheme: const IconThemeData(color: Color(0xff004fff)),
            selectedItemColor:
                // 하단 바 내의 요소를 클릭했을 때 나타나는 색을 지정해준 것
                const Color(0xff004fff),
            selectedFontSize: 12, // focused되고 있는 아이템의 글자 크기
            unselectedFontSize: 12, // unfocused 된 아이템의 글자 크기
            type: BottomNavigationBarType.fixed,
            currentIndex: controller.currentIndex.value,
            onTap: controller.changePageIndex,
            items: const [
              BottomNavigationBarItem(
                  icon: Icon(Icons.home_filled),
                  activeIcon: Icon(Icons.home_filled),
                  label: "홈"),
              BottomNavigationBarItem(
                  icon: Icon(Icons.search),
                  activeIcon: Icon(Icons.search),
                  label: "검색"),
              BottomNavigationBarItem(
                  icon: Icon(Icons.person),
                  activeIcon: Icon(Icons.person),
                  label: "나"),
            ],
          ),
        ),
      ),
    );
  }
}
