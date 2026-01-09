import 'package:bloc_login_validation/presentation/bloc/navigation/navigation_cubit.dart';
import 'package:bloc_login_validation/presentation/pages/datapage.dart';
import 'package:bloc_login_validation/presentation/pages/homepage.dart';
import 'package:bloc_login_validation/presentation/pages/profilepage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MainWrapper extends StatelessWidget {
  const MainWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => NavigationCubit(),
      child: const _MainWrapperView(),
    );
  }
}

class _MainWrapperView extends StatelessWidget {
  const _MainWrapperView();

  final List<Widget> _pages = const [Homepage(), Profilepage(), Datapage()];

  @override
  Widget build(BuildContext context) {
    final selectedIndex = context.select(
      (NavigationCubit cubit) => cubit.state,
    );

    return Scaffold(
      body: IndexedStack(index: selectedIndex, children: _pages),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: selectedIndex,
        onTap: (index) => context.read<NavigationCubit>().updateIndex(index),
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
          BottomNavigationBarItem(icon: Icon(Icons.data_usage), label: 'Data'),
        ],
      ),
    );
  }
}
