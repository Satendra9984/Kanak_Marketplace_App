part of 'registration_bloc.dart';

abstract class RegistrationState extends Equatable {
  @override
  List<Object?> get props => [];
}

class RegistrationInitialState extends RegistrationState {
  @override
  List<Object?> get props => [];
}

class DetailsUploading extends RegistrationState {
  @override
  List<Object?> get props => [];
}

class DetailsUploadError extends RegistrationState {
  final String? error;
  DetailsUploadError({this.error});
  @override
  List<Object?> get props => [error];
}

class AadharCardUploading extends RegistrationState {
  @override
  List<Object?> get props => [];
}

class PanCardUploading extends RegistrationEvent {
  @override
  List<Object?> get props => [];
}