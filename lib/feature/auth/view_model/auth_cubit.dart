import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:teldax/core/local_db/cache_helper.dart';

import '../../../core/network/firestore_constants.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitial());
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController fullNameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  var formKey = GlobalKey<FormState>();

  AuthCubit get(context) => BlocProvider.of(context);

  final db = FirebaseFirestore.instance;

  void validateData() {
    if (passwordController.text != confirmPasswordController.text) {
      emit(AuthFail());
    } else if (formKey.currentState!.validate()) {
      registerationWithEmail();
    }
  }

  Future<void> register() async {
    emit(AuthLoading());
    await db
        .collection(userCollection)
        .doc(emailController.text)
        .get()
        .then((doc) {
      if (doc.exists) {
        emit(AuthFail());
      } else {
        storeData();
      }
    }).onError((error, stackTrace) {
      debugPrint('Register Failed ${error.toString()}');
      emit(AuthFail());
    });
  }

  Future<void> registerationWithEmail() async {
    emit(AuthLoading());
    try {
      await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
              email: emailController.text, password: passwordController.text)
          .then((value) {
        storeData();
      }).onError((error, stackTrace) {
        emit(AuthFail());
      });
    } catch (e) {
      emit(AuthFail());
    }
  }

  Future<void> storeData() async {
    await db
        .collection(userCollection)
        .doc(emailController.text) // auto generate id
        .set({
      "email": emailController.text,
      "phone": phoneController.text,
      "fullName": fullNameController.text,
    }).then((value) {
      clearControllers();
      emit(AuthSuccess());
    }).onError((error, stackTrace) {
      debugPrint('Register Failed ${error.toString()}');
      emit(AuthFail());
    });
  }

  void clearControllers() {
    emailController.clear();
    phoneController.clear();
    fullNameController.clear();
    passwordController.clear();
    confirmPasswordController.clear();
  }

  Future<void> login() async {
    emit(AuthLoading());
    await db
        .collection(userCollection)
        .where("email", isEqualTo: emailController.text)
        .where("password", isEqualTo: passwordController.text)
        .get()
        .then((querySnapshot) async {
      if (querySnapshot.docs.isNotEmpty) {
        String email = emailController.text;
        await CacheHelper.saveData(key: "email", value: email);
        clearControllers();
        emit(AuthSuccess());
      } else {
        emit(AuthFail());
      }
    }).onError((error, stackTrace) {
      debugPrint('Login Failed ${error.toString()}');
      emit(AuthFail());
    });
  }

  Future<void> loginWithEmailAndPassword() async {
    emit(AuthLoading());
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(
              email: emailController.text, password: passwordController.text)
          .then((value) async {
        await CacheHelper.saveData(key: "email", value: emailController.text);
        clearControllers();
        emit(AuthSuccess());
      }).onError((error, stackTrace) {
        emit(AuthFail());
      });
    } catch (e) {
      emit(AuthFail());
    }
  }
}
