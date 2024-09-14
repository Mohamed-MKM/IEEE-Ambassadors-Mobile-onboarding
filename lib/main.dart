import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: MyPage(),
      ),
    );
  }
}

class MyPage extends StatefulWidget {
  @override
  _MyPageState createState() => _MyPageState();
}

class _MyPageState extends State<MyPage> {
  final PageController _pageController = PageController();
  int currentPage = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          PageView(
            controller: _pageController,
            onPageChanged: (index) {
              setState(() {
                currentPage = index; // Update current page index
              });
            },
            children: const [
              onBoardingScreen(
                image: "images/img1.gif",
                title: "Deliver at Your Door Step",
                subtitle: "From Our Door Step to Yours Swift, secure, and contactless Delivery!",
              ),
              onBoardingScreen(
                image: "images/img2.gif",
                title: "Choose Your Product",
                subtitle: "Welcome to a world of limitless Choices, Your Perfect Product awaits",
              ),
              onBoardingScreen(
                image: "images/img3.gif",
                title: "Select Payment Method",
                subtitle: "For Seamless Transactions, Choose Your Payment Path. Your Convenience, Our Priority!",
              ),
            ],
          ),
          const onBoardSkip(),
          onBoardNavigator(controller: _pageController),
          onBoardBtn(controller: _pageController, currentPage: currentPage),
        ],
      ),
    );
  }
}

class onBoardBtn extends StatelessWidget {
  final PageController controller;
  final int currentPage;

  const onBoardBtn({super.key, required this.controller, required this.currentPage});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 25,
      right: 15,
      child: FloatingActionButton(
        onPressed: () {
          if (currentPage < 2) {
            controller.nextPage(
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeInOut,
            );
          }
        },
        shape: const CircleBorder(),
        backgroundColor: Colors.grey,
        child: const Icon(Icons.arrow_forward_ios),
      ),
    );
  }
}

class onBoardNavigator extends StatelessWidget {
  final PageController controller;

  const onBoardNavigator({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 35,
      left: 15,
      child: SmoothPageIndicator(
        controller: controller,
        count: 3,
        effect: const ExpandingDotsEffect(activeDotColor: Colors.red, dotHeight: 6),
      ),
    );
  }
}

class onBoardSkip extends StatelessWidget {
  const onBoardSkip({super.key});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 25,
      right: 15,
      child: TextButton(
        onPressed: () {},
        child: const Text("Skip"),
      ),
    );
  }
}

class onBoardingScreen extends StatelessWidget {
  const onBoardingScreen({
    super.key,
    required this.image,
    required this.title,
    required this.subtitle,
  });

  final String image, title, subtitle;

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    double imageWidth = screenWidth * 0.8;
    double imageHeight = screenHeight * 0.7;

    return Padding(
      padding: const EdgeInsets.all(0.8),
      child: Column(
        children: [
          Image(
            width: imageWidth,
            height: imageHeight,
            image: AssetImage(image),
          ),
          const SizedBox(height: 5),
          Text(
            title,
            style: const TextStyle(fontSize: 20, color: Colors.black, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 20),
          Text(
            subtitle,
            style: const TextStyle(fontSize: 14, color: Colors.grey),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
