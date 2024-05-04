import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:teldax/core/local_db/cache_helper.dart';

import '../../../core/network/firestore_constants.dart';

part 'credit_card_state.dart';

class CreditCardCubit extends Cubit<CreditCardState> {
  CreditCardCubit() : super(CreditCardInitial());
  CreditCardCubit get(context) => BlocProvider.of(context);

  TextEditingController cardNumberController = TextEditingController();
  TextEditingController cardHolderNameController = TextEditingController();
  TextEditingController expiryDateController = TextEditingController();
  TextEditingController cvvController = TextEditingController();
  TextEditingController balanceController = TextEditingController();
  var formKey = GlobalKey<FormState>();

  var db = FirebaseFirestore.instance;

  Future<void> addCard() async {
    String ? email = await CacheHelper.getData(key: "email");
    emit(CreditCardLoading());
    db.collection(creditCardsCollection).doc().set({
      "card_number": cardNumberController.text,
      "email": email,
      "card_holder_name": cardHolderNameController.text,
      "expiry_date": expiryDateController.text,
      "cvv": cvvController.text,
      "balance": balanceController.text
    }).then((value) {
      emit(CreditCardAdded());
    }).catchError((error) {
      emit(CreditCardError());
    });
  }



}
