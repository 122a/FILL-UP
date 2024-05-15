import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';
import 'package:front_renewal/display/components/customAppBar.dart';

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
            leading: _lead(),
            leadingWidth: 200,
            floating: true,
            snap: true,
            actions: [
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
                width: 15,
              ),
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
                    'assets/icons/Reddit.svg',
                    width: 50,
                  ),
                ),
              ),
              const SizedBox(
                width: 5,
              ),
              IconButton(
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
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 5),
                  child: Container(
                    height: 300,
                    color: const Color.fromARGB(42, 0, 81, 255),
                  ),
                );
              },
              childCount: 10,
            ),
          ),
        ],
      ),
    );
  }
}
