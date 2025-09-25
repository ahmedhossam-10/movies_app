import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:movies_app/core/resources/ColorManager.dart';
import 'package:movies_app/ui/login/screen/login_screen.dart';
import '../edit_Profile_screen/edit_profile_screen.dart';

class ProfileTab extends StatefulWidget {
  static const String routeName = "/profile";

  const ProfileTab({super.key});

  @override
  State<ProfileTab> createState() => _ProfileTabState();
}

class _ProfileTabState extends State<ProfileTab>
    with SingleTickerProviderStateMixin {
  late final TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;

    final historyImages = [
      'assets/images/aveng.png',
      'assets/images/doctorWho.png',
      'assets/images/blackP.png',
      'assets/images/joker.png',
      'assets/images/aven2.png',
      'assets/images/ironman.png',
      'assets/images/wensday.png',
      'assets/images/godzila.png',
      'assets/images/doctorS.png',
      'assets/images/fast.png',
      'assets/images/captain america.jpg',
      'assets/images/aven2.png',
    ];

    return Scaffold(
      backgroundColor: ColorManager.darkGray,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 20),

              /// Avatar + Username + Stats
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    /// Avatar + Name
                    Column(
                      children: [
                        CircleAvatar(
                          radius: 40,
                          backgroundImage:
                          (user?.photoURL?.isNotEmpty ?? false)
                              ? NetworkImage(user!.photoURL!)
                              : const AssetImage(
                              'assets/images/avatar 3.png')
                          as ImageProvider,
                        ),
                        const SizedBox(height: 8),
                        Text(
                          user?.displayName ?? "John Safwat",
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(width: 40),

                    /// Stats
                    Row(
                      children: const [
                        /// Wish List
                        Column(
                          children: [
                            Text(
                              "12",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 5),
                            Text(
                              "Wish List",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(width: 20),

                        /// History
                        Column(
                          children: [
                            Text(
                              "10",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 5),
                            Text(
                              "History",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 15),

              /// Buttons (Edit Profile + Exit)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  children: [
                    /// Edit Profile Button
                    Expanded(
                      flex: 2,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: ColorManager.yellow,
                          foregroundColor: ColorManager.darkGray,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          padding: const EdgeInsets.symmetric(vertical: 15),
                        ),
                        onPressed: () => Navigator.pushNamed(
                          context,
                          EditProfileScreen.routeName,
                        ),
                        child: const Text(
                          "Edit Profile",
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),

                    /// Exit Button
                    Expanded(
                      flex: 1,
                      child: ElevatedButton.icon(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.red,
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          padding: const EdgeInsets.symmetric(vertical: 12),
                        ),
                        onPressed: () async {
                          await FirebaseAuth.instance.signOut();
                          Navigator.pushReplacementNamed(
                            context,
                            LogInScreen.routeName,
                          );
                        },
                        icon: const Icon(Icons.logout, size: 18),
                        label: const Text(
                          "Exit",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 10),

              /// Tabs
              TabBar(
                controller: _tabController,
                labelColor: Colors.yellow,
                unselectedLabelColor: Colors.white,
                indicatorColor: Colors.yellow,
                tabs: [
                  Tab(
                    icon: SvgPicture.asset(
                      'assets/svg/watch list.svg',
                      width: 20,
                      height: 20,
                      color: ColorManager.yellow,
                    ),
                    text: "Watch List",
                  ),
                  Tab(
                    icon: SvgPicture.asset(
                      'assets/svg/files.svg',
                      width: 20,
                      height: 20,
                      color: ColorManager.yellow,
                    ),
                    text: "History",
                  ),
                ],
              ),

              /// Tab Views
              SizedBox(
                height: 580,
                child: TabBarView(
                  controller: _tabController,
                  physics: const NeverScrollableScrollPhysics(),
                  children: [
                    /// Watch List Tab
                    Container(
                      color: ColorManager.primaryColor,
                      child: Center(
                        child: Image.asset('assets/images/pop corn.png'),
                      ),
                    ),

                    /// History Tab
                    GridView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      padding: const EdgeInsets.all(5),
                      gridDelegate:
                      const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        crossAxisSpacing: 5,
                        mainAxisSpacing: 5,
                        childAspectRatio: 0.7,
                      ),
                      itemCount: historyImages.length,
                      itemBuilder: (context, index) {
                        final image = historyImages[index % historyImages.length];
                        return ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Container(
                            color: ColorManager.gray,
                            child: Image.asset(
                              image,
                              fit: BoxFit.cover,
                            ),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
