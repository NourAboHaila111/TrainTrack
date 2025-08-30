
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../layout/TrainDrawer.dart';
import '../../layout/triantrack_layout.dart';

import 'package:flutter/material.dart';

import '../../model/InquiryModel.dart';
import '../../model/NotificationModel.dart';
import '../../notifications/notifications_cubit.dart';
import '../../notifications/notifications_screen.dart';
import 'Favourite/FavouriteListScreen.dart';
import 'cubit/HomeCubit.dart';
import 'cubit/HomeState.dart';


class HomeScreen extends StatefulWidget {
  final String role;

  HomeScreen({required this.role});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int currentIndex = 0;

  Widget getCurrentScreen() {
    switch (currentIndex) {
      case 0:
        return widget.role == 'Trainer'
            ? TrainerLayout()
            : EmployeeLayout(searchController: TextEditingController());
      case 1:
        return FavouriteListScreen();
      case 2:
        return NotificationsScreen(
        );

      default:
        return Center(child: Text('Unknown Tab'));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: getCurrentScreen(),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        selectedItemColor: Theme.of(context).primaryColor,
        unselectedItemColor: Colors.grey,
        onTap: (index) => setState(() => currentIndex = index),
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: 'Favourite',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.notifications),
            label: 'Notifications',
          ),
        ],
      ),
    );
  }
}

class FavouriteListScreen1 extends StatelessWidget {
  final String role;

  FavouriteListScreen1({required this.role});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: TrainDrawer(),
      appBar: AppBar(title: const Text("Favourite Inquiries")),
      body: BlocBuilder<InquiriesCubit, InquiriesState>(
        builder: (context, state) {
          if (state is InquiriesLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is InquiriesLoaded) {
            // عرض فقط الاستفسارات المفضلة
            final favInquiries =
            state.inquiries.where((inq) => inq.isFavourite).toList();

            if (favInquiries.isEmpty) {
              return const Center(child: Text("No favourite inquiries yet."));
            }

            return ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: favInquiries.length,
              itemBuilder: (context, index) {
                final inquiry = favInquiries[index];
                return _inquiryCard(context, inquiry);
              },
            );
          } else if (state is InquiriesError) {
            return Center(child: Text(state.message));
          } else {
            return const Center(child: Text("No data available."));
          }
        },
      ),
    );
  }

  Widget _inquiryCard(BuildContext context, Inquiry inquiry) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 3,
      child: ListTile(
        title: Text(inquiry.title ?? "No Title"),
        subtitle: Text(inquiry.statusName ?? "No Status"),
        trailing: IconButton(
          icon: Icon(
            inquiry.isFavourite ? Icons.favorite : Icons.favorite_border,
            color: inquiry.isFavourite ? Colors.red : Colors.grey,
          ),
          onPressed: () {
            context.read<InquiriesCubit>().toggleFavorite(inquiry.id);
          },
        ),
      ),
    );
  }

  Widget _inboxItem(int index) {
    return Card(
      margin: EdgeInsets.only(bottom: 12),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ListTile(
        leading: Icon(Icons.mail_outline, color: Colors.blueAccent),
        title: Text("Message #$index"),
        subtitle: Text("This is a message for $role."),
        trailing: Icon(Icons.arrow_forward_ios, size: 16),
        onTap: () {},
      ),
    );
  }
}

