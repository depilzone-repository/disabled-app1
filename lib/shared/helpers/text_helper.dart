class TextHelper{
  TextHelper();

  String hideText(String? text){
    late String output = '';
    if(text != null && text.isNotEmpty){
      final String text0 = text.trim();

      for(var i = 0; i < text0.length; i++) {
        output += (i > 2 && i < text0.length-2) ? '*' : text0[i];
      }
    }
    return output;
  }

}