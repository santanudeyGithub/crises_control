import 'package:bloc/bloc.dart';
import 'package:crises_control/src/core/constants.dart';
import 'package:crises_control/src/core/errors/cc_error.dart';
import 'package:crises_control/src/core/services/url_launcher_service.dart';
import 'package:crises_control/src/help/help_repository.dart';
import 'package:crises_control/src/help/help_rest_service.dart';
import 'package:equatable/equatable.dart';

part 'help_state.dart';

class HelpCubit extends Cubit<HelpState> {
  HelpCubit(
    this.urlLauncherService,
    this.helpRepository,
  ) : super(const HelpInitial());

  final HelpRepository helpRepository;
  final UrlLauncherService urlLauncherService;

  callSupport() {
    try {
      urlLauncherService.initiateCall(
          phoneNumber: SupportConstants.supportPhoneNumber);
    } on Exception {
      emit(const HelpError(CCError()));
    }
  }

  onPolicy({required PolicyType policyType}) async {
    emit(const HelpLoading());
    try {
      final result = await helpRepository.getPolicy(policyType: policyType);
      result.fold(
        (error) => emit(HelpError(error)),
        (url) => emit(HelpPolicy(url.result, policyType)),
      );
    } on Exception {
      emit(const HelpError(CCError()));
    }
  }

  emailSupport() {
    try {
      urlLauncherService.sendEmail(
        email: SupportConstants.supportEmail,
        subject: '',
        body: '',
      );
    } on Exception {
      emit(const HelpError(CCError()));
    }
  }

  sendDeviceInfo() {
    try {
      helpRepository.sendDeviceInfo();
    } on Exception {
      emit(const HelpError(CCError()));
    }
  }
}
