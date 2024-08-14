import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:formz/formz.dart';
import 'package:funoon/app/theme/colors.dart';
import 'package:funoon/app/utils/dynamic_size.dart';
import 'package:funoon/app/widgets/rounded_gradient_button.dart';
import 'package:funoon/features/profile/presentation/bloc/upload_post_page_bloc.dart';
import 'package:funoon/features/profile/presentation/bloc/upload_post__page_event.dart';
import 'package:funoon/features/profile/presentation/bloc/upload_post__page_state.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';

import '../../../feed/presentation/bloc/feed_bloc.dart';

class PostUploadScreen extends StatefulWidget {
  const PostUploadScreen({super.key});

  static const String route = '/PostUploadScreen';

  @override
  State<PostUploadScreen> createState() => _PostUploadScreenState();
}

class _PostUploadScreenState extends State<PostUploadScreen> {
  late FToast fToast;
  //-------------Focus Nodes for Text fields---------------------
  final _titleFocusNode = FocusNode();

  final _descriptionFocusNode = FocusNode();

  final _priceFocusNode = FocusNode();
  //----------Text Editing Controller----------------------------
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _priceController = TextEditingController();

  final ScrollController _scrollController = ScrollController();

  final ImagePicker _picker = ImagePicker();
  //----------List of pre-defined tags--------------------------
  List<String> tags = [
    'Painting',
    'Sketch',
    'Artwork',
    'Unique',
    'Graffiti',
    'Sculpture',
    'Pottery',
    'Embroidory',
    'Scenery',
    'Pencil Art',
    'Abstract',
    'Crafts',
  ];
  @override
  void initState() {
    fToast = FToast();
    fToast.init(context);
    _titleFocusNode.addListener(() {
      if (!_titleFocusNode.hasFocus) {
        context.read<UploadPostPageBloc>().add(TitleUnFocused());
      }
    });
    _priceFocusNode.addListener(() {
      if (!_priceFocusNode.hasFocus) {
        context.read<UploadPostPageBloc>().add(PriceUnFocused());
      }
    });
    _descriptionFocusNode.addListener(() {
      if (!_descriptionFocusNode.hasFocus) {
        context.read<UploadPostPageBloc>().add(DescriptionUnFocused());
      }
    });

    _titleController.text =
        BlocProvider.of<UploadPostPageBloc>(context).state.title.value;
    _descriptionController.text =
        BlocProvider.of<UploadPostPageBloc>(context).state.description.value;
    _priceController.text =
        BlocProvider.of<UploadPostPageBloc>(context).state.price.value;
    super.initState();
  }

  @override
  void dispose() {
    _titleFocusNode.dispose();
    _descriptionFocusNode.dispose();
    _priceFocusNode.dispose();

    _titleController.dispose();
    _descriptionController.dispose();
    _priceController.dispose();
    super.dispose();
  }

