//
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
//
// import '../../model/InquiryModel.dart';
// import '../../shared/components/AppColors.dart';
// import '../../shared/components/components.dart';
// import '../Replay/ReplayInquiriesScreen.dart';
// import 'Timeline.dart';
// import 'cubit/HomeCubit.dart';
// import 'cubit/HomeState.dart';
//
// class QueryTable extends StatelessWidget {
//   final List<Inquiry>? inquiries;
//
//   const QueryTable({super.key, this.inquiries});
//
//   Color getStatusColor(String status) {
//     switch (status.toLowerCase()) {
//       case 'opened':
//         return AppColor.primaryBlue;
//       case 'closed':
//         return AppColor.primaryRed;
//       case 'pending':
//         return AppColor.mypink;
//       default:
//         return Colors.blueGrey;
//     }
//   }
//
//   void showTimelineDialog(BuildContext context, String currentStatus) {
//     showDialog(
//       context: context,
//       builder: (context) => AlertDialog(
//         title: const Text("Inquiry Timeline"),
//         content: SizedBox(
//           width: double.maxFinite,
//           height: 400,
//           child: InquiryTimeline(currentStatus: currentStatus),
//         ),
//         actions: [
//           TextButton(
//             onPressed: () => Navigator.pop(context),
//             child: const Text("Close"),
//           ),
//         ],
//       ),
//     );
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     if (inquiries != null) {
//       return buildInquiryList(inquiries!);
//     }
//
//     return BlocBuilder<InquiriesCubit, InquiriesState>(
//       builder: (context, state) {
//         if (state is InquiriesLoading) {
//           return const Center(child: CircularProgressIndicator());
//         } else if (state is InquiriesError) {
//           return Center(child: Text('Error: ${state.message}'));
//         } else if (state is InquiriesLoaded) {
//           return buildInquiryList(state.inquiries);
//         }
//         return const SizedBox.shrink();
//       },
//     );
//   }
//
//   Widget buildInquiryList(List<Inquiry> data) {
//     if (data.isEmpty) {
//       return const Center(child: Text("لا توجد استفسارات مطابقة."));
//     }
//
//     return ListView.builder(
//       itemCount: data.length,
//       shrinkWrap: true,
//       physics: const NeverScrollableScrollPhysics(),
//       itemBuilder: (context, index) {
//         final item = data[index];
//         return Card(
//           elevation: 4,
//           margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
//           shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
//           child: Padding(
//             padding: const EdgeInsets.all(16.0),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Hero(
//                   tag: 'inquiry-title-$index',
//                   child: Material(
//                     color: Colors.transparent,
//                     child: Text(
//                       item.title,
//                       style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w300),
//                       overflow: TextOverflow.ellipsis, //
//                       maxLines: 2, // يعرض سطرين فقط
//                     ),
//                   ),
//                 ),
//                 const SizedBox(height: 8),
//                 Row(
//                   children: [
//                     Chip(
//                       label: Text(item.status),
//                       backgroundColor: getStatusColor(item.status),
//                       labelStyle: const TextStyle(color: Colors.white),
//                     ),
//                     const SizedBox(width: 10),
//
//                     // 🔥 خلي النص داخل Expanded عشان ما يكسر الـ Row
//                     Expanded(
//                       child: Text(
//                         item.category,
//                         style: const TextStyle(fontSize: 14, color: AppColor.primaryGrye),
//                         overflow: TextOverflow.ellipsis,
//                       ),
//                     ),
//
//                     // أيقونة المفضلة ❤️
//                     IconButton(
//                       icon: Icon(
//                         item.isFavorite ? Icons.favorite : Icons.favorite_border,
//                         color: item.isFavorite ? Colors.red : Colors.grey,
//                       ),
//                       onPressed: () {
//                         setState(() {
//                           item.isFavorite = !item.isFavorite;
//                           // هنا ممكن تحفظه في local storage أو DB
//                         });
//                       },
//                     ),
//
//                     ElevatedButton(
//                       onPressed: () {
//                         navigateTo(
//                           context,
//                           Replayinquiriesscreen(
//                             inquiry: {
//                               'id': item.id.toString(),
//                               'title': item.title,
//                               'status': item.status,
//                               'category': item.category,
//                             },
//                             tagIndex: index,
//                           ),
//                         );
//                       },
//                       style: ElevatedButton.styleFrom(
//                         backgroundColor: AppColor.mybabyellow,
//                         foregroundColor: Colors.black,
//                         shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(8),
//                         ),
//                       ),
//                       child: const Text('Reply', style: TextStyle(fontWeight: FontWeight.w300)),
//                     ),
//
//                     IconButton(
//                       icon: const Icon(Icons.timeline),
//                       tooltip: 'View Timeline',
//                       onPressed: () {
//                         showTimelineDialog(context, item.status);
//                       },
//                     ),
//                   ],
//                 ),
//               ],
//             ),
//           ),
//         );
//
//       },
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


import '../../model/InquiryModel.dart';
import '../../shared/components/AppColors.dart';
import '../../shared/components/components.dart';
import '../Replay/ReplayInquiriesScreen.dart';
import 'Favourite/FavouriteCubit.dart';
import 'Favourite/FavouriteState.dart';
import 'Timeline.dart';
import 'cubit/HomeCubit.dart';
import 'cubit/HomeState.dart';

class QueryTable extends StatelessWidget {
  final List<Inquiry>? inquiries;

  const QueryTable({super.key, this.inquiries});

  Color getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'opened':
        return AppColor.primaryBlue;
      case 'closed':
        return AppColor.primaryRed;
      case 'pending':
        return AppColor.mypink;
      case 'reopened':
        return Colors.orange;
      default:
        return Colors.blueGrey;
    }
  }

  void showTimelineDialog(BuildContext context, String currentStatus) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Inquiry Timeline"),
        content: SizedBox(
          width: double.maxFinite,
          height: 400,
          child: InquiryTimeline(currentStatus: currentStatus),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Close"),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (inquiries != null) {
      return buildInquiryList(context, inquiries!);
    }

    return BlocBuilder<InquiriesCubit, InquiriesState>(
      builder: (context, state) {
        if (state is InquiriesLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is InquiriesError) {
          return Center(child: Text('Error: ${state.message}'));
        } else if (state is InquiriesLoaded) {
          return buildInquiryList(context, state.inquiries);
        }
        return const SizedBox.shrink();
      },
    );
  }

  Widget buildInquiryList(BuildContext context, List<Inquiry> data) {
    if (data.isEmpty) {
      return const Center(child: Text("There are no matching iquiries"));
    }

    final cubit = BlocProvider.of<InquiriesCubit>(context);
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return ListView.builder(
      itemCount: data.length,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        final item = data[index];

        return Card(
          color: isDark ? Colors.grey[800] : Colors.grey[200],
          elevation: 4,
          margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          child: Stack(
            children: [
              // محتوى الكارد الأساسي
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // 🔹 العنوان
                    Hero(
                      tag: 'inquiry-title-$index',
                      child: Material(
                        color: Colors.transparent,
                        child: Text(
                          item.title,
                          style: const TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w300,
                          ),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2,
                        ),
                      ),
                    ),

                    Text(
                      item.categoryName,
                      style: const TextStyle(
                        fontSize: 12,
                        color: AppColor.primaryGrye,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 12),

                    // 🔹 الحالة + القسم + الأزرار
                    Wrap(
                      spacing: 10,
                      runSpacing: 8,
                      crossAxisAlignment: WrapCrossAlignment.center,
                      children: [
                        Chip(
                          label: Text(item.statusName),
                          backgroundColor: getStatusColor(item.statusName),
                          labelStyle: const TextStyle(color: Colors.white),
                        ),


                        ElevatedButton(
                          onPressed: () {
                            navigateTo(
                              context,
                              ReplayInquiryScreen(
                                inquiry: {
                                  'id': item.id.toString(),
                                  'title': item.title,
                                  'status': item.statusName,
                                  'category': item.categoryName,
                                },
                              ),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColor.mybabyellow,
                            foregroundColor: Colors.black,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            padding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 8,
                            ),
                          ),
                          child: const Text(
                            'Reply',
                            style: TextStyle(fontWeight: FontWeight.w300),
                          ),
                        ),

                        IconButton(
                          icon: const Icon(Icons.timeline),
                          tooltip: 'View Timeline',
                          onPressed: () {
                            showTimelineDialog(context, item.statusName);
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              // 🔹 أيقونة المفضلة مثبتة أعلى الكارد
              Positioned(
                top: 8,
                right: 8,
                child: BlocBuilder<FavouriteCubit, FavouriteState>(
                  builder: (context, state) {
                    final favCubit = context.read<FavouriteCubit>();
                    final isFav = favCubit.isFavourite(item.id);

                    return IconButton(
                      icon: Icon(
                        isFav ? Icons.favorite : Icons.favorite_border,
                        color: isFav ? Colors.red : Colors.grey,
                      ),
                      onPressed: () {
                        if (isFav) {
                          final fav = favCubit.favourites
                              .firstWhere((f) => f.inquiryId == item.id);
                          favCubit.removeFromFavourite(fav.id);
                        } else {
                          favCubit.addToFavourite(item.id);
                        }
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        );

      },
    );
  }
}

