import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';
import 'package:front_renewal/controller/home_controller.dart';
import 'package:front_renewal/display/components/vidio_widget.dart';
import 'package:get/get.dart';

class Home extends StatelessWidget {
  Home({super.key});

  final HomeController controller = Get.put(HomeController());

  Widget _lead() {
    // 상단바 좌측에 들어갈 아이콘들을 그냥 Row로 묶어서 반환하는 메서드를 작성했음. 이거를 한번에 leading에 다 때려박으면 코드 너무 난잡해질까봐 이렇게 했음.
    return Row(
      children: [
        const SizedBox(width: 5),
        SvgPicture.asset(
          'assets/icons/fillUpLogo.svg',
          width: 43,
          height: 43,
        ),
        const Text(
          "FillUp",
          style: TextStyle(
            fontFamily: "SF-Pro-Display",
            fontWeight: FontWeight.w700,
            fontSize: 22,
          ),
        )
      ],
    );
  }

  List<Widget> _ends() {
    // 코드 가독성을 위해서 상단바 우측 끝 아이콘들을 그냥 메서드로 리턴했음.
    return [
      // 상단바 우측 아이콘들
      Container(
        width: 35,
        height: 35,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(color: const Color.fromARGB(38, 158, 158, 158)),
        ),
        child: IconButton(
          onPressed: () {},
          icon: SvgPicture.asset(
            'assets/icons/Youtube.svg',
            width: 50,
          ),
        ),
      ),
      const SizedBox(
        //상단바 우측 아이콘 들끼리의 간격
        width: 15,
      ),
      Container(
        //구글 아이콘
        width: 35,
        height: 35,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(color: const Color.fromARGB(38, 158, 158, 158)),
        ),
        child: IconButton(
          onPressed: () {},
          icon: SvgPicture.asset(
            'assets/icons/google_icon.svg',
            width: 50,
          ),
        ),
      ),
      const SizedBox(
        width: 5,
      ),
      IconButton(
        //검색 버튼
        onPressed: () {
          Get.toNamed("/search");
        },
        icon: const Icon(
          Icons.search,
          size: 25,
        ),
      ),
      const SizedBox(
        width: 5,
      )
    ];
  }

  // 여기서 부터 빌드
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      // 동영상 창 구현을 위해서 제일 상위에 쓴 위젯
      child: Obx(
        () => CustomScrollView(
          // 스크롤 뷰 구현을 위해서 쓰는 위젯인 듯?
          slivers: [
            //스크롤뷰 자식요소들을 담는 named parameter 같음.
            SliverAppBar(
              //상단 바
              surfaceTintColor: Colors.white,
              leading: _lead(), //상단바 (좌측) 아이콘
              leadingWidth: 200,
              floating: true,
              snap: true,
              actions: _ends(), //상단바 (우측) 아이콘
            ),
            //--------------------------- 선. 위쪽으로 AppBar, 아랫쪽으로 동영상 List
            SliverList(
              //동영상 썸네일이나 정보 같은 것들, 동영상 위젯들
              delegate: SliverChildBuilderDelegate(
                //delegate 파라미터를 사용해서 동영상들의 공통적인 특징을 정해주는 것 같음.
                (context, index) {
                  return GestureDetector(
                    onTap: () {
                      Get.toNamed(
                          '/detail/${controller.youtubeResult.value.items![index].id.videoId}');
                    },
                    child: VidioWidget(
                        video: controller.youtubeResult.value.items![index]),
                  );
                },
                childCount: controller.youtubeResult.value.items == null
                    ? 0
                    : controller.youtubeResult.value.items!
                        .length, // 화면에 나타낼 최대 동영상 갯수.
              ),
            ),
          ],
        ),
      ),
    );
  }
}
