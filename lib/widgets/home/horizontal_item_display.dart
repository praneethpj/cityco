import 'package:cityco/blocs/room/room_bloc.dart';
import 'package:cityco/screens/product_description.dart';
import 'package:cityco/widgets/customized_circular_indicator.dart';
import 'package:cityco/widgets/home/image_widget_container.dart';
import 'package:cityco/widgets/home/room_status_widget_container.dart';
import 'package:cityco/widgets/home/text_widget_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HorizontalItemDisplay extends StatefulWidget {
  const HorizontalItemDisplay({super.key});

  @override
  State<HorizontalItemDisplay> createState() => _HorizontalItemDisplayState();
}

class _HorizontalItemDisplayState extends State<HorizontalItemDisplay> {
  @override
  Widget build(BuildContext context) {
    var _deviceSize = MediaQuery.of(context).size;
    return BlocBuilder<RoomBloc, RoomState>(
      builder: (context, state) {
        if (state is RoomLoaded) {
          return SizedBox(
            height: _deviceSize.height / 2,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: state.roomModel.length,
              itemBuilder: (context, index) {
                final room = state.roomModel[index];
                return GestureDetector(
                  onTap: () {
                    context
                        .read<RoomBloc>()
                        .add(RoomGetByDocumentId(documentId: room.documentId));
                    Navigator.pushNamed(context, ProductDescription.routeName);
                  },
                  child: Container(
                    margin: const EdgeInsets.symmetric(horizontal: 8),
                    decoration:
                        BoxDecoration(borderRadius: BorderRadius.circular(90)),
                    child: Stack(
                      children: [
                        Positioned(
                          child: ImageWidgetContainer(image: room.image),
                        ),
                        Positioned(
                            child: RoomStatusWidgetContainer(
                                roomStatus: room.availability)),
                        Positioned(
                          bottom: 0,
                          child: TextWidgetContainer(
                            roomName: room.name,
                            price: room.pricePerDay,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          );
        } else {
          return CustomizedCircularIndicator();
        }
      },
    );
  }
}
