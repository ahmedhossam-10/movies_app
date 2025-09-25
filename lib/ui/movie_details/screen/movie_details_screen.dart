import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:movies_app/core/resources/ColorManager.dart';
import 'package:movies_app/ui/movie_details/widgets/cast_widget.dart';
import 'package:movies_app/ui/movie_details/widgets/genres_widget.dart';
import 'package:movies_app/ui/movie_details/widgets/rating_widget.dart';
import 'package:movies_app/ui/movie_details/widgets/screen_shot_widget.dart';

class MovieDetailsScreen extends StatelessWidget {
  static const String routeName = "movie details";
  const MovieDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: Colors.black,
      appBar: AppBar(
        actionsPadding: EdgeInsets.symmetric(horizontal: 15),
        backgroundColor: Colors.transparent,
        leading: Icon(Icons.arrow_back_ios, color: Colors.white, size: 35),
        actions: [SvgPicture.asset("assets/svg/save.svg")],
      ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                children: [
                  Image.asset(
                    "assets/images/doctorS.jpg",
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                  Container(
                    width: double.infinity,
                    height: 500,
                    color: ColorManager.primaryColor.withOpacity(0.5),
                  ),
                  Positioned(
                    bottom: 240,
                    left: 0,
                    right: 0,
                    child: GestureDetector(
                      onTap: () {
                        print("Play icon tapped!");
                      },
                      child: SvgPicture.asset(
                        "assets/svg/buttonY.svg",
                        width: 60,
                        height: 60,
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 20,
                    left: 0,
                    right: 0,
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: [
                              Text(
                                "Doctor Strange in the Multiverse of Madness",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 24,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 15),
                        Text(
                          "2022",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: ColorManager.darkGreyColor,
                            fontSize: 20,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),


              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 16),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          padding: EdgeInsets.symmetric(vertical: 15),
                          backgroundColor: ColorManager.red,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                        ),
                        onPressed: () {},
                        child: Text(
                          "Watch".tr(),
                          style: TextStyle(
                            color: ColorManager.white,
                            fontSize: 20,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        RatingWidget(text: "15", picture: "assets/svg/love_icon.svg"),
                        SizedBox(width: 6,),
                        RatingWidget(text: "90", picture: "assets/svg/time_icon.svg"),
                        SizedBox(width: 6,),
                        RatingWidget(text: "7.6", picture: "assets/svg/star_icon.svg"),
                      ],
                    ),
                    SizedBox(height: 16),
                    Text(
                      "Screen Shots",
                      style: TextStyle(
                        color: ColorManager.white,
                        fontSize: 24,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    SizedBox(height: 10),
                    ListView.separated(
                      padding: EdgeInsets.zero,
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) =>
                          ScreenShotWidget(pic: "assets/images/screenshot1.png"),
                      separatorBuilder: (context, index) => SizedBox(height: 10),
                      itemCount: 3,
                    ),
                    SizedBox(height: 16),
                    Text(
                      "Similar",
                      style: TextStyle(
                        color: ColorManager.white,
                        fontSize: 24,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    SizedBox(height: 10),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Column(
                            children: [
                              Image.asset("assets/images/c.png"),
                              SizedBox(height: 10),
                              Image.asset("assets/images/blackP.png"),
                            ],
                          ),
                        ),
                        SizedBox(width: 10),
                        Expanded(
                          child: Column(
                            children: [
                              Image.asset("assets/images/end_game.png"),
                              SizedBox(height: 10),
                              Image.asset("assets/images/war.png"),
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 10),
                    Text(
                      "Summary",
                      style: TextStyle(
                        color: ColorManager.white,
                        fontSize: 24,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      "Following the events of Spider-Man No Way Home, Doctor Strange unwittingly casts a forbidden spell that accidentally opens up the multiverse. With help from Wong and Scarlet Witch, Strange confronts various versions of himself as well as teaming up with the young America Chavez while traveling through various realities and working to restore reality as he knows it. Along the way, Strange and his allies realize they must take on a powerful new adversary who seeks to take over the multiverse...",
                      style: TextStyle(
                        color: ColorManager.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    SizedBox(height: 16),
                    Text(
                      "Cast",
                      style: TextStyle(
                        color: ColorManager.white,
                        fontSize: 24,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    ListView.separated(
                      padding: EdgeInsets.zero,
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) => CastWidget(
                        pic: "assets/images/cast.png",
                        name: "Mahmoud hany",
                        character: "Bat man ",
                      ),
                      separatorBuilder: (context, index) => SizedBox(height: 10),
                      itemCount: 4,
                    ),
                    SizedBox(height: 16),
                    Text(
                      "Genres",
                      style: TextStyle(
                        color: ColorManager.white,
                        fontSize: 24,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    SizedBox(height: 5),
                    GridView.builder(
                      itemCount: 5,
                      padding: EdgeInsets.zero,
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                          childAspectRatio: 3,
                          mainAxisSpacing: 15,
                          crossAxisSpacing: 15),
                      itemBuilder: (context, index) => GenresWidget(text: "action"),
                    ),
                    SizedBox(height: 40),
                  ],
                ),
              ),
            ],
          ),
        ),

    );
  }
}
