import 'package:equatable/equatable.dart';
import 'package:flutter_adviser/1_domain/entities/advice_entity.dart';

/*
 * we are extending [AdviceEntity] because it holds the same data structure 
 * we want for this class as we are getting same structured data from Api. Also
 * this class will hold additional functions which will be separated from 
 * [AdviceEntity] and with that we can perform test easily as they both will be 
 * separate entity.
 *
 */
class AdviceModel extends AdviceEntity with EquatableMixin {
  AdviceModel({required String advice, required int id})
      : super(advice: advice, id: id);

  factory AdviceModel.fromJson(Map<String, dynamic> json) {
    // Get value from the decoded json object.
    return AdviceModel(advice: json['advice'], id: json['advice_id']);
  }
}
