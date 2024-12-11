
class TextUtil{

  static String capitalizeDateFormat1(String text) {
    List<String> words = text.split(" ");
    for(int i = 0; i< words.length; i++){
        switch(i){
          case 0:
          case 3: {
            List<String> letter = List<String>.generate(words[i].length,(index) => words[i][index]);
            letter[0] = letter[0].toUpperCase();
            words[i] = letter.join();

            break;
          }
          default: break;
        }
    }
    return words.join(" ");
  }

}