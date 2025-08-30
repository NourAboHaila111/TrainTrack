import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:triantrak/layout/TrainDrawer.dart';

import '../../../shared/components/AppColors.dart';
import '../../Replay/ReplayInquiriesScreen.dart';
import 'FavouriteCubit.dart';
import 'FavouriteState.dart';

class FavouriteListScreen extends StatelessWidget {
  const FavouriteListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: TrainDrawer(),
      appBar: AppBar(title: const Text("Favourite Inquiries")),
      body: BlocBuilder<FavouriteCubit, FavouriteState>(
        builder: (context, state) {
          if (state is FavouriteLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is FavouriteLoaded) {
            if (state.favourites.isEmpty) {
              return const Center(child: Text("No favourite inquiries yet."));
            }
            return ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: state.favourites.length,
              itemBuilder: (context, index) {
                final fav = state.favourites[index];
                return Card(
                  margin: const EdgeInsets.only(bottom: 12),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  elevation: 3,
                  child: ListTile(
                    title: Text(fav.inquiry.title ?? "No Title"),
                    subtitle: Text(fav.inquiry.body ?? ""),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.reply, color: AppColor.primaryYellow),
                          tooltip: 'Reply',
                          onPressed: () {
                            // الانتقال لواجهة الرد
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => ReplayInquiryScreen(
                                  inquiry: {
                                    'id': fav.inquiry.id.toString(),
                                    'title': fav.inquiry.title,
                                    'status': fav.inquiry.statusName,
                                    'category': fav.inquiry.categoryName,
                                    'body': fav.inquiry.body,
                                    'response': fav.inquiry.response,
                                  },
                                ),
                              ),
                            );
                          },
                        ),
                        IconButton(
                          icon: const Icon(Icons.delete, color: Colors.red),
                          onPressed: () {
                            context.read<FavouriteCubit>().removeFromFavourite(fav.id);
                          },
                        ),
                      ],
                    ),
                    onTap: () {
                      // يمكنك وضع أي وظيفة عند الضغط على الكارد بالكامل إذا أحببت
                    },
                  ),
                );

              },
            );
          } else if (state is FavouriteError) {
            return Center(child: Text(state.message));
          }
          return const SizedBox();
        },
      ),
    );
  }
}
