import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:furniture_shopping_ecommerce/core/utilities/strings.dart';
import 'package:furniture_shopping_ecommerce/features/cart/data/datasource/places_api.dart';
import 'package:furniture_shopping_ecommerce/features/cart/presentation/bloc/cubit/address_cubit.dart';
import 'package:furniture_shopping_ecommerce/features/cart/presentation/bloc/location_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:uuid/uuid.dart';
import '../../../../core/colors/colors.dart';
import '../../../../core/utilities/mediaquery.dart';
import '../../../login/presentation/widgets/alert_snackbar.dart';
import '../../data/models/suggession_model.dart';

class MapView extends StatelessWidget {
  const MapView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        automaticallyImplyLeading: false,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          AppStrings.selectnewaddress,
          style: Theme.of(context).textTheme.headlineSmall,
        ),
      ),
      body: BlocConsumer<LocationBloc, LocationState>(
        listener: (context, state) {
          final bloc = BlocProvider.of<LocationBloc>(context);
          if (state is MapSelectedPosition) {
            showSnackbar(
              "The selected area is: ${bloc.currentAddressDetails}",
              context,
              ColorManager.white,
            );
          }
        },
        builder: (context, state) {
          final bloc = BlocProvider.of<LocationBloc>(context);

          if (state is MapLoadingState) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(height: kHeight(context) / 8),
                  const CircularProgressIndicator(),
                ],
              ),
            );
          } else if (state is MapLoadedState ||
              state is MapSelectedPosition ||
              state is SelectMethodState) {
            return Stack(
              children: [
                SizedBox(
                  width: kWidth(context),
                  height: kHeight(context),
                  child:
                      bloc.initialTarget != null
                          ? GoogleMap(
                            initialCameraPosition: bloc.initialTarget!,
                            onMapCreated: (controller) {
                              bloc.googleMapController = controller;
                            },
                            markers: {
                              Marker(
                                markerId: const MarkerId('1'),
                                icon: BitmapDescriptor.defaultMarkerWithHue(
                                  BitmapDescriptor.hueRed,
                                ),
                                position:
                                    bloc.myCurrentPosition != null
                                        ? LatLng(
                                          bloc.myCurrentPosition!.latitude,
                                          bloc.myCurrentPosition!.longitude,
                                        )
                                        : const LatLng(0.0, 0.0),
                              ),
                            },
                            onTap: (tapped) {
                              bloc.add(SelectPosition(latLng: tapped));
                            },
                          )
                          : const Center(child: CircularProgressIndicator()),
                ),
                Positioned(
                  left: 20,
                  right: 20,
                  top: 20,
                  child: TextField(
                    controller: bloc.searchController,
                    readOnly: true,
                    onTap: () {
                      PlacesDatasourceImpl.sessionToken = const Uuid().v4();
                      showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            contentPadding: EdgeInsets.symmetric(
                              vertical: kHeight(context) / 20,
                              horizontal: 20,
                            ),
                            content: Material(
                              color: Colors.transparent,
                              child: TypeAheadField<Suggestion>(
                                debounceDuration: const Duration(
                                  milliseconds: 500,
                                ),
                                suggestionsCallback: (pattern) async {
                                  return BlocProvider.of<AddressCubit>(
                                    context,
                                  ).searchLocation(pattern, context);
                                },
                                itemBuilder: (context, Suggestion suggestion) {
                                  return ListTile(
                                    leading: const Icon(Icons.location_on),
                                    title: Text(
                                      suggestion.description,
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: Theme.of(
                                        context,
                                      ).textTheme.headlineLarge!.copyWith(
                                        color:
                                            Theme.of(
                                              context,
                                            ).textTheme.bodyLarge!.color,
                                        fontSize: 16,
                                      ),
                                    ),
                                  );
                                },
                                onSelected: (Suggestion suggestion) async {
                                  final addressCubit =
                                      BlocProvider.of<AddressCubit>(context);
                                  await addressCubit.getLocation(
                                    suggestion.placeId,
                                    context,
                                  );
                                  LatLng? latLng = addressCubit.location;

                                  if (latLng != null) {
                                    bloc.myCurrentPosition = Position(
                                      longitude: latLng.longitude,
                                      latitude: latLng.latitude,
                                      timestamp: DateTime.now(),
                                      accuracy: 0.0,
                                      altitude: 0.0,
                                      heading: 0.0,
                                      speed: 0.0,
                                      speedAccuracy: 0.0,
                                      altitudeAccuracy: 0.0,
                                      headingAccuracy: 0.0,
                                    );
                                    bloc.googleMapController.animateCamera(
                                      CameraUpdate.newCameraPosition(
                                        CameraPosition(
                                          target: latLng,
                                          zoom: 15,
                                        ),
                                      ),
                                    );
                                  }
                                  bloc.searchController.text =
                                      suggestion.description;

                                  if (context.mounted) {
                                    Navigator.pop(context);
                                  }
                                },
                                textFieldConfiguration: TextFieldConfiguration(
                                  controller:
                                      bloc.searchController, // Use the existing controller
                                  focusNode: FocusNode(),
                                  textInputAction: TextInputAction.search,
                                  autofocus: true,
                                  textCapitalization: TextCapitalization.words,
                                  keyboardType: TextInputType.streetAddress,
                                  decoration: InputDecoration(
                                    hintText: AppStrings.searchlocation,
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      borderSide: const BorderSide(
                                        style: BorderStyle.none,
                                        width: 0,
                                      ),
                                    ),
                                    hintStyle: Theme.of(
                                      context,
                                    ).textTheme.headlineLarge!.copyWith(
                                      fontSize: 15,
                                      color: Theme.of(context).disabledColor,
                                    ),
                                  ),
                                  style: Theme.of(
                                    context,
                                  ).textTheme.headlineLarge!.copyWith(
                                    color:
                                        Theme.of(
                                          context,
                                        ).textTheme.bodyLarge!.color,
                                    fontSize: 18,
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      );
                    },
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(color: Colors.transparent),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(color: Colors.transparent),
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(color: Colors.transparent),
                      ),
                      hintText: AppStrings.searchlocation,
                      hintStyle: const TextStyle(color: Color(0xFF535353)),
                      suffixIcon: const SizedBox(),
                    ),
                  ),
                ),
              ],
            );
          } else if (state is MapErrorState) {
            return Center(child: Text(state.message));
          } else {
            return const SizedBox();
          }
        },
      ),
    );
  }
}