  _showToast(
      {required String message, required Color color, required Icon icon}) {
    Widget toast = Container(
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25.0),
        color: color,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          icon,
          const SizedBox(
            width: 12.0,
          ),
          Text(message),
        ],
      ),
    );

    fToast.showToast(
      child: toast,
      gravity: ToastGravity.CENTER,
      toastDuration: const Duration(seconds: 1),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<UploadPostPageBloc, UploadPostState>(
      listener: (context, state) async {
        if (state.status == FormzStatus.submissionSuccess) {
          _showToast(
            message: "Post was posed Successfully!",
            color: Colors.greenAccent,
            icon: const Icon(
              Icons.done,
              color: Colors.white,
            ),
          );
          BlocProvider.of<FeedBloc>(context).add(LoadFeed());
          Navigator.of(context).pop();
        }
        if (state.status == FormzStatus.submissionFailure) {
          if (state.status.isSubmissionFailure) {
            _showToast(
              message: "Something went wrong",
              color: red,
              icon: const Icon(
                Icons.error_outline,
                color: Colors.white,
              ),
            );
          }
        }
      },
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          flexibleSpace: SafeArea(
            child: Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 30,
                      child: Image.asset('assets/appbar_logo.png'),
                    ),
                    const SizedBox(
                      height: 24,
                      child: VerticalDivider(
                        color: Colors.black,
                        thickness: 2,
                      ),
                    ),
                    const Text(
                      'Post',
                      style: TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.black),
                    )
                  ],
                ),
              ),
            ),
          ),
          centerTitle: false,
          backgroundColor: Colors.white,
        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              BlocBuilder<UploadPostPageBloc, UploadPostState>(
                builder: (_, state) {
                  return Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: state.imagesPath.isNotEmpty
                        ? selectedImages(context, state)
                        : InkWell(
                            onTap: () async {
                              _picker.pickMultiImage().then((value) {
                                List<String> paths = [];
                                for (var element in value) {
                                  paths.add(element.path);
                                }
                                BlocProvider.of<UploadPostPageBloc>(context)
                                    .add(AddImage(path: paths));
                              });
                            },
                            child: Container(
                              height: SizeConfig.blockSizeVertical! * 35,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15.0),
                                color: grey.withOpacity(0.2),
                              ),
                              child: Center(
                                child: SizedBox(
                                    height: 120,
                                    child: Image.asset(
                                        'assets/post_page_image.png')),
                              ),
                            ),
                          ),
                  );
                },
              ),

              //-----------------------Title Field--------------------------------
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: BlocBuilder<UploadPostPageBloc, UploadPostState>(
                  builder: (context, state) {
                    return TextFormField(
                      maxLength: 50,
                      style: const TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                      focusNode: _titleFocusNode,
                      initialValue: state.title.value,
                      textInputAction: TextInputAction.next,
                      onChanged: (value) {
                        context.read<UploadPostPageBloc>().add(
                              TitleChanged(title: value),
                            );
                      },
                      decoration: InputDecoration(
                        //suffixIconColor: white,
                        focusedBorder: const OutlineInputBorder(
                          borderSide: BorderSide(
                            width: 2,
                            color: orange,
                          ),
                          borderRadius: BorderRadius.all(Radius.circular(25)),
                        ),
                        suffixIconConstraints: const BoxConstraints(
                          minHeight: 0,
                          maxHeight: 0,
                        ),
                        errorText: state.title.invalid
                            ? 'Post title must be 8 to 50 characters'
                            : null,
                        helperText: 'Write a catchy title for your Artwork',
                        errorStyle: TextStyle(
                          fontFamily: GoogleFonts.montserrat().fontFamily,
                          color: red,
                          fontWeight: FontWeight.bold,
                        ),
                        //----------TODO: change the font color to dynamic colors according to the theme
                        floatingLabelStyle: const TextStyle(
                          color: grey,
                          fontWeight: FontWeight.bold,
                        ),
                        helperStyle: const TextStyle(
                          color: grey,
                          fontWeight: FontWeight.bold,
                        ),
                        focusColor: Colors.black,
                        hintStyle: const TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                        border: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(25),
                          ),
                        ),

                        labelText: 'Title',
                      ),
                      //autofocus: true,
                    );
                  },
                ),
              ),

              //-----------------------Price Field--------------------------------
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                child: BlocBuilder<UploadPostPageBloc, UploadPostState>(
                  builder: (context, state) {
                    return TextFormField(
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                      ],
                      keyboardType: TextInputType.number,
                      style: const TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                      focusNode: _priceFocusNode,
                      initialValue: state.price.value,
                      textInputAction: TextInputAction.next,
                      onChanged: (value) {
                        context.read<UploadPostPageBloc>().add(
                              PriceChanged(price: value),
                            );
                      },
                      decoration: InputDecoration(
                        //suffixIconColor: white,
                        focusedBorder: const OutlineInputBorder(
                          borderSide: BorderSide(
                            width: 2,
                            color: orange,
                          ),
                          borderRadius: BorderRadius.all(Radius.circular(25)),
                        ),
                        suffixIconConstraints: const BoxConstraints(
                          minHeight: 0,
                          maxHeight: 0,
                        ),
                        errorText: state.price.invalid
                            ? 'Price can\'t be empty'
                            : null,
                        helperText: 'Enter the price for your artwork (in PKR)',
                        errorStyle: TextStyle(
                          fontFamily: GoogleFonts.montserrat().fontFamily,
                          color: red,
                          fontWeight: FontWeight.bold,
                        ),
                        //----------TODO: change the font color to dynamic colors according to the theme
                        floatingLabelStyle: const TextStyle(
                          color: grey,
                          fontWeight: FontWeight.bold,
                        ),
                        helperStyle: const TextStyle(
                          color: grey,
                          fontWeight: FontWeight.bold,
                        ),
                        focusColor: Colors.black,
                        hintStyle: const TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                        border: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(25)),
                        ),

                        labelText: 'Price',
                      ),
                      //autofocus: true,
                    );
                  },
                ),
              ),
              //-------------------Description Text Field
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                child: BlocBuilder<UploadPostPageBloc, UploadPostState>(
                  builder: (context, state) {
                    return TextFormField(
                      minLines: 1,
                      maxLength: 500,
                      maxLines: 5,
                      keyboardType: TextInputType.multiline,
                      style: const TextStyle(
                        color: Colors.black,
                        //fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                      focusNode: _descriptionFocusNode,

                      initialValue: state.description.value,
                      textInputAction: TextInputAction.next,
                      onChanged: (value) {
                        context.read<UploadPostPageBloc>().add(
                              DescriptionChanged(description: value),
                            );
                      },
                      decoration: InputDecoration(
                        //suffixIconColor: white,
                        focusedBorder: const OutlineInputBorder(
                          borderSide: BorderSide(
                            width: 2,
                            color: orange,
                          ),
                          borderRadius: BorderRadius.all(Radius.circular(25)),
                        ),
                        suffixIconConstraints: const BoxConstraints(
                          minHeight: 0,
                          maxHeight: 0,
                        ),
                        errorText: state.description.invalid
                            ? 'description must be 20 characters long'
                            : null,
                        helperText: 'Let the world know your art',
                        errorStyle: TextStyle(
                          fontFamily: GoogleFonts.montserrat().fontFamily,
                          color: red,
                          fontWeight: FontWeight.bold,
                        ),
                        //----------TODO: change the font color to dynamic colors according to the theme
                        floatingLabelStyle: const TextStyle(
                          color: grey,
                          fontWeight: FontWeight.bold,
                        ),
                        helperStyle: const TextStyle(
                          color: grey,
                          fontWeight: FontWeight.bold,
                        ),
                        focusColor: Colors.black,
                        hintStyle: const TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                        border: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(25)),
                        ),

                        labelText: 'Description',
                      ),
                      //autofocus: true,
                    );
                  },
                ),
              ),

              //---------------------Post Button
              Center(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  //-------------Using two blocBuilder here to set the token for the request
                  child: BlocBuilder<UploadPostPageBloc, UploadPostState>(
                    builder: (context, state) {
                      return state.status.isSubmissionInProgress
                          ? const SpinKitFadingCircle(
                              color: red,
                              size: 25,
                            )
                          : CustomRoundedButton(
                              radius: 25,
                              width: SizeConfig.screenWidth! * 0.80,
                              height: SizeConfig.screenHeight! * 0.05,
                              text: 'POST',
                              onPressed: (state.status == FormzStatus.valid &&
                                      state.tags.isNotEmpty &&
                                      state.imagesPath.isNotEmpty)
                                  ? () {
                                      BlocProvider.of<UploadPostPageBloc>(
                                              context)
                                          .add(CreatePost());
                                    }
                                  : null,
                            );
                    },
                  ),
                ),
              ),

              //---------------------Selected Tags
              BlocBuilder<UploadPostPageBloc, UploadPostState>(
                builder: (context, state) {
                  return state.tags.isEmpty
                      ? const SizedBox()
                      : const Padding(
                          padding: EdgeInsets.all(20.0),
                          child: Text(
                            'Selected Tags',
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                          ),
                        );
                },
              ),

              BlocBuilder<UploadPostPageBloc, UploadPostState>(
                builder: (context, state) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: SizedBox(
                      child: Wrap(
                        spacing: 6.0,
                        runSpacing: 6.0,
                        children: _addedTags(state, context),
                      ),
                    ),
                  );
                },
              ),
              const Padding(
                padding: EdgeInsets.all(20.0),
                child: Text(
                  'Tags',
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
              ),
              BlocBuilder<UploadPostPageBloc, UploadPostState>(
                builder: (context, state) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: SizedBox(
                      child: Wrap(
                        spacing: 6.0,
                        runSpacing: 6.0,
                        children: _givenTags(context),
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  List<Widget> _addedTags(UploadPostState state, BuildContext blocContext) {
    List<Widget> chipList = [];
    for (var element in state.tags) {
      chipList.add(
        InputChip(
          padding: const EdgeInsets.all(2.0),
          backgroundColor: red,
          label: Text(
            element,
            style: const TextStyle(
                color: Colors.white, fontWeight: FontWeight.bold),
          ),
          selectedColor: Colors.blue.shade600,
          deleteIcon: const Icon(
            Icons.close,
            color: Colors.white,
          ),
          onDeleted: () {
            BlocProvider.of<UploadPostPageBloc>(blocContext)
                .add(RemoveTag(tagName: element));
          },
        ),
      );
    }
    return chipList;
  }

  List<Widget> _givenTags(BuildContext blocContext) {
    List<Widget> chipList = [];
    for (var element in tags) {
      chipList.add(ActionChip(
        onPressed: () {
          BlocProvider.of<UploadPostPageBloc>(blocContext)
              .add(AddTag(tagName: element));
        },
        labelPadding: const EdgeInsets.all(2.0),
        label: Text(
          element,
          style: const TextStyle(
            color: Colors.black,
          ),
        ),
        backgroundColor: Colors.transparent,
        padding: const EdgeInsets.symmetric(
          horizontal: 10,
        ),
        shape: const StadiumBorder(
            side: BorderSide(
          width: 1,
          color: red,
        )),
      ));
    }
    return chipList;
  }

  Widget selectedImages(BuildContext blocContext, UploadPostState state) {
    return SizedBox(
      height: SizeConfig.blockSizeVertical! * 35,
      child: ListView.builder(
          shrinkWrap: true,
          scrollDirection: Axis.horizontal,
          itemCount: state.imagesPath.length,
          itemBuilder: (blocContext, index) {
            return Stack(
              children: [
                SizedBox(
                  height: SizeConfig.blockSizeVertical! * 35,
                  width: SizeConfig.screenWidth! - 30,
                  child: Image.file(
                    File(state.imagesPath[index]),
                    fit: BoxFit.cover,
                  ),
                ),
                Positioned(
                  top: 20,
                  right: 20,
                  child: InkWell(
                    onTap: () {
                      BlocProvider.of<UploadPostPageBloc>(blocContext)
                          .add(RemoveImage(path: state.imagesPath[index]));
                    },
                    child: Container(
                      height: 40,
                      width: 40,
                      decoration: const BoxDecoration(
                        color: red,
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.delete,
                        size: 30,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                Positioned(
                  bottom: 10,
                  right: 10,
                  child: Container(
                    height: 20,
                    padding:
                        const EdgeInsets.symmetric(horizontal: 12, vertical: 2),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.black,
                    ),
                    child: Text('${index + 1} / ${state.imagesPath.length}'),
                  ),
                ),
              ],
            );
          }),
    );
  }
}
