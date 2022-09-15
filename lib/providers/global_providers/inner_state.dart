import 'package:agrokomakchi/services/services.dart';
import 'package:equatable/equatable.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final innerProvider = StateNotifierProvider<InnerNotifier, InnerState>((ref) {
  return InnerNotifier();
});

class InnerNotifier extends StateNotifier<InnerState> {
  InnerNotifier() : super(InnerState.initial());

  void selectEnum(InnerEnum innerEnum) {
    state = state.copyWith(innerEnum: innerEnum);
  }

  void selectModel(InnerModel model) {
    state = state.copyWith(model: model);
  }
}

class InnerState extends Equatable {
  final InnerEnum innerEnum;
  final InnerModel model;

  const InnerState({
    required this.innerEnum,
    required this.model,
  });

  factory InnerState.initial() {
    return InnerState(
      innerEnum: InnerEnum.disease,
      model: InnerModel.list[0],
    );
  }

  InnerState copyWith({
    InnerEnum? innerEnum,
    InnerModel? model,
  }) {
    return InnerState(
      innerEnum: innerEnum ?? this.innerEnum,
      model: model ?? this.model,
    );
  }

  @override
  List<Object> get props {
    return [innerEnum, model];
  }
}
