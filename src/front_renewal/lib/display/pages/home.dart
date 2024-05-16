import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  Widget _lead() {
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

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: CustomScrollView(
        slivers: [
          SliverAppBar(
            //상단 바
            leading: _lead(), //상단바 좌측 아이콘
            leadingWidth: 200,
            floating: true,
            snap: true,
            actions: [
              // 상단바 우측 아이콘들
              Container(
                width: 35,
                height: 35,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                      color: const Color.fromARGB(38, 158, 158, 158)),
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
                //reddit 아이콘
                width: 35,
                height: 35,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                      color: const Color.fromARGB(38, 158, 158, 158)),
                ),
                child: IconButton(
                  onPressed: () {},
                  icon: SvgPicture.asset(
                    'assets/icons/Reddit.svg',
                    width: 50,
                  ),
                ),
              ),
              const SizedBox(
                width: 5,
              ),
              IconButton(
                //검색 버튼
                onPressed: () {},
                icon: const Icon(
                  Icons.search,
                  size: 25,
                ),
              ),
              const SizedBox(
                width: 5,
              )
            ],
          ),
          SliverList(
            //동영상 썸네일이나 정보 같은 것들, 동영상 위젯들
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                return Padding(
                  //동영상 요소들의 특징과 사이 간격
                  padding: const EdgeInsets.symmetric(vertical: 5),
                  child: Container(
                    height: 300,
                    color: const Color.fromARGB(42, 0, 81, 255),
                  ),
                );
              },
              childCount: 10, // 화면에 나타낼 최대 동영상 갯수.
            ),
          ),
        ],
      ),
    );
  }
}
