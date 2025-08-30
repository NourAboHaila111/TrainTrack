part of 'follow_up_cubit.dart';

/// الحالة الأساسية عند بدء التشغيل
abstract class FollowUpState {}

/// الحالة الابتدائية
class FollowUpInitial extends FollowUpState {}

/// حالة التحميل أثناء أي عملية (جلب – إضافة – تعديل – حذف)
class FollowUpLoading extends FollowUpState {}

/// حالة نجاح أي عملية مع رسالة
class FollowUpSuccess extends FollowUpState {
  final String message;
  FollowUpSuccess(this.message);
}

/// حالة الخطأ مع رسالة
class FollowUpError extends FollowUpState {
  final String message;
  FollowUpError(this.message);
}

/// حالة تحميل الأقسام بنجاح
class FollowUpSectionsLoaded extends FollowUpState {
  final List<SectionModel> sections;
  FollowUpSectionsLoaded(this.sections);
}

/// حالة تحميل المتابعات الخاصة باستفسار معين
class FollowUpListLoaded extends FollowUpState {
  final List<FollowUp> followups;
  FollowUpListLoaded(this.followups);
}

/// حالة تحميل المتابعات المحذوفة (إذا أردت عرضها)
class FollowUpDeletedListLoaded extends FollowUpState {
  final List<FollowUp> deletedFollowups;
  FollowUpDeletedListLoaded(this.deletedFollowups);
}
