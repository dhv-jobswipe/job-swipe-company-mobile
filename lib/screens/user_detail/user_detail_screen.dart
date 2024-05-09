import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_it/get_it.dart';
import 'package:pbl5/constants.dart';
import 'package:pbl5/locator_config.dart';
import 'package:pbl5/screens/base/base_view.dart';
import 'package:pbl5/screens/user_detail/tabs/jobs_tab.dart';
import 'package:pbl5/screens/user_detail/tabs/overview_tab.dart';
import 'package:pbl5/shared_customization/extensions/build_context.ext.dart';
import 'package:pbl5/view_models/detail_view_model.dart';
import 'package:provider/provider.dart';

class UserDetailScreen extends StatefulWidget {
  final String userId;


  UserDetailScreen({super.key, required this.userId});

  @override
  State<UserDetailScreen> createState() => _UserDetailScreenState();
}

class _UserDetailScreenState extends State<UserDetailScreen> {
  late DetailViewModel viewModel;

  @override
  void initState() {
    viewModel = getIt.get<DetailViewModel>();
    GetIt.instance.get<DetailViewModel>().onGetUserByIdPressed(userId: widget.userId,);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    debugPrint('UserDetailScreen: ' + widget.userId.toString());
    return BaseView(
      viewModel: viewModel,
      backgroundColor: orangePink,
      canPop: true,
      appBar: AppBar(
        backgroundColor: orangePink,
        elevation: 0,
        leading: IconButton(
          icon: Icon(
            Icons.chevron_left,
            size: 30,
            color: Colors.white,
          ),
          onPressed: (){
            viewModel.clear();
            context.pop();
          },
        ),
      ),
      mobileBuilder: (context) {
        var user = context.select((DetailViewModel vm) => vm.user);
        return
          user == null ? Container() :
          Column(
          children: [
            Expanded(
              flex: 1,
              child: Container(
                child: Column(
                  children: [
                    Flexible(
                      child: user!.avatar != null
                          ? Image.network(user!.avatar!)
                          : Icon(
                              Icons.location_city,
                              size: 95,
                              color: Colors.white,
                            ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
        (user!.lastName ?? '') + " " + (user!.firstName ?? ''),
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 19.sp,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Poppins',
                          ),
                        ),
                        if (user!.accountStatus != null)
                          user!.accountStatus!
                              ? Container(
                                  margin: EdgeInsets.only(left: 10.w),
                                  padding: EdgeInsets.all(2),
                                  decoration: BoxDecoration(
                                    color: Colors.lightGreenAccent,
                                    borderRadius: BorderRadius.circular(100),
                                  ),
                                  child: Container(
                                    padding: EdgeInsets.all(6),
                                    decoration: BoxDecoration(
                                      color: Colors.green,
                                      borderRadius: BorderRadius.circular(100),
                                    ),
                                  ),
                                )
                              : Container(
                                  margin: EdgeInsets.only(left: 10.w),
                                  padding: EdgeInsets.all(2),
                                  decoration: BoxDecoration(
                                    color: Colors.redAccent,
                                    borderRadius: BorderRadius.circular(100),
                                  ),
                                  child: Container(
                                    padding: EdgeInsets.all(6),
                                    decoration: BoxDecoration(
                                      color: Colors.red,
                                      borderRadius: BorderRadius.circular(100),
                                    ),
                                  ),
                                ),
                      ],
                    ),
                    Text(
                      'Available for new job',
                      style: TextStyle(
                        color: Colors.white54,
                      ),
                    ),
                    SizedBox(
                      height: 50.h,
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              flex: 3,
              child: Container(
                color: Colors.white,
                child: DefaultTabController(
                  length: 2,
                  child: Scaffold(
                    backgroundColor: orangePink,
                    appBar: TabBar(
                      indicatorColor: Colors.white,
                      tabs: [
                        Tab(
                          child: Text(
                            'OVERVIEW',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        Tab(
                          child: Text(
                            'JOBS',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ],
                    ),
                    body: Container(
                        color: Colors.white,
                        child: TabBarView(
                          children: <Widget>[
                            OverviewTab(
                              user: user!,
                            ),
                            JobsTab(),
                          ],
                        )),
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
