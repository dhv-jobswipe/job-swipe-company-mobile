import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get_it/get_it.dart';
import 'package:pbl5/generated/assets.gen.dart';
import 'package:pbl5/locator_config.dart';
import 'package:pbl5/models/company/company.dart';
import 'package:pbl5/screens/base/base_view.dart';
import 'package:pbl5/screens/search/widget/search_item.dart';
import 'package:pbl5/services/api_models/api_page_response/api_page_response.dart';
import 'package:pbl5/shared_customization/extensions/build_context.ext.dart';
import 'package:pbl5/shared_customization/widgets/custom_widgets/custom_list.dart';
import 'package:pbl5/shared_customization/widgets/texts/custom_text.dart';
import 'package:pbl5/view_models/search_view_model.dart';
import 'package:provider/provider.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  late SearchViewModel viewModel;

  @override
  void initState() {
    viewModel = getIt.get<SearchViewModel>();
    // GetIt.instance.get<SearchViewModel>().searchCompanies();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BaseView(
        canPop: false,
        viewModel: viewModel,
        appBar: AppBar(
          title: const Text(
            'JobSwipe',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontFamily: 'Poppins',
              color: Colors.pink,
            ),
          ),
          leading: const SizedBox.shrink(),
          leadingWidth: 0,
          elevation: 0,
        ),
        mobileBuilder: (context) {
          return Column(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: context.screenSize.width * 0.05,
                  vertical: context.screenSize.height * 0.02,
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: CupertinoTextField(
                        controller: viewModel.searchController,
                        autocorrect: false,
                        placeholder: 'Search Companies',
                        onSubmitted: (value) async {
                          if (viewModel.searchController.text.isNotEmpty) {
                            await viewModel.searchCompanies(
                                query: viewModel.searchController.text);
                          }
                        },
                        onTapOutside: (pointerOutSidedEvent) async {
                          if (viewModel.searchController.text.isEmpty) {
                            await viewModel.searchCompanies();
                          }
                        },
                        suffixMode: OverlayVisibilityMode.always,
                        suffix: IconButton(
                          icon: Icon(
                            Icons.search_rounded,
                            color: Colors.pink,
                          ),
                          onPressed: () async {
                            if (viewModel.searchController.text.isNotEmpty) {
                              await viewModel.searchCompanies(
                                  query: viewModel.searchController.text);
                            } else {
                              await viewModel.searchCompanies();
                            }
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: CustomList(
                  padding: EdgeInsets.symmetric(
                    horizontal: 10.w,
                  ),
                  sourceData:
                      context.select((SearchViewModel vm) => vm.searchData),
                  onItemRender: (item) => SearchItem(
                    searchText: viewModel.searchController.text,
                    item: item,
                  ),
                  onReload: () async {
                    await viewModel.searchCompanies();
                  },
                  onLoadMore: (page) => viewModel.searchCompanies(page: page),
                  emptyListIcon: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(Icons.search_off,
                          size: 100.sp, color: Colors.black45),
                      const SizedBox(height: 16),
                      Text(
                        "No Companies",
                        style: TextStyle(
                          fontSize: 20.sp,
                          fontWeight: FontWeight.w600,
                          color: Colors.black45,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          );
        });
  }
}
