import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:nan_aptipro_sampling_2023/core/common/constants.dart';
import 'package:nan_aptipro_sampling_2023/features/home/blocs/dashboard_cubit.dart';
import 'package:nan_aptipro_sampling_2023/features/login/blocs/authentication_bloc.dart';
import 'package:very_good_infinite_list/very_good_infinite_list.dart';

import '../../../core/entity/filter.dart';
import '../../../core/entity/outlet.dart';
import '../../../core/platform/package_info.dart';
import '../../../core/utils/my_dialog.dart';
import '../../../core/widgets/custom_loading.dart';

class DashboardPage extends StatefulWidget {
  @override
  State createState() {
    return _State();
  }
}

class _State extends State<DashboardPage> with SingleTickerProviderStateMixin {
  final user = AuthenticationBloc.loginEntity!;
  final _cubit = Modular.get<DashboardCubit>();
  final _filter = Filter(skip: 0, take: 20, outletCode: '');
  final TextEditingController _controller = TextEditingController();

  final _outlets = <OutletEntity>[];

  bool _canLoadMore = true;
  bool _loadingMore = false;

  final _focus = FocusNode();

  @override
  void initState() {
    super.initState();
    _cubit.getOutlets(filter: _filter);
  }

  @override
  void dispose() {
    super.dispose();
  }

  void _fetchData() async {
    if (_canLoadMore && !_loadingMore) {
      setState(() {
        _loadingMore = true;
      });
      _cubit.getOutlets(filter: _filter, loadMore: true);
      if (!mounted) {
        return;
      }
    }
  }

  void _reload() {
    setState(() {
      _outlets.clear();
      _filter.skip = 0;
      _canLoadMore = true;
      _loadingMore = false;
    });
    _cubit.getOutlets(filter: _filter);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xffF4F3FD),
        title: Padding(
          padding: const EdgeInsets.only(left: 6),
          child: Text(
            user.userName,
            style: kStyleBlack16Medium,
          ),
        ),
        actions: [
          InkWell(
            onTap: () {
              Modular.to.pushNamedAndRemoveUntil('/setting', (p0) => false);
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Icon(
                Icons.settings,
                size: 34,
                color: Colors.grey.shade700,
              ),
            ),
          )
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Danh sách outlet',
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontWeight: FontWeight.w900,
                  fontSize: 24,
                  color: Colors.black,
                ),
              ),
              searchBar(),
              Expanded(
                child: BlocConsumer<DashboardCubit, DashboardState>(
                  bloc: _cubit,
                  listener: (context, state) {
                    if (state is DashboardFailure) {
                      displayError(state.failure);
                    }
                    if (state is DashboardSuccess) {
                      setState(() {
                        _outlets.addAll(state.outlets);
                        _filter.skip += state.outlets.length;
                        if (!state.isLoadMoreFailure &&
                            state.outlets.length < _filter.take) {
                          _canLoadMore = false;
                        }
                        _loadingMore = false;
                      });
                    }
                  },
                  builder: (context, state) {
                    if (state is DashboardSuccess) {
                      if (_outlets.isEmpty) {
                        return Center(
                          child: Text(
                            'Không tìm thấy outlet',
                            style: kStyleGrey16Regular,
                          ),
                        );
                      }
                      return InfiniteList(
                        itemCount: _outlets.length,
                        isLoading: _loadingMore,
                        onFetchData: _fetchData,
                        debounceDuration: const Duration(milliseconds: 300),
                        physics: BouncingScrollPhysics(),
                        loadingBuilder: (context) => Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          child: CupertinoActivityIndicator(radius: 15),
                        ),
                        itemBuilder: (context, index) {
                          final e = _outlets[index];
                          return Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8),
                            child: InkWell(
                              borderRadius: BorderRadius.circular(12.0),
                              onTap: () {
                                if (Modular.to.path.contains('edit')) {
                                  Modular.to.pushNamedAndRemoveUntil(
                                      '/edit/${e.id}/form',
                                      arguments: e,
                                      (p0) => false);
                                  return;
                                }
                                Modular.to.pushNamedAndRemoveUntil(
                                    '/${e.id}/form', arguments: e, (p0) => false);
                              },
                              child: Material(
                                elevation: 5,
                                borderRadius: BorderRadius.circular(12.0),
                                child: Container(
                                  padding: const EdgeInsets.all(4.0),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(12.0),
                                      color: Colors.white),
                                  child: Row(
                                    children: [
                                      SizedBox(
                                          width: 100,
                                          child: Image.asset(
                                            'assets/images/outlet.png',
                                            height: 80,
                                          )),
                                      Expanded(
                                        flex: 3,
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Text(
                                              e.name,
                                              style: kStyleBlack16Bold,
                                            ),
                                            const SizedBox(
                                              height: 5,
                                            ),
                                            Text(
                                              'Mã outlet: ${e.code}',
                                              style: kStyleBlack14Regular,
                                            ),
                                            const SizedBox(
                                              height: 5,
                                            ),
                                            Text(
                                              'Địa chỉ: ${e.address}',
                                              style: kStyleBlack14Regular,
                                            ),
                                            const SizedBox(
                                              height: 5,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      );
                    }
                    if (state is DashboardFailure) {
                      return Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Không có dữ liệu',
                            style: kStyleGrey16Regular,
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          ElevatedButton(
                              onPressed: () {
                                _cubit.getOutlets(filter: _filter);
                              },
                              child: Text('Tải lại'))
                        ],
                      );
                    }
                    return Center(
                        child: Image.asset(
                      'assets/images/blue_loading.gif',
                      height: 110,
                      width: 110,
                    ));
                  },
                ),
              ),
              Center(
                  child: Text(
                'Phiên bản ${MyPackageInfo.version}',
                style: kStyleGrey14Regular,
              )),
            ],
          ),
        ),
      ),
    );
  }

  Widget searchBar() {
    return SizedBox(
      height: 60,
      child: Row(
        children: [
          Expanded(
            child: TextFormField(
              textInputAction: TextInputAction.search,
              autofocus: false,
              focusNode: _focus,
              onFieldSubmitted: (v) {
                FocusScope.of(context).requestFocus();
              },
              controller: _controller,
              onChanged: (value) {
                setState(() {
                  _filter.outletCode = _controller.text;
                });
              },
              decoration: InputDecoration(
                hintText: 'Nhập mã outlet',
                contentPadding: EdgeInsets.all(16),
                prefixIcon: Icon(Icons.search),
                filled: true,
                fillColor: Color(0xffF3F3F3),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Color(0xffF3F3F3), width: 1),
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(12),
                      bottomLeft: Radius.circular(12)),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(12),
                      bottomLeft: Radius.circular(12)),
                  borderSide: BorderSide(color: Color(0xffF3F3F3), width: 1),
                ),
                border: OutlineInputBorder(
                  borderSide: BorderSide(color: Color(0xffF3F3F3), width: 1),
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(12),
                      bottomLeft: Radius.circular(12)),
                  gapPadding: double.infinity,
                ),
              ),
            ),
          ),
          InkWell(
            onTap: () {
              _reload();
            },
            child: Container(
                width: 58,
                height: 48,
                decoration: BoxDecoration(
                  color: Color(0xffFF7A7A),
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(12),
                      bottomRight: Radius.circular(12)),
                ),
                child: Center(
                    child: Text(
                  'Tìm',
                  style: kStyleWhite16Regular,
                ))),
          ),
        ],
      ),
    );
  }
}
