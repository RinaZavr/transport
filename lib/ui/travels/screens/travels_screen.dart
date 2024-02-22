import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:transport/data/model/travel_model.dart';
import 'package:transport/ui/templates/button_template.dart';
import 'package:transport/ui/templates/input_template.dart';
import 'package:transport/ui/travels/bloc/travels_bloc.dart';

class TravelsScreen extends StatefulWidget {
  const TravelsScreen({super.key});

  @override
  State<TravelsScreen> createState() => _TravelsScreenState();
}

class _TravelsScreenState extends State<TravelsScreen> {
  late TravelsBloc bloc;
  final RefreshController _refreshController =
      RefreshController(initialRefresh: false);
  List<Travel> travels = [];
  String departureCity = '';
  String destinationCity = '';
  DateTime date = DateTime.now();

  @override
  void initState() {
    bloc = TravelsBloc();
    bloc.add(GetTravelsEvent(
        departureCity: departureCity,
        destinationCity: destinationCity,
        date: date));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      extendBody: true,
      appBar: AppBar(
        title: const Text('Поиск поездок'),
        centerTitle: true,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(
            Icons.arrow_back_ios_new_rounded,
          ),
        ),
      ),
      body: SmartRefresher(
        enablePullDown: true,
        controller: _refreshController,
        onRefresh: _onRefresh,
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: Row(
                children: [
                  Image.asset('assets/way.png', width: 40,),
                  Expanded(
                    child: Column(
                      children: [
                        InputTemplate(
                          city: departureCity,
                          setCity: (value) {
                            setState(() {
                              departureCity = value;
                            });
                          },
                          title: 'Откуда',
                        ),
                        InputTemplate(
                          city: destinationCity,
                          setCity: (value) {
                            setState(() {
                              destinationCity = value;
                            });
                          },
                          title: 'Куда',
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SliverToBoxAdapter(
              child: GestureDetector(
                onTap: () async {
                  date = await _selectDate(context, date) ?? DateTime.now();
                },
                child: Container(
                  margin: const EdgeInsets.all(8),
                  padding:
                      const EdgeInsets.symmetric(vertical: 23, horizontal: 10),
                  decoration: BoxDecoration(
                      border: Border.all(
                        color: Theme.of(context).focusColor,
                      ),
                      borderRadius: BorderRadius.circular(20)),
                  child: Text(
                    DateFormat('yyyy-MM-dd').format(date),
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: ButtonTemplate(
                  onTap: () {
                    bloc.add(GetTravelsEvent(
                        departureCity: departureCity,
                        destinationCity: destinationCity,
                        date: date));
                  },
                  title: 'Найти'),
            ),
            BlocProvider(
              create: (context) => bloc,
              child: BlocBuilder<TravelsBloc, TravelsState>(
                builder: (context, state) {
                  if (state is TravelsInitial) {
                    return const SliverToBoxAdapter(
                      child: Center(
                        child: CircularProgressIndicator(),
                      ),
                    );
                  }
                  if (state is TravelsError) {
                    return SliverToBoxAdapter(
                      child: Center(
                        child: Text(
                          state.message,
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                      ),
                    );
                  }
                  if (state is TravelsLoaded) {
                    travels = state.travels;
                    return SliverList(
                      delegate: SliverChildBuilderDelegate(
                        (context, index) {
                          return Column(
                            children: [
                              ListTile(
                                title: Text(travels[index].carrier, style: Theme.of(context).textTheme.headlineLarge,),
                                subtitle: Text(travels[index].bus, style: Theme.of(context).textTheme.headlineSmall,),
                                leading: CircleAvatar(
                                  backgroundColor: Theme.of(context).primaryColor,
                                ),
                                trailing: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Icon(Icons.circle, color: Theme.of(context).hintColor, size: 7,),
                                    const SizedBox(width: 10,),
                                    Text('${travels[index].cost} ₽', style: Theme.of(context).textTheme.headlineMedium,),
                                  ],
                                ),
                              ),
                              ListTile(
                                title: Text(travels[index].departureCity, style: Theme.of(context).textTheme.headlineLarge,),
                                subtitle: Text(formatTime(travels[index].departureTime), style: Theme.of(context).textTheme.headlineSmall,),
                                leading: const CircleAvatar(
                                  radius: 15,
                                  backgroundColor: Colors.transparent,
                                  backgroundImage: AssetImage('assets/dot.png'),
                                ),
                                trailing: SizedBox(
                                  width: size.width/3,
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Icon(Icons.circle, color: Theme.of(context).hintColor, size: 7,),
                                      const SizedBox(width: 10,),
                                      Expanded(child: Text(travels[index].departureAddress, style: Theme.of(context).textTheme.headlineMedium,)),
                                    ],
                                  ),
                                ),
                              ),
                              ListTile(
                                title: Text(travels[index].destinationCity, style: Theme.of(context).textTheme.headlineLarge,),
                                subtitle: Text(formatTime(travels[index].arrivalTime), style: Theme.of(context).textTheme.headlineSmall,),
                                leading: const CircleAvatar(
                                  radius: 15,
                                  backgroundColor: Colors.transparent,
                                  backgroundImage: AssetImage('assets/dot.png'),
                                ),
                                trailing: SizedBox(
                                  width: size.width/3,
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Icon(Icons.circle, color: Theme.of(context).hintColor, size: 7,),
                                      const SizedBox(width: 10,),
                                      Expanded(child: Text(travels[index].destinationAddress, style: Theme.of(context).textTheme.headlineMedium,)),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          );
                        },
                        childCount: travels.length,
                      ),
                    );
                  }
                  return Container();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  String formatTime(DateTime time){
    String month = '';
    if(time.month == 1) {
      month = 'января';
    } else if(time.month == 2) {
      month = 'февраля';
    } else if(time.month == 3) {
      month = 'марта';
    } else if(time.month == 4) {
      month = 'апреля';
    } else if(time.month == 5) {
      month = 'мая';
    } else if(time.month == 6) {
      month = 'июня';
    } else if(time.month == 7) {
      month = 'июля';
    } else if(time.month == 8) {
      month = 'августа';
    } else if(time.month == 9) {
      month = 'сентября';
    } else if(time.month == 10) {
      month = 'октября';
    } else if(time.month == 11) {
      month = 'ноября';
    } else if(time.month == 12) {
      month = 'декабря';
    }

    return '${time.day} $month,\n${time.hour}:${time.minute}';
  }

  Future<DateTime?> _selectDate(
    BuildContext context,
    DateTime? selectedDate,
  ) async {
    final selected = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2025),
    );
    if (selected != null && selected != selectedDate) {
      setState(() {
        selectedDate = selected;
      });
    }
    return selectedDate;
  }

  void _onRefresh() async {
    await Future.delayed(const Duration(seconds: 2));
    try {
      setState(() {
        travels = [];
        bloc.add(GetTravelsEvent(
            departureCity: departureCity,
            destinationCity: destinationCity,
            date: date));
      });
      _refreshController.refreshCompleted();
    } catch (e) {
      _refreshController.refreshFailed();
    }
  }
}
