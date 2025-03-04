import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:timberr/constants.dart';
import 'package:timberr/controllers/home_controller.dart';
import 'package:timberr/screens/cart/cart_screen.dart';
import 'package:timberr/screens/search_delegate/product_search_delegate.dart';
import 'package:timberr/widgets/tabbed/bottom_navbar.dart';
import 'package:timberr/widgets/tabbed/category_tab_bar.dart';
import 'package:timberr/widgets/tiles/product_grid_tile.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  // Ensure controller is properly initialized
  final HomeController _controller = Get.put(HomeController());

  // Function to handle cart button tap
  void _onCartTap() {
    Get.to(() => CartScreen(), transition: Transition.fade);
  }

  @override
  Widget build(BuildContext context) {
    // ignore: deprecated_member_use
    return WillPopScope(
      onWillPop: () async {
        return kOnExitConfirmation(); // Ensure this function exists
      },
      child: Scaffold(
        bottomNavigationBar: const BottomNavBar(selectedPos: 0),
        body: CustomScrollView(
          physics: const BouncingScrollPhysics(),
          slivers: [
            // App Bar with Search & Cart Icons
            SliverAppBar(
              leading: IconButton(
                onPressed: () {
                  showSearch(
                      context: context, delegate: ProductSearchDelegate());
                },
                icon: SvgPicture.asset('assets/icons/search_icon_grey.svg'),
              ),
              title: Column(
                children: [
                  Text(
                    'Make home',
                    style: kGelasio18.copyWith(color: kTinGrey),
                  ),
                  Text(
                    'BEAUTIFUL',
                    style: kGelasio18.copyWith(
                      fontWeight: FontWeight.bold,
                      color: kOffBlack,
                    ),
                  ),
                ],
              ),
              centerTitle: true,
              actions: [
                IconButton(
                  onPressed: _onCartTap,
                  icon: SvgPicture.asset('assets/icons/cart_icon_grey.svg'),
                )
              ],
              bottom: PreferredSize(
                preferredSize: const Size(double.infinity, 65),
                child: CategoryTabBar(),
              ),
              floating: true,
              snap: true,
            ),

            // Product Grid View
            SliverPadding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              sliver: Obx(() {
                if (_controller.productsList.isEmpty) {
                  return const SliverToBoxAdapter(
                    child: Center(
                      child: Text(
                        "No products available",
                        style: TextStyle(fontSize: 16, color: Colors.grey),
                      ),
                    ),
                  );
                }
                return SliverGrid(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 0.55,
                    mainAxisSpacing: 8,
                    crossAxisSpacing: 18,
                  ),
                  delegate: SliverChildBuilderDelegate(
                    (context, index) {
                      return ProductGridTile(
                        product: _controller.productsList[index],
                      );
                    },
                    childCount: _controller.productsList.length,
                  ),
                );
              }),
            ),
          ],
        ),
      ),
    );
  }
}
