import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_admin_scaffold/admin_scaffold.dart';
import 'package:multi_vendor_admin/views/screens/categories_screen.dart';
import 'package:multi_vendor_admin/views/screens/dashboard_screen.dart';
import 'package:multi_vendor_admin/views/screens/order_screen.dart';
import 'package:multi_vendor_admin/views/screens/product_screen.dart';
import 'package:multi_vendor_admin/views/screens/upload_bannerscreen.dart';
import 'package:multi_vendor_admin/views/screens/vendors_screen.dart';
import 'package:multi_vendor_admin/views/screens/withdrawl_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  
  Widget _selecteItem =  DashboardScreen();
screenSelector(item){
  switch(item.route){
    case DashboardScreen.routeName:
    setState(() {
      _selecteItem = DashboardScreen();
    });
    break;
     case VendorsScreen.routeName:
    setState(() {
      _selecteItem =VendorsScreen();
    });
    break;
     case WithdrawlScreen.routeName:
    setState(() {
      _selecteItem =WithdrawlScreen();
    });
    break;
     case OrderScreen.routeName:
    setState(() {
      _selecteItem =OrderScreen();
    });
    break;
     case CategoriesScreen.routeName:
    setState(() {
      _selecteItem =CategoriesScreen();
    });
    break;
     case ProductScreen.routeName:
    setState(() {
      _selecteItem =ProductScreen();
    });
    break;
     case UploadBannerscreen.routeName:
    setState(() {
      _selecteItem =UploadBannerscreen();
    });
    break;
  }
}

  @override
  Widget build(BuildContext context) {
    return AdminScaffold(
      backgroundColor:Colors.yellow.shade900,
     
      sideBar: SideBar(items: [
        AdminMenuItem(
          title: 'Dashboard',
          icon:Icons.dashboard, 
          route:DashboardScreen.routeName),
                AdminMenuItem(
                  title: 'Vendors',
                  icon:CupertinoIcons.person_3,
                   route:VendorsScreen.routeName)
                ,        AdminMenuItem(
                  title: 'Withdrawl',
                  icon:CupertinoIcons.money_dollar,
                   route: WithdrawlScreen.routeName),
                        AdminMenuItem(
                          title: 'Orders',
                          icon:CupertinoIcons.shopping_cart, 
                          route: OrderScreen.routeName),
                           AdminMenuItem(
                          title: 'Categories',
                          icon:CupertinoIcons.shopping_cart, 
                          route: CategoriesScreen.routeName),
                          AdminMenuItem(
                          title: 'Products',
                          icon:Icons.shop, 
                          route: ProductScreen.routeName),
                          AdminMenuItem(
                          title: 'Upload Banners',
                          icon:CupertinoIcons.add, 
                          route: UploadBannerscreen.routeName)
      ], selectedRoute:'', onSelected: (item){
        screenSelector(item);
      },
      header: Container(
          height: 50,
          width: double.infinity,
          color: const Color(0xff444444),
          child: const Center(
            child: Text(
              'Winkler  Store Panel',
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          ),
        ),
        footer: Container(
          height: 50,
          width: double.infinity,
          color: const Color(0xff444444),
          child: const Center(
            child: Text(
              'footer',
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          ),
        ),

      ),
      body:_selecteItem,
    );

  }
}