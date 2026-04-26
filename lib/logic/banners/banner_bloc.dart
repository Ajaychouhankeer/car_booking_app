import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/models/get_banners_model.dart';
import '../../data/repositories/api_methods.dart';
import 'banner_event.dart';
import 'banner_state.dart';

class BannerBloc extends Bloc<BannerEvent, BannerState> {
  BannerBloc() : super(BannerInitial()) {
    on<FetchBannersEvent>(_onFetchBanners);
  }

  Future<void> _onFetchBanners(
      FetchBannersEvent event, Emitter<BannerState> emit) async {
    emit(BannerLoading());

    try {
      final GetBanners? response = await ApiMethods.getBanners(
        userId: "",
      );

      if (response != null && response.success) {
        emit(BannerLoaded(response.banners));
      } else {
        emit(BannerError("Failed to load banners"));
      }
    } catch (e) {
      emit(BannerError(e.toString()));
    }
  }
}
