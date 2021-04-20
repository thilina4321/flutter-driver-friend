import 'package:driver_friend/provider/driver_provider.dart';
import 'package:driver_friend/provider/faq_provider.dart';
import 'package:driver_friend/provider/mechanic_provider.dart';
import 'package:driver_friend/provider/service_provider.dart';
import 'package:driver_friend/provider/spare_provider.dart';
import 'package:driver_friend/provider/user_provider.dart';
import 'package:driver_friend/screen/driver/appointments.dart';
import 'package:driver_friend/screen/faq/FAQ.dart';
import 'package:driver_friend/screen/faq/add_question.dart';
import 'package:driver_friend/screen/faq/answer_screen.dart';
import 'package:driver_friend/screen/faq/default_quiz_screen.dart';
import 'package:driver_friend/screen/driver/driver_form_screen.dart';
import 'package:driver_friend/screen/driver/driver_profile_screes.dart';
import 'package:driver_friend/screen/driver/driver_setting_screen.dart';
import 'package:driver_friend/screen/auth/logIn_screen.dart';
import 'package:driver_friend/screen/faq/not_answer_quiz.dart';
import 'package:driver_friend/screen/map/map_screen.dart';
import 'package:driver_friend/screen/mechanic/Mechanic.dart';
import 'package:driver_friend/screen/mechanic/mechanic_contact_screen.dart';
import 'package:driver_friend/screen/mechanic/mechanic_setting.dart';
import 'package:driver_friend/screen/mechanic/mechanics_list.dart';
import 'package:driver_friend/screen/mechanic/mechnic_form_screen.dart';
import 'package:driver_friend/screen/serviceCenter/add-services.dart';
import 'package:driver_friend/screen/serviceCenter/service_center_form.dart';
import 'package:driver_friend/screen/serviceCenter/service_center_list.dart';
import 'package:driver_friend/screen/serviceCenter/service_center_profile.dart';
import 'package:driver_friend/screen/serviceCenter/service_center_services.dart';
import 'package:driver_friend/screen/serviceCenter/service_contact.dart';
import 'package:driver_friend/screen/serviceCenter/service_settings.dart';
import 'package:driver_friend/screen/auth/signup_screen.dart';
import 'package:driver_friend/screen/sparePartShop/Spare_part_shop_profile_screen.dart';
import 'package:driver_friend/screen/sparePartShop/add-part.dart';
import 'package:driver_friend/screen/sparePartShop/spare_contact.dart';
import 'package:driver_friend/screen/sparePartShop/spare_part_shop_list.dart';
import 'package:driver_friend/screen/sparePartShop/spare_part_shop_form_screen.dart';
import 'package:driver_friend/screen/sparePartShop/spare_setting.dart';
import 'package:driver_friend/screen/sparePartShop/spare_shop_items.dart';
import 'package:driver_friend/widget/polyline.dart';
import 'package:driver_friend/widget/rating.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (ctx) => UserProvider()),
        ChangeNotifierProvider(
          create: (ctx) => DriverProvider(),
        ),
        ChangeNotifierProvider(create: (ctx) => MechanicProvider()),
        ChangeNotifierProvider(create: (ctx) => ServiceCenterProvider()),
        ChangeNotifierProvider(create: (ctx) => SpareShopProvider()),
        ChangeNotifierProvider(create: (ctx) => FaqProvider()),
      ],
      child: Consumer<UserProvider>(
        builder: (context, user, child) => MaterialApp(
          theme: ThemeData(
            primarySwatch: Colors.purple,
            accentColor: Color(0xff2e1503),
            accentColorBrightness: Brightness.dark,
            textTheme: ThemeData.light().textTheme.copyWith(
                  headline1: TextStyle(
                    color: Colors.black,
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                  ),
                  headline2: TextStyle(
                    fontSize: 18,
                    color: Colors.grey,
                    fontWeight: FontWeight.bold,
                  ),
                  button: TextStyle(
                    color: Colors.white,
                  ),
                ),
          ),
          home: user.token != null
              ? user.role == 'driver'
                  ? DriverProfileScreen()
                  : user.role == 'mechanic'
                      ? MechanicProfileScreen()
                      : user.role == 'sparePartShop'
                          ? SparePartShopProfileScreen()
                          : ServiceCenterProfileScreen()
              : FutureBuilder(
                  future: Provider.of<UserProvider>(context, listen: false)
                      .tryAutoLogin(),
                  builder: (context, data) =>
                      data.connectionState == ConnectionState.waiting
                          ? Center(child: CircularProgressIndicator())
                          : LogInScreen()),
          routes: {
            SignUpScreen.routeName: (ctx) => SignUpScreen(),

            // faq
            FAQ.routeName: (ctx) => FAQ(),
            AddNewQuestionPageScreen.routeName: (ctx) =>
                AddNewQuestionPageScreen(),
            AnswerScreen.routeName: (ctx) => AnswerScreen(),
            NotAnswerdYetQuizScreen.routeName: (ctx) =>
                NotAnswerdYetQuizScreen(),

            //driver section
            DriverProfileScreen.routeName: (ctx) => DriverProfileScreen(),
            DriverSettignScreen.routeName: (ctx) => DriverSettignScreen(),
            DriverFormScreen.routeName: (ctx) => DriverFormScreen(),
            AppointmentScreen.routeName: (ctx) => AppointmentScreen(),

            //mechanic section
            MechanicListScreen.routeName: (ctx) => MechanicListScreen(),
            MechanicProfileScreen.routeName: (ctx) => MechanicProfileScreen(),
            MechanicFormScreen.routeName: (ctx) => MechanicFormScreen(),
            MechanicSettignScreen.routeName: (ctx) => MechanicSettignScreen(),
            MechanicContactScreen.routeName: (ctx) => MechanicContactScreen(),

            //service center section
            ServiceCenterProfileScreen.routeName: (ctx) =>
                ServiceCenterProfileScreen(),
            ServiceCenterFormScreen.routeName: (ctx) =>
                ServiceCenterFormScreen(),
            ServiceCenterList.routeName: (ctx) => ServiceCenterList(),
            ServiceCenterSettignScreen.routeName: (ctx) =>
                ServiceCenterSettignScreen(),
            ServiceCenterContactScreen.routeName: (ctx) =>
                ServiceCenterContactScreen(),
            ServiceCenterServices.routeName: (ctx) => ServiceCenterServices(),
            CreateNewServiceScreen.routeName: (ctx) => CreateNewServiceScreen(),

            //spare part section
            SparepartShopListScreen.routeName: (ctx) =>
                SparepartShopListScreen(),
            SparePartShopProfileScreen.routeName: (ctx) =>
                SparePartShopProfileScreen(),
            SparePartShopFormScreen.routeName: (ctx) =>
                SparePartShopFormScreen(),
            SparePartShopSettignScreen.routeName: (ctx) =>
                SparePartShopSettignScreen(),
            SpareShopContactScreen.routeName: (ctx) => SpareShopContactScreen(),
            SpareShopItems.routeName: (ctx) => SpareShopItems(),
            CreateNewPartScreen.routeName: (ctx) => CreateNewPartScreen(),

            DefaultQuestionScreen.routeName: (ctx) => DefaultQuestionScreen(),

            //ratings
            CustomRatingWidget.routeName: (ctx) => CustomRatingWidget(),

            //map
            MapScreen.routeName: (ctx) => MapScreen(),
            PolyLineScreen.routeName: (ctx) => PolyLineScreen(),
          },
        ),
      ),
    );
  }
}
